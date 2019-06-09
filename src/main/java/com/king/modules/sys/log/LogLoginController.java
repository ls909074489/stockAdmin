package com.king.modules.sys.log;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.king.common.utils.DateUtil;
import com.king.frame.controller.BaseController;

/**
 * 登录日志
 * @ClassName: LogLoginController
 * @author liusheng
 * @date 2016年4月5日 上午11:50:42
 */
@Controller
@RequestMapping(value = "/sys/log_lgin")
public class LogLoginController extends BaseController<LogLoginEntity> {
	
	@RequestMapping(method = RequestMethod.GET)
	public String view() {
		return "modules/sys/log/log_login_main";
	}

	@Override
	public Map<String, Object> addSearchParam(ServletRequest request) {
		Map<String, Object> addParam = new HashMap<String, Object>();
		addParam.put("EQ_status", "1");
		try {
			String acceptDate = request.getParameter("search_LTE_createtime");
			DateFormat format=new SimpleDateFormat("yyyy-MM-dd");
			if(StringUtils.isNotBlank(acceptDate)) {
				Date d = format.parse(acceptDate);
				d = DateUtil.addDays(d, 1);
				addParam.put("LTE_createtime", DateUtil.dateToString(d));
			}
		} catch (Exception e) {
			e.printStackTrace();
			addParam.clear();
		}
		return addParam;
	}

	
}
