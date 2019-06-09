package com.king.modules.sys.usermenu;

import java.util.List;

import com.king.frame.dao.IBaseDAO;

/**
 * 快捷菜单dao
 * 
 * @ClassName: UserMenuDao
 * @author
 * @date 2016年42月27日 07:19:23
 */
public interface UserMenuDao extends IBaseDAO<UserMenuEntity, String> {

	UserMenuEntity findByFuncidAndUserid(String funcid, String uuid);

	List<UserMenuEntity> findByUseridOrderByTsDesc(String userid);

}
