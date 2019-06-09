package com.king.modules.sys.notice;

import java.util.List;

import javax.servlet.ServletRequest;

import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.king.common.utils.DateUtil;
import com.king.frame.controller.ActionResultModel;
import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.BaseServiceImpl;

@Service
@Transactional
public class NoticeService extends BaseServiceImpl<NoticeEntity, String> {

	@Autowired
	private NoticeDAO dao;

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	protected IBaseDAO getDAO() {
		return dao;
	}

	@Override
	public Iterable<NoticeEntity> save(Iterable<NoticeEntity> entities) throws ServiceException {
		return super.save(entities);
	}

	/**
	 * 发布
	 * 
	 * @param pks
	 * @return
	 */
	public ActionResultModel<NoticeEntity> publish(ServletRequest request, Model model, String[] pks) {
		List<NoticeEntity> list = (List<NoticeEntity>) findAll(pks);// <NoticeEntity>
		ActionResultModel<NoticeEntity> arm = new ActionResultModel<NoticeEntity>();
		NoticeEntity entity = null;
		try {
			for (int i = 0; i < list.size(); i++) {
				entity = list.get(i);
				entity.setIssue_date(DateUtil.getDateTime());
				entity.setPublisher("1");
				entity.setNotice_status("已发布");
				entity = save(entity);
				list.set(i, entity);
			}
			arm.setRecords(list);
			arm.setSuccess(true);
		} catch (ServiceException e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
		} catch (Exception e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
		}

		return arm;
	}

	/**
	 * 取消发布
	 * 
	 * @param pks
	 * @return
	 */
	public ActionResultModel<NoticeEntity> unpublish(ServletRequest request, Model model, String[] pks) {
		List<NoticeEntity> list = (List<NoticeEntity>) findAll(pks);// <NoticeEntity>
		ActionResultModel<NoticeEntity> arm = new ActionResultModel<NoticeEntity>();
		NoticeEntity entity = null;
		try {
			for (int i = 0; i < list.size(); i++) {
				entity = list.get(i);
				entity.setIssue_date("");
				entity.setPublisher("");
				entity.setNotice_status("未发布");
				entity = save(entity);
				list.set(i, entity);
			}
			arm.setRecords(list);
			arm.setSuccess(true);
		} catch (ServiceException e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
		} catch (Exception e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
		}

		return arm;
	}

	/**
	 * 获取NoticeList
	 * 
	 * @return
	 */
	public List<NoticeEntity> getNoticeList() {
		return dao.getNoticeList();
	}

}
