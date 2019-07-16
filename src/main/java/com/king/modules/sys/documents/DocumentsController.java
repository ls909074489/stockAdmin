package com.king.modules.sys.documents;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.king.common.result.ReturnMessage;
import com.king.frame.controller.BaseController;

/**
 * 单据号生成策略controller
 * 
 * @ClassName: DocumentsController
 * @author dsp
 * @date 2016年08月22日 04:16:12
 */
@Controller
@RequestMapping(value = "/sys/documents")
public class DocumentsController extends BaseController<DocumentsEntity> {

	@Autowired
	private BillCodeService billCodeService;

	private DocumentsService getService() {
		return (DocumentsService) super.baseService;
	}

	/**
	 * 
	 * 单据号生成策略
	 */
	@RequestMapping(method = RequestMethod.GET)
	public String view() {
		return "modules/sys/documents/documents_main";
	}

	@RequestMapping(value = "/genDocuments", method = RequestMethod.POST)
	@ResponseBody
	private String genDocuments(String documentType) {
		String billcode = "";
		try {
			billcode = billCodeService.createBillCode(documentType, null);
			System.out.println(Thread.currentThread().getName() + "号线程生成单据号：" + billcode + "。");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return billcode;
	}

	@RequestMapping(value = "/refreshToRedis", method = RequestMethod.POST)
	@ResponseBody
	private String refreshToRedis() {
		getService().refreshToRedis();
		return "success";
	}

	@RequestMapping(value = "/refreshToBill", method = RequestMethod.POST)
	@ResponseBody
	private String refreshToBill() {
		getService().refreshToBill();
		return "success";
	}

	@RequestMapping(value = "/cleanAllRedisCache", method = RequestMethod.POST)
	@ResponseBody
	private String cleanAllRedisCache() {
		getService().cleanAllRedisCache();
		return "success";
	}

	@RequestMapping(value = "/test", method = RequestMethod.GET)
	@ResponseBody
	private ReturnMessage<Object> test(HttpServletRequest request, HttpServletResponse response) {
		ReturnMessage<Object> result = new ReturnMessage<Object>();
		String billcode = billCodeService.createBillCode("cs_dj", null);
		System.out.println(billcode);

		result.setMessageInfo(billcode);
		return result;
	}

	@RequestMapping(value = "/batchBillcodes", method = RequestMethod.POST)
	@ResponseBody
	private String batchBillcodes(String documentType) {
		try {
			for (int i = 1; i <= 20; i++) {
				String billcode = billCodeService.createBillCode(documentType, null);
				System.out.println(Thread.currentThread().getName() + "号线程生成单据号：" + billcode + "。");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "success";
	}

	// 判断单据号是否存在
	@RequestMapping(value = "/querydocumentType", method = RequestMethod.POST)
	@ResponseBody
	private String getAll(String documentType, String uuid) {
		if (getService().queryDocumentType(documentType, uuid)) {
			return "success";
		} else {
			return "error";
		}
	}

}
