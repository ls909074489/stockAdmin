package com.king.modules.info.material;

import java.io.IOException;
import java.io.InputStream;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.king.common.utils.ExcelDataUtil;
import com.king.frame.controller.ActionResultModel;
import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.BaseServiceImpl;
import com.king.modules.sys.enumdata.EnumDataUtils;
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
	
	

	@Override
	public void beforeSave(MaterialEntity entity) throws ServiceException {
		String code = entity.getCode();
		String hwCode = entity.getHwcode();
		code = StringUtils.isEmpty(code)?"*":code;
		hwCode = StringUtils.isEmpty(hwCode)?"*":hwCode;
		entity.setCodeAndHw(code+"_"+hwCode);
		super.beforeSave(entity);
	}



	@Override
	public Iterable<MaterialEntity> doAdd(Iterable<MaterialEntity> entities) throws ServiceException {
		List<String> codeList = new ArrayList<>();
		for (MaterialEntity entity : entities) {
			codeList.add(entity.getCode());
		}
		List<MaterialEntity> materialList = dao.findByCodes(codeList);
		if(materialList!=null&&materialList.size()>0){
			List<String> code = new ArrayList<>();
			for(MaterialEntity m:materialList){
				code.add(m.getCode());
			}
			throw new ServiceException("料号"+StringUtils.join(code)+"已存在");
		}
		return super.doAdd(entities);
	}



	@Transactional
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
//			Map<String,String> codeMap=new HashMap<String,String>();
			MaterialEntity entity = null;
			String postfix = ExcelDataUtil.getPostfix(file.getOriginalFilename());
			DecimalFormat df = new DecimalFormat("0");// 格式化 number String
			String code="";
			String hwcode="";
			String purchaseType = "";
			List<MaterialEntity> list = new ArrayList<>();
			List<String> codeList = new ArrayList<>();
			List<String> hwcodeList = new ArrayList<>();
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
								code = ExcelDataUtil.getValue(hssfRow.getCell(imexMap.get("code")),df);
								if(StringUtils.isNotEmpty(code)){
									code = code.trim();
									code = code.replace(".0", "");
									codeList.add(code);
								}
								entity.setCode(code);
								hwcode=ExcelDataUtil.getValue(hssfRow.getCell(imexMap.get("hwcode")));
								if(StringUtils.isNotEmpty(hwcode)){
									hwcode = hwcode.trim();
									hwcode = hwcode.replace(".0", "");
									hwcodeList.add(hwcode);
								}
								entity.setHwcode(hwcode);
								
								entity.setName(ExcelDataUtil.getValue(hssfRow.getCell(imexMap.get("name")),df));
								entity.setMemo(ExcelDataUtil.getValue(hssfRow.getCell(imexMap.get("memo"))));
								purchaseType = ExcelDataUtil.getValue(hssfRow.getCell(imexMap.get("purchaselType")));
								entity.setHasRisk(0);
								if(!StringUtils.isEmpty(purchaseType)){
									if((purchaseType.equals("CS")||purchaseType.equals("C/S"))){
										entity.setPurchaseType(MaterialEntity.PURCHASETYPE_CS);
									}else if(purchaseType.equals("TK")){
										entity.setPurchaseType(MaterialEntity.PURCHASETYPE_TK);
									}else{
										throw new ServiceException("第"+(rowNum+1)+"行采购模式必须为TK或CS");
									}
								}else{
									throw new ServiceException("第"+(rowNum+1)+"行采购模式不能为空");
								}
								entity.setClassDesc(ExcelDataUtil.getValue(hssfRow.getCell(imexMap.get("classDesc"))));
								entity.setUnit(ExcelDataUtil.getValue(hssfRow.getCell(imexMap.get("unit"))));//单位
//								if(codeMap.containsKey(code)){
//									repeatCode.add(code);
//								}else{
//									list.add(entity);
//								}
//								codeMap.put(code,code);
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
								entity = new MaterialEntity();
								code = ExcelDataUtil.getValue(xssfRow.getCell(imexMap.get("code")),df);
								if(StringUtils.isNotEmpty(code)){
									code = code.trim();
									code = code.replace(".0", "");
									codeList.add(code);
								}
								entity.setCode(code);
								hwcode=ExcelDataUtil.getValue(xssfRow.getCell(imexMap.get("hwcode")));
								if(StringUtils.isNotEmpty(hwcode)){
									hwcode = hwcode.trim();
									hwcode = hwcode.replace(".0", "");
									hwcodeList.add(hwcode);
								}
								entity.setHwcode(hwcode);
								
								entity.setName(ExcelDataUtil.getValue(xssfRow.getCell(imexMap.get("name")),df));
								entity.setMemo(ExcelDataUtil.getValue(xssfRow.getCell(imexMap.get("memo"))));
								purchaseType = ExcelDataUtil.getValue(xssfRow.getCell(imexMap.get("purchaselType")));
								entity.setHasRisk(0);
								if(!StringUtils.isEmpty(purchaseType)){
									if((purchaseType.equals("CS")||purchaseType.equals("C/S"))){
										entity.setPurchaseType(MaterialEntity.PURCHASETYPE_CS);
									}else if(purchaseType.equals("TK")){
										entity.setPurchaseType(MaterialEntity.PURCHASETYPE_TK);
									}else{
										throw new ServiceException("第"+(rowNum+1)+"行采购模式必须为TK或CS");
									}
								}else{
									throw new ServiceException("第"+(rowNum+1)+"行采购模式不能为空");
								}
								entity.setClassDesc(ExcelDataUtil.getValue(xssfRow.getCell(imexMap.get("classDesc"))));
								entity.setUnit(ExcelDataUtil.getValue(xssfRow.getCell(imexMap.get("unit"))));//单位
