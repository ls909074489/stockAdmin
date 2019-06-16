package com.king.modules.sys.imexlate;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Sheet;
import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.TypeReference;
import com.king.common.poi.POIExcelMakerUtil;
import com.king.common.poi.POIReadExcelUtil;
import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.BaseServiceImpl;
import com.king.modules.sys.enumdata.EnumDataSubEntity;
import com.king.modules.sys.enumdata.EnumDataSubService;
import com.king.modules.sys.enumdata.EnumDataUtils;
import com.king.modules.sys.param.ParameterDAO;
import com.king.modules.sys.param.ParameterEntity;
import com.king.modules.sys.param.ParameterUtil;

/**
 * 导入模板service
 * 
 * @ClassName: ImplateService
 * @author
 * @date 2016年55月10日 01:13:52
 */
@Service
@Transactional
public class ImexlateService extends BaseServiceImpl<ImexlateEntity, String> {

	@Autowired
	private ImexlateDao dao;

	@Autowired
	private ImexlateSubService subService;

	@Autowired
	private EnumDataSubService enumDataSubService;

	@Autowired
	private ParameterDAO parameterDAO;

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	protected IBaseDAO getDAO() {
		return dao;
	}


	public ImexlateEntity findByTemCoding(String coding) {
		ImexlateEntity imex=ImexlateUtil.getImexlateEntity(coding);
		//由于下载中都要调用该方法，所以先从缓存读取  edit by liusheng
		if(imex!=null&&!org.springframework.util.StringUtils.isEmpty(imex.getUuid())){
			return imex;
		}else{
			return dao.findByTemCoding(coding);
		}
	}
	
	public List<ImexlateEntity> findAllBystatus() {
		return dao.findByStatus();
	}

	/**
	 * 初始化
	 */
	public void initImexlate() {
		List<ImexlateEntity> list = findAllBystatus();
		if (list.size() > 0) {
			String classPath = this.getClass().getClassLoader().getResource("").getPath();
			// logger.info("classPath : " + classPath);
			/*
			 * if(StringUtils.isNotBlank(classPath) && StringUtils.contains(classPath, "ROOT")) { classPath =
			 * classPath.replace("ROOT", productName); }
			 */
			String dirPath = System.getProperty("user.dir");
			// logger.info("dirPath : " + dirPath);
			classPath = classPath.substring(0, classPath.length() - 1);
			classPath = classPath.substring(1, classPath.lastIndexOf("W") - 1);
			String iem = getExcelTempalePath();
			// logger.info("iem : " + iem);
			if (iem == null || iem.equals("")) {
				throw new ServiceException("模板存放地址参数未设置");
			} else {

				String path = getWinLinux(classPath + iem);
				// logger.info("path1 : " + path);
				if ("\\".equals(File.separator)) {
					path = path + iem.substring(iem.length() - 1, iem.length());
				}

				// logger.info("path2 : " + path);
				creFile(path);
				String excelPath = getExcelPath();
				if (excelPath == null || excelPath.equals("")) {
					throw new ServiceException("导入文件暂存地址参数未设置");
				}
				creFile(classPath + excelPath);
				List<ImexlateSubEntity> subList = subService.findAllByStatus();
				for (ImexlateEntity im : list) {
					if ("0".equals(im.getIscreate())) {
						continue;
					}
					// generateTemplate(im.getCoding(), path);
					generateTemplateForMany(im, path, subList);
				}
				// logger.info(">>>>>>>>> 导出导入模板生成成功！>>>>>>>>");
			}
		}
	}

