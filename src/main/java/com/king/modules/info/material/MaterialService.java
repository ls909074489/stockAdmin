package com.king.modules.info.material;

import java.io.IOException;
import java.io.InputStream;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.king.common.utils.ExcelDataUtil;
import com.king.frame.controller.ActionResultModel;
import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.BaseServiceImpl;
import com.king.modules.sys.imexlate.ImexlateSubEntity;
import com.king.modules.sys.imexlate.ImexlateSubService;

/**
 * 物料
 * @author null
 * @date 2019-06-16 15:53:34
 */
@Service
@Transactional(readOnly=true)
public class MaterialService extends BaseServiceImpl<MaterialEntity,String> {

	@Autowired
	private MaterialDao dao;
	//@Autowired
	//private DbUtilsDAO dbDao;
	@Autowired
	private ImexlateSubService imexlateSubService;

	protected IBaseDAO<MaterialEntity, String> getDAO() {
		return dao;
	}

	public ActionResultModel<MaterialEntity> importExcel(MultipartFile file) {
		List<ImexlateSubEntity> implateSubList=imexlateSubService.findByTemCoding("materialImport");
		Map<String,Integer> imexMap=new HashMap<String,Integer>();
		String exportCellNum="";
		for(ImexlateSubEntity implateSub:implateSubList){
			exportCellNum=implateSub.getExportCellNum();
			imexMap.put(implateSub.getFieldName(), ExcelDataUtil.excelColtoNum(exportCellNum, exportCellNum.length()-1));
		}
		
		ActionResultModel<MaterialEntity> arm=new ActionResultModel<MaterialEntity>();
		HSSFWorkbook hssfWorkbook =null;
		XSSFWorkbook xssfWorkbook = null;
		InputStream is=null;
		try {
			Map<String,String> codeMap=new HashMap<String,String>();
			MaterialEntity entity = null;
			
			String postfix = ExcelDataUtil.getPostfix(file.getOriginalFilename());
			DecimalFormat df = new DecimalFormat("0");// 格式化 number String
			String code="";
			List<String> repeatCode = new ArrayList<>();
			List<MaterialEntity> list = new ArrayList<>();
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
								
								entity = new MaterialEntity();
								code = ExcelDataUtil.getValue(hssfRow.getCell(imexMap.get("code")));
								entity.setCode(code);
								entity.setName(ExcelDataUtil.getValue(hssfRow.getCell(imexMap.get("name"))));
								codeMap.put(code,code);
								if(codeMap.containsKey(code)){
									repeatCode.add(code);
								}else{
									list.add(entity);
								}
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
								
								entity = new MaterialEntity();
								code = ExcelDataUtil.getValue(xssfRow.getCell(imexMap.get("code")),df);
								entity.setCode(code);
								entity.setName(ExcelDataUtil.getValue(xssfRow.getCell(imexMap.get("name")),df));
								codeMap.put(code,code);
								if(codeMap.containsKey(code)){
									repeatCode.add(code);
								}else{
									list.add(entity);
								}
							}
						}
					}
				}
			}
			if(repeatCode.size()>0){
				arm.setSuccess(false);
				arm.setMsg(StringUtils.join(repeatCode)+"存在相同的物料编码");
			}else{
				doAdd(list);
				arm.setSuccess(true);
				arm.setMsg("导入成功.");
			}
		} catch (Exception e) {
			e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
			//throw new ServiceException(e.getMessage());
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