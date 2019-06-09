package com.king.modules.sys.notice;

import java.util.List;

import javax.servlet.ServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.king.frame.controller.ActionResultModel;
import com.king.frame.controller.BaseController;

@Controller
@RequestMapping(value = "/sys/notice")
public class NoticeController extends BaseController<NoticeEntity> {

	private NoticeService getService() {
		return (NoticeService) super.baseService;
	}
	
	private String noticeId;

	@RequestMapping(method = RequestMethod.GET)
	public String view() {
		return "modules/sys/notice/notice_main";
	}
	
	/**
	 * 发布
	 * 
	 * @param pks
	 * @return
	 */
	@RequestMapping(value = "/publish")
	@ResponseBody
	public ActionResultModel<NoticeEntity> publish(ServletRequest request, Model model, String[] pks) {
		return getService().publish(request, model, pks);
	}
	
	/**
	 * 取消发布
	 * 
	 * @param pks
	 * @return
	 */
	@RequestMapping(value = "/unpublish")
	@ResponseBody
	public ActionResultModel<NoticeEntity> unpublish(ServletRequest request, Model model, String[] pks) {
		return getService().unpublish(request, model, pks);
	}

	@RequestMapping(value = "/getNoticeViewList")
	@ResponseBody
	public ActionResultModel<NoticeEntity> getNoticeViewList(Model model, int limitAmt) {
		ActionResultModel<NoticeEntity> arm = new ActionResultModel<NoticeEntity>();
		try {
			List<NoticeEntity> noticeList = getService().getNoticeList();
			if(noticeList.size() >= limitAmt){
				noticeList.subList(0, limitAmt);
			}
			arm.setRecords(noticeList);
			arm.setTotal(0);
			arm.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			arm.setMsg(e.getMessage());
		}
		return arm;
	}

	@RequestMapping(value = "/viewNotice")
	public String viewNotice(Model model, String uuid) {
		noticeId = uuid;
		NoticeEntity notice = getService().getOne(noticeId);
		model.addAttribute("notice", notice);
		return "modules/sys/notice/notice_contentView";
	}
	
	@RequestMapping(value="showMoreNotice")
	public String showMoreNotice() {
		return "modules/sys/notice/notice_viewList";
	}
}