package com.king.modules.sys.job.ctrl;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.quartz.SchedulerException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.king.frame.controller.ActionResultModel;
import com.king.modules.sys.job.schedule.JobSchedule;
import com.king.modules.sys.job.schedule.JobScheduleVo;

/**
 * 后台任务控制层
 * 
 * @author xuechen
 * @date 2016年1月5日 上午9:57:15
 */
@Controller
@RequestMapping(value = "/sys/job")
public class JobController {

	@Autowired
	private JobService jobService;

	/**
	 * 跳转页面
	 * 
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET)
	public String view() {
		return "/modules/sys/job/job_main";
	}

	/**
	 * 设置立即执行参数
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/setRunParam")
	public String materialBill(Model model, String jobId, String callBackMethod, HttpServletRequest request) {
		String view = "/modules/sys/job/job_run";
		model.addAttribute("jobId", jobId);
		if (StringUtils.isNotBlank(callBackMethod)) {
			model.addAttribute("callBackMethod", callBackMethod);
		}
		return view;
	}

	/**
	 * 查询
	 * 
	 * @return
	 */
	@RequestMapping(value = "/query")
	@ResponseBody
	public ActionResultModel<JobSchedule> doQuery() {
		ActionResultModel<JobSchedule> arm = new ActionResultModel<JobSchedule>();
		try {
			List<JobSchedule> jobs = jobService.findJob();
			arm.setRecords(jobs);
			arm.setSuccess(true);
		} catch (Exception e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
		}
		return arm;
	}

	/**
	 * 新增
	 * 
	 * @param
	 * @return
	 */
	@RequestMapping(value = "/add")
	@ResponseBody
	private ActionResultModel<JobScheduleVo> add(JobScheduleVo job) {
		ActionResultModel<JobScheduleVo> arm = new ActionResultModel<JobScheduleVo>();
		try {
			jobService.addJob(job);
			arm.setRecords(job);
			arm.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
		}
		return arm;
	}

	/**
	 * 删除
	 * 
	 * @param pks	testQuart_01
	 * @return
	 */
	@RequestMapping(value = "/delete")
	@ResponseBody
	public ActionResultModel<JobSchedule> delete(String[] pks) {
		ActionResultModel<JobSchedule> arm = new ActionResultModel<JobSchedule>();
		try {
			jobService.deleteJob(pks);
			arm.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
		}
		return arm;
	}

	/**
	 * 更新
	 * 
	 * @param job
	 * @return
	 */
	@RequestMapping(value = "/update")
	@ResponseBody
	public ActionResultModel<JobScheduleVo> update(JobScheduleVo job) {
		ActionResultModel<JobScheduleVo> arm = new ActionResultModel<JobScheduleVo>();
		try {
			jobService.updateJob(job);
			arm.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
		}
		return arm;
	}

	/**
	 * 运行、立即执行
	 * 
	 * @param job
	 * @throws SchedulerException
	 */
	@RequestMapping(value = "/runNow")
	@ResponseBody
	public ActionResultModel<JobSchedule> runNow(String jobId, String parameterJson) {
		ActionResultModel<JobSchedule> arm = new ActionResultModel<JobSchedule>();
		try {
			jobService.runNow(jobId, parameterJson);
			arm.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
		}
		return arm;
	}

	/**
	 * 运行
	 * 
	 * @param job
	 * @throws SchedulerException
	 * 
	 * @RequestMapping(value = "/runNow")
	 * @ResponseBody public ActionResultModel<JobSchedule> runNow(JobSchedule jobSchedule) { ActionResultModel
	 *               <JobSchedule> arm = new ActionResultModel<JobSchedule>(); try { jobService.runNow(jobSchedule);
	 *               arm.setSuccess(true); }catch(Exception e){ e.printStackTrace(); arm.setSuccess(false);
	 *               arm.setMsg(e.getMessage()); } return arm; }
	 */

	/**
	 * 暂停
	 * 
	 * @param job
	 * @throws SchedulerException
	 */
	@RequestMapping(value = "/pauseJob")
	@ResponseBody
	public ActionResultModel<JobSchedule> pauseJob(String[] pks) {
		ActionResultModel<JobSchedule> arm = new ActionResultModel<JobSchedule>();
		try {
			jobService.pauseJob(pks);
			arm.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
		}
		return arm;
	}

	/**
	 * 恢复
	 * 
	 * @param job
	 * @throws SchedulerException
	 */
	@RequestMapping(value = "/resumeJob")
	@ResponseBody
	public ActionResultModel<JobSchedule> resumeJob(String[] pks) {
		ActionResultModel<JobSchedule> arm = new ActionResultModel<JobSchedule>();
		try {
			jobService.resumeJob(pks);
			arm.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
		}
		return arm;
	}

}
