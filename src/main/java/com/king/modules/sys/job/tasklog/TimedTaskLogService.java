package com.king.modules.sys.job.tasklog;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.king.common.exception.base.CustomException;
import com.king.common.exception.base.impl.NullParameterException;
import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.BaseServiceImpl;

/**
 * @ClassName: TimedTaskLogService
 * @Description: 定时任务日志service层
 * @author WangMin
 * @date 2016年3月23日 下午6:59:45
 */
@Service
@Transactional
public class TimedTaskLogService extends BaseServiceImpl<TimedTaskLogEntity,String> {

	@Autowired
	private TimedTaskLogDAO dao;// 注入到层接口

	/**
	 * 前台编辑保存数据
	 * 
	 * @param timedTaskLog
	 * */
	public void resumeData(String[] pks) throws CustomException {
		if (pks == null || pks.length < 1) {
			throw new NullParameterException("参数为空");
		}
		try {
			for (int i = 0; i < pks.length; i++) {
				TimedTaskLogEntity timedTaskLog = dao.findByUuid(pks[i]);
				/*
				Class<?> processClass = Class.forName(timedTaskLog.getProcessClass());
				Object o = processClass.newInstance();
				Method procecessMethod = processClass.getMethod(timedTaskLog.getProcessMethod());
				Method saveDataMethod = processClass.getMethod(timedTaskLog.getSaveDataMethod());
				saveDataMethod.getName();
				saveDataMethod.invoke(o);*/
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new CustomException("service无法实例化");
		}
		// 第一步：保存修改后的数据数据
		// 第二步：取出 timedTaskLog 里面 saveDate的方法，然后通过反射new出来
		// 第三步：把json丢进去
	}

	/**
	 * 重新请求接口，获取数据，然后运行
	 * 
	 * @param timedTaskLog
	*/
	public void resumeRequest(String[] pks) {
		System.out.println("TimedTaskLogService.resumeRequest(old)");
	} 

	/**
	 * 只保存日志
	 * @param timedTaskLog
	 * @throws CustomException 
	 */
	public void onlySaveData(String uuid, String content) throws CustomException {
//		//只能改变内容
//		TimedTaskLogEntity temp = dao.findByUuid(uuid);
//		if(temp==null){
//			throw new NullParameterException("已经不存在该日志");
//		}
//		temp.setContent(content);
//		dao.save(temp);
	}
	
	@Override
	protected IBaseDAO<TimedTaskLogEntity, String> getDAO() {
		return dao;
	}

	

}
