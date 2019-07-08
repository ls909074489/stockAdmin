package com.king.modules.sys.job.tasklog;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.king.frame.controller.ActionResultModel;
import com.king.frame.controller.BaseController;

/**
* @ClassName: JobTaskLogController  
* @Description: 定时任务日志
* @author WangMin
* @date 2016年3月28日 上午10:43:09
 */
@Controller
@RequestMapping(value = "/sys/job/tasklog")
public class TimedTaskLogController extends BaseController<TimedTaskLogEntity> {
	 
	/**
	 * 已经在CSC中重新
	 */
	@Autowired
	private TimedTaskLogService timedTaskLogService;
	
	/**
	 * 跳转页面
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET)
	public String view() {
		return "modules/sys/job/tasklog/tasklog_main";
	}
	
	/**
	 * 保存数据
	 */
	@RequestMapping(value = "/onlySaveData")
	@ResponseBody
	public ActionResultModel<TimedTaskLogEntity> onlySaveData(String uuid,String content) {
		ActionResultModel<TimedTaskLogEntity> arm = new ActionResultModel<TimedTaskLogEntity>();
		try {
			timedTaskLogService.onlySaveData(uuid,content);
			arm.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
		}
		return arm;
	}
	

	/* 跳转到编辑页面
	@Override
	public String editView(Model model, ServletRequest request, TimedTaskLogEntity entity) {
		try{
			model.addAttribute("entity",entity);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "modules/sys/job/tasklog/tasklog_edit";
	}*/
	

	/**
	 * 执行保存的数据
	 * @param timedTaskLog
	 * @return
	 */
	@RequestMapping(value = "/resumeData")
	@ResponseBody
	public ActionResultModel<TimedTaskLogEntity> resumeData(String[] pks) {
		ActionResultModel<TimedTaskLogEntity> arm = new ActionResultModel<TimedTaskLogEntity>();
		try {
			timedTaskLogService.resumeData(pks);
			arm.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
		}
		return arm;
	}
	
	/**
	 * 重新执行接口
	 * @param pks
	 * @return
	 */
	@RequestMapping(value = "/resumeRequest")
	@ResponseBody
	public ActionResultModel<TimedTaskLogEntity> resumeRequest(String[] pks) {
		ActionResultModel<TimedTaskLogEntity> arm = new ActionResultModel<TimedTaskLogEntity>();
		try {
			timedTaskLogService.resumeRequest(pks);
			arm.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
		}
		return arm;
	}

}




