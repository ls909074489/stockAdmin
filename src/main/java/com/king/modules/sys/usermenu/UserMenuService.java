package com.king.modules.sys.usermenu;

import java.util.List;

import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.BaseServiceImpl;

/**
 * 快捷菜单service
 * 
 * @ClassName: UserMenuService
 * @author
 * @date 2016年42月27日 07:19:23
 */
@Service
@Transactional
public class UserMenuService extends BaseServiceImpl<UserMenuEntity, String> {

	@Autowired
	private UserMenuDao dao;

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	protected IBaseDAO getDAO() {
		return dao;
	}

	public UserMenuEntity addUserMenu(String funcid, String userid) throws ServiceException {
		UserMenuEntity entity = dao.findByFuncidAndUserid(funcid, userid);
		if (entity == null) {
			entity = new UserMenuEntity();
			entity.setUserid(userid);
			entity.setFuncid(funcid);
			this.doAdd(entity);
		} else {
			this.doUpdate(entity);
		}
		return entity;
	}

	public List<UserMenuEntity> queryUserMenu(String userid) throws ServiceException {
		return dao.findByUseridOrderByTsDesc(userid);
	}

}
