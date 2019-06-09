package com.king.frame.service;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.Serializable;
import java.io.StringWriter;
import java.lang.reflect.Method;
import java.lang.reflect.ParameterizedType;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import org.hibernate.service.spi.ServiceException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.king.common.dao.DbUtilsDAO;
import com.king.frame.dao.IBaseDAO;
import com.king.frame.entity.BaseEntity;
import com.king.frame.security.ShiroUser;

/**
 * IService基本实现
 * 
 * @author kevin
 * 
 * @param <T>
 *            实体类型
 * @param <PK>
 *            主键类型
 */
// 所有service都要加上rollbackFor={Exception.class}才能回滚
@Service
@Transactional(rollbackFor = { Exception.class })
public abstract class BaseServiceImpl<T extends BaseEntity, PK extends Serializable> implements IService<T, PK> {

	protected abstract IBaseDAO<T, PK> getDAO();

	protected Class<T> persistentClass;

	DbUtilsDAO dbUtilsDAO;

	public BaseServiceImpl() {
		init();
	}

	/**
	 * getClass().getGenericSuperclass()返回表示此 Class 所表示的实体（类、接口、基本类型或 void） 的直接超类的 Type(Class
	 * <T>泛型中的类型)，然后将其转换ParameterizedType。。 getActualTypeArguments()返回表示此类型实际类型参数的 Type 对象的数组。 [0]就是这个数组中第一个了。。
	 * 简而言之就是获得超类的泛型参数的实际类型。。
	 */
	public void init() {
		persistentClass = (Class<T>) ((ParameterizedType) this.getClass().getGenericSuperclass())
				.getActualTypeArguments()[0];
	}

	public T findById(PK pk) throws ServiceException {
		// dbUtilsDAO.find(entityClass, sql)
		return getDAO().findByUuid(pk);
	}

	@Override
	public T getOne(PK pk) throws ServiceException {
		return getDAO().findOne(pk);
	}

	@Override
	public Iterable<T> findAll(Iterable<PK> pks) throws ServiceException {
		try {
			return getDAO().findAll(pks);
		} catch (Exception e) {
			throw new ServiceException(e.getMessage());
		}
	}

	@Override
	public Iterable<T> findAll(PK[] pks) throws ServiceException {
		try {
			return getDAO().findAll(Arrays.asList(pks));
		} catch (Exception e) {
			throw new ServiceException(e.getMessage());
		}
	}

	@Override
	public Iterable<T> findAll() throws ServiceException {
		try {
			return getDAO().findAll();
		} catch (Exception e) {
			throw new ServiceException(e.getMessage());
		}
	}

	@Override
	public Iterable<T> findAll(Sort sort) throws ServiceException {
		try {
			return getDAO().findAll(sort);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServiceException(e.getMessage());
		}
	}

	@Override
	public Page<T> findAll(Specification<T> spec, Pageable pageable) throws ServiceException {
		try {
			return getDAO().findAll(spec, pageable);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServiceException(e.getMessage());
		}
	}

	@Override
	public Page<T> findAll(Pageable pageable) throws ServiceException {
		try {
			return getDAO().findAll(pageable);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServiceException(e.getMessage());
		}
	}

	@Override
	public List<T> findAll(Specification<T> spec) throws ServiceException {
		try {
			return getDAO().findAll(spec);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServiceException(e.getMessage());
		}
	}

	@Override
	public List<T> findAll(Specification<T> spec, Sort sort) throws ServiceException {
		try {
			return getDAO().findAll(spec, sort);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServiceException(e.getMessage());
		}
	}

	public void beforeSave(T entity) throws ServiceException {

	}

	@Override
	public T save(T entity) throws ServiceException {
		try {
			beforeSave(entity);
			T newEntity = this.baseSave(entity);
			afterSave(newEntity);
			return newEntity;
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServiceException(e.getMessage());
		}
	}

	public void afterSave(T newEntity) throws ServiceException {

	}

	@Override
	public T baseSave(T entity) throws ServiceException {
		try {
			return getDAO().save(entity);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServiceException(e.getMessage());
		}
	}

	@Override
	public Iterable<T> save(Iterable<T> entities) throws ServiceException {
		try {
			return getDAO().save(entities);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServiceException(e.getMessage());
		}
	}

	@Override
	public void deleteAll() throws ServiceException {
		try {
			getDAO().deleteAll();
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServiceException(e.getMessage());
		}
	}

	@Override
	public void delete(PK pk) throws ServiceException {
		try {
			T entity = this.getOne(pk);
			this.delete(entity);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServiceException(e.getMessage());
		}
	}

