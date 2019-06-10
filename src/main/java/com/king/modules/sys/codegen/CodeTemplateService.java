package com.king.modules.sys.codegen;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.BaseServiceImpl;

/**
 * 物料类型service
 * @ClassName: CodeTemplateService
 * @author  
 * @date 2019年52月10日 03:15:55
 */
@Service
@Transactional
public class CodeTemplateService extends BaseServiceImpl<CodeTemplateEntity, String> {

	@Autowired
	private CodeTemplateDao dao;
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	protected IBaseDAO getDAO() {
		return dao;
	}

}
