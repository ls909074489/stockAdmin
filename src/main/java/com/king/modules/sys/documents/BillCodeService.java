package com.king.modules.sys.documents;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

import com.king.modules.sys.param.ParameterUtil;

/**
 * 单据号生成
 * 
 */
@Service
// @Scope("prototype")
public class BillCodeService {

	@Autowired
	private DocumentsService documentsService;

	@Autowired
	StringRedisTemplate redisTemplate;

	public String createBillCode(String billtype, String role) {
		if (StringUtils.isEmpty(billtype)) {
			return "";
		}
		String billcode = "";
		// 正常的单据号
		if ("1".endsWith(ParameterUtil.getParamValue("sys_redis", "0"))) {
			// redis单据号
			// billcode = documentsService.generateDocumentsByRedis(billtype, role);
			billcode = documentsService.createBillCodeByRedis(billtype, role);
		} else {
			// 普通创建单据号
			billcode = documentsService.generateDocuments(billtype, role, false);
		}
		return billcode;
	}

}