	@Override
	public void delete(PK[] pks) throws ServiceException {
		try {
			for (PK pk : pks) {
				delete(pk);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServiceException(e.getMessage());
		}
	}

	@Override
	public void delete(T entity) throws ServiceException {
		try {
			getDAO().delete(entity);
		} catch (Exception e) {
			// throw new ServiceException(e.getMessage());
			e.printStackTrace();
			StringWriter sw = new StringWriter();
			e.printStackTrace(new PrintWriter(sw, true));
			String strs = sw.toString();
			try {
				if (!strs.contains("constraint")) {
					strs = e.getMessage();
				}
				sw.close();
			} catch (IOException e1) {
				e1.printStackTrace();
				throw new ServiceException(e.getMessage());
			}
			throw new ServiceException(strs);
		}
	}

	@Override
	public void delete(Iterable<T> entities) throws ServiceException {
		try {
			getDAO().delete(entities);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServiceException(e.getMessage());
		}
	}

	public Specification<T> getDefaultSpecification() {
		return null;
	}

	public Sort getDefaultSort() {
		return null;
	}

	public void beforeAdd(T entity) throws ServiceException {

	}

	@Override
	@Transactional
	public T doAdd(T entity) throws ServiceException {
		beforeAdd(entity);
		T newEntity = this.save(entity);
		afterAdd(newEntity);
		return newEntity;
	}

	@Override
	@Transactional
	public Iterable<T> doAdd(Iterable<T> entities) throws ServiceException {
		try {
			List<T> result = new ArrayList<T>();
			if (entities == null) {
				return result;
			}
			for (T entity : entities) {
				result.add(doAdd(entity));
			}
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServiceException(e.getMessage());
		}
	}

	public void afterAdd(T entity) throws ServiceException {

	}

	public void beforeUpdate(T entity) throws ServiceException {

	}

	@Override
	@Transactional
	public T doUpdate(T entity) throws ServiceException {
		try {
			beforeUpdate(entity);

			// ShiroUser.getCurrentUserEntity().getUuid();
			entity.setModifier(ShiroUser.getCurrentUserEntity().getUuid());
			entity.setModifiername(ShiroUser.getCurrentUserEntity().getUsername());
			entity.setModifytime(new Date());

			T newEntity = this.save(entity);
			afterUpdate(newEntity);
			return newEntity;
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServiceException(e.getMessage());
		}
	}

	public void afterUpdate(T entity) throws ServiceException {

	}

	@Override
	@Transactional
	public Iterable<T> doUpdate(Iterable<T> entities) throws ServiceException {
		try {
			List<T> result = new ArrayList<T>();
			if (entities == null) {
				return result;
			}
			for (T entity : entities) {
				result.add(doUpdate(entity));
			}
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServiceException(e.getMessage());
		}
	}

	public void beforeDelete(T entity) throws ServiceException {

	}

	@Override
	@Transactional
	public void doDelete(PK pk) throws ServiceException {
		try {
			T entity = this.getOne(pk);
			beforeDelete(entity);
			delete(pk);
			afterDelete(entity);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServiceException(e.getMessage());
		}
	}

	@Override
	@Transactional
	public void doDelete(PK[] pks) throws ServiceException {
		try {
			for (PK pk : pks) {
				doDelete(pk);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServiceException(e.getMessage());
		}
	}

	public void afterDelete(T entity) throws ServiceException {

	}

	@Override
	@Transactional
	public void doDisabled(PK[] pks) throws ServiceException {
		try {
			for (PK pk : pks) {
				doDisabled(pk);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServiceException(e.getMessage());
		}
	}

	@Override
	@Transactional
	public void doDisabled(PK pk) throws ServiceException {
		try {
			T entity = this.getOne(pk);
			beforeDisabled(entity);
			this.getDAO().save(entity);
			afterDisabled(entity);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServiceException(e.getMessage());
		}
	}

	// set disabled
	private void beforeDisabled(T entity) throws Exception {
		Method m = entity.getClass().getMethod("setIs_use", String.class);
		m.invoke(entity, "0");
	}

	public void afterDisabled(T entity) throws ServiceException {

	}

	@Override
	@Transactional
	public void doEnabled(PK[] pks) throws ServiceException {
		try {
			for (PK pk : pks) {
				doEnabled(pk);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServiceException(e.getMessage());
		}
	}

	@Override
	@Transactional
	public void doEnabled(PK pk) throws ServiceException {
		try {
			T entity = this.getOne(pk);
			beforeEnabled(entity);
			this.getDAO().save(entity);
			afterEnabled(entity);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServiceException(e.getMessage());
		}
	}

	// set disabled
	private void beforeEnabled(T entity) throws Exception {
		Method m = entity.getClass().getMethod("setIs_use", String.class);
		m.invoke(entity, "1");
	}

	public void afterEnabled(T entity) throws ServiceException {

	}

}
