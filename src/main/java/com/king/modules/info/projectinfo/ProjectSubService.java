package com.king.modules.info.projectinfo;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.collections.CollectionUtils;
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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import com.google.protobuf.ServiceException;
import com.king.common.utils.ExcelDataUtil;
import com.king.frame.controller.ActionResultModel;
import com.king.frame.dao.IBaseDAO;
import com.king.frame.security.ShiroUser;
import com.king.frame.service.BaseServiceImpl;
import com.king.modules.info.material.MaterialBaseEntity;
import com.king.modules.info.material.MaterialEntity;
import com.king.modules.info.material.MaterialService;
import com.king.modules.sys.imexlate.ImexlateSubEntity;
import com.king.modules.sys.imexlate.ImexlateSubService;
import com.king.modules.sys.user.UserEntity;

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
	public ActionResultModel<ProjectInfoEntity> saveSelfAndSubList(ProjectInfoEntity entity,
			List<ProjectSubEntity> subList, String[] deletePKs) {
		ActionResultModel<ProjectInfoEntity> arm = new ActionResultModel<ProjectInfoEntity>();
		try {
			// 删除子表一数据
			if (deletePKs != null && deletePKs.length > 0) {
				delete(deletePKs);
			}
			ProjectInfoEntity savedEntity = null;
			// 保存自身数据
			savedEntity = mainService.save(entity);

			UserEntity user = ShiroUser.getCurrentUserEntity();	
			// 保存子表数据
			if (subList != null && subList.size() > 0) {
				Map<String,String> codeMap = new HashMap<>();
				for (ProjectSubEntity sub : subList) {
					if (StringUtils.isEmpty(sub.getUuid())) {
						sub.setCreator(user.getUuid());
						sub.setCreatorname(user.getUsername());
						sub.setCreatetime(new Date());
					}
					sub.setMain(savedEntity);
					sub.setMid(savedEntity.getUuid());
					sub.setModifier(user.getUuid());
					sub.setModifiername(user.getUsername());
					sub.setModifytime(new Date());
					sub.setActualAmount(sub.getPlanAmount());
					
					if(codeMap.containsKey(sub.getBoxNum()+"_"+sub.getMaterialCode())){
						throw new ServiceException("第"+sub.getBoxNum()+"箱料号"+sub.getMaterialCode()+"不能重复");
					}
					codeMap.put(sub.getBoxNum()+"_"+sub.getMaterialCode(), "第"+sub.getBoxNum()+"箱料号"+sub.getMaterialCode());
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
	public ActionResultModel<ProjectSubEntity> updateBarcode(String newBarcode, String subId) {
		ActionResultModel<ProjectSubEntity> arm = new ActionResultModel<ProjectSubEntity>();
		ProjectSubEntity sub = getOne(subId);
		sub.setBarcode(newBarcode);
		arm.setSuccess(true);
		arm.setMsg("操作成功");
		return arm;
	}

	@Transactional
	public ActionResultModel<ProjectInfoEntity> importExcel(MultipartFile file, ProjectInfoEntity projectInfo) {
		List<ImexlateSubEntity> implateSubList = imexlateSubService.findByTemCoding("projectInfoImport");
		Map<String, Integer> imexMap = new HashMap<String, Integer>();
		String exportCellNum = "";
		for (ImexlateSubEntity implateSub : implateSubList) {
			exportCellNum = implateSub.getExportCellNum();
			imexMap.put(implateSub.getFieldName(),
					ExcelDataUtil.excelColtoNum(exportCellNum, exportCellNum.length() - 1));
		}

		ActionResultModel<ProjectInfoEntity> arm = new ActionResultModel<ProjectInfoEntity>();
		HSSFWorkbook hssfWorkbook = null;
		XSSFWorkbook xssfWorkbook = null;
		InputStream is = null;
		try {
			ProjectSubEntity entity = null;

			String postfix = ExcelDataUtil.getPostfix(file.getOriginalFilename());
			String code = "";
			String planCount = "";
			String boxNumStr = "";
			List<ProjectSubEntity> list = new ArrayList<>();
			Set<String> materialCodeSet = new HashSet<>();
			List<String> codeList = new ArrayList<>();
			List<String> repeatCode = new ArrayList<>();
			String distinctCode = "";
			if (!ExcelDataUtil.EMPTY.equals(postfix)) {
				is = file.getInputStream();
				if (ExcelDataUtil.OFFICE_EXCEL_2003_POSTFIX.equals(postfix)) {
					hssfWorkbook = new HSSFWorkbook(is);
					int sheetCount = 1;// hssfWorkbook.getNumberOfSheets();只读取第一个sheet
					for (int numSheet = 0; numSheet < sheetCount; numSheet++) {
						HSSFSheet hssfSheet = hssfWorkbook.getSheetAt(numSheet);
						if (hssfSheet == null) {
							continue;
						}
						// i=hssfSheet.getFirstRowNum();
						// i <= hssfSheet.getPhysicalNumberOfRows()
						for (int rowNum = 1; rowNum <= hssfSheet.getLastRowNum(); rowNum++) {
							HSSFRow hssfRow = hssfSheet.getRow(rowNum);
							if (hssfRow != null) {
								entity = new ProjectSubEntity();
								planCount = ExcelDataUtil.getValue(hssfRow.getCell(imexMap.get("planAmount")));
								if (StringUtils.isEmpty(planCount)) {
									throw new ServiceException("第" + (rowNum + 1) + "计划数量不能为空");
								} else {
									try {
										planCount = planCount.replace(".0", "");
										entity.setPlanAmount(Long.parseLong(planCount));
									} catch (Exception e) {
										e.printStackTrace();
										throw new ServiceException("第" + (rowNum + 1) + "行计划数量不为有效数字");
									}
								}
								entity.setActualAmount(entity.getPlanAmount());
								entity.setMemo(ExcelDataUtil.getValue(hssfRow.getCell(imexMap.get("memo"))));

								boxNumStr = ExcelDataUtil.getValue(hssfRow.getCell(imexMap.get("boxNum")));
								if (StringUtils.isEmpty(boxNumStr)) {
									throw new ServiceException("第" + (rowNum + 1) + "箱号不能为空");
								} else {
									entity.setBoxNum(boxNumStr);
								}
								code = ExcelDataUtil.getValue(hssfRow.getCell(imexMap.get("materialCode")));
								if (StringUtils.isEmpty(code)) {
									throw new ServiceException("第" + (rowNum + 1) + "行物料不能为空");
								}
								code = code.trim();
								distinctCode = "第" + entity.getPlanAmount() + "箱料号" + code;
								if (materialCodeSet.contains(distinctCode)) {
									repeatCode.add(distinctCode);
								}
								entity.setMaterialCode(code);
								materialCodeSet.add(distinctCode);
								codeList.add(code);
								list.add(entity);
							}
						}
					}
				} else if (ExcelDataUtil.OFFICE_EXCEL_2010_POSTFIX.equals(postfix)) {
					xssfWorkbook = new XSSFWorkbook(is);
					int sheetCount = 1;// xssfWorkbook.getNumberOfSheets()
										// 只读取第一个sheet
					for (int numSheet = 0; numSheet < sheetCount; numSheet++) {
						XSSFSheet xssfSheet = xssfWorkbook.getSheetAt(numSheet);
						if (xssfSheet == null) {
							continue;
						}
						// i=hssfSheet.getFirstRowNum();
						// i <= hssfSheet.getPhysicalNumberOfRows()
						for (int rowNum = 1; rowNum <= xssfSheet.getLastRowNum(); rowNum++) {
							XSSFRow xssfRow = xssfSheet.getRow(rowNum);
							if (xssfRow != null) {
								entity = new ProjectSubEntity();
								planCount = ExcelDataUtil.getValue(xssfRow.getCell(imexMap.get("planAmount")));
								if (StringUtils.isEmpty(planCount)) {
									throw new ServiceException("第" + (rowNum + 1) + "计划数量不能为空");
								} else {
									try {
										planCount = planCount.replace(".0", "");
										entity.setPlanAmount(Long.parseLong(planCount));
									} catch (Exception e) {
										e.printStackTrace();
										throw new ServiceException("第" + (rowNum + 1) + "行计划数量不为有效数字");
									}
								}
								entity.setActualAmount(entity.getPlanAmount());
								entity.setMemo(ExcelDataUtil.getValue(xssfRow.getCell(imexMap.get("memo"))));
								boxNumStr = ExcelDataUtil.getValue(xssfRow.getCell(imexMap.get("boxNum")));
								if (StringUtils.isEmpty(boxNumStr)) {
									throw new ServiceException("第" + (rowNum + 1) + "箱号不能为空");
								} else {
									entity.setBoxNum(boxNumStr);
								}

								code = ExcelDataUtil.getValue(xssfRow.getCell(imexMap.get("materialCode")));
								if (StringUtils.isEmpty(code)) {
									throw new ServiceException("第" + (rowNum + 1) + "行物料不能为空");
								}
								code = code.trim();
								distinctCode = "第" + entity.getPlanAmount() + "箱料号" + code;
								if (materialCodeSet.contains(distinctCode)) {
									repeatCode.add(distinctCode);
								}
								entity.setMaterialCode(code);
								materialCodeSet.add(distinctCode);
								codeList.add(code);
								list.add(entity);
							}
						}
					}
				}
			}
			if (repeatCode.size() > 0) {
				arm.setSuccess(false);
				arm.setMsg(org.apache.commons.lang3.StringUtils.join(repeatCode) + "存在相同的物料编码");
			} else {
				List<MaterialEntity> materialList = materialService.findByCodes(codeList);
				boolean hasMaterial = false;// 是否存在料号
				List<String> notExitCode = new ArrayList<>();// 不存在的料号
				MaterialBaseEntity materialBase = null;
				for (ProjectSubEntity projectSub : list) {
					hasMaterial = false;
					for (MaterialEntity material : materialList) {
						if (projectSub.getMaterialCode().equals(material.getCode())) {
							hasMaterial = true;
							materialBase = new MaterialBaseEntity();
							materialBase.setUuid(material.getUuid());
							projectSub.setMaterial(materialBase);
							projectSub.setMaterialCode(material.getCode());
							break;
						}
					}
					if (!hasMaterial) {
						notExitCode.add(projectSub.getMaterialCode());
					}
				}
				if (CollectionUtils.isEmpty(notExitCode)) {
					saveSelfAndSubList(projectInfo, list, null);
					arm.setSuccess(true);
					arm.setMsg("导入成功.");
				} else {
					arm.setSuccess(false);
					arm.setMsg("料号" + org.apache.commons.lang3.StringUtils.join(notExitCode) + "不存在");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
		} finally {
			try {
				if (is != null) {
					is.close();
				}
				if (hssfWorkbook != null) {
					hssfWorkbook.close();
				}
				if (xssfWorkbook != null) {
					xssfWorkbook.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
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
		cell.setCellValue("实际数量");
		
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
}
