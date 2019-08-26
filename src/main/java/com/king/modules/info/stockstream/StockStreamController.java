package com.king.modules.info.stockstream;

import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.king.common.utils.DateUtil;
import com.king.frame.controller.ActionResultModel;
import com.king.frame.controller.BaseController;
import com.king.frame.controller.QueryRequest;
import com.king.frame.utils.RequestUtil;
import com.king.modules.info.projectinfo.ProjectSubEntity;
import com.king.modules.info.projectinfo.ProjectSubService;

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
	@Autowired
	private ProjectSubService projectSubService;

	
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
	
	
	@RequestMapping("/toSubRecord")
	public String toSubRecord(Model model,String subId) {
		model.addAttribute("subId", subId);
		return "modules/info/stockstream/stockstream_record_sub";
	}
	
	@RequestMapping(value = "/dataSubRecord")
	@ResponseBody
	public ActionResultModel<StockStreamEntity> dataSubRecord(ServletRequest request) {
		Map<String, Object> addParam = new HashMap<String, Object>();
		addParam.put("EQ_status", "1");
		String subId = request.getParameter("subId");
		ProjectSubEntity sub = projectSubService.getOne(subId);
		addParam.put("EQ_sourceId", sub.getMain().getUuid());
		addParam.put("EQ_material.uuid", sub.getMaterial().getUuid());
		addParam.put("EQ_projectSubId", sub.getUuid());
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
		addParam.put("EQ_showType", "1");
//		addParam.put("GT_surplusAmount", "0");
		
		String GT_surplusAmount= request.getParameter("GT_surplusAmount");
		if(StringUtils.isNotEmpty(GT_surplusAmount)){//0:已出库、1:在库
			if(GT_surplusAmount.equals("0")){//已出库
				addParam.put("EQ_surplusAmount", "0");
			}else{
				addParam.put("GT_surplusAmount", "0");
			}
		}
		
		String search_GTE_createtime = request.getParameter("search_GTE_createtime");
		if(StringUtils.isNotEmpty(search_GTE_createtime)){
			addParam.put("LTE_createtime", search_GTE_createtime+" 59:59:59");//要预警 
			addParam.put("GTE_createtime", search_GTE_createtime+" 00:00:00");//要预警 
		}
		
		String search_LTE_warningTime = request.getParameter("search_LTE_warningTime");
		if(StringUtils.isEmpty(search_LTE_warningTime)){
			addParam.put("LTE_warningTime", DateUtil.getDate()+" 59:59:59");//要预警 
		}else{
			addParam.put("LTE_warningTime", search_LTE_warningTime+" 59:59:59");//要预警 
			addParam.put("GTE_warningTime", search_LTE_warningTime+" 00:00:00");//要预警 
		}
		QueryRequest<StockStreamEntity> qr = getQueryRequest(request, addParam);
		return execQuery(qr, baseService);
	}
	
	
	
	@RequestMapping(value = "/exportWarnQuery")
	public void exportWarnQuery(HttpServletRequest request, HttpServletResponse response) {
		ActionResultModel<StockStreamEntity> arm=new ActionResultModel<StockStreamEntity>();
		OutputStream os = null;
		Workbook wb = null;
		try {
			os = response.getOutputStream();// 取得输出流   
	        response.reset();// 清空输出流   
	        response.setContentType("application/octet-stream; charset=utf-8");
			String explorerType = RequestUtil.getExplorerType((HttpServletRequest)request);
			
			arm= dataWarning(request);
			
			List<StockStreamEntity> resultList = arm.getRecords();
			
			if (explorerType == null || explorerType.contains("IE")) {// IE
				response.setHeader("Content-Disposition",
				"attachment; filename=\"" + RequestUtil.encode(("预警物料"+DateUtil.getDateTimeZone()),"utf-8")+".xlsx" + "\"");
			} else {// fireFox/Chrome
				response.setHeader("Content-Disposition",
						"attachment; filename=" + new String(("预警物料"+DateUtil.getDateTimeZone()).getBytes("utf-8"), "ISO8859-1")+".xlsx");
			}
	        response.setContentType("application/msexcel");// 定义输出类型 
			wb = new SXSSFWorkbook(100);
			service.changeToWarnCells(resultList, wb);
			wb.write(os);
		} catch (Exception e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
			e.printStackTrace();
		}finally{
			try {
				if(wb!=null){
					wb.close();
				}
				if(os!=null){
					os.close();// 关闭流
				}
			} catch (IOException e) {
				e.printStackTrace();
			} 
		} 
	}
	
	/**
	 * 仓库的物料
	 * @param model
	 * @param stockId
	 * @param materialId
	 * @return
	 */
	@RequestMapping("/toStockMaterialIn")
	public String toStockMaterial(Model model,String subId) {
		ProjectSubEntity sub = projectSubService.getOne(subId);
		model.addAttribute("stockId", sub.getMain().getStock().getUuid());
		model.addAttribute("materialId", sub.getMaterial().getUuid());
		model.addAttribute("subId", subId);
		model.addAttribute("projectId", sub.getMain().getUuid());
		return "modules/info/stockstream/stockstream_stock_material_in";
	}
	
	
	/**
	 * 查询挪料的
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/dataStockMaterialIn")
	@ResponseBody
	public ActionResultModel<StockStreamEntity> dataStockMaterialIn(ServletRequest request) {
		Map<String, Object> addParam = new HashMap<String, Object>();
		addParam.put("EQ_stock.uuid", request.getParameter("stockId"));
		addParam.put("EQ_material.uuid", request.getParameter("materialId"));
		addParam.put("EQ_operType", StockStreamEntity.IN_STOCK);//增加库存
		addParam.put("IN_billType", StockStreamEntity.BILLTYPE_RECEIVE+","+StockStreamEntity.BILLTYPE_BORROW);//收货的
		addParam.put("NE_sourceId", request.getParameter("projectId")); 
		addParam.put("GT_surplusAmount", "0");
//		addParam.put("EQ_warningType", StockStreamEntity.WARNINGTYPE_BE_NEED);//要预警 
//		addParam.put("LTE_warningTime", DateUtil.getDateTime());//要预警 
		QueryRequest<StockStreamEntity> qr = getQueryRequest(request, addParam);
		return execQuery(qr, baseService);
	}
	
	
	
	@RequestMapping(value = "/saveProjectBorrow")
	@ResponseBody
	public ActionResultModel<StockStreamEntity> saveProjectBorrow(String fromStreamId,String toSubId,Long actualAmount) {
		try {
			return service.saveProjectBorrow(fromStreamId,toSubId,actualAmount);
		}catch (ServiceException e){
			e.printStackTrace();
			return new ActionResultModel<>(false, e.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			return new ActionResultModel<>(false, "挪料失败:"+e.getMessage());
		}
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