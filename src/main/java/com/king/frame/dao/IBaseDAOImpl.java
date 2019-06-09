package com.king.frame.dao;

import java.io.Serializable;

import javax.persistence.EntityManager;

import org.springframework.data.jpa.repository.support.SimpleJpaRepository;
import org.springframework.data.repository.NoRepositoryBean;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

/**
 * 扩展 Jpa 实现类
 * 
 * @author yy-team
 * @date 2017年9月6日
 * @param <T>
 * @param <ID>
 */
@Transactional(readOnly = true)
@NoRepositoryBean
public class IBaseDAOImpl<T, ID extends Serializable> extends SimpleJpaRepository<T, ID> implements IBaseDAO<T, ID> {
	// private final Class<T> domainClass;

	// 持久化上下文
	private final EntityManager em;

	public IBaseDAOImpl(Class<T> domainClass, EntityManager em) {
		super(domainClass, em);
		this.em = em;
		// this.domainClass = domainClass;
	}

	@Override
	public T findByUuid(ID id) {
		Assert.notNull(id, "ID 不能为空");
		Class<T> domainType = getDomainClass();
		T t = em.find(domainType, id);
		// 把持久化对象变成托管状态
		em.detach(t);
		return t;
	}

	/**
	 * 批量保存
	 * 
	 * @param entities
	 */
	public void batchSave(Iterable<T> entities) {
		int i = 0;
		for (T entity : entities) {
			em.persist(entity);
			if (i % 100 == 0) {
				em.flush();
				em.clear();
			}
			i++;
		}
	}

}
