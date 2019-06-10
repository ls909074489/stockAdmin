package com.king.modules.sys.mappingtable;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.BaseServiceImpl;


/**
 * 
 * @ClassName: AuditColsService
 * @author liusheng
 * @date 2017年11月21日 下午5:42:21
 */
@Service
@Transactional
public class MappingTableService extends BaseServiceImpl<MappingTableEntity, String> {

	@Autowired
	private MappingTableDao dao;


	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	protected IBaseDAO getDAO() {
		return dao;
	}
	
	
	public List<MappingTableEntity> findByOrgId(String orgId){
		return dao.findByOrgId(orgId);
	}
}
