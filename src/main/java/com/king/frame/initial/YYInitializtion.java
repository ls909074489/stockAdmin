package com.king.frame.initial;

import java.util.List;
import java.util.Map;

import org.hibernate.service.spi.ServiceException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.stereotype.Service;

import com.king.frame.redis.YYRedisCache;
import com.king.modules.sys.alertmsg.AlertmsgService;
import com.king.modules.sys.alertmsg.YYMsg;
import com.king.modules.sys.documents.DocumentsService;
import com.king.modules.sys.documents.DocumentsUtil;
import com.king.modules.sys.enumdata.EnumDataService;
import com.king.modules.sys.enumdata.EnumDataSubEntity;
import com.king.modules.sys.enumdata.EnumDataUtils;
import com.king.modules.sys.imexlate.ImexlateService;
import com.king.modules.sys.org.OrgService;
import com.king.modules.sys.org.OrgUtils;
import com.king.modules.sys.param.ParameterService;
import com.king.modules.sys.param.ParameterUtil;

/**
 * 启动初始化类
 * 
 * @author zhangcb
 *
 */
@Service
public class YYInitializtion implements ApplicationListener<ContextRefreshedEvent> {

	private static Logger logger = LoggerFactory.getLogger(YYInitializtion.class);

	@Autowired
	ParameterService parameterService;

	@Autowired
	OrgService orgService;

	@Autowired
	EnumDataService enumDataService;

	@Autowired
	AlertmsgService alertmsgService;

	@Autowired
	ImexlateService imexlateService;

	@Autowired
	YYRedisCache yyRedisCache;
	
	@Autowired
	DocumentsService documentsService;

	@Override
	public void onApplicationEvent(ContextRefreshedEvent event) {
		if (event.getApplicationContext().getParent() == null) {
			// 在bean初始化前执行
			beforeInitialization(event);
		} else {
			// 在bean初始 后 前执行
			afterInitialization(event);
		}
	}

	/**
	 * 在bean初始前执行
	 * 
	 * @param event
	 */
	public void beforeInitialization(ContextRefreshedEvent event) {
		// System.out.println("----------在bean初始前执行:--------------");
		// CacheManager cacheManager = CacheManager.create();
	}

	/**
	 * 在bean初始后执行
	 * 
	 * @param event
	 */
	public void afterInitialization(ContextRefreshedEvent event) {

		System.out.println(">>>>>>>>>> 平台开始处理缓存:--------------");

		try {
			Map<String, List<EnumDataSubEntity>> enumMap = enumDataService.getEnumDataMap();
			EnumDataUtils.updateEnumDatas(enumMap);
			logger.info(">>>>>>>>>> 加载枚举完成！>>>>>>>>");
		} catch (ServiceException e) {
			logger.error(">>>>>>>>> 加载枚举失败！！！>>>>>>>>");
			e.printStackTrace();
		}

		try {
			ParameterUtil.updateParam(parameterService.findAll());
			logger.info(">>>>>>>>>> 系统参数加载完成！>>>>>>>>");
		} catch (ServiceException e) {
			logger.error(">>>>>>>>> 系统参数参数失败！>>>>>>>>");
			e.printStackTrace();
		}

		try {
			YYMsg.updateEntitys(alertmsgService.findAll());
			logger.info(">>>>>>>>>> 消息提示信息缓存加载完成！>>>>>>>>");
		} catch (ServiceException e) {
			logger.error(">>>>>>>>> 消息提示信息缓存加载失败！>>>>>>>>");
			e.printStackTrace();
		}


		try {
			OrgUtils.updateEntitys(orgService.findAll());
			logger.info(">>>>>>>>>> 组织架构缓存加载完成！>>>>>>>>");
		} catch (ServiceException e) {
			logger.error(">>>>>>>>> 组织架构缓存加载失败！>>>>>>>>");
			e.printStackTrace();
		}


		try {
			imexlateService.initImexlate();
			logger.info(">>>>>>>>>> 导出导入模板生成完成！>>>>>>>>");
		} catch (ServiceException e) {
			logger.error(">>>>>>>>> 导出导入模板生成失败！！！>>>>>>>>");
			e.printStackTrace();
		}
		
		try {
			DocumentsUtil.updateEntitys(documentsService.findAll());
			logger.info(">>>>>>>>>> 单据号规则缓存加载完成！>>>>>>>>");
		} catch (ServiceException e) {
			logger.error(">>>>>>>>> 单据号规则缓存加载失败！>>>>>>>>");
			e.printStackTrace();
		}

	}

}