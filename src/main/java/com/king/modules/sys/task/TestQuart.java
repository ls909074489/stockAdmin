package com.king.modules.sys.task;
import org.quartz.DisallowConcurrentExecution;
import org.quartz.JobExecutionException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.king.common.utils.DateUtil;
import com.king.modules.sys.job.YYJob;
import com.king.modules.sys.job.schedule.JobSchedule;

@Service("testQuart")
@DisallowConcurrentExecution
public class TestQuart implements YYJob {

	private static Logger logger = LoggerFactory.getLogger(TestQuart.class);

	@Override
	public void execute(JobSchedule schedule) throws JobExecutionException {
		try {
			System.out.println("testQuart>>>>>>>>>>>"+DateUtil.getDateTime());
		} catch (Exception e) {
			logger.info("testQuart 定时器失败：" + e);
		}
	}

}