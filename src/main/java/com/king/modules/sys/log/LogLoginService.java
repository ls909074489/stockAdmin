package com.king.modules.sys.log;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.king.common.utils.DateUtil;
import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.BaseServiceImpl;

/**
 * 登录日志
 * 
 * @ClassName: LogLoginService
 * @author liusheng
 * @date 2016年3月29日 上午9:15:10
 */
@Service
@Transactional
public class LogLoginService extends BaseServiceImpl<LogLoginEntity, String> {
	@Autowired
	private LogLoginDAO dao;

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	protected IBaseDAO getDAO() {
		return dao;
	}

	/**
	 * 
	 * @Title: findByUserName @author liusheng @date 2016年3月29日 上午10:41:40 @param @param userName @param @return
	 *         设定文件 @return List<LogLoginEntity> 返回类型 @throws
	 */
	public List<LogLoginEntity> findByUserName(String userName) {
		return dao.findByUserName(userName);
	}

	/**
	 * 删除 n 天前日志
	 */
	public void deleteLog(int nday) {
		Date date = DateUtil.getDateBefore(new Date(), nday);
		dao.deleteByTime(date);
	}

}