//								if(codeMap.containsKey(code)){
//									repeatCode.add(code);
//								}else{
//									list.add(entity);
//								}
//								codeMap.put(code,code);
								list.add(entity);
							}
						}
					}
				}
			}
			List<MaterialEntity> tkMaterial = findByCodes(codeList);
			List<MaterialEntity> csMaterial = findByCodes(hwcodeList);
			for(MaterialEntity obj:list){
				if(saveWithHwCode(obj, csMaterial)){
					continue;
				}
				if(saveWithCode(obj, tkMaterial)){
					continue;
				}
				doAdd(obj);
			}
			arm.setSuccess(true);
			arm.setMsg("导入成功.");
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

	private boolean saveWithHwCode(MaterialEntity obj,List<MaterialEntity> mList){
		if(CollectionUtils.isNotEmpty(mList)){
			return false;
		}
		for(MaterialEntity m:mList){
			if(m.getHwcode().equals(obj.getHwcode())){
				m.setCode(obj.getCode());
				m.setName(obj.getName());
				m.setUnit(obj.getUnit());
				m.setClassDesc(obj.getClassDesc());
				m.setMemo(obj.getMemo());
				m.setPurchaseType(obj.getPurchaseType());
				return true;
			}
		}
		return false;
	}
	
	private boolean saveWithCode(MaterialEntity obj,List<MaterialEntity> mList){
		if(CollectionUtils.isNotEmpty(mList)){
			return false;
		}
		for(MaterialEntity m:mList){
			if(m.getCode().equals(obj.getCode())){
				m.setHwcode(obj.getHwcode());
				m.setName(obj.getName());
				m.setUnit(obj.getUnit());
				m.setClassDesc(obj.getClassDesc());
				m.setMemo(obj.getMemo());
				m.setPurchaseType(obj.getPurchaseType());
				return true;
			}
		}
		return false;
	}
	
	
	public void changeToStatisCells(List<MaterialEntity> resultList, Workbook wb) {
		List<ImexlateSubEntity> implateSubList=imexlateSubService.findByTemCoding("materialExport");
		Row row = null;
		Cell cell =null;
		Sheet sh =null;
		sh = wb.createSheet("物料信息");
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
		for(MaterialEntity obj:resultList){
			rownum++;
			row = sh.createRow(rownum);
			map = changeMaterialToMap(map, obj);
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
	private Map<String,String> changeMaterialToMap(Map<String,String> map,MaterialEntity obj){
		map = new HashMap<>();
		map.put("code", obj.getCode());
		map.put("name", obj.getName());
		map.put("hwcode", obj.getHwcode());
		map.put("hasRisk", EnumDataUtils.getEnumValue(obj.getHasRisk()+"", "BooleanType"));
		map.put("unit", EnumDataUtils.getEnumValue(obj.getUnit(), "MaterialUnit"));
		map.put("classDesc", obj.getClassDesc());
		map.put("memo", obj.getMemo());
		map.put("purchaselType", obj.getPurchaseType());
		map.put("position", obj.getPosition());
		return map;
	}
	
	
	public List<MaterialEntity> findByCodes(List<String> codeList) {
		List<MaterialEntity> list=new ArrayList<MaterialEntity>();
		if(codeList!=null&&codeList.size()>0){
			int pageSize=1000;
			double pageCount=Math.ceil(Double.valueOf(codeList.size()+"")/pageSize);
			for(int i=0;i<pageCount;i++){
				if((i+1)*pageSize<codeList.size()){
					list.addAll(dao.findByCodes(codeList.subList(i*pageSize, (i+1)*pageSize)));
				}else{
					list.addAll(dao.findByCodes(codeList.subList(i*pageSize, codeList.size())));
				}
			}
		}
		return list;
	}
	
	public List<MaterialEntity> findByHwCodes(List<String> hwCodeList) {
		List<MaterialEntity> list=new ArrayList<MaterialEntity>();
		if(hwCodeList!=null&&hwCodeList.size()>0){
			int pageSize=1000;
			double pageCount=Math.ceil(Double.valueOf(hwCodeList.size()+"")/pageSize);
			for(int i=0;i<pageCount;i++){
				if((i+1)*pageSize<hwCodeList.size()){
					list.addAll(dao.findByHwCodes(hwCodeList.subList(i*pageSize, (i+1)*pageSize)));
				}else{
					list.addAll(dao.findByHwCodes(hwCodeList.subList(i*pageSize, hwCodeList.size())));
				}
			}
		}
		return list;
	}

}