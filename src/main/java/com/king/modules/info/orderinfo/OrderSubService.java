package com.king.modules.info.orderinfo;

import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.collections.CollectionUtils;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import com.google.protobuf.ServiceException;
import com.king.common.enums.BillStatus;
import com.king.common.utils.ExcelDataUtil;
import com.king.frame.controller.ActionResultModel;
import com.king.frame.dao.IBaseDAO;
import com.king.frame.security.ShiroUser;
import com.king.frame.service.BaseServiceImpl;
import com.king.modules.info.material.MaterialEntity;
import com.king.modules.info.material.MaterialService;
import com.king.modules.info.stockstream.StockStreamEntity;
import com.king.modules.sys.imexlate.ImexlateSubEntity;
import com.king.modules.sys.imexlate.ImexlateSubService;
import com.king.modules.sys.user.UserEntity;

/**
 * OrderSubService
 * @author liusheng
 *
 */
@Service
@Transactional(readOnly=true)
public class OrderSubService extends BaseServiceImpl<OrderSubEntity, String> {

	@Autowired
	private OrderSubDao dao;
	@Lazy
	@Autowired
	private OrderInfoService mainService;
	@Autowired
	private ImexlateSubService imexlateSubService;
	@Autowired
	private MaterialService materialService;

	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	protected IBaseDAO getDAO() {
		return dao;
	}

