package com.king.modules.info.projectinfo;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import com.alibaba.fastjson.JSON;
import com.king.common.enums.BillStatus;
import com.king.frame.controller.ActionResultModel;
import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.BaseServiceImpl;
import com.king.modules.info.barcode.ProjectBarcodeLogEntity;
import com.king.modules.info.barcode.ProjectBarcodeLogService;
import com.king.modules.info.material.MaterialBaseEntity;

/**
 * OrderSubService
 * 
 * @author liusheng
 *
 */
@Service
@Transactional(readOnly = true)
public class ProjectSubService extends BaseServiceImpl<ProjectSubEntity, String> {

	@Autowired
	private ProjectSubDao dao;
	@Lazy
	@Autowired
	private ProjectInfoService mainService;
	@Autowired
	private ProjectBarcodeLogService projectBarcodeLogService;


	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	protected IBaseDAO getDAO() {
		return dao;
	}
	

	@Transactional(readOnly = true)
	public List<ProjectSubEntity> findByMain(String mainId) {
		return dao.findByMain(mainId);
	}

	/**
	 * 更新条形码
	 * 
	 * @param newBarcode
	 * @param subId
	 * @return
	 */
	@Transactional
	public ActionResultModel<ProjectSubEntity> updateBarcode(String newBarcode, String newUuid) {
		ActionResultModel<ProjectSubEntity> arm = new ActionResultModel<ProjectSubEntity>();
		String []idArr = newUuid.split("_");
		ProjectSubEntity sub = getOne(idArr[1]);
		String barcodeJson = sub.getBarcodejson();
		List<String> blist = new ArrayList<>();
		if(sub.getLimitCount()==MaterialBaseEntity.limitCount_unique&&sub.getPlanAmount()>1){//唯一
			String [] barcodeArr = new String[sub.getPlanAmount().intValue()];
			if(!StringUtils.isEmpty(barcodeJson)){
				blist = JSON.parseArray(barcodeJson, String.class);
			}
			for(int i=0;i<barcodeArr.length;i++){
				if(blist.size()>i){
					barcodeArr[i] = blist.get(i);
				}else{
					barcodeArr[i] = "";
				}
			}
			barcodeArr[Integer.parseInt(idArr[0])] = newBarcode;
			blist = Arrays.asList(barcodeArr);
		}else{
			blist.add(newBarcode);
		}
		if(Integer.parseInt(idArr[0])==0){
			sub.setBarcode(newBarcode);
		}
		sub.setBarcodejson(JSON.toJSONString(blist));
		
		//保存条码日志
		ProjectBarcodeLogEntity barcodeLog = new ProjectBarcodeLogEntity();
		barcodeLog.setProjectId(sub.getMain().getUuid());
		barcodeLog.setProjectSubId(sub.getUuid());
		barcodeLog.setBarcode(newBarcode);
		projectBarcodeLogService.doAdd(barcodeLog);
		
		arm.setSuccess(true);
		arm.setMsg("操作成功");
		return arm;
	}

	
	

