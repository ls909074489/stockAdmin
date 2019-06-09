package com.king.modules.sys.param;

import java.util.List;

import com.king.frame.dao.IBaseDAO;

/*
*	版权信息 (c) RAP 保留所有权利.
*
*	维护历史:
*	新建
*/
/**
 * 系统参数 DAO类
 * 
 * @author RAP Team
 *
 */

public interface ParameterDAO extends IBaseDAO<ParameterEntity, String> {

	ParameterEntity findByParamtercode(String paramtercode);

	List<ParameterEntity> findByGroudcode(String groudcode);
}
