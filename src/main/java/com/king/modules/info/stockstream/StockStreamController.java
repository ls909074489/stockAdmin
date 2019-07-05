package com.king.modules.info.stockstream;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.king.frame.controller.ActionResultModel;
import com.king.frame.controller.BaseController;
import com.king.frame.controller.QueryRequest;
import com.king.modules.info.stockdetail.StockDetailEntity;

/**
 * 测试111
 * @author ls2008
 * @date 2019-07-05 14:02:18
 */
@Controller
@RequestMapping(value = "/info/stockstream")
public class StockStreamController extends BaseController<StockStreamEntity> {

	@Autowired
	private StockStreamService service;

	
	@RequestMapping("/toRecord")
	public String toRecord(Model model,String stockId,String materialId) {
		model.addAttribute("stockId", stockId);
		model.addAttribute("materialId", materialId);
		return "modules/info/stockstream/stockstream_record";
	}
	
	@RequestMapping(value = "/dataRecord")
	@ResponseBody
	public ActionResultModel<StockStreamEntity> dataRecord(ServletRequest request) {
		Map<String, Object> addParam = new HashMap<String, Object>();
		addParam.put("EQ_stock.uuid", request.getParameter("stockId"));
		addParam.put("EQ_material.uuid", request.getParameter("materialId"));
		QueryRequest<StockStreamEntity> qr = getQueryRequest(request, addParam);
		return execQuery(qr, baseService);
	}
	
	
	/**
	 * 
	 * @Title: listView
	 * @author ls2008
	 * @date 2019-07-05 14:02:18
	 * @param @param model
	 * @param @return 设定文件 
	 * @return String 返回类型 
	 * @throws
	 */
	@RequestMapping("/list")
	public String listView(Model model) {
		return "modules/info/stockstream/stockstream_list";
	}

	@Override
	public String addView(Model model, ServletRequest request) {
		return "modules/info/stockstream/stockstream_edit";
	}

	@Override
	public String editView(Model model, ServletRequest request, StockStreamEntity entity) {
		return "modules/info/stockstream/stockstream_edit";
	}

	@Override
	public String detailView(Model model, ServletRequest request, StockStreamEntity entity) {
		return "modules/info/stockstream/stockstream_detail";
	}

	
	@Override
	public ActionResultModel<StockStreamEntity> add(ServletRequest request, Model model, StockStreamEntity entity) {
		return new ActionResultModel<StockStreamEntity>(false, "不允许操作");
	}

	@Override
	protected ActionResultModel<StockStreamEntity> doAdd(ServletRequest request, Model model,
			StockStreamEntity entity) {
		return new ActionResultModel<StockStreamEntity>(false, "不允许操作");
	}

	@Override
	protected ActionResultModel<StockStreamEntity> doUpdate(ServletRequest request, Model model,
			StockStreamEntity entity) {
		return new ActionResultModel<StockStreamEntity>(false, "不允许操作");
	}

	@Override
	public ActionResultModel delete(ServletRequest request, Model model, String[] pks) {
		return new ActionResultModel<StockStreamEntity>(false, "不允许操作");
	}

	@Override
	protected ActionResultModel doDelete(ServletRequest request, Model model, String[] pks) {
		return new ActionResultModel<StockStreamEntity>(false, "不允许操作");
	}
	

}