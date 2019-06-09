package com.king.modules.sys.alertmsg;

import java.util.HashMap;
import java.util.Map;

import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.BaseServiceImpl;

/**
 * 提示语service
 * 
 * @ClassName: AlertmsgService
 * @author
 * @date 2016年19月24日 10:10:52
 */
@Service
@Transactional
public class AlertmsgService extends BaseServiceImpl<AlertmsgEntity, String> {

	@Autowired
	private AlertmsgDao dao;

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	protected IBaseDAO getDAO() {
		return dao;
	}

	@Override
	public void beforeSave(AlertmsgEntity entity) {
		YYMsg.updateEntity(entity);
		super.beforeSave(entity);
	}

	/**
	 * 获取
	 * 
	 * @return
	 * @throws ServiceException
	 */
	public Map<String, AlertmsgEntity> getAlertMsg() throws ServiceException {
		Map<String, AlertmsgEntity> map = new HashMap<String, AlertmsgEntity>();
		try {
			Iterable<AlertmsgEntity> list = this.findAll(getDefaultSort());
			// 处多次查询数据库，效率问题有待测试
			for (AlertmsgEntity en : list) {
				map.put(en.getAcode(), en);
			}
		} catch (Exception e) {
			throw new ServiceException(e.getMessage());
		}
		return map;
	}

}
