package com.king.frame.tree;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;

import com.king.frame.entity.ITreeEntity;

public class TreeUtils {
	public static TreeNode getTreeNode(ITreeEntity entity, List<ITreeEntity> list) {
		TreeNode node = new TreeNode(entity);
		node.setId(entity.getUuid());
		node.setName(entity.getName());
		node.setPid(entity.getParentId());

		if ("root".equals(node.getId())) {
			node.setOpen(true);
		}

		node.setIcon("");
		node.setUrl("");

		List<TreeNode> cnodes = new ArrayList<TreeNode>();
		for (ITreeEntity oc : list) {
			if (entity.getIslast() == null) {
				node.setParentname(oc.getName());
			}
			if (entity.getIslast()) {
				if (!"root".equals(node.getId()) && entity.getParentId().equals(oc.getUuid())) {
					node.setParentname(oc.getName());
				}
			} else {
				if (!"root".equals(node.getId()) && entity.getParentId().equals(oc.getUuid())) {
					node.setParentname(oc.getName());
				}
				// 递归设置子节点
				if (entity.getUuid().equals(oc.getParentId())) {
					TreeNode cnode = getTreeNode(oc, list);
					cnodes.add(cnode);
				}

			}
			node.setChildren(cnodes);
		}
		return node;
	}

	public static List<TreeNode> getTreeNodes(List<ITreeEntity> list) {
		List<TreeNode> nodes = new ArrayList<TreeNode>();
		for (ITreeEntity item : list) {
			TreeNode node = getTreeNode(item, list);
			Object a = node.getNodeData(); 
			nodes.add(node);
		}
		
		return nodes;
	}

	/**
	 * 重新组装树
	 * 
	 * @author wzw 2014年11月28日
	 * @param treeList
	 * @return
	 */
	public static List createTree(List<ITreeEntity> treeList) {
		// 找出根节点
		List<ITreeEntity> roots = findRoots(treeList);
		// 自根到叶子层层组装
		for (ITreeEntity root : roots) {
			createChildren(root, treeList);
		}
		return roots;
	}

	public static void createChildren(ITreeEntity root, List<ITreeEntity> treeList) {
		String id = root.getUuid();
		List<ITreeEntity> children = new ArrayList<ITreeEntity>();
		for (ITreeEntity node : treeList) {
			if (id.equals(node.getParentId())) {
				children.add(node);
				createChildren(node, treeList);
			}
		}
	}

	private static List<ITreeEntity> findRoots(List<ITreeEntity> treeList) {
		List<ITreeEntity> roots = new ArrayList<ITreeEntity>();
		for (ITreeEntity node : treeList) {
			if (node.getParentId() == null || StringUtils.isBlank(node.getParentId())) {
				roots.add(node);
			}
		}
		return roots;
	}

}
