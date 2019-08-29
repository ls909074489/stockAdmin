package com.king.modules.info.stockdetail;

import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.CollectionUtils;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.king.common.utils.DateUtil;
import com.king.common.utils.ExcelDataUtil;
import com.king.frame.controller.ActionResultModel;
import com.king.frame.controller.BaseController;
import com.king.frame.controller.QueryRequest;
import com.king.frame.service.BaseServiceImpl;
import com.king.frame.service.IService;
import com.king.frame.utils.RequestUtil;
import com.king.modules.info.stockstream.StockStreamEntity;
import com.king.modules.info.stockstream.StockStreamService;
import com.king.modules.sys.imexlate.ImexlateSubEntity;
import com.king.modules.sys.imexlate.ImexlateSubService;
import com.king.modules.sys.param.ParameterUtil;

/**
 * 库存明细
 * 
 * @author null
 * @date 2019-06-18 11:50:47
 */
@Controller
@RequestMapping(value = "/info/stockdetail")
public class StockDetailController extends BaseController<StockDetailEntity> {

	private static Logger logger = LoggerFactory.getLogger(BaseServiceImpl.class);
	
	@Autowired
	private StockStreamService streamService;
	@Autowired
	private ImexlateSubService imexlateSubService;
	@Autowired
	private StockDetailService stockDetailService;
	@Autowired
	@Qualifier("threadTaskExecutor")
	private ThreadPoolTaskExecutor threadTaskExecutor;

	@Async("msgTaskExecutor")
	private void syncStockDetail() {
		threadTaskExecutor.execute(new Runnable() {
			@Override
			public void run() {
				try {
					calUpdateStockDetail();
				} catch (Exception e) {
					logger.error("计算库存出错》》》》"+e.getMessage());
					e.printStackTrace();
				}
			}
		});
	}
	
	private void calUpdateStockDetail(){
		List<StockDetailEntity> list = stockDetailService.listUpdateDetail();
		if(CollectionUtils.isNotEmpty(list)){
			List<String> detailIdList = new ArrayList<String>();
			for (StockDetailEntity entity : list) {
				detailIdList.add(entity.getUuid());
			}
			List<StockStreamEntity> streamList = streamService.findSurplusByDetailIds(detailIdList);
			Map<String, List<StockStreamEntity>> streamMap = changeToMap(streamList);
			for (StockDetailEntity entity : list) {
				calcDetail(entity, streamMap.get(entity.getUuid()));
				entity.setSurplusCount(entity.getSurplusAmount());
				entity.setOccupyCount(entity.getOccupyAmount());
				entity.setActualCount(entity.getActualAmount());
				entity.setUpdateType("0");
			}
			stockDetailService.save(list);
		}
	}

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

//	@Override
//	public Map<String, Object> addSearchParam(ServletRequest request) {
//		Map<String, Object> addParam = new HashMap<String, Object>();
//		addParam.put("EQ_showType", "1");
//		return addParam;
//	}

	@Override
	protected ActionResultModel<StockDetailEntity> execQuery(QueryRequest<StockDetailEntity> qr, IService service) {
		if(ParameterUtil.getParamValue("syncStockDetail", "0").equals("1")){
			try {
				calUpdateStockDetail();
			} catch (Exception e) {
				logger.error("list 计算库存出错》》》》"+e.getMessage());
				e.printStackTrace();
			}
		}
		ActionResultModel<StockDetailEntity> arm = super.execQuery(qr, service);
		List<StockDetailEntity> list = arm.getRecords();
		if (CollectionUtils.isNotEmpty(list)) {
			List<String> detailIdList = new ArrayList<String>();
			if(ParameterUtil.getParamValue("syncStockDetail", "0").equals("1")){
				for (StockDetailEntity entity : list) {
					entity.setSurplusAmount(entity.getSurplusCount());
					entity.setOccupyAmount(entity.getOccupyCount());
					entity.setActualAmount(entity.getActualAmount());
				}
			}else{
				for (StockDetailEntity entity : list) {
					detailIdList.add(entity.getUuid());
				}
				List<StockStreamEntity> streamList = streamService.findSurplusByDetailIds(detailIdList);
				Map<String, List<StockStreamEntity>> streamMap = changeToMap(streamList);
				for (StockDetailEntity entity : list) {
					calcDetail(entity, streamMap.get(entity.getUuid()));
				}
			}
		}
		return arm;
	}

