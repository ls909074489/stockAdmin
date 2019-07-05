package com.king.modules.info.stockdetail;

import javax.servlet.ServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.king.frame.controller.ActionResultModel;
import com.king.frame.controller.BaseController;
import com.king.frame.controller.QueryRequest;

/**
 * 库存明细
 * @author null
 * @date 2019-06-18 11:50:47
 */
@Controller
@RequestMapping(value = "/info/stockdetail")
public class StockDetailController extends BaseController<StockDetailEntity> {

	@Autowired
	private StockDetailService service;
	
	
	@RequestMapping("/search")
	public String search(Model model) {
		return "modules/info/stockdetail/stockdetail_search";
	}
	
	@RequestMapping(value = "/dataSearch")
	@ResponseBody
	public ActionResultModel<StockDetailEntity> dataSearch(ServletRequest request, Model model) {
		QueryRequest<StockDetailEntity> qr = getQueryRequest(request, addSearchParam(request));
		return execQuery(qr, baseService);
	}
	
	/**
	 * 
	 * @Title: listView
	 * @author null
	 * @date 2019-06-18 11:50:47
	 * @param @param model
	 * @param @return 设定文件 
	 * @return String 返回类型 
	 * @throws
	 */
	@RequestMapping("/list")
	public String listView(Model model) {
		return "modules/info/stockdetail/stockdetail_list";
	}

	@Override
	public String addView(Model model, ServletRequest request) {
		return "modules/info/stockdetail/stockdetail_edit";
	}

	@Override
	public String editView(Model model, ServletRequest request, StockDetailEntity entity) {
		return "modules/info/stockdetail/stockdetail_edit";
	}

	@Override
	public String detailView(Model model, ServletRequest request, StockDetailEntity entity) {
		return "modules/info/stockdetail/stockdetail_detail";
	}

	@Override
	public ActionResultModel<StockDetailEntity> add(ServletRequest request, Model model, StockDetailEntity entity) {
		return new ActionResultModel<StockDetailEntity>(false, "不允许操作");
	}

	@Override
	protected ActionResultModel<StockDetailEntity> doAdd(ServletRequest request, Model model,
			StockDetailEntity entity) {
		return new ActionResultModel<StockDetailEntity>(false, "不允许操作");
	}

	@Override
	public ActionResultModel<StockDetailEntity> update(ServletRequest request, Model model, StockDetailEntity entity) {
		return new ActionResultModel<StockDetailEntity>(false, "不允许操作");
	}

	@Override
	protected ActionResultModel<StockDetailEntity> doUpdate(ServletRequest request, Model model,
			StockDetailEntity entity) {
		return new ActionResultModel<StockDetailEntity>(false, "不允许操作");
	}

	@Override
	protected ActionResultModel<StockDetailEntity> doDelete(ServletRequest request, Model model, String[] pks) {
		return new ActionResultModel<StockDetailEntity>(false, "不允许操作");
	}

	@Override
	public ActionResultModel<StockDetailEntity> delete(ServletRequest request, Model model, String[] pks) {
		return new ActionResultModel<StockDetailEntity>(false, "不允许操作");
	}
	

}