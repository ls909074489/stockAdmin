package com.king.modules.sys.job.log;

import javax.servlet.ServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.king.frame.controller.ActionResultModel;
import com.king.frame.controller.BaseController;

/**
 * 后台任务日志controller
 * 
 * @ClassName: JobLogController
 * @author
 * @date 2016年37月18日 04:16:00
 */
@Controller
@RequestMapping(value = "/job/log")
public class JobLogController extends BaseController<JobLogEntity> {

	private JobLogService getService() {
		return (JobLogService) super.baseService;
	}

	/**
	 * 
	 */
	@RequestMapping(method = RequestMethod.GET)
	public String view(Model model) {

		return "modules/sys/job/log/log_main";
	}

	/**
	 * 视图
	 */
	@RequestMapping(value = "/showJobLog", method = RequestMethod.GET)
	public String showJobLog(ServletRequest request, Model model) {
		model.addAttribute("jobname", request.getParameter("jobname"));
		return "modules/sys/job/log/joblog_show";
	}

	@RequestMapping(value = "/deleteJobLog", method = RequestMethod.POST)
	@ResponseBody
	public ActionResultModel<JobLogEntity> deleteJobLog(Model model, @RequestParam(value = "jobname") String jobname) {
		ActionResultModel<JobLogEntity> arm = new ActionResultModel<JobLogEntity>();
		try {
			getService().deleteJobLogByJobname(jobname);
			arm.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
		}
		return arm;
	}

}