	@RequestMapping(value = "/exportQuery")
	public void exportQuery(HttpServletRequest request, HttpServletResponse response) {
		ActionResultModel<StockDetailEntity> arm = new ActionResultModel<StockDetailEntity>();
		OutputStream os = null;
		Workbook wb = null;
		try {
			os = response.getOutputStream();// 取得输出流
			response.reset();// 清空输出流
			response.setContentType("application/octet-stream; charset=utf-8");
			String explorerType = RequestUtil.getExplorerType((HttpServletRequest) request);

			List<StockDetailEntity> resultList = doQuery(request).getRecords();

			if (explorerType == null || explorerType.contains("IE")) {// IE
				response.setHeader("Content-Disposition", "attachment; filename=\""
						+ RequestUtil.encode(("库存明细" + DateUtil.getDateTimeZone()), "utf-8") + ".xlsx" + "\"");
			} else {// fireFox/Chrome
				response.setHeader("Content-Disposition", "attachment; filename="
						+ new String(("库存明细" + DateUtil.getDateTimeZone()).getBytes("utf-8"), "ISO8859-1") + ".xlsx");
			}
			response.setContentType("application/msexcel");// 定义输出类型
			wb = new SXSSFWorkbook(100);
			changeToWarnCells(resultList, wb);
			wb.write(os);
		} catch (Exception e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
			e.printStackTrace();
		} finally {
			try {
				if (wb != null) {
					wb.close();
				}
				if (os != null) {
					os.close();// 关闭流
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	private void calcDetail(StockDetailEntity entity, List<StockStreamEntity> list) {
		if (CollectionUtils.isEmpty(list)) {
			return;
		}
		for (StockStreamEntity s : list) {
			// totalAmount
			entity.setSurplusAmount(entity.getSurplusAmount() + s.getSurplusAmount());
			entity.setOccupyAmount(entity.getOccupyAmount() + s.getOccupyAmount());
			entity.setActualAmount(entity.getSurplusAmount() - entity.getOccupyAmount());
		}
	}

	private Map<String, List<StockStreamEntity>> changeToMap(List<StockStreamEntity> streamList) {
		Map<String, List<StockStreamEntity>> map = new HashMap<String, List<StockStreamEntity>>();
		if (CollectionUtils.isEmpty(streamList)) {
			return map;
		}
		List<StockStreamEntity> list = null;
		for (StockStreamEntity s : streamList) {
			list = map.get(s.getStockDetailId());
			if (list == null) {
				list = new ArrayList<StockStreamEntity>();
			}
			list.add(s);
			map.put(s.getStockDetailId(), list);
		}
		return map;
	}

	/**
	 * 
	 * @Title: listView @author null @date 2019-06-18 11:50:47 @param @param
	 * model @param @return 设定文件 @return String 返回类型 @throws
	 */
	@RequestMapping("/list")
	public String listView(Model model) {
		return "modules/info/stockdetail/stockdetail_list";
	}
	
	
	@RequestMapping(value = "/toUpdatePlaces")
	public String toUpdatePlaces(ServletRequest request,String uuid,Model model) {
		model.addAttribute("uuid", uuid);
		return "modules/info/stockdetail/stockdetail_update_places";
	}
	
	/**
	 * 修改库位
	 * @param request
	 * @param uuid
	 * @param places
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/updatePlaces")
	public ActionResultModel<StockDetailEntity> updatePlaces(ServletRequest request,String uuid,String places) {
		return stockDetailService.updatePlaces(uuid,places);
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

	public void changeToWarnCells(List<StockDetailEntity> resultList, Workbook wb) {
		List<ImexlateSubEntity> implateSubList = imexlateSubService.findByTemCoding("stockDetailExport");
		Row row = null;
		Cell cell = null;
		Sheet sh = null;
		sh = wb.createSheet("物料明细");
		CellStyle style = wb.createCellStyle();// 样式对象
		// 生成一个字体
		Font font = wb.createFont();
		font.setColor(HSSFColor.BLACK.index);// 字体颜色
		font.setFontHeightInPoints((short) 12);
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD); // 字体增粗
		// 把字体应用到当前的样式
		style.setFont(font);
		style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 垂直
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);// 水平

		// sh.setColumnWidth(0, 15 * 256);//设置宽度
		// sh.setColumnWidth(3, 25 * 256);//设置宽度
		// sh.setColumnWidth(4, 25 * 256);//设置宽度

		// 设置表头
		row = sh.createRow(0);
		int i = 0;
		for (ImexlateSubEntity sub : implateSubList) {
			cell = row.createCell(i);
			cell.setCellStyle(style);
			cell.setCellValue(sub.getChineseField());
			if (sub.getColumnWidth() != null && sub.getColumnWidth() != 0) {
				sh.setColumnWidth(ExcelDataUtil.getExcelCol(sub.getExportCellNum()), sub.getColumnWidth() * 256);// 设置宽度
			}
			i++;
		}
		int rownum = 0;
		Map<String, String> map = null;
		for (StockDetailEntity obj : resultList) {
			rownum++;
			row = sh.createRow(rownum);
			map = changeStreamToMap(map, obj);
			i = 0;
			for (ImexlateSubEntity sub : implateSubList) {
				cell = row.createCell(i);//
				cell.setCellValue(map.get(sub.getFieldName()));
				i++;
			}
		}
	}

	/**
	 * 转换成map
	 * 
	 * @param map
	 * @param obj
	 * @return
	 */
	private Map<String, String> changeStreamToMap(Map<String, String> map, StockDetailEntity obj) {
		map = new HashMap<>();
		map.put("stockName", obj.getStock().getName());
		map.put("code", obj.getMaterial().getCode());
		map.put("hwcode", obj.getMaterial().getHwcode());
		map.put("name", obj.getMaterial().getName());
		map.put("surplusAmount", obj.getSurplusAmount() + "");
		map.put("occupyAmount", obj.getOccupyAmount() + "");
		map.put("actualAmount", obj.getActualAmount() + "");
		return map;
	}

}