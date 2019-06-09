package com.king.frame.controller;

import com.king.frame.entity.ITreeEntity;
import com.king.frame.service.TreeServiceImpl;

public class TreeController<T extends ITreeEntity> extends BaseController<T> {
	private TreeServiceImpl getService() {
		return (TreeServiceImpl) super.baseService;
	}
}
