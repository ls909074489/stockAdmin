package com.king.modules.info.projectinfo;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.beanutils.converters.DateConverter;
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
import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import com.king.common.enums.BillStatus;
import com.king.frame.controller.ActionResultModel;
import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.BaseServiceImpl;
import com.king.modules.info.barcode.ProjectBarcodeLogEntity;
import com.king.modules.info.barcode.ProjectBarcodeLogService;
import com.king.modules.info.material.MaterialBaseEntity;
import com.king.modules.info.material.MaterialEntity;
import com.king.modules.info.stockdetail.StockDetailService;
import com.king.modules.sys.enumdata.EnumDataSubEntity;
import com.king.modules.sys.enumdata.EnumDataUtils;

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
	@Lazy
	@Autowired
	private StockDetailService stockDetailService;
	@Autowired
	private ProjectSubBarcodeService projectSubBarcodeService;


	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	protected IBaseDAO getDAO() {
		return dao;
	}
	
	

	@Override
	public void delete(String pk) throws ServiceException {
		try {
			ProjectSubEntity entity = this.getOne(pk);
			entity.setStatus(0);
//			this.delete(entity);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServiceException(e.getMessage());
		}
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
	public ActionResultModel<ProjectSubEntity> updateBarcode(String newBarcode, String newUuid,Long subAmount) {
		ActionResultModel<ProjectSubEntity> arm = new ActionResultModel<ProjectSubEntity>();
		String []idArr = newUuid.split("_");
		ProjectSubEntity sub = getOne(idArr[1]);
		
		if(checkHasStream(idArr[0])){//已经出库的
			ProjectSubBarcodeEntity bc = projectSubBarcodeService.getOne(idArr[0]);
			if(bc==null){
				throw new ServiceException("没有对应的条码明细");
			}
			bc.setBarcode(newBarcode);
		}else{//扫码时出库
			if(sub.getLimitCount()==MaterialBaseEntity.limitCount_unique){//唯一,每次只出一个
				subAmount = 1l;
			}else{
				subAmount = Math.abs(subAmount);
			}
			String streamId = stockDetailService.descStockDetail(sub,subAmount);
			
			ProjectSubBarcodeEntity subBc = new ProjectSubBarcodeEntity();
			ProjectInfoBaseEntity main = new ProjectInfoBaseEntity();
			main.setUuid(sub.getMain().getUuid());
			subBc.setMain(main);
			ProjectSubBaseEntity subBase = new ProjectSubBaseEntity();
			subBase.setUuid(sub.getUuid());
			subBc.setSub(subBase);
			subBc.setBarcode(newBarcode);
			subBc.setStreamId(streamId);
			subBc.setSubAmount(subAmount);
			projectSubBarcodeService.doAdd(subBc);
		}
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
	
	
	/**
	 * 保存批次
	 * @param newBarcode
	 * @param subId
	 * @param subAmount
	 * @param operType  添加add 修改update
	 * @return
	 */
	@Transactional
	public ActionResultModel<ProjectSubEntity> updateBarcodePc(String newBarcode, String subId,Long subAmount,String operType) {
		ActionResultModel<ProjectSubEntity> arm = new ActionResultModel<ProjectSubEntity>();
		String []idArr = subId.split("_");
		if(idArr.length>1){
			subId = idArr[1];
		}
		ProjectSubEntity sub = getOne(subId);
		List<ProjectSubBarcodeEntity> bcList = projectSubBarcodeService.findBySubIdAndBarcode(subId,newBarcode);
		if(CollectionUtils.isEmpty(bcList)){
			subAmount = Math.abs(subAmount);
			String streamId = stockDetailService.descStockDetail(sub,subAmount);
			
			ProjectSubBarcodeEntity subBc = new ProjectSubBarcodeEntity();
			ProjectInfoBaseEntity main = new ProjectInfoBaseEntity();
			main.setUuid(sub.getMain().getUuid());
			subBc.setMain(main);
			ProjectSubBaseEntity subBase = new ProjectSubBaseEntity();
			subBase.setUuid(sub.getUuid());
			subBc.setSub(subBase);
			subBc.setBarcode(newBarcode);
			subBc.setStreamId(streamId);
			subBc.setSubAmount(subAmount);
			projectSubBarcodeService.doAdd(subBc);
		}else{
			ProjectSubBarcodeEntity bc = bcList.get(0);
			if(operType.equals("update")){
				bc.setSubAmount(subAmount);
			}else {
				bc.setSubAmount(bc.getSubAmount()+subAmount);
			}
			stockDetailService.unOutBySub(bc.getStreamId());//插销出库
			
			String streamId = stockDetailService.descStockDetail(sub,bc.getSubAmount());
			bc.setStreamId(streamId);
		}
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
	

	
	@Transactional
	public ActionResultModel<ProjectSubEntity> unOutBySub(String newUuid) {
		ActionResultModel<ProjectSubEntity> arm = new ActionResultModel<ProjectSubEntity>();
		String []idArr = newUuid.split("_");
		if(checkHasStream(idArr[0])){
			ProjectSubBarcodeEntity bc = projectSubBarcodeService.getOne(idArr[0]);
			if(bc!=null){
				stockDetailService.unOutBySub(bc.getStreamId());//idArr[0]
				projectSubBarcodeService.delete(bc);
			}
		}else{
			throw new ServiceException("未扫码出库不能撤销");
		}
//		ProjectSubEntity sub = getOne(idArr[1]);
//		String barcodeJson = sub.getBarcodejson();
//		List<ProjectBarcodeVo> blist = new ArrayList<>();
//		if(!StringUtils.isEmpty(barcodeJson)){
//			blist = JSON.parseArray(barcodeJson, ProjectBarcodeVo.class);
//		}
//		for(int i=0;i<blist.size();i++){
//			if(blist.get(i).getUuid().equals(idArr[0])){
//				blist.remove(i);
//			}
//		}
//		sub.setBarcodejson(JSON.toJSONString(blist));
		arm.setSuccess(true);
		arm.setMsg("操作成功");
		return arm;
	}
	
	
	private boolean checkHasStream(String index){
		if(index.length()<10){
			return false;
		}
		return true;
	}
	
	
	public void changeToSheet(List<ProjectInfoEntity> mainList, Workbook wb) {
		for(ProjectInfoEntity main:mainList){
			List<ProjectSubEntity> subList = findByMain(main.getUuid());
			changeToCells(main, subList, wb);
		}
	}

	
	private void changeToCells(ProjectInfoEntity main, List<ProjectSubEntity> subList, Workbook wb) {
		Row row = null;
		Cell cell =null;
		Sheet sh =null;
		sh = wb.createSheet(main.getName() + "(" + main.getCode() + ")");
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
        
        CellStyle  redStyle = wb.createCellStyle();// 样式对象    
        Font redFont = wb.createFont();
	    redFont.setColor(Font.COLOR_RED);//颜色
	    redStyle.setFont(redFont);
		
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
//		
//		cell = row.createCell(1);
//		cell.setCellStyle(style);
//		cell.setCellValue("物料编码");
		
		cell = row.createCell(1);
		cell.setCellStyle(style);
		cell.setCellValue("物料编码");
		
		cell = row.createCell(2);
		cell.setCellStyle(style);
		cell.setCellValue("物料描述");
		
		cell = row.createCell(3);
		cell.setCellStyle(style);
		cell.setCellValue("计划数量");
		
		cell = row.createCell(4);
		cell.setCellStyle(style);
		cell.setCellValue("单位");
		
		cell = row.createCell(5);
		cell.setCellStyle(style);
		cell.setCellValue("采购模式");
		
		cell = row.createCell(6);
		cell.setCellStyle(style);
		cell.setCellValue("条形码");
		
		cell = row.createCell(7);
		cell.setCellStyle(style);
		cell.setCellValue("到货数量");
		
		cell = row.createCell(8);
		cell.setCellStyle(style);
		cell.setCellValue("备注");
		
		
		List<ProjectSubEntity> resultList = new ArrayList<>();
		List<String> projectIdList = new ArrayList<String>();
		projectIdList.add(main.getUuid());
		List<ProjectSubBarcodeEntity> barcodeList = projectSubBarcodeService.findByProjectIds(projectIdList);
		Map<String,List<ProjectSubBarcodeEntity>> barcodeMap = changeToBarcodeMap(barcodeList);
		List<ProjectSubBarcodeEntity> subBarcodelist = null;
		ProjectSubEntity desSub = null;
		List<EnumDataSubEntity> enumList = EnumDataUtils.getEnumSubList("barCodeExtract");
		for(ProjectSubEntity sub:subList){
			subBarcodelist = barcodeMap.get(sub.getUuid());
			if(sub.getLimitCount()==MaterialBaseEntity.limitCount_unique&&sub.getPlanAmount()>1){//唯一
				for(int i=0;i<sub.getPlanAmount();i++){
					desSub = new ProjectSubEntity();
					try {
						ConvertUtils.register(new DateConverter(null), java.util.Date.class);
						BeanUtils.copyProperties(desSub, sub);
					} catch (IllegalAccessException e) {
						e.printStackTrace();
					} catch (InvocationTargetException e) {
						e.printStackTrace();
					}
					if(i==0){
						desSub.setFirstRow("1");
					}else{
						desSub.setFirstRow("0");
					}
					desSub.setNewUuid(i+"_"+sub.getUuid());
					if(subBarcodelist!=null&&i<subBarcodelist.size()){
						desSub.setBarcode(subBarcodelist.get(i).getBarcode());
					}else{
						desSub.setBarcode("");
					}
					resultList.add(desSub);
				}
			}else{
//				sub.setNewUuid("0_"+sub.getUuid());
//				sub.setFirstRow("1");
//				if(subBarcodelist!=null&&subBarcodelist.size()>0){
//					sub.setBarcode(subBarcodelist.get(0).getBarcode());
//				}else{
//					sub.setBarcode("");
//				}
//				resultList.add(sub);
				
				if(CollectionUtils.isEmpty(subBarcodelist)){
					sub.setFirstRow("1");
					sub.setBarcode("");
					checkStyle(sub,enumList);
					resultList.add(sub);
				}else{
					for(int i=0;i<subBarcodelist.size();i++){
						desSub = new ProjectSubEntity();
						try {
							ConvertUtils.register(new DateConverter(null), java.util.Date.class);
							BeanUtils.copyProperties(desSub, sub);
						} catch (Exception e) {e.printStackTrace();}
						desSub.setFirstRow(i==0?"1":"0");
						desSub.setBarcode(subBarcodelist.get(i).getBarcode());
//						desSub.setBarcodeHis(desSub.getBarcode());
						checkStyle(desSub,enumList);
						resultList.add(desSub);
					}
				}
			}
		}
		int rownum=0;
		for(ProjectSubEntity sub:resultList){
			rownum++;
			row = sh.createRow(rownum);
			
			cell = row.createCell(0);//
			cell.setCellValue((sub.getBoxNum()));
			
			if(sub.getMaterial().getPurchaseType().equals(MaterialEntity.PURCHASETYPE_CS)){
				cell = row.createCell(1);//
				cell.setCellValue(sub.getMaterial().getHwcode());
				
			}else{
				cell = row.createCell(1);//
				cell.setCellValue(sub.getMaterial().getCode());
			}
			
			cell = row.createCell(2);//
			if(sub.getFirstRow().equals("1")){
				cell.setCellValue(sub.getMaterial().getMemo());
			}else{
				cell.setCellValue("");
			}	
			
			cell = row.createCell(3);//
			if(sub.getFirstRow().equals("1")){
				cell.setCellValue(sub.getPlanAmount());
			}else{
				cell.setCellValue("");
			}
			
			cell = row.createCell(4);//
			if(sub.getFirstRow().equals("1")){
				cell.setCellValue(sub.getMaterial().getUnit());
			}else{
				cell.setCellValue("");
			}
			
			cell = row.createCell(5);//
			if(sub.getFirstRow().equals("1")){
				cell.setCellValue(sub.getMaterial().getPurchaseType());
			}else{
				cell.setCellValue("");
			}
			
			cell = row.createCell(6);//
			cell.setCellValue(sub.getBarcode());
			if(checkStyle(sub, enumList)){
				cell.setCellStyle(redStyle);
			}
			
			cell = row.createCell(7);//
			if(sub.getFirstRow().equals("1")){
				cell.setCellValue(sub.getActualAmount());
			}else{
				cell.setCellValue("");
			}
			
			cell = row.createCell(8);//
			if(sub.getFirstRow().equals("1")){
				cell.setCellValue(sub.getMemo());
			}else{
				cell.setCellValue("");
			}
		}	
	}
	
	/**
	 * 转成条码map
	 * @param streamList
	 * @return
	 */
	private Map<String, List<ProjectSubBarcodeEntity>> changeToBarcodeMap(List<ProjectSubBarcodeEntity> barcodeList) {
		Map<String,List<ProjectSubBarcodeEntity>> map = new HashMap<String, List<ProjectSubBarcodeEntity>>();
		if(CollectionUtils.isEmpty(barcodeList)){
			return map;
		}
		List<ProjectSubBarcodeEntity> list = null;
		for(ProjectSubBarcodeEntity s:barcodeList){
			list = map.get(s.getSub().getUuid());
			if(list==null){
				list = new ArrayList<ProjectSubBarcodeEntity>();
			}
			list.add(s);
			map.put(s.getSub().getUuid(), list);
		}
		return map;
	}

	
	private boolean checkStyle(ProjectSubEntity sub,List<EnumDataSubEntity> enumList){
		if(StringUtils.isEmpty(sub.getBarcode())){
//			sub.setCheckStatus(ProjectSubEntity.checkStatus_init);
		}else if(sub.getBarcode().contains(sub.getMaterial().getHwcode())){
//			sub.setCheckStatus(ProjectSubEntity.checkStatus_pass);
			return true;
		}else{
//			sub.setCheckStatus(ProjectSubEntity.checkStatus_error);
			return true;
		}
		for(EnumDataSubEntity enumSub:enumList){
			String t_pre = enumSub.getEnumdatakey();
			if(sub.getBarcode()!=null&&sub.getBarcode().indexOf(t_pre)==0){//以19,39...开头的
				String limitLength = enumSub.getDescription();//限制长度
				if(limitLength!=null&&limitLength!=""&&Integer.parseInt(limitLength)!=sub.getBarcode().length()){
//					sub.setBarcodeStatus(ProjectSubEntity.BARCODE_STATUS_LENGTH_WRONG);
//					break;
					return true;
				}
			}
		}
		return false;
	}
	
	public ActionResultModel<ProjectSubEntity> checkBarcode(String newBarcode, String subId) {
		ActionResultModel<ProjectSubEntity> arm = new ActionResultModel<ProjectSubEntity> ();
		List<ProjectSubBarcodeEntity> searchBarcodeList = projectSubBarcodeService.findLikeBarcode(null,newBarcode);
		if(CollectionUtils.isEmpty(searchBarcodeList)){
			arm.setSuccess(true);
			arm.setMsg("没有重复的条码");
			return arm;
		}
		String []arr = subId.split("_");
		if(arr.length>1){
			subId = arr[0];
		}
		if(searchBarcodeList.size()==1&&searchBarcodeList.get(0).getUuid().equals(subId)){
			arm.setSuccess(true);
			arm.setMsg("没有重复的条码");
			return arm;
		}else{
			List<String> repeatList = new ArrayList<>();
			for(ProjectSubBarcodeEntity sub:searchBarcodeList){
				repeatList.add(sub.getMain().getName()+"("+sub.getMain().getCode()+")箱号"+sub.getSub().getBoxNum());
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
