package com.king.frame.service;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.Serializable;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.service.spi.ServiceException;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.king.frame.entity.TreeEntity;
import com.king.frame.specifications.DynamicSpecifications;

/**
 * 树形服务类 基类
 * 
 *
 * @param <T>
 * @param <PK>
 */
@Service
@Transactional(rollbackFor = { Exception.class })
public abstract class TreeServiceImpl<T extends TreeEntity, PK extends Serializable> extends BaseServiceImpl<T, PK> {

	/**
	 * 重写保存方法，保存的同时刷新自身以及下级所有节点的nodePath
	 */
	@Override
	public T save(T entity) throws ServiceException {
		beforeSave(entity);
		boolean isAdd = false;
		boolean codeChange = false;
		String uuid = entity.getUuid();
		if (StringUtils.isBlank(uuid)) {
			isAdd = true;
		}
		if (isAdd) {
			// 新增- 都是末及节点Islast 为true
			entity.setIslast(true);
			// 创建nodePath(节点路径)
			// entity.setNodepath(this.createNodePath(entity));//edit by ls2008
			// 如果父节点的Islast
			if (StringUtils.isNotBlank(entity.getParentId())) {
				T parentEntity = this.getOne((PK) entity.getParentId());
				if (parentEntity != null && parentEntity.getIslast() != null && parentEntity.getIslast()) {
					parentEntity.setIslast(false);
					getDAO().save(parentEntity);
				}
			}
			entity = getDAO().save(entity);
			// 创建nodePath(节点路径)
			entity.setNodepath(this.createNodePath(entity));// edit by ls2008
		} else {
			/*
			 * String oldCode = this.get((PK)uuid).getCode(); if(!entity.getCode().equals(oldCode)){ codeChange = true;
			 * }
			 */
			// 需要判断节点代码是否有修改，如果有修改才刷新节点路径 目前每次修改信息都刷新当前节点及下级的nodepath
			T oldEntity = this.getOne((PK) entity.getUuid());

			codeChange = true;
			// if (!oldEntity.getCode().equals(entity.getCode())) {
			if (codeChange) {
				codeChange = true;
				T parentEntity = this.getOne((PK) entity.getParentId());
				if (parentEntity != null) {
					entity.setNodepath(parentEntity.getNodepath() + "," + entity.getUuid());
				}else{
					entity.setNodepath(entity.getUuid());//如果父节点没有，则以自己的id为主 edit by liusheng
				}
			}
			entity = getDAO().save(entity);
			// 如果修改编码则刷新nodePath(节点路径)
			if (codeChange && oldEntity.getIslast() != null && !oldEntity.getIslast()) {
				refreshNodePathsWithSub(entity.getUuid());
			}
		}
		afterSave(entity);
		return entity;
	}

	// 更新子节点nodepath
	public void refreshNodePathsWithSub(String nodeId) throws ServiceException {
		Iterable<T> treeList = this.findAll();
		List<T> saveList = new ArrayList<T>();
		T curNode = this.getNode(nodeId, treeList);
		String nodePath = createNodePath(curNode, treeList);
		curNode.setNodepath(nodePath);
		saveList.add(curNode);
		createChildrensNodePath(curNode, treeList, saveList);
		getDAO().save(saveList);
	}

	// 创建子节点nodepath
	private void createChildrensNodePath(T curNode, Iterable<T> treeList, List<T> saveList) {
		List<T> children = getChildren(curNode);
		if (children != null && children.size() > 0) {
			for (T node : children) {
				String nodePath = createNodePath(node, treeList);
				node.setNodepath(nodePath);
				saveList.add(node);
				createChildrensNodePath(node, treeList, saveList);
			}
		}
	}

	// 获得所有子节点
	public List<T> getChildren(T curNode) {
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("EQ_parentid", curNode.getUuid());
		Specification<T> spec = DynamicSpecifications.buildSpecification(searchMap, persistentClass);
		List<T> list = getDAO().findAll(spec);
		return list;
	}

	@Override
	public void delete(T t) throws ServiceException {
		beforeDelete(t);
		try {
			T pt = getDAO().findOne((PK) t.getParentId());
			getDAO().delete(t);
			if (pt == null) {
				return;
			}
			Iterable<T> treeList = getDAO().findAll();
			// 判断是否需要更新父节点的Islast,如果找不到子节点，就设置本身为末级别节点
			boolean lastBool = true;
			for (T node : treeList) {
				if (pt.getUuid().equals(node.getParentId()) && !pt.getUuid().equals(t.getUuid())) {
					lastBool = false;
					break;
				}
			}
			// 更新父节点的Islast属性
			if (lastBool) {
				pt.setIslast(true);
				getDAO().save(pt);
			}
			afterDelete(t);
		} catch (Exception e) {
			e.printStackTrace();
            StringWriter sw = new StringWriter();   
            e.printStackTrace(new PrintWriter(sw, true));   
            String strs = sw.toString();   
            try {
            	if(!strs.contains("constraint")){
            		strs=e.getMessage();
            	}
				sw.close();
			} catch (IOException e1) {
				e1.printStackTrace();
				throw new ServiceException(e.getMessage());
			}
			throw new ServiceException(strs);
		}
	}

	/**
	 * 根据主键获取节点路径
	 * 
	 * @author wzw 2014年10月14日
	 * @param pk
	 *            主键
	 * @return
	 */
	public String getNodePath(PK pk) {
		// return ((T) getDAO().findOne(pk)).getNodepath();//edit by ls2008
		T t = getDAO().findOne(pk);
		if (t != null) {
			return t.getNodepath();
		}
		return "";
	}

	/**
	 * 生成某节点的节点路径，以逗号隔开
	 * 
	 * @author wzw 2014年10月14日
	 * @param entity
	 * @return
	 */
	protected String createNodePath(T entity) {
		String nodePath = getNodePath((PK) entity.getParentId());
		if (StringUtils.isBlank(nodePath))
			return entity.getUuid();
		nodePath = nodePath.concat(",").concat(entity.getUuid());
		return nodePath;
	}

	/**
	 * 刷新整一颗树的节点路径
	 * 
	 * @author wzw 2014年10月15日
	 * @param t
	 */
	public void refreshNodePaths() throws ServiceException {
		Iterable<T> treeList = getDAO().findAll();
		List<T> saveList = new ArrayList<T>();
		for (T node : treeList) {
			String nodePath = createNodePath(node, treeList);
			node.setNodepath(nodePath);
			saveList.add(node);
		}
		getDAO().save(saveList);
	}

	/**
	 * 根据节点和整棵树生成该节点的路径，以逗号隔开
	 * 
	 * @author wzw 2014年10月15日
	 * @param node
	 * @param treeList
	 * @return
	 */
	private String createNodePath(T node, Iterable<T> treeList) {
		String nodePath = node.getUuid();

		String pid = node.getParentId();
		while (true) {
			T pnode = getNode(pid, treeList);
			if (pnode == null)
				break;
			nodePath = pnode.getUuid() + "," + nodePath;
			pid = pnode.getParentId();
		}
		return nodePath;
	}

	/**
	 * 
	 * @author wzw 2014年10月15日
	 * @param pk
	 *            节点主键
	 * @param treeList
	 *            整棵树
	 * @return
	 */
	private T getNode(String pk, Iterable<T> treeList) {
		if (StringUtils.isBlank(pk))
			return null;
		for (T pnode : treeList) {
			if (pnode.getUuid().equals(pk)) {
				return pnode;
			}
		}
		return null;
	}

}