	public void changeToSheet(List<ProjectInfoEntity> mainList, Workbook wb) {
		for(ProjectInfoEntity main:mainList){
			List<ProjectSubEntity> subList = findByMain(main.getUuid());
			changeToCells(main.getName() + "(" + main.getCode() + ")", subList, wb);
		}
	}

	
	private void changeToCells(String sheetName, List<ProjectSubEntity> subList, Workbook wb) {
		Row row = null;
		Cell cell =null;
		Sheet sh =null;
		sh = wb.createSheet(sheetName);
		CellStyle  style=wb.createCellStyle();// 样式对象    
		//生成一个字体
        Font font=wb.createFont();
        font.setColor(HSSFColor.BLACK.index);//字体颜色
        font.setFontHeightInPoints((short)12);
        font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);         //字体增粗
        //把字体应用到当前的样式
        style.setFont(font);
//        style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);  //填充单元格
//        style.setFillForegroundColor(HSSFColor.BLUE_GREY.index);//设置背景颜色
        style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 垂直      
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER);// 水平      
		
		
		sh.setColumnWidth(1, 10 * 256);//设置宽度
		sh.setColumnWidth(2, 10 * 256);//设置宽度
		sh.setColumnWidth(3, 20 * 256);//设置宽度
		sh.setColumnWidth(4, 20 * 256);//设置宽度
		sh.setColumnWidth(5, 20 * 256);//设置宽度
		sh.setColumnWidth(6, 20 * 256);//设置宽度
		sh.setColumnWidth(7, 10 * 256);//设置宽度
		
		row=sh.createRow(0);
		cell = row.createCell(0);
		cell.setCellStyle(style);
		cell.setCellValue("箱号");
		
		cell = row.createCell(1);
		cell.setCellStyle(style);
		cell.setCellValue("物料编码");
		
		cell = row.createCell(2);
		cell.setCellStyle(style);
		cell.setCellValue("华为物料编码");
		
		cell = row.createCell(3);
		cell.setCellStyle(style);
		cell.setCellValue("计划数量");
		
		cell = row.createCell(4);
		cell.setCellStyle(style);
		cell.setCellValue("到货数量");
		
		cell = row.createCell(5);
		cell.setCellStyle(style);
		cell.setCellValue("条形码");
		
		cell = row.createCell(6);
		cell.setCellStyle(style);
		cell.setCellValue("备注");
		
		int rownum=0;
		for(ProjectSubEntity sub:subList){
			rownum++;
			row = sh.createRow(rownum);
			
			cell = row.createCell(0);//
			cell.setCellValue((sub.getBoxNum()));
			
			cell = row.createCell(1);//
			cell.setCellValue(sub.getMaterial().getCode());
			
			cell = row.createCell(2);//
			cell.setCellValue(sub.getMaterial().getHwcode());
			
			cell = row.createCell(3);//
			cell.setCellValue(sub.getPlanAmount());
			
			cell = row.createCell(4);//
			cell.setCellValue(sub.getActualAmount());
			
			cell = row.createCell(5);//
			cell.setCellValue(sub.getBarcode());
			
			cell = row.createCell(6);//
			cell.setCellValue(sub.getMemo());
		}
	}

	
	public ActionResultModel<ProjectSubEntity> checkBarcode(String newBarcode, String subId) {
		ActionResultModel<ProjectSubEntity> arm = new ActionResultModel<ProjectSubEntity> ();
		List<ProjectSubEntity> subList = dao.findByBarcode("\""+newBarcode+"\"");
		if(CollectionUtils.isEmpty(subList)){
			arm.setSuccess(true);
			arm.setMsg("没有重复的条码");
			return arm;
		}
		if(subList.size()==1&&subList.get(0).getUuid().equals(subId)){
			arm.setSuccess(true);
			arm.setMsg("没有重复的条码");
			return arm;
		}else{
			List<String> repeatList = new ArrayList<>();
			for(ProjectSubEntity sub:subList){
				repeatList.add(sub.getMain().getName()+"("+sub.getMain().getCode()+")箱号"+sub.getBoxNum());
			}
			arm.setSuccess(false);
			arm.setMsg(org.apache.commons.lang.StringUtils.join(repeatList, ",")+"已存在条码"+newBarcode);
			return arm;
		}
	}


	@Transactional
	public ActionResultModel<ProjectSubEntity> updateLimitCount(int limitCount, String subId) {
		ActionResultModel<ProjectSubEntity> arm = new ActionResultModel<ProjectSubEntity>();
		ProjectSubEntity sub = getOne(subId);
		if(sub.getMain().getBillstatus()==BillStatus.APPROVAL.toStatusValue()){
			arm.setSuccess(false);
			arm.setMsg("已审核不能修改");
			return arm;
		}
		sub.setLimitCount(limitCount);
		arm.setSuccess(true);
		arm.setMsg("操作成功");
		return arm;
	}


}
