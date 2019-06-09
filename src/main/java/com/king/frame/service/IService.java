/**
 * 
 */
package com.king.frame.service;

import java.io.Serializable;
import java.util.List;

import org.hibernate.service.spi.ServiceException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;

/**
 * @author kevin
 * 
 */
public interface IService<T, PK extends Serializable> {

	/**
	 * 根据PK查找对象
	 * 
	 * @auth kevin
	 * @param pk
	 * @return
	 * @throws ServiceException
	 */
	T getOne(PK pk) throws ServiceException;

	T findById(PK pk) throws ServiceException;

	Iterable<T> findAll(Iterable<PK> pks) throws ServiceException;

	Iterable<T> findAll() throws ServiceException;

	Iterable<T> findAll(Sort sort) throws ServiceException;

	Page<T> findAll(Pageable pageable) throws ServiceException;

	List<T> findAll(Specification<T> spec) throws ServiceException;

	List<T> findAll(Specification<T> spec, Sort sort) throws ServiceException;

	Page<T> findAll(Specification<T> spec, Pageable pageable) throws ServiceException;

	Iterable<T> findAll(PK[] pks) throws ServiceException;

	T save(T entity) throws ServiceException;

	T baseSave(T entity) throws ServiceException;

	Iterable<T> save(Iterable<T> entities) throws ServiceException;

	void delete(PK pk) throws ServiceException;

	void delete(PK[] pks) throws ServiceException;

	void delete(T entity) throws ServiceException;

	void delete(Iterable<T> list) throws ServiceException;

	void deleteAll() throws ServiceException;

	T doAdd(T entity) throws ServiceException;

	Iterable<T> doAdd(Iterable<T> entities) throws ServiceException;

	T doUpdate(T entity) throws ServiceException;

	Iterable<T> doUpdate(Iterable<T> entities) throws ServiceException;

	void doDelete(PK[] pks) throws ServiceException;

	void doDelete(PK pk) throws ServiceException;

	void doDisabled(PK[] pks);

	void doDisabled(PK pk);

	void doEnabled(PK[] pks);

	void doEnabled(PK pk);

}