	/**
	 * 
	 * @Title: generateTemplate @author liusheng @date 2016年8月30日 上午11:07:02 @param @param imexlate @param @param
	 *         path @param @param subList @param @return 设定文件 @return String 返回类型 @throws
	 */
	public String generateTemplateForMany(ImexlateEntity imexlate, String path, List<ImexlateSubEntity> subList) {

		Map<String, String[]> enumdataMap = new HashMap<String, String[]>();
		POIExcelMakerUtil poiEx = null;
		try {
			// logger.info("path00 : " + path);
			File file = new File(getWinLinux(path + "/"));
			if (!file.exists()) {
				file.mkdirs();
			}
			poiEx = new POIExcelMakerUtil(getWinLinux(path + "/" + imexlate.getExportFileName() + ".xlsx"),
					imexlate.getExportFileName());
			// List<ImexlateSubEntity> imexs = subService.findByTemCoding(imexlate.getCoding());
			List<ImexlateSubEntity> imexs = findSubByParent(imexlate.getUuid(), subList);

//			poiEx.MergeCells(0, 0, 0, imexs.size() - 1, imexlate.getExportFileName());
//			poiEx.createCell(0, 0);
//			poiEx.writeToExcel(0, 0, imexlate.getExportFileName());
//			poiEx.setUpStyle(0, 0, true, 20, true, true, false, false, false);
			for (ImexlateSubEntity imex : imexs) {
				int[] rowCell = poiEx.convertToRowNumColumnNum(imex.getExportCellNum() + 1);
				poiEx.createCell(rowCell[0], rowCell[1]);
				poiEx.writeToExcel(rowCell[0], rowCell[1], imex.getChineseField());
				poiEx.setUpStyle(rowCell[0], rowCell[1], false, 20, true, true, imex.getIsnotempty(), true,
						imex.getIsMainField());
				if(imex.getColumnWidth()!=null&&imex.getColumnWidth()!=0){
					poiEx.setSizeColumn(rowCell[1], imex.getColumnWidth());
				}else{
					poiEx.setSizeColumn(rowCell[1], length(imex.getChineseField()));
				}
				// 判断是否枚举字段 是 设置下拉框
				if ((imex.getEnumdata() != null && !imex.getEnumdata().equals(""))
						|| (imex.getQualifiedValue() != null && !imex.getQualifiedValue().equals(""))) {
					String[] enStr = null;
					for (String key : enumdataMap.keySet()) {
						if (key.equals(imex.getEnumdata()) || key.equals(imex.getQualifiedValue())) {
							enStr = enumdataMap.get(key);
						}
					}
					if (enStr == null) {
						if (imex.getQualifiedValue() != null && !imex.getQualifiedValue().equals("")) {
							if (imex.getQualifiedValue().lastIndexOf(",") != -1) {
								enStr = imex.getQualifiedValue().split(",");
							} else {
								enStr = new String[1];
								enStr[0] = imex.getQualifiedValue();
							}
							enumdataMap.put(imex.getQualifiedValue(), enStr);
						} else if (imex.getEnumdata() != null && !imex.getEnumdata().equals("")) {
							// List<EnumDataSubEntity> listEn = enumDataSubService.findByGroupcode(imex.getEnumdata());
							List<EnumDataSubEntity> listEn = EnumDataUtils.getEnumSubList(imex.getEnumdata());
							if (listEn != null && listEn.size() > 0) {
								enStr = new String[listEn.size()];
								for (int n = 0; n < listEn.size(); n++) {
									enStr[n] = listEn.get(n).getEnumdataname();
								}
								enumdataMap.put(imex.getEnumdata(), enStr);
							} else {
								throw new ServiceException("枚举" + imex.getEnumdata() + "设置不正确");
							}
						}

					}
					// 设置下拉框
					// poiEx.setHSSFValidation(imexlate.getExportFileName(), enStr, 2, 100000, rowCell[1], rowCell[1]);
				}
			}

//			instructions(poiEx, imexs.size(), imexlate.getExportFileName());
			poiEx.writeAndClose();

		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		File newFile = new File(getWinLinux(path + "/" + imexlate.getExportFileName() + ".xlsx"));
		// logger.info("FilePath : " + newFile.getPath());
		if (!newFile.exists()) {
			return "error";
		} else {
			return "success";
		}
	}

	/**
	 * 
	 * @Title: findSubByParent @author liusheng @date 2016年8月30日 上午11:10:17 @param @param uuid @param @param
	 *         subList @param @return 设定文件 @return List<ImexlateSubEntity> 返回类型 @throws
	 */
	public List<ImexlateSubEntity> findSubByParent(String uuid, List<ImexlateSubEntity> subList) {
		List<ImexlateSubEntity> list = null;
		if (subList != null && subList.size() > 0) {
			list = new ArrayList<ImexlateSubEntity>();
			for (ImexlateSubEntity sub : subList) {
				if (sub.getImplate().getUuid().equals(uuid)) {
					list.add(sub);
				}
			}
		}
		return list;
	}

	/**
	 * 生成模板
	 * 
	 * @param imexs
	 */
	// public String generateTemplate(String coding, String path) {
	public String generateTemplate(ImexlateEntity imexlate, String path) {

		// ImexlateEntity imexlate = dao.findByTemCoding(coding);

		List<ImexlateSubEntity> imexs = subService.findByTemCoding(imexlate.getCoding());
		return generateTemplateForMany(imexlate, path, imexs);// edit by ls2008
	}

	/**
	 * 生成使用说明
	 * 
	 * @param poiEx
	 * @param size
	 * @param sheetName
	 * @throws Exception
	 */
	private void instructions(POIExcelMakerUtil poiEx, int size, String sheetName) throws Exception {
		poiEx.createSheet(ImexlateAuxiliary.DFU.toCodeValue());
		poiEx.MergeCells(0, 0, 0, size - 1, ImexlateAuxiliary.DFU.toCodeValue());
		poiEx.copyCell(0, ImexlateAuxiliary.DFU.toCodeValue(), 0, true);
		poiEx.copyCell(1, ImexlateAuxiliary.DFU.toCodeValue(), 1, true);
		poiEx.createCell(2, 0, ImexlateAuxiliary.DFU.toCodeValue());

		poiEx.MergeCells(3, 3, 0, 2, ImexlateAuxiliary.DFU.toCodeValue());
		poiEx.createCell(3, 0, ImexlateAuxiliary.DFU.toCodeValue());
		poiEx.writeToExcel(ImexlateAuxiliary.DFU.toCodeValue(), 3, 0, ImexlateAuxiliary.DFU.toCodeValue());

		poiEx.MergeCells(4, 4, 0, 7, ImexlateAuxiliary.DFU.toCodeValue());
		poiEx.createCell(4, 0, ImexlateAuxiliary.DFU.toCodeValue());
		poiEx.writeToExcel(ImexlateAuxiliary.DFU.toCodeValue(), 4, 0, ImexlateAuxiliary.DFU_ONE.toCodeValue());

		poiEx.MergeCells(5, 5, 0, 7, ImexlateAuxiliary.DFU.toCodeValue());
		poiEx.createCell(5, 0, ImexlateAuxiliary.DFU.toCodeValue());
		poiEx.writeToExcel(ImexlateAuxiliary.DFU.toCodeValue(), 5, 0, ImexlateAuxiliary.DFU_TWO.toCodeValue());
		poiEx.setColor(ImexlateAuxiliary.DFU.toCodeValue(), 5, 0);

		poiEx.MergeCells(6, 6, 0, 7, ImexlateAuxiliary.DFU.toCodeValue());
		poiEx.createCell(6, 0, ImexlateAuxiliary.DFU.toCodeValue());
		poiEx.writeToExcel(ImexlateAuxiliary.DFU.toCodeValue(), 6, 0, ImexlateAuxiliary.DFU_THREE.toCodeValue());
		poiEx.setColor(ImexlateAuxiliary.DFU.toCodeValue(), 6, 0);

		poiEx.MergeCells(7, 7, 0, 7, ImexlateAuxiliary.DFU.toCodeValue());
		poiEx.createCell(7, 0, ImexlateAuxiliary.DFU.toCodeValue());
		poiEx.writeToExcel(ImexlateAuxiliary.DFU.toCodeValue(), 7, 0, ImexlateAuxiliary.DFU_FOUR.toCodeValue());
	}

	/**
	 * 获取导出导入文件暂放地址
	 * 
	 * @return
	 */
	public String getExcelPath() {
		String path = ParameterUtil.getParamValue("yy_excel");
		if (StringUtils.isBlank(path)) {
			ParameterEntity entity = parameterDAO.findByParamtercode("yy_excel");
			if (entity != null) {
				path = entity.getParamtervalue();
			}
		}
		return path;
	}

	/**
	 * 获取导出导入模板地址
	 * 
	 * @return
	 */
	public String getExcelTempalePath() {
		String path = ParameterUtil.getParamValue("yy_exceltemplate");
		if (StringUtils.isBlank(path)) {
			ParameterEntity entity = parameterDAO.findByParamtercode("yy_exceltemplate");
			if (entity != null) {
				path = entity.getParamtervalue();
			}
		}
		return path;
	}

	/**
	 * 创建目录
	 */
	public void creFile(String path) {
		File file = new File(path);
		// 如果文件夹不存在则创建
		if (!file.exists() && !file.isDirectory()) {
			file.mkdirs();
		}
	}

	/**
	 * 获取项目地址
	 * 
	 * @param request
	 * @return
	 */
	public String getWinLinux(String path) {
		// windows下
		if ("\\".equals(File.separator)) {
			path = path.replace("/", "\\");
			path = path.substring(0, path.length());
		}
		// linux下
		if ("/".equals(File.separator)) {
			path = path.replace("\\", "/");
		}
		return path;
	}

	/**
	 * 将list集合转换成map
	 * 
	 * @param list
	 * @return
	 */
	public List<Map<String, Object>> setMap(List list) {
		String jsonStr = JSON.toJSONString(list);
		return JSONArray.parseObject(jsonStr, new TypeReference<List<Map<String, Object>>>() {
		});
	}

	/**
	 * 导出写文件
	 * 
	 * @param listMap
	 * @param coding
	 * @param path
	 * @param response
	 * @return
	 */
	public String writtenfile(HttpServletRequest request, HttpServletResponse response,
			List<Map<String, Object>> listMap, String coding) throws Exception {

		ImexlateEntity imex = dao.findByTemCoding(coding);

		String excelTemplate = getWinLinux(request.getServletContext().getRealPath("/")) + getExcelTempalePath();
		String excel = getWinLinux(request.getServletContext().getRealPath("/")) + getExcelPath();
		creFile(excel);
		creFile(excelTemplate);
		File file = new File(getWinLinux(excelTemplate + "/" + imex.getExportFileName() + ".xlsx"));
		if (!file.exists()) {
			if ("0".equals(imex.getIscreate())) {
				throw new Exception("找不到导出模板");
			}
			// generateTemplate(coding, getWinLinux(excelTemplate + "/"));
			generateTemplate(imex, getWinLinux(excelTemplate + "/"));
			file = new File(getWinLinux(excelTemplate + "/" + imex.getExportFileName() + ".xlsx"));
		}
		InputStream inps = null;
		String filePath = "";
		try {
			inps = new FileInputStream(file);
			SimpleDateFormat df = new SimpleDateFormat("yyyymmdd");
			String dateStr = df.format(new Date());
			long timeStr = new Date().getTime();
			filePath = saveFileFromInputStream(inps, excel, dateStr + timeStr + ".xlsx");
			df = null;
		} catch (FileNotFoundException e1) {
			e1.printStackTrace();
			throw new Exception(e1.getMessage());
		} catch (IOException e) {
			e.printStackTrace();
			throw new Exception(e.getMessage());
		} finally {
			if (inps != null) {
				try {
					inps.close();
				} catch (IOException e) {
					e.printStackTrace();
					throw new Exception(e.getMessage());
				}
			}
			if (file != null) {
				file = null;
			}
		}

		List<ImexlateSubEntity> imexSub = subService.findByTemCoding(coding);
		try {
			int criticalValue = ParameterUtil.getIntParamValue("CRITICALVALUE", 100000);
			if (listMap != null && listMap.size() > criticalValue && criticalValue > 0) {
				setVlueExBySheet(filePath, listMap, imexSub, imex, 1, criticalValue);
			} else {
				setVlueEx(filePath, listMap, imexSub, imex, 1);
			}
			// 设置下拉
			// SetTheDropdown(filePath,imexSub,imex,listMap.size());
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception(e.getMessage());
		}
		return filePath;
	}

	/**
	 * 设置下拉
	 * 
	 * @param filePath
	 * @param imexSub
	 * @param imex
	 */
	public void SetTheDropdown(String filePath, List<ImexlateSubEntity> imexSub, ImexlateEntity imex, int num) {
		POIExcelMakerUtil poiEx = null;
		Map<String, String[]> enumdataMap = new HashMap<String, String[]>();
		try {
			poiEx = new POIExcelMakerUtil(filePath, imex.getExportFileName());
			for (ImexlateSubEntity imSub : imexSub) {
				int[] rowCell = poiEx.convertToRowNumColumnNum(imSub.getExportCellNum() + 2);
				if ((imSub.getEnumdata() != null && !imSub.getEnumdata().equals(""))
						|| (imSub.getQualifiedValue() != null && !imSub.getQualifiedValue().equals(""))) {
					String[] enStr = null;
					for (String key : enumdataMap.keySet()) {
						if (key.equals(imSub.getEnumdata()) || key.equals(imSub.getQualifiedValue())) {
							enStr = enumdataMap.get(key);
						}
					}
					if (enStr == null) {
						if (imSub.getQualifiedValue() != null && !imSub.getQualifiedValue().equals("")) {
							if (imSub.getQualifiedValue().lastIndexOf(",") != -1) {
								enStr = imSub.getQualifiedValue().split(",");
							} else {
								enStr = new String[1];
								enStr[0] = imSub.getQualifiedValue();
							}
							enumdataMap.put(imSub.getQualifiedValue(), enStr);
						} else if (imSub.getEnumdata() != null && !imSub.getEnumdata().equals("")) {
							List<EnumDataSubEntity> listEn = enumDataSubService.findByGroupcode(imSub.getEnumdata());
							if (listEn.size() > 0) {
								enStr = new String[listEn.size()];
								for (int n = 0; n < listEn.size(); n++) {
									enStr[n] = listEn.get(n).getEnumdataname();
								}
								enumdataMap.put(imSub.getEnumdata(), enStr);
							} else {
								throw new ServiceException("枚举" + imSub.getEnumdata() + "设置不正确");
							}
						}

					}
					// 设置下拉框
					poiEx.setAllFValidation(imex.getExportFileName(), enStr, 2, num, rowCell[1], rowCell[1], filePath);
				}
			}
			// poiEx.writeAndClose();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 写文件
	 */
	public void setVlueEx(String filePath, List<Map<String, Object>> listMap, List<ImexlateSubEntity> imexSub,
			ImexlateEntity imex, int j) throws Exception {
		File newFile = new File(filePath);
		POIExcelMakerUtil poiEx = null;
		poiEx = new POIExcelMakerUtil(newFile, imex.getExportFileName());
		if (listMap != null && listMap.size() > 0) {
			for (Map<String, Object> imMap : listMap) {
				for (String imKey : imMap.keySet()) {
					for (ImexlateSubEntity imSub : imexSub) { // 主表

						if (imKey.equals(ImexlateAuxiliary.CHILD.toCodeValue())) {
							break;
						}
						if (imKey.equals(imSub.getFieldName())) {
							int[] rowCell = poiEx.convertToRowNumColumnNum(imSub.getExportCellNum() + (2 + j));
							poiEx.createCell(rowCell[0], rowCell[1]);

							if (imSub.getEnumdata() != null && !imSub.getEnumdata().equals("")) {
								String label = EnumDataUtils.getEnumValue(String.valueOf(imMap.get(imKey)),
										imSub.getEnumdata());
								poiEx.writeToExcel(rowCell[0], rowCell[1], label);
							} else if ("1".equals(imSub.getDatatype())) {
								poiEx.setUpStyleNum(rowCell[0], rowCell[1], "#,#0");
								poiEx.writeToExcel(rowCell[0], rowCell[1],
										Integer.parseInt(imMap.get(imKey) == null ? "0" : imMap.get(imKey).toString()));

							} else if ("2".equals(imSub.getDatatype())) {
								poiEx.setUpStyleNum(rowCell[0], rowCell[1], null);
								poiEx.writeToExcel(rowCell[0], rowCell[1], Double
										.parseDouble(imMap.get(imKey) == null ? "0" : imMap.get(imKey).toString()));

							} else {
								poiEx.writeToExcel(rowCell[0], rowCell[1], imMap.get(imKey));
							}
							break;
						}
					}
				}
				boolean thereChild = true;
				for (String imKey : imMap.keySet()) {
					// 子表
					if (imKey.equals(ImexlateAuxiliary.CHILD.toCodeValue())) {
						thereChild = false;
						List<Map<String, Object>> subMap = (List<Map<String, Object>>) imMap
								.get(ImexlateAuxiliary.CHILD.toCodeValue());
						if (subMap != null && subMap.size() > 0) {
							for (Map<String, Object> map : subMap) {
								for (String key : map.keySet()) {
									for (ImexlateSubEntity imSub : imexSub) {
										if (imSub.getFieldName().equals(key)) {
											int[] subRowCell = poiEx
													.convertToRowNumColumnNum(imSub.getExportCellNum() + (2 + j));
											poiEx.createCell(subRowCell[0], subRowCell[1]);
											if (imSub.getEnumdata() != null && !imSub.getEnumdata().equals("")) {
												String label = EnumDataUtils.getEnumValue(
														String.valueOf(imMap.get(imKey)), imSub.getEnumdata());
												poiEx.writeToExcel(subRowCell[0], subRowCell[1], label);
											} else {
												poiEx.writeToExcel(subRowCell[0], subRowCell[1], map.get(key));
											}
											break;
										}
									}
								}
								j++;
							}
						} else {
							j++;
						}
					}
				}
				if (thereChild) { // 字表数据不为null也不存在
					j++;
				}
			}
		}
		poiEx.writeAndClose();

	}

	/**
	 * 按sheet写文件
	 * 
	 * @param filePath
	 * @param listMap
	 * @param imexSub
	 * @param imex
	 * @param j
	 * @param num
	 *            每个sheet显示的条数
	 * @throws Exception
	 */
	public void setVlueExBySheet(String filePath, List<Map<String, Object>> listMap, List<ImexlateSubEntity> imexSub,
			ImexlateEntity imex, int j, int num) throws Exception {
		File newFile = new File(filePath);
		POIExcelMakerUtil poiEx = null;
		poiEx = new POIExcelMakerUtil(newFile, imex.getExportFileName());
		String sheetName = new String();
		if (listMap != null && listMap.size() > 0) {
			List<Map<String, Object>> listMapAll = listMap;
			int start = 0, end = 0, count = listMap.size();
			int totalpage = (count % num == 0) ? count / num : (count / num + 1); // 标签页数
			for (int i = 0; i < totalpage; i++) {
				start = i * num;
				end = start + num;
				if (listMapAll.size() < end) {
					end = listMapAll.size();
				}
				sheetName = imex.getExportFileName() + (i + 1);
				poiEx.createSheet(sheetName, i + 1);
				poiEx.copyCell(imex.getExportFileName(), 0, sheetName, 0, true);
				poiEx.copyCell(imex.getExportFileName(), 1, sheetName, 1, true);
				poiEx.MergeCells(0, 0, 0, imexSub.size() - 1, sheetName);
				poiEx.setUpStyle(sheetName, 0, 0, true, 20, true, true, false, false, true);

				listMap = listMapAll.subList(start, end);
				for (Map<String, Object> imMap : listMap) {
					for (String imKey : imMap.keySet()) {
						for (ImexlateSubEntity imSub : imexSub) { // 主表
							if (imKey.equals(ImexlateAuxiliary.CHILD.toCodeValue())) {
								break;
							}
							if (imKey.equals(imSub.getFieldName())) {
								int[] rowCell = poiEx.convertToRowNumColumnNum(imSub.getExportCellNum() + (2 + j));
								poiEx.createCell(j + 1 - start, rowCell[1]);
								if (imSub.getEnumdata() != null && !imSub.getEnumdata().equals("")) {
									String label = EnumDataUtils.getEnumValue(String.valueOf(imMap.get(imKey)),
											imSub.getEnumdata());
									poiEx.writeToExcel(sheetName, j + 1 - start, rowCell[1], label);
								} else {
									poiEx.writeToExcel(sheetName, j + 1 - start, rowCell[1], imMap.get(imKey));
								}
								break;
							}
						}
					}
					boolean thereChild = true;
					for (String imKey : imMap.keySet()) {
						// 子表
						if (imKey.equals(ImexlateAuxiliary.CHILD.toCodeValue())) {
							thereChild = false;
							List<Map<String, Object>> subMap = (List<Map<String, Object>>) imMap
									.get(ImexlateAuxiliary.CHILD.toCodeValue());
							if (subMap != null && subMap.size() > 0) {
								for (Map<String, Object> map : subMap) {
									for (String key : map.keySet()) {
										for (ImexlateSubEntity imSub : imexSub) {
											if (imSub.getFieldName().equals(key)) {
												int[] subRowCell = poiEx
														.convertToRowNumColumnNum(imSub.getExportCellNum() + (2 + j));
												poiEx.createCell(j + 1 - start, subRowCell[1]);
												if (imSub.getEnumdata() != null && !imSub.getEnumdata().equals("")) {
													String label = EnumDataUtils.getEnumValue(
															String.valueOf(imMap.get(imKey)), imSub.getEnumdata());
													poiEx.writeToExcel(sheetName, j + 1 - start, subRowCell[1], label);
												} else {
													poiEx.writeToExcel(sheetName, j + 1 - start, subRowCell[1],
															map.get(key));
												}
												break;
											}
										}
									}
									j++;
								}
							} else {
								j++;
							}
						}
					}
					if (thereChild) { // 字表数据不为null也不存在
						j++;
					}
				}
			}
			poiEx.removeSheet(imex.getExportFileName());// 移除第一个sheet
		}
		poiEx.writeAndClose();

	}

	/**
	 * 写标题
	 **/
	public void cetTitle(POIExcelMakerUtil poiEx, List<ImexlateSubEntity> imexs) {
		try {
			for (ImexlateSubEntity imex : imexs) {
				int[] rowCell = poiEx.convertToRowNumColumnNum(imex.getExportCellNum() + 2);
				poiEx.createCell(rowCell[0], rowCell[1]);
				poiEx.writeToExcel(rowCell[0], rowCell[1], imex.getChineseField());
				poiEx.setUpStyle(rowCell[0], rowCell[1], false, 20, true, true, imex.getIsnotempty(), true,
						imex.getIsMainField());
				poiEx.setSizeColumn(rowCell[1], length(imex.getChineseField()));
			}
		} catch (Exception e) {
			e.printStackTrace();

		}
	}

	/**
	 * 文件导入 读取文件数据
	 * 
	 * @param FilePath
	 * @param coding
	 * @return
	 */

	public List<Map<String, Object>> importData(String FilePath, String coding) {
		List<ImexlateSubEntity> imexSub = subService.findByTemCoding(coding);
		ImexlateEntity imex = dao.findByTemCoding(coding);
		List<Map<String, Object>> list = null;
		try {
			list = importExcelFile(imex, FilePath, imexSub);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	/**
	 * 目录创建
	 * 
	 * @param path
	 * @return
	 * @throws InterruptedException
	 */
	public boolean isexitsPath(String path) throws InterruptedException {
		String[] paths = path.split("/");
		StringBuffer fullPath = new StringBuffer();
		for (int i = 0; i < paths.length; i++) {
			fullPath.append(paths[i]).append("/");
			File file = new File(fullPath.toString());
			if (!file.exists()) {
				file.mkdir();
				Thread.sleep(1500);
			}
		}
		File file = new File(fullPath.toString());// 目录全路径
		if (!file.exists()) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * 文件上传
	 * 
	 * @param file
	 * @return
	 */

	public String copyFile(HttpServletRequest request, MultipartFile file) {
		Calendar calendar = Calendar.getInstance();
		SimpleDateFormat df = new SimpleDateFormat("yyyymmdd");
		calendar.setTime(new Date());
		String time = calendar.getTimeInMillis() + "";
		String filePath = "";
		String suffix = file.getOriginalFilename();
		suffix = suffix.substring(suffix.lastIndexOf("."), suffix.length());
		try {
			String excel = getWinLinux(request.getServletContext().getRealPath("/")) + getExcelPath();
			creFile(excel);
			filePath = saveFileFromInputStream(file.getInputStream(), excel,
					df.format(calendar.getTime()) + time + suffix);
		} catch (IOException e) {
			return null;
		}
		File newFile = new File(filePath);
		if (!newFile.exists()) {
			return null;
		} else {
			return filePath;
		}
	}

	/**
	 * excel文件导入
	 * 
	 * @param ExportFileName
	 *            导出文件名，页签名
	 * @param fileStr
	 *            待导入文件地址
	 * @param imexSub
	 *            对应模板子表
	 * @return List<Map<String, Object>>
	 * @throws Exception
	 */
	public List<Map<String, Object>> importExcelFile(ImexlateEntity imex, String fileStr,
			List<ImexlateSubEntity> imexSub) throws Exception {
		Map<String, List<EnumDataSubEntity>> enumdataMap = new HashMap<String, List<EnumDataSubEntity>>();
		String ExportFileName = imex.getExportFileName();
		POIReadExcelUtil poiRead = new POIReadExcelUtil(new File(fileStr));
		poiRead.removeSheet(ImexlateAuxiliary.DFU.toCodeValue());
		List<Map<String, Object>> mainList = new ArrayList<Map<String, Object>>();
		Sheet sheet = poiRead.getSheet(ExportFileName);
		if (sheet == null) {
			throw new ServiceException("没找到名为" + ExportFileName + "的工作表");
			// return null;
		}
		int cellNum = 0;
		String imexchnotemptyMain = null;
		String imexchnotemptyChild = null;
		for (ImexlateSubEntity imub : imexSub) {
			if (imub.getIsMainField()) {
				cellNum++;
			}
			if (imub.getIsnotempty() && imexchnotemptyMain == null) {
				imexchnotemptyMain = imub.getExportCellNum();
			}
		}
		if (imexSub.size() > cellNum) { // 有子表
			for (ImexlateSubEntity imub : imexSub) {
				if (imub.getIsnotempty() && !imub.getIsMainField() && imexchnotemptyChild == null) {
					imexchnotemptyChild = imub.getExportCellNum();
				}
			}
		}
		int imexch = 0; // 根据那列数据结束读取excel 如果有子表 按子表不为空字段 无则按主表字段
		if (StringUtils.isNotEmpty(imexchnotemptyChild)) {
			imexch = excelColStrToNum(imexchnotemptyChild, imexchnotemptyChild.length());
		}
		if (StringUtils.isEmpty(imexchnotemptyChild)) {
			imexch = excelColStrToNum(imexchnotemptyMain, imexchnotemptyMain.length());
		}
		int imexchMain = excelColStrToNum(imexchnotemptyMain, imexchnotemptyMain.length());
		Map<String, Object> mainMap = null; // 一张单据
		List<Map<String, Object>> childlist = null; // 单据子表列表
		for (int i = 2; i < sheet.getLastRowNum() + 2; i++) { // 循环 行
			int lineNumber = 1;
			// 这里的代码还不知道什么作用-by zhangcb 这里判断读取excel是否结束
			if (!poiRead.getValue(sheet, i, imexch - 1)) {
				if (!poiRead.getValue(sheet, i + 1, imexch - 1)) {
					if (mainMap != null) {
						mainMap.put(ImexlateAuxiliary.CHILD.toCodeValue(), childlist);
						mainList.add(mainMap);
					}
					break;
				}
			}
			boolean isNew = false;
			boolean isChild = false;
			if (poiRead.getValue(sheet, i, imexchMain - 1)) { // 主表不为空字段 不为空开始一张单据
				if (i != 2) {
					if (mainMap != null) {
						mainMap.put(ImexlateAuxiliary.CHILD.toCodeValue(), childlist);
						mainList.add(mainMap);
					}
					isChild = false;
				}
				mainMap = new HashMap<String, Object>();// 开始一张单据
				childlist = new ArrayList<Map<String, Object>>(); // 开始单据的子表List
				isChild = false;
				isNew = true;
			}
			Map<String, Object> childMap = null; // 一张子表
			for (int j = 0; j < imexSub.size(); j++) { // 循环列
				if (sheet.getRow(i) == null) {
					break;
				}
				Cell cell = sheet.getRow(i).getCell(j);
				Object cellVal = "";
				if (cell != null) {
					cellVal = poiRead.getCellValue(cell);
				}
				ImexlateSubEntity imexFeEn = getFieldNamebyChineseField(imexSub, poiRead.getExcelColumnLabel(j));

				if (j < cellNum) {
					if (isNew) {
						if (lineNumber == 1) {
							if (mainMap != null) {
								mainMap.put(ImexlateAuxiliary.LINENUM.toCodeValue(), i + 1); // 添加行号
								lineNumber++;
							}
						}
						if (poiRead.getValue(sheet, i, j)) {
							if (!StringUtils.isEmpty(imexFeEn.getEnumdata())) {
								List<EnumDataSubEntity> listEn = null;
								for (String key : enumdataMap.keySet()) {
									if (key.equals(imexFeEn.getEnumdata())) {
										listEn = enumdataMap.get(key);
									}
								}
								if (listEn == null) {
									listEn = enumDataSubService.findByGroupcode(imexFeEn.getEnumdata());
									enumdataMap.put(imexFeEn.getEnumdata(), listEn);
								}
								for (EnumDataSubEntity en : listEn) {
									if (cellVal.equals(en.getEnumdataname())) {
										mainMap.put(imexFeEn.getFieldName(), en.getEnumdatakey());
									}
								}
							} else {
								mainMap.put(imexFeEn.getFieldName(), cellVal);
							}
						} else {
							mainMap.put(imexFeEn.getFieldName(), null);
						}
					}
				}
				if (j == cellNum) {
					childMap = new HashMap<String, Object>();
					isChild = true;
				}
				if (j >= cellNum) {
					childMap.put(ImexlateAuxiliary.LINENUM.toCodeValue(), i + 1); // 添加行号
					if (poiRead.getValue(sheet, i, j)) {
						if (!StringUtils.isEmpty(imexFeEn.getEnumdata())) {
							List<EnumDataSubEntity> listEn = null;
							for (String key : enumdataMap.keySet()) {
								if (key.equals(imexFeEn.getEnumdata())) {
									listEn = enumdataMap.get(key);
								}
							}
							if (listEn == null) {
								listEn = enumDataSubService.findByGroupcode(imexFeEn.getEnumdata());
								enumdataMap.put(imexFeEn.getEnumdata(), listEn);
							}
							for (EnumDataSubEntity en : listEn) {
								if (cellVal.equals(en.getEnumdataname())) {
									childMap.put(imexFeEn.getFieldName(), en.getEnumdatakey());
								}
							}
						} else {
							childMap.put(imexFeEn.getFieldName(), cellVal);
						}
					} else {
						childMap.put(imexFeEn.getFieldName(), null);
					}
				}
				if (j == imexSub.size() - 1) { // 读取到 excel 模板最后一列
					if (isChild) {
						childlist.add(childMap);
					}
				}
			}
			if (i == sheet.getLastRowNum() + 1) {
				if (mainMap != null) {
					mainMap.put(ImexlateAuxiliary.CHILD.toCodeValue(), childlist);
					mainList.add(mainMap);
				}
			}
		}
		return mainList;
	}

	/**
	 * 
	 * @param colStr
	 * @param length
	 * @return
	 */
	public int excelColStrToNum(String colStr, int length) {
		int num = 0;
		int result = 0;
		for (int i = 0; i < length; i++) {
			char ch = colStr.charAt(length - i - 1);
			num = (int) (ch - 'A' + 1);
			num *= Math.pow(26, i);
			result += num;
		}
		return result;
	}

	/**
	 * excel 数字转字母
	 * 
	 * @param index
	 * @return String
	 */
	public String getLetter(int index) {
		String rs = "";
		index++;
		do {
			index--;
			rs = ((char) (index % 26 + (int) 'A')) + rs;
			index = (int) ((index - index % 26) / 26);
		} while (index > 0);
		return rs;
	}

	/**
	 * 根据导出列号 找对应字段
	 * 
	 * @param imexSub
	 * @param exportCellNum
	 * @return
	 */
	public ImexlateSubEntity getFieldNamebyChineseField(List<ImexlateSubEntity> imexSub, String exportCellNum) {
		if (imexSub != null && imexSub.size() > 0) {
			for (ImexlateSubEntity imex : imexSub) {
				if (exportCellNum.equals(imex.getExportCellNum())) {
					return imex;
				}
			}
		} else {
			return null;
		}
		return null;
	}

	/**
	 * 复制文件
	 * 
	 * @param stream
	 * @param path
	 * @param filename
	 * @throws IOException
	 */
	public String saveFileFromInputStream(InputStream stream, String path, String filename) throws IOException {
		FileOutputStream fs = new FileOutputStream(getWinLinux(path + "/" + filename));
		byte[] buffer = new byte[1024 * 1024];
		int bytesum = 0;
		int byteread = 0;
		while ((byteread = stream.read(buffer)) != -1) {
			bytesum += byteread;
			fs.write(buffer, 0, byteread);
			fs.flush();
		}
		fs.close();
		stream.close();
		return getWinLinux(path + "/" + filename);
	}

	/**
	 * 
	 * @param entity
	 * @param subList
	 * @param deletePKs
	 * @return
	 */
	public ImexlateEntity saveSelfAndSubList(ImexlateEntity entity, List<ImexlateSubEntity> subList,
			String[] deletePKs) {
		// 删除子表一数据
		if (deletePKs != null && deletePKs.length > 0)
			subService.delete(deletePKs);
		// subService.deleteByUuids(deletePKs);
		// 保存自身数据
		ImexlateEntity savedEntity = this.save(entity);

		// 保存子表数据
		for (ImexlateSubEntity sub : subList) {
			sub.setImplate(savedEntity);
		}
		// 判断子表编码是否重复再保存
		// String result = checkSubList(subList,savedEntity);
		String result = "true";
		if ("true".equals(result)) {
			subService.save(subList);
		} else {
			throw new ServiceException(result);
		}
		ImexlateUtil.updateImexlate(findAll());//更新缓存
		// 刷新缓存
		// refreshEnumCache(entity.getGroupCode());
		return savedEntity;
	}

	/**
	 * 得到一个字符串的长度,显示的长度,一个汉字或日韩文长度为2,英文字符长度为1
	 * 
	 * @param String
	 *            s 需要得到长度的字符串
	 * @return int 得到的字符串长度
	 */
	public int length(String s) {
		if (s == null)
			return 0;
		char[] c = s.toCharArray();
		int len = 0;
		for (int i = 0; i < c.length; i++) {
			len++;
			if (!isLetter(c[i])) {
				len++;
			}
		}
		return len;
	}

	public boolean isLetter(char c) {
		int k = 0x80;
		return c / k == 0 ? true : false;
	}
}
