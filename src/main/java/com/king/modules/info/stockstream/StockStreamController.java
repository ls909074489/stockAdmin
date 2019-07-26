package com.king.modules.info.stockstream;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.king.common.utils.DateUtil;
import com.king.frame.controller.ActionResultModel;
import com.king.frame.controller.BaseController;
import com.king.frame.controller.QueryRequest;

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

	
	@Override
	public Map<String, Object> addSearchParam(ServletRequest request) {
		Map<String, Object> addParam = new HashMap<String, Object>();
		addParam.put("EQ_status", "1");
		return addParam;
	}

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
		addParam.put("EQ_status", "1");
		addParam.put("EQ_material.uuid", request.getParameter("materialId"));
		QueryRequest<StockStreamEntity> qr = getQueryRequest(request, addParam);
		return execQuery(qr, baseService);
	}
	
	
	/**
	 * 预警列表
	 * @param model
	 * @return
	 */
	@RequestMapping("/warningList")
	public String warningList(Model model) {
		return "modules/info/stockstream/stockstream_warning_list";
	}
	
	
	@RequestMapping(value = "/dataWarning")
	@ResponseBody
	public ActionResultModel<StockStreamEntity> dataWarning(ServletRequest request) {
		Map<String, Object> addParam = new HashMap<String, Object>();
		addParam.put("EQ_stock.uuid", request.getParameter("stockId"));
		addParam.put("EQ_material.uuid", request.getParameter("materialId"));
		addParam.put("EQ_operType", StockStreamEntity.IN_STOCK);//增加库存
//		addParam.put("EQ_warningType", StockStreamEntity.WARNINGTYPE_BE_NEED);//要预警 
		addParam.put("EQ_status", "1");
		addParam.put("GT_surplusAmount", "0");
		addParam.put("LTE_warningTime", DateUtil.getDateTime());//要预警 
		QueryRequest<StockStreamEntity> qr = getQueryRequest(request, addParam);
		return execQuery(qr, baseService);
	}
	
	
	/**
	 * 仓库的物料
	 * @param model
	 * @param stockId
	 * @param materialId
	 * @return
	 */
	@RequestMapping("/toStockMaterialIn")
	public String toStockMaterial(Model model,String stockId,String materialId) {
		model.addAttribute("stockId", stockId);
		model.addAttribute("materialId", materialId);
		return "modules/info/stockstream/stockstream_stock_material_in";
	}
	
	
	@RequestMapping(value = "/dataStockMaterialIn")
	@ResponseBody
	public ActionResultModel<StockStreamEntity> dataStockMaterialIn(ServletRequest request) {
		Map<String, Object> addParam = new HashMap<String, Object>();
		addParam.put("EQ_stock.uuid", request.getParameter("stockId"));
		addParam.put("EQ_material.uuid", request.getParameter("materialId"));
		addParam.put("EQ_operType", StockStreamEntity.IN_STOCK);//增加库存
		addParam.put("GT_surplusAmount", "0");
//		addParam.put("EQ_warningType", StockStreamEntity.WARNINGTYPE_BE_NEED);//要预警 
//		addParam.put("LTE_warningTime", DateUtil.getDateTime());//要预警 
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