	/**
	 * 保存
	 * @param entity
	 * @param subList
	 * @param deletePKs
	 * @return
	 */
	@Transactional
	public ActionResultModel<OrderInfoEntity> saveSelfAndSubList(OrderInfoEntity entity, List<OrderSubEntity> subList,
			String[] deletePKs) {
		ActionResultModel<OrderInfoEntity> arm = new ActionResultModel<OrderInfoEntity>();
      try {
    	// 删除子表一数据
  		if (deletePKs != null && deletePKs.length > 0) {
  			delete(deletePKs);
  		}
  		OrderInfoEntity savedEntity = null;
  		// 保存自身数据
  		if(StringUtils.isEmpty(entity.getUuid())){
			entity.setBillstatus(BillStatus.FREE.toStatusValue());
		}
  		savedEntity = mainService.save(entity);
  		
  		UserEntity user = ShiroUser.getCurrentUserEntity();
  		// 保存子表数据
  		if(subList!=null&&subList.size()>0){
  			for (OrderSubEntity sub : subList) {
  				if(StringUtils.isEmpty(sub.getUuid())){
  	  				sub.setCreator(user.getUuid());
  	  				sub.setCreatorname(user.getUsername());
  	  				sub.setCreatetime(new Date());
  				}
  				MaterialEntity material = new MaterialEntity();
  				material.setUuid(sub.getMaterialId());
  				
  				if(sub.getWarningTime()!=null){
  					sub.setWarningType(StockStreamEntity.WARNINGTYPE_BE_NEED);
  				}else{
  					sub.setWarningType(StockStreamEntity.WARNINGTYPE_NO_NEED);
  				}
  				sub.setMaterial(material);
  				sub.setActualAmount(sub.getPlanAmount());
  				sub.setMain(savedEntity);
  				sub.setModifier(user.getUuid());
  				sub.setModifiername(user.getUsername());
  				sub.setModifytime(new Date());
  			}
  			save(subList);
  		}
  		arm.setRecords(savedEntity);
  		arm.setSuccess(true);
      } catch (Exception e) {
    	  arm.setSuccess(false);
    	  arm.setMsg(e.getMessage());
    	  e.printStackTrace();
      }
	  return arm;
	}

	
	@Transactional(readOnly=true)
	public List<OrderSubEntity> findByMain(String mainId) {
		return dao.findByMain(mainId);
	}

	
	@SuppressWarnings({ "unchecked", "resource" })
	@Transactional
	public ActionResultModel<OrderInfoEntity> importExcel(MultipartFile file, OrderInfoEntity orderInfo) {
		List<ImexlateSubEntity> implateSubList=imexlateSubService.findByTemCoding("orderInfoImport");
		Map<String,Integer> imexMap=new HashMap<String,Integer>();
		String exportCellNum="";
		for(ImexlateSubEntity implateSub:implateSubList){
			exportCellNum=implateSub.getExportCellNum();
			imexMap.put(implateSub.getFieldName(), ExcelDataUtil.excelColtoNum(exportCellNum, exportCellNum.length()-1));
		}
		
		ActionResultModel<OrderInfoEntity> arm=new ActionResultModel<OrderInfoEntity>();
		HSSFWorkbook hssfWorkbook =null;
		XSSFWorkbook xssfWorkbook = null;
		InputStream is=null;
		try {
			OrderSubEntity entity = null;
			
			String postfix = ExcelDataUtil.getPostfix(file.getOriginalFilename());
			String code="";
			String planCount = "";
			String warningTimeStr = "";
			List<OrderSubEntity> list = new ArrayList<>();
			Set<String> materialCodeSet = new HashSet<>();
			List<String> codeList =new ArrayList<>();
			List<String> repeatCode = new ArrayList<>();
			if (!ExcelDataUtil.EMPTY.equals(postfix)) {
				is = file.getInputStream();
				if (ExcelDataUtil.OFFICE_EXCEL_2003_POSTFIX.equals(postfix)) {
					hssfWorkbook = new HSSFWorkbook(is);
					int sheetCount=1;//hssfWorkbook.getNumberOfSheets();只读取第一个sheet
					for (int numSheet = 0; numSheet < sheetCount; numSheet++) {
						HSSFSheet hssfSheet = hssfWorkbook.getSheetAt(numSheet);
						if (hssfSheet == null) {
							continue;
						}
						//i=hssfSheet.getFirstRowNum(); 
						//i <= hssfSheet.getPhysicalNumberOfRows()
						for (int rowNum = 1; rowNum <= hssfSheet.getLastRowNum(); rowNum++) {
							HSSFRow hssfRow = hssfSheet.getRow(rowNum);
							if (hssfRow != null) {
								entity = new OrderSubEntity();
								planCount = ExcelDataUtil.getValue(hssfRow.getCell(imexMap.get("planAmount")));
								if(StringUtils.isEmpty(planCount)){
									throw new ServiceException("第"+(rowNum+1)+"计划数量不能为空");
								}else{
									try {
										planCount = planCount.replace(".0", "");
										entity.setPlanAmount(Long.parseLong(planCount));
									} catch (Exception e) {
										e.printStackTrace();
										throw new ServiceException("第"+(rowNum+1)+"行计划数量不为有效数字");
									}
								}
								warningTimeStr = ExcelDataUtil.getValue(hssfRow.getCell(imexMap.get("warningTime")));
								if(!StringUtils.isEmpty(warningTimeStr)){
									try {
										SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
										entity.setWarningTime(formatter.parse(warningTimeStr));
									} catch (Exception e) {
										e.printStackTrace();
										throw new ServiceException("第"+(rowNum+1)+"行预警时间格式不为yyyy-MM-dd");
									}
									entity.setWarningType(StockStreamEntity.WARNINGTYPE_BE_NEED); //1：要预警
								}
								entity.setActualAmount(entity.getPlanAmount());
								entity.setMemo(ExcelDataUtil.getValue(hssfRow.getCell(imexMap.get("memo"))));
								
								code = ExcelDataUtil.getValue(hssfRow.getCell(imexMap.get("materialCode")));
								if(StringUtils.isEmpty(code)){
									throw new ServiceException("第"+(rowNum+1)+"行物料不能为空");
								}
								if(materialCodeSet.contains(code)){
									repeatCode.add(code);
								}else{
									list.add(entity);
								}
								entity.setMaterialCode(code);
								materialCodeSet.add(code);
								codeList.add(code);
								list.add(entity);
							}
						}
					}
				} else if (ExcelDataUtil.OFFICE_EXCEL_2010_POSTFIX.equals(postfix)) {
					xssfWorkbook = new XSSFWorkbook(is);
					int sheetCount=1;//xssfWorkbook.getNumberOfSheets() 只读取第一个sheet
					for (int numSheet = 0; numSheet < sheetCount; numSheet++) {
						XSSFSheet xssfSheet = xssfWorkbook.getSheetAt(numSheet);
						if (xssfSheet == null) {
							continue;
						}
						//i=hssfSheet.getFirstRowNum(); 
						//i <= hssfSheet.getPhysicalNumberOfRows()
						for (int rowNum = 1; rowNum <= xssfSheet.getLastRowNum(); rowNum++) {
							XSSFRow xssfRow = xssfSheet.getRow(rowNum);
							if (xssfRow != null) {
								entity = new OrderSubEntity();
								planCount = ExcelDataUtil.getValue(xssfRow.getCell(imexMap.get("planAmount")));
								if(StringUtils.isEmpty(planCount)){
									throw new ServiceException("第"+(rowNum+1)+"计划数量不能为空");
								}else{
									try {
										planCount = planCount.replace(".0", "");
										entity.setPlanAmount(Long.parseLong(planCount));
									} catch (Exception e) {
										e.printStackTrace();
										throw new ServiceException("第"+(rowNum+1)+"行计划数量不为有效数字");
									}
								}
								warningTimeStr = ExcelDataUtil.getValue(xssfRow.getCell(imexMap.get("warningTime")));
								if(!StringUtils.isEmpty(warningTimeStr)){
									try {
										SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
										entity.setWarningTime(formatter.parse(warningTimeStr));
									} catch (Exception e) {
										e.printStackTrace();
										throw new ServiceException("第"+(rowNum+1)+"行预警时间格式不为yyyy-MM-dd");
									}
									entity.setWarningType(StockStreamEntity.WARNINGTYPE_BE_NEED); //1：要预警
								}
								entity.setActualAmount(entity.getPlanAmount());
								entity.setMemo(ExcelDataUtil.getValue(xssfRow.getCell(imexMap.get("memo"))));
								
								code = ExcelDataUtil.getValue(xssfRow.getCell(imexMap.get("materialCode")));
								if(StringUtils.isEmpty(code)){
									throw new ServiceException("第"+(rowNum+1)+"行物料不能为空");
								}
								if(materialCodeSet.contains(code)){
									repeatCode.add(code);
								}else{
									list.add(entity);
								}
								entity.setMaterialCode(code);
								materialCodeSet.add(code);
								codeList.add(code);
								list.add(entity);
							}
						}
					}
				}
			}
			if(repeatCode.size()>0){
				arm.setSuccess(false);
				arm.setMsg(org.apache.commons.lang3.StringUtils.join(repeatCode)+"存在相同的物料编码");
			}else{
				List<MaterialEntity> materialList = materialService.findByCodes(codeList);
				boolean hasMaterial = false;//是否存在料号
				List<String> notExitCode = new ArrayList<>();//不存在的料号
				for(OrderSubEntity orderSub : list){
					hasMaterial = false;
					for(MaterialEntity material:materialList){
						if(orderSub.getMaterialCode().equals(material.getCode())){
							hasMaterial = true;
							orderSub.setMaterialId(material.getUuid());
							break;
						}
					}
					if(!hasMaterial){
						notExitCode.add(orderSub.getMaterialCode());
					}
				}
				if(CollectionUtils.isEmpty(notExitCode)){
					saveSelfAndSubList(orderInfo, list, null);
					arm.setSuccess(true);
					arm.setMsg("导入成功.");
				}else{
					arm.setSuccess(false);
					arm.setMsg("料号"+org.apache.commons.lang3.StringUtils.join(notExitCode)+"不存在");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
		}finally {
			try {
				if(is!=null){
					is.close();
				}
				if(hssfWorkbook!=null){
					hssfWorkbook.close();
				}
				if(xssfWorkbook!=null){
					xssfWorkbook.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return arm;
	}



	
}
