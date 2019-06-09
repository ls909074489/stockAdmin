package com.king.modules.sys.enumdata;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.BaseServiceImpl;

@Service
@Transactional(rollbackFor={Exception.class})
public class EnumDataSubService extends BaseServiceImpl<EnumDataSubEntity, String>{
	@Autowired
	private EnumDataSubDao dao;
	@Override
	protected IBaseDAO<EnumDataSubEntity, String> getDAO() {
		return dao;
	}
	
	public List<EnumDataSubEntity> findByGroupId(String uuid) {
		return dao.findByGroupId(uuid);
	}
	
	public List<EnumDataSubEntity> findByGroupcode(String groupcode){
		return dao.findByGroupcode(groupcode);
	}
	
	/**
	 * 通过枚举编码和key找到对应的值
	 * @param groupcode
	 * @param enumdatakey
	 * @return
	 */
	public EnumDataSubEntity findByGroupcodeAndEnumDataKey(String groupcode, String enumdatakey){
		List<EnumDataSubEntity> enumsub = dao.findByGroupcodeAndEnumDataKey(groupcode, enumdatakey);
		if(enumsub!=null && enumsub.size()>0) {
			return enumsub.get(0);
		}
		return null;
	}

}
