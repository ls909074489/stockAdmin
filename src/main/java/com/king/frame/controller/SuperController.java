package com.king.frame.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.validation.Valid;

import org.hibernate.service.spi.ServiceException;
import org.springframework.orm.ObjectOptimisticLockingFailureException;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.king.frame.entity.SuperEntity;
import com.king.frame.service.SuperServiceImpl;

public class SuperController<T extends SuperEntity> extends BaseController<T> {

	@SuppressWarnings("rawtypes")
	private SuperServiceImpl getService() {
		return (SuperServiceImpl) super.baseService;
	}
	
	/** 
	* @Title: getObjectOptimsMsg 
	* @param e    设定文件 
	* @return void    返回类型 
	* @author linjq
	* @date 2016年7月8日 上午12:39:49 
	* @throws 
	*/
	private String getObjectOptimsMsg(ObjectOptimisticLockingFailureException e) {
		return "您的数据已经被他人修改，请刷新后再操作。";
	}


	/**
	 * 此处添加查询参数,用Map替代null,格式：LIKE_loginName=aa key和value都是String类型的。 addParam.put("LIKE_loginName", "aa");
	 * addParam.put("EQ_validDate", "2014-10-01");
	 * 
	 * @return
	 */
	public Map<String, Object> addSearchParam(ServletRequest request) {
		Map<String, Object> addParam = new HashMap<String, Object>();
		addParam.put("EQ_status", "1");
		return addParam;
	}
	
	
	/**
	 * 提交
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/submit")
	@ResponseBody
	public ActionResultModel Submit(ServletRequest request, Model model,
			@Valid @ModelAttribute("preloadEntity") T entity) {
		return doSubmit(request, model, entity);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	protected ActionResultModel doSubmit(ServletRequest request, Model model, T entity) {
		ActionResultModel arm = new ActionResultModel();
		try {
			entity = (T) getService().doSubmit(entity);
			arm.setRecords(entity);
			arm.setSuccess(true);
		} catch (ServiceException e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
			e.printStackTrace();
		} catch (ObjectOptimisticLockingFailureException e) {
			e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg(getObjectOptimsMsg(e));
		}
		return arm;
	}


	/**
	 * 批量提交
	 */
	@RequestMapping(value = "/batchSubmit")
	@ResponseBody
	public ActionResultModel<T> batchSubmit(ServletRequest request, Model model, String[] pks) {
		return doBatchSubmit(request, model, pks);
	}

	@SuppressWarnings({ "unchecked" })
	protected ActionResultModel<T> doBatchSubmit(ServletRequest request, Model model, String[] pks) {
		ActionResultModel<T> arm = new ActionResultModel<T>();
		try {
			getService().doBatchSubmit(pks);
			arm.setSuccess(true);
		} catch (ServiceException e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
			e.printStackTrace();
		} catch (ObjectOptimisticLockingFailureException e) {
			e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg(getObjectOptimsMsg(e));
		}
		return arm;
	}

	/**
	 * 撤销提交
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/unSubmit")
	@ResponseBody
	public ActionResultModel unSubmit(ServletRequest request, Model model,
			@Valid @ModelAttribute("preloadEntity") T entity) {
		return doUnSubmit(request, model, entity);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	protected ActionResultModel doUnSubmit(ServletRequest request, Model model, T entity) {
		ActionResultModel arm = new ActionResultModel();
		try {
			entity = (T) getService().doUnSubmit(entity);
			arm.setRecords(entity);
			arm.setSuccess(true);
		} catch (ServiceException e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
			e.printStackTrace();
		} catch (ObjectOptimisticLockingFailureException e) {
			e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg(getObjectOptimsMsg(e));
		}
		return arm;
	}
	
	/**
	 * 批量撤销提交
	 */
	@RequestMapping(value = "/batchUnSubmit")
	@ResponseBody
	public ActionResultModel<T> batchUnSubmit(ServletRequest request, Model model, String[] pks) {
		return doBatchUnSubmit(request, model, pks);
	}

	@SuppressWarnings({ "unchecked" })
	protected ActionResultModel<T> doBatchUnSubmit(ServletRequest request, Model model, String[] pks) {
		ActionResultModel<T> arm = new ActionResultModel<T>();
		try {
			getService().doBatchUnSubmit(pks);
			arm.setSuccess(true);
		} catch (ServiceException e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
			e.printStackTrace();
		} catch (ObjectOptimisticLockingFailureException e) {
			e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg(getObjectOptimsMsg(e));
		}
		return arm;
	}
	
	
	
