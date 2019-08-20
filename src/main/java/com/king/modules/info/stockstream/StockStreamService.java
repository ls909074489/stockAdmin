package com.king.modules.info.stockstream;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.king.common.utils.DateUtil;
import com.king.common.utils.ExcelDataUtil;
import com.king.frame.controller.ActionResultModel;
import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.BaseServiceImpl;
import com.king.modules.info.stockdetail.StockDetailService;
import com.king.modules.sys.imexlate.ImexlateSubEntity;
import com.king.modules.sys.imexlate.ImexlateSubService;

/**
 * 测试111
 * @author ls2008
 * @date 2019-07-05 14:02:18
 */
@Service
@Transactional(readOnly=true)
public class StockStreamService extends BaseServiceImpl<StockStreamEntity,String> {

	@Autowired
	private StockStreamDao dao;
	@Autowired
	private StockDetailService stockDetailService;
	@Autowired
	private ImexlateSubService imexlateSubService;
	
	protected IBaseDAO<StockStreamEntity, String> getDAO() {
		return dao;
	}

	public List<StockStreamEntity> findsurplusByStockAndMaterial(String stockId, String materialId) {
		return dao.findsurplusByStockAndMaterial(stockId, materialId);
	}
	
	public List<StockStreamEntity> findsurplusByProjectSubIdAndMaterial(String sourceSubId, String materialId) {
		return dao.findsurplusByProjectSubIdAndMaterial(sourceSubId, materialId);
	}

	/**
	 * 入库的流水-剩余数量大于0的
	 * @param sourceId
	 * @return
	 */
	public List<StockStreamEntity> findSurplusBySourceIdIn(String sourceId) {
		return dao.findSurplusBySourceIdAndOperType(sourceId,StockStreamEntity.IN_STOCK);
	}
	
	public List<StockStreamEntity> findSurplusBySubIdIn(String subId) {
		return dao.findSurplusBySubIdIn(subId,StockStreamEntity.IN_STOCK);
	}
	
	public List<StockStreamEntity> findSurplusAllBySourceIdsIn(List<String> sourceIdList) {
		return dao.findSurplusAllBySourceIdsIn(sourceIdList,StockStreamEntity.IN_STOCK);
	}
	
	
	public List<StockStreamEntity> findBySourceId(String sourceId) {
		return dao.findBySourceId(sourceId);
	}
	
	/**
	 * 入库的流水
	 * @param sourceId
	 * @return
	 */
//	public List<StockStreamEntity> findBySourceIdAndOperType(String sourceId,String operType) {
//		return dao.findBySourceIdAndOperType(sourceId,operType);//StockStreamEntity.IN_STOCK
//	}

	@Transactional
	public void delBySourceIdAndOperType(String sourceId, String operType) {
		dao.delBySourceIdAndOperType(sourceId,operType);
	}

	public List<StockStreamEntity> findOrderByStockAndMaterial(String stockId, String materialId) {
		return dao.findOrderByStockAndMaterial(stockId, materialId,StockStreamEntity.BILLTYPE_ORDER);
	}
	
	
	@Transactional
	public ActionResultModel<StockStreamEntity> saveProjectBorrow(String fromStreamId, String toSubId,
			Long actualAmount) {
		stockDetailService.borrowProjectMaterial(fromStreamId, toSubId, actualAmount);
		return new ActionResultModel<>(true, "操作成功");
	}

	
	public List<StockStreamEntity> findByProjectSubIds(List<String> subIdList) {
		return dao.findByProjectSubIds(subIdList);
	}

	public List<StockStreamEntity> findReceiveByProjectSubIds(List<String> subIdList) {
		return dao.findReceiveByProjectSubIds(subIdList,StockStreamEntity.BILLTYPE_RECEIVE);
	}
	
	
	@Transactional
	public void updateSourceBillCode(String sourceBillCode,String sourceBillId) {
		dao.updateSourceBillCode(sourceBillCode,sourceBillId);
	}

	public List<StockStreamEntity> findSurplusByDetailIds(List<String> detailIdList) {
		return dao.findSurplusByDetailIds(detailIdList);
	}

	public void changeToWarnCells(List<StockStreamEntity> resultList, Workbook wb) {
		List<ImexlateSubEntity> implateSubList=imexlateSubService.findByTemCoding("warnMaterialExport");
		Row row = null;
		Cell cell =null;
		Sheet sh =null;
		sh = wb.createSheet("预警物料");
		CellStyle  style=wb.createCellStyle();// 样式对象    
		//生成一个字体
        Font font=wb.createFont();
        font.setColor(HSSFColor.BLACK.index);//字体颜色
        font.setFontHeightInPoints((short)12);
        font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);         //字体增粗
        //把字体应用到当前的样式
        style.setFont(font);
        style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 垂直      
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER);// 水平      
		
//        sh.setColumnWidth(0, 15 * 256);//设置宽度
//        sh.setColumnWidth(3, 25 * 256);//设置宽度
//        sh.setColumnWidth(4, 25 * 256);//设置宽度
		
        //设置表头
		row=sh.createRow(0);
		int i=0;
		for(ImexlateSubEntity sub:implateSubList){
			cell = row.createCell(i);
			cell.setCellStyle(style);
			cell.setCellValue(sub.getChineseField());
			if(sub.getColumnWidth()!=null&&sub.getColumnWidth()!=0){
				sh.setColumnWidth(ExcelDataUtil.getExcelCol(sub.getExportCellNum()), sub.getColumnWidth() * 256);//设置宽度
			}
			i++;
		}
		int rownum=0;
		Map<String,String> map = null;
		for(StockStreamEntity obj:resultList){
			rownum++;
			row = sh.createRow(rownum);
			map = changeStreamToMap(map, obj);
			i=0;
			for(ImexlateSubEntity sub:implateSubList){
				cell = row.createCell(i);//
				cell.setCellValue(map.get(sub.getFieldName()));
				i++;
			}
		}
	}
	
	
	/**
	 * 转换成map
	 * @param map
	 * @param obj
	 * @return
	 */
	private Map<String,String> changeStreamToMap(Map<String,String> map,StockStreamEntity obj){
		map = new HashMap<>();
		map.put("code", obj.getMaterial().getCode());
		map.put("hwcode", obj.getMaterial().getHwcode());
		map.put("name", obj.getMaterial().getName());
		map.put("sourceBillCode", obj.getSourceBillCode());
		map.put("creatorname", obj.getCreatorname());
		map.put("createtime", DateUtil.dateToString(obj.getCreatetime()));
		map.put("totalAmount", obj.getTotalAmount()+"");
		map.put("surplusAmount", obj.getSurplusAmount()+"");
		map.put("occupyAmount", obj.getOccupyAmount()+"");
		map.put("actualAmount", obj.getActualAmount()+"");
		if(obj.getWarningTime()!=null){
			map.put("warningTime",DateUtil.dateToString(obj.getWarningTime()));
		}else{
			map.put("warningTime","");
		}
		if(obj.getSurplusAmount()>0){
			map.put("status","在库");
		}else{
			map.put("status","已出库");
		}
		return map;
	}
}