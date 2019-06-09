package com.king.modules.sys.user;


import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;

import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.BaseServiceImpl;
import com.king.modules.sys.org.OrgEntity;

/**
 * 用户关联的业务单元
 * @ClassName: UserOrgService
 * @author liusheng 
 * @date 2016年2月18日 下午8:14:12
 */
@Service
@Transactional
public class UserOrgService extends BaseServiceImpl<UserOrgEntity, String>{
	
	@Autowired
	private UserOrgDAO dao;
	@Autowired
	@Lazy
	private UserService userService;
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	protected IBaseDAO getDAO() {
		return dao;
	}

	
	public void deleteByUserid(String userId){
		dao.deleteByUserId(userId);
	}


	public void addUserOrg(OrgEntity afterEntity) {
		List<UserEntity> userList=(List<UserEntity>) userService.findAll();
		List<UserOrgEntity> list=new ArrayList<UserOrgEntity>();
		for(UserEntity user:userList){
			UserOrgEntity userOrg=new UserOrgEntity();
			userOrg.setUser_id(user.getUuid());
			userOrg.setPk_corp(afterEntity.getUuid());
			list.add(userOrg);
		}
		doAdd(list);
	}
	
}