	/**
	 * 保存并提交
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/saveSubmit")
	@ResponseBody
	public ActionResultModel saveSubmit(ServletRequest request, Model model, @Valid T entity) {
		return doSaveSubmit(request, model, entity);
	}

	@SuppressWarnings("unchecked")
	protected ActionResultModel<T> doSaveSubmit(ServletRequest request, Model model, T entity) {
		ActionResultModel<T> arm = new ActionResultModel<T>();
		try {
			getService().doSaveSubmit(entity);
			arm.setSuccess(true);
		} catch (ServiceException e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
			e.printStackTrace();
		} catch (ObjectOptimisticLockingFailureException e) {
			e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg(getObjectOptimsMsg(e));
		}
		return arm;
	}

	/**
	 * 修改并提交
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/updateSubmit")
	@ResponseBody
	public ActionResultModel updateSubmit(ServletRequest request, Model model,
			@Valid @ModelAttribute("preloadEntity") T entity) {
		return doUpdateSubmit(request, model, entity);
	}
	

	@SuppressWarnings({ "rawtypes", "unchecked" })
	protected ActionResultModel doUpdateSubmit(ServletRequest request, Model model, T entity) {
		ActionResultModel arm = new ActionResultModel();
		try {
			getService().doSaveSubmit(entity);
			arm.setSuccess(true);
		} catch (ServiceException e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
			e.printStackTrace();
		} catch (ObjectOptimisticLockingFailureException e) {
			e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg(getObjectOptimsMsg(e));
		}
		return arm;
	}

	

	/**
	 * 退回
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/revoke")
	@ResponseBody
	public ActionResultModel Revoke(ServletRequest request, Model model,
			@Valid @ModelAttribute("preloadEntity") T entity,
			@RequestParam(value = "approveRemark", required = false) String approveRemark) {
		return doRevoke(request, model, entity,approveRemark);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	protected ActionResultModel doRevoke(ServletRequest request, Model model, T entity,String approveRemark) {
		ActionResultModel arm = new ActionResultModel();
		try {
			entity = (T) getService().doRevoke(entity,approveRemark);
			arm.setRecords(entity);
			arm.setSuccess(true);
		} catch (ServiceException e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
			e.printStackTrace();
		} catch (ObjectOptimisticLockingFailureException e) {
			e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg(getObjectOptimsMsg(e));
		}
		return arm;
	}

	/**
	 * 批量退回
	 */
	@SuppressWarnings({ "rawtypes" })
	@RequestMapping(value = "/batchRevoke")
	@ResponseBody
	public ActionResultModel batchRevoke(ServletRequest request, Model model, String[] pks,
			@RequestParam(value = "approveRemark", required = false) String approveRemark) {
		return doBatchRevoke(request, model, pks, approveRemark);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	protected ActionResultModel doBatchRevoke(ServletRequest request, Model model, String[] pks, String approveRemark) {
		ActionResultModel arm = new ActionResultModel();
		try {
			getService().doBatchRevoke(pks, approveRemark);
			arm.setSuccess(true);
		} catch (ServiceException e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
			e.printStackTrace();
		} catch (ObjectOptimisticLockingFailureException e) {
			e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg(getObjectOptimsMsg(e));
		}
		return arm;
	}

	/**
	 * 审核
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/approve")
	@ResponseBody
	public ActionResultModel approve(ServletRequest request, Model model,
			@Valid @ModelAttribute("preloadEntity") T entity,
			@RequestParam(value = "approveRemark", required = false) String approveRemark) {
		return doApprove(request, model, entity, approveRemark);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	protected ActionResultModel doApprove(ServletRequest request, Model model, T entity, String approveRemark) {
		ActionResultModel arm = new ActionResultModel();
		try {
			entity = (T) getService().doApprove(entity, approveRemark);
			arm.setRecords(entity);
			arm.setSuccess(true);
		} catch (ServiceException e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
			e.printStackTrace();
		}
		catch (ObjectOptimisticLockingFailureException e) {
			e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg(getObjectOptimsMsg(e));
		}
		return arm;
	}


	/**
	 * 批量审核
	 */
	@SuppressWarnings({ "rawtypes" })
	@RequestMapping(value = "/batchApprove")
	@ResponseBody
	public ActionResultModel batchApprove(ServletRequest request, Model model, String[] pks,
			@RequestParam(value = "approveRemark", required = false) String approveRemark) {
		return doBatchApprove(request, model, pks, approveRemark);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	protected ActionResultModel doBatchApprove(ServletRequest request, Model model, String[] pks,
			String approveRemark) {
		ActionResultModel arm = new ActionResultModel();
		try {
			getService().doBatchApprove(pks, approveRemark);
			arm.setSuccess(true);
		} catch (ServiceException e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
			e.printStackTrace();
		} catch (ObjectOptimisticLockingFailureException e) {
			e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg(getObjectOptimsMsg(e));
		}
		return arm;
	}

	/**
	 * 批量反审核
	 */
	@SuppressWarnings({ "rawtypes" })
	@RequestMapping(value = "/batchUnApprove")
	@ResponseBody
	public ActionResultModel batchUnApprove(ServletRequest request, Model model, String[] pks,
			@RequestParam(value = "approveRemark", required = false) String approveRemark) {
		return doBatchUnApprove(request, model, pks, approveRemark);
	}
	
	
	/**
	 * 反审核
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/unApprove")
	@ResponseBody
	public ActionResultModel unApprove(ServletRequest request, Model model,
			@Valid @ModelAttribute("preloadEntity") T entity) {
		return doUnApprove(request, model, entity);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	protected ActionResultModel doUnApprove(ServletRequest request, Model model, T entity) {
		ActionResultModel arm = new ActionResultModel();
		try {
			entity = (T) getService().doUnApprove(entity);
			arm.setRecords(entity);
			arm.setSuccess(true);
		} catch (ServiceException e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
			e.printStackTrace();
		} catch (ObjectOptimisticLockingFailureException e) {
			e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg(getObjectOptimsMsg(e));
		}
		return arm;
	}
	

	@SuppressWarnings({ "rawtypes", "unchecked" })
	protected ActionResultModel doBatchUnApprove(ServletRequest request, Model model, String[] pks,
			String approveRemark) {
		ActionResultModel arm = new ActionResultModel();
		try {
			getService().doBatchUnApprove(pks, approveRemark);
			arm.setSuccess(true);
		} catch (ServiceException e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
			e.printStackTrace();
		} catch (ObjectOptimisticLockingFailureException e) {
			e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg(getObjectOptimsMsg(e));
		}
		return arm;
	}

}
