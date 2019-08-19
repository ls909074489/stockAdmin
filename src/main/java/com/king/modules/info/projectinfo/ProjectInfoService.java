package com.king.modules.info.projectinfo;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Arrays;
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
import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.socket.TextMessage;

import com.king.common.dao.DbUtilsDAO;
import com.king.common.enums.BillStatus;
import com.king.common.exception.DAOException;
import com.king.common.utils.ExcelDataUtil;
import com.king.frame.controller.ActionResultModel;
import com.king.frame.dao.IBaseDAO;
import com.king.frame.security.ShiroUser;
import com.king.frame.service.SuperServiceImpl;
import com.king.frame.websocket.YyWebSocketHandler;
import com.king.modules.info.apply.ProjectApplyEntity;
import com.king.modules.info.apply.ProjectApplyService;
import com.king.modules.info.approve.ApproveUserEntity;
import com.king.modules.info.approve.ApproveUserService;
import com.king.modules.info.material.MaterialBaseEntity;
import com.king.modules.info.material.MaterialEntity;
import com.king.modules.info.material.MaterialService;
import com.king.modules.info.stockstream.StockStreamEntity;
import com.king.modules.info.stockstream.StockStreamService;
import com.king.modules.sys.imexlate.ImexlateSubEntity;
import com.king.modules.sys.imexlate.ImexlateSubService;
import com.king.modules.sys.param.ParameterUtil;
import com.king.modules.sys.user.UserEntity;

/**
 * 项目
 * @author null
 * @date 2019-06-19 21:25:24
 */
@Service
@Transactional(readOnly=true)
public class ProjectInfoService extends SuperServiceImpl<ProjectInfoEntity,String> {

	@Autowired
	private ProjectInfoDao dao;
	@Lazy
	@Autowired
	private ProjectSubService projectSubService;
	@Autowired
	private DbUtilsDAO dbDao;
	@Autowired
	private YyWebSocketHandler webSocketHandler;
	@Autowired
	private ProjectApplyService projectApplyService;
	@Autowired
	private ApproveUserService approveUserService;
	@Autowired
	private StockStreamService streamService;
	@Autowired
	private ImexlateSubService imexlateSubService;
	@Autowired
	private MaterialService materialService;
	
	
	protected IBaseDAO<ProjectInfoEntity, String> getDAO() {
		return dao;
	}
	
	@Override	
	public void beforeSave(ProjectInfoEntity entity) throws ServiceException {
		entity.setBillcode(entity.getCode());
		super.beforeSave(entity);
	}
	
	
	
	@Override
	public void doDelete(String pk) throws ServiceException {
		List<ProjectSubEntity> subList = projectSubService.findByMain(pk);
		if (CollectionUtils.isNotEmpty(subList)) {
//			projectSubService.delete(subList);
			List<String> subIdList = new ArrayList<>();
			for(ProjectSubEntity sub:subList){
				subIdList.add(sub.getUuid());
				sub.setStatus(0);
			}
			List<StockStreamEntity> streamList = streamService.findByProjectSubIds(subIdList);
			if(CollectionUtils.isNotEmpty(streamList)){
				for(StockStreamEntity stream:streamList){
					if(stream.getSurplusAmount()<stream.getTotalAmount()){
						throw new ServiceException("物料编码："+stream.getMaterial().getCode()+
								",华为编码："+stream.getMaterial().getHwcode()+" 已使用(剩余数量小于总数量)，不能删除");
					}
				}
				streamService.delete(streamList);
			}
		}
		try {
			ProjectInfoEntity entity = this.getOne(pk);
			beforeDelete(entity);
			entity.setStatus(0);
			entity.setCode("Del_");
			save(entity);
			afterDelete(entity);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServiceException(e.getMessage());
		}
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
//		try {
			if(entity.getBillstatus()==BillStatus.APPROVAL.toStatusValue()){
				arm.setSuccess(false);
				arm.setMsg("审核通过不能进行操作");
				return arm;
			}
//			if(entity.getReceiveType()==ProjectInfoEntity.receiveType_yes){
//				arm.setSuccess(false);
//				arm.setMsg("已收货不能进行操作");
//				return arm;
//			}
			// 删除子表一数据
			if (deletePKs != null && deletePKs.length > 0) {
				projectSubService.delete(deletePKs);
				List<StockStreamEntity> streamList = streamService.findByProjectSubIds(Arrays.asList(deletePKs));
				if(CollectionUtils.isNotEmpty(streamList)){
					for(StockStreamEntity stream:streamList){
						if(stream.getSurplusAmount()<stream.getTotalAmount()){
							throw new ServiceException("物料编码："+stream.getMaterial().getCode()+
									",华为编码："+stream.getMaterial().getHwcode()+" 已使用(剩余数量小于总数量)，不能删除");
						}
					}
					streamService.delete(streamList);
				}
			}
			ProjectInfoEntity savedEntity = null;
			if(!StringUtils.isEmpty(entity.getUuid())){
				streamService.updateSourceBillCode(entity.getCode(),entity.getUuid());
			}
			// 保存自身数据
			savedEntity = save(entity);

			UserEntity user = ShiroUser.getCurrentUserEntity();	
			
			List<ProjectSubEntity> addList = new ArrayList<>();
			List<ProjectSubEntity> updateList = new ArrayList<>();
			// 保存子表数据
			if (subList != null && subList.size() > 0) {
				Map<String,String> codeMap = new HashMap<>();
				for (ProjectSubEntity sub : subList) {
					if (StringUtils.isEmpty(sub.getUuid())) {
						sub.setCreator(user.getUuid());
						sub.setCreatorname(user.getUsername());
						sub.setCreatetime(new Date());
//						sub.setLimitCount(sub.getMaterial().getLimitCount());
						sub.setActualAmount(sub.getPlanAmount());
						addList.add(sub);
					}else{
						updateList.add(sub);
					}
					sub.setMain(savedEntity);
					sub.setMid(savedEntity.getUuid());
					sub.setModifier(user.getUuid());
					sub.setModifiername(user.getUsername());
					sub.setModifytime(new Date());
					
					
					if(codeMap.containsKey(sub.getBoxNum()+"_"+sub.getMaterial().getUuid())){
						MaterialEntity material = materialService.getOne(sub.getMaterial().getUuid());
						throw new ServiceException("第"+sub.getBoxNum()+"箱华为料号"+material.getHwcode()+"不能重复");
					}
					codeMap.put(sub.getBoxNum()+"_"+sub.getMaterial().getUuid(), "第"+sub.getBoxNum()+"箱料号"+sub.getMaterial().getUuid());
					
					//设置条形码
					setBarcodeJson(sub);
				}
//				save(subList);
				if(CollectionUtils.isNotEmpty(addList)){
					projectSubService.doAdd(addList);
				}
				if(CollectionUtils.isNotEmpty(updateList)){
					ProjectSubEntity subEntity = null;
					for(ProjectSubEntity sub :updateList){
						subEntity = projectSubService.getOne(sub.getUuid());
						subEntity.setBoxNum(sub.getBoxNum());
						subEntity.setMaterial(sub.getMaterial());
						subEntity.setLimitCount(sub.getLimitCount());
						subEntity.setPlanAmount(sub.getPlanAmount());
						if(entity.getReceiveType().equals(ProjectInfoEntity.receiveType_no)){
							subEntity.setActualAmount(subEntity.getPlanAmount());
						}
						subEntity.setMemo(sub.getMemo());
						subEntity.setWarningTime(sub.getWarningTime());
					}
				}
			}
//			arm.setRecords(savedEntity);
			arm.setSuccess(true);
//		} catch (Exception e) {
//			arm.setSuccess(false);
//			arm.setMsg(e.getMessage());
//			e.printStackTrace();
//		}
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
			String materialPurchaseType = "";
			List<ProjectSubEntity> list = new ArrayList<>();
			Set<String> materialCodeSet = new HashSet<>();
			List<String> codeList = new ArrayList<>();
			List<String> hwcodeList = new ArrayList<>();
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
								
								boxNumStr = ExcelDataUtil.getValue(hssfRow.getCell(imexMap.get("boxNum")));
								if (StringUtils.isEmpty(boxNumStr)) {
									throw new ServiceException("第" + (rowNum + 1) + "箱号不能为空");
								} else {
									entity.setBoxNum(boxNumStr);
								}
								
								materialPurchaseType = ExcelDataUtil.getValue(hssfRow.getCell(imexMap.get("materialPurchaseType")));
								if (StringUtils.isEmpty(materialPurchaseType)) {
									throw new ServiceException("第" + (rowNum + 1) + "行采购模式不能为空");
								} else {
									if((materialPurchaseType.equals(MaterialEntity.PURCHASETYPE_CS)||materialPurchaseType.equals("C/S"))){
										entity.setMaterialPurchaseType(MaterialEntity.PURCHASETYPE_CS);
									}else if(materialPurchaseType.equals("TK")){
										entity.setMaterialPurchaseType(MaterialEntity.PURCHASETYPE_TK);
									}else{
										throw new ServiceException("第"+(rowNum+1)+"行采购模式必须为TK或CS");
									}
								}
								
								code = ExcelDataUtil.getValue(hssfRow.getCell(imexMap.get("materialCode")));
								if (StringUtils.isEmpty(code)) {
									throw new ServiceException("第" + (rowNum + 1) + "行物料不能为空");
								}
								code = code.trim();
								distinctCode = "第" + boxNumStr + "箱料号" + code;
								if (materialCodeSet.contains(distinctCode)) {
									repeatCode.add(distinctCode);
								}
								if(entity.getMaterialPurchaseType().equals(MaterialEntity.PURCHASETYPE_CS)){
									entity.setMaterialHwCode(code);//华为物料编码
									hwcodeList.add(code);
								}else{
									entity.setMaterialCode(code);//物料编码
									codeList.add(code);
								}
								
								entity.setMaterialDesc(ExcelDataUtil.getValue(hssfRow.getCell(imexMap.get("materialDesc"))));
								
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
								
								entity.setMaterialUnit(ExcelDataUtil.getValue(hssfRow.getCell(imexMap.get("materialUnit"))));
								entity.setMemo(ExcelDataUtil.getValue(hssfRow.getCell(imexMap.get("memo"))));
								
								materialCodeSet.add(distinctCode);
								if(entity.getMaterialPurchaseType().equals("TK")){
									if(ParameterUtil.getParamValue("isImpInTK").equals("1")){
										list.add(entity);
									}
								}else{
									list.add(entity);
								}
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
								boxNumStr = ExcelDataUtil.getValue(xssfRow.getCell(imexMap.get("boxNum")));
								if (StringUtils.isEmpty(boxNumStr)) {
									throw new ServiceException("第" + (rowNum + 1) + "箱号不能为空");
								} else {
									entity.setBoxNum(boxNumStr);
								}
								
								materialPurchaseType = ExcelDataUtil.getValue(xssfRow.getCell(imexMap.get("materialPurchaseType")));
								if (StringUtils.isEmpty(materialPurchaseType)) {
									throw new ServiceException("第" + (rowNum + 1) + "行采购模式不能为空");
								} else {
									if((materialPurchaseType.equals("CS")||materialPurchaseType.equals("C/S"))){
										entity.setMaterialPurchaseType(MaterialEntity.PURCHASETYPE_CS);
									}else if(materialPurchaseType.equals("TK")){
										entity.setMaterialPurchaseType(MaterialEntity.PURCHASETYPE_TK);
									}else{
										throw new ServiceException("第"+(rowNum+1)+"行采购模式必须为TK或CS");
									}
								}
								
								code = ExcelDataUtil.getValue(xssfRow.getCell(imexMap.get("materialCode")));
								if (StringUtils.isEmpty(code)) {
									throw new ServiceException("第" + (rowNum + 1) + "行物料不能为空");
								}
								code = code.trim();
								distinctCode = "第" + boxNumStr + "箱料号" + code;
								if (materialCodeSet.contains(distinctCode)) {
									repeatCode.add(distinctCode);
								}
								if(entity.getMaterialPurchaseType().equals(MaterialEntity.PURCHASETYPE_CS)){
									entity.setMaterialHwCode(code);//华为物料编码
									hwcodeList.add(code);
								}else{
									entity.setMaterialCode(code);//物料编码
									codeList.add(code);
								}
								entity.setMaterialDesc(ExcelDataUtil.getValue(xssfRow.getCell(imexMap.get("materialDesc"))));
								
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
								
								entity.setMaterialUnit(ExcelDataUtil.getValue(xssfRow.getCell(imexMap.get("materialUnit"))));
								entity.setMemo(ExcelDataUtil.getValue(xssfRow.getCell(imexMap.get("memo"))));
								
								materialCodeSet.add(distinctCode);
								
								if(entity.getMaterialPurchaseType().equals("TK")){
									if(ParameterUtil.getParamValue("isImpInTK").equals("1")){
										list.add(entity);
									}
								}else{
									list.add(entity);
								}
							}
						}
					}
				}
			}
			if (repeatCode.size() > 0) {
				arm.setSuccess(false);
				arm.setMsg(org.apache.commons.lang.StringUtils.join(repeatCode,",") + "存在相同的物料编码");
			} else {
				List<MaterialEntity> materialList = materialService.findByCodes(codeList);
				List<MaterialEntity> hwmaterialList = materialService.findByHwCodes(hwcodeList);
				materialList.addAll(hwmaterialList);
				boolean hasMaterial = false;// 是否存在料号
				MaterialBaseEntity materialBase = null;
				Map<String,MaterialEntity> materialMap = new HashMap<>();
				Map<String,MaterialEntity> hwmaterialMap = new HashMap<>();
				for (ProjectSubEntity projectSub : list) {
					hasMaterial = false;
					for (MaterialEntity material : materialList) {
						if (projectSub.getMaterialPurchaseType().equals(MaterialEntity.PURCHASETYPE_CS)&&
								projectSub.getMaterialHwCode().equals(material.getHwcode())) {
							hasMaterial = true;
							materialBase = new MaterialBaseEntity();
							materialBase.setUuid(material.getUuid());
							projectSub.setMaterial(materialBase);
							break;
						}
						if (projectSub.getMaterialPurchaseType().equals(MaterialEntity.PURCHASETYPE_TK)&&
								projectSub.getMaterialCode().equals(material.getCode())) {
							hasMaterial = true;
							materialBase = new MaterialBaseEntity();
							materialBase.setUuid(material.getUuid());
							projectSub.setMaterial(materialBase);
							break;
						}
					}
					if (!hasMaterial) {//物料不存在 先添加
						MaterialEntity material = new MaterialEntity();
						material.setPurchaseType(projectSub.getMaterialPurchaseType());
						material.setName(projectSub.getMaterialDesc());
						material.setClassDesc(projectSub.getMaterialDesc());
						material.setMemo(projectSub.getMaterialDesc());
						material.setUnit(projectSub.getMaterialUnit());
						material.setLimitCount(-1);
						if (projectSub.getMaterialPurchaseType().equals(MaterialEntity.PURCHASETYPE_CS)){
							material.setHwcode(projectSub.getMaterialHwCode());
							if(hwmaterialMap.get(material.getHwcode())!=null){
								material = hwmaterialMap.get(material.getHwcode());
							}else{
								materialService.doAdd(material);
								hwmaterialMap.put(material.getHwcode(), material);
							}
						}else{
							material.setCode(projectSub.getMaterialCode());
							if(materialMap.get(material.getCode())!=null){
								material = materialMap.get(material.getCode());
							}else{
								materialService.doAdd(material);
								materialMap.put(material.getCode(), material);
							}
						}
						materialBase = new MaterialBaseEntity();
						materialBase.setUuid(material.getUuid());
						projectSub.setMaterial(materialBase);
					}
				}
//				mainService.saveSelfAndSubList(projectInfo, list, null);
				// 保存自身数据
				ProjectInfoEntity savedEntity = save(projectInfo);

				UserEntity user = ShiroUser.getCurrentUserEntity();	
				
				List<ProjectSubEntity> addList = new ArrayList<>();
				// 保存子表数据
				if (list != null && list.size() > 0) {
					Map<String,String> codeMap = new HashMap<>();
					for (ProjectSubEntity sub : list) {
						sub.setCreator(user.getUuid());
						sub.setCreatorname(user.getUsername());
						sub.setCreatetime(new Date());
						sub.setLimitCount(sub.getMaterial().getLimitCount());
						sub.setActualAmount(sub.getPlanAmount());
						addList.add(sub);
						sub.setMain(savedEntity);
						sub.setMid(savedEntity.getUuid());
						sub.setModifier(user.getUuid());
						sub.setModifiername(user.getUsername());
						sub.setModifytime(new Date());
						
						
						if (sub.getMaterialPurchaseType().equals(MaterialEntity.PURCHASETYPE_CS)) {
							if(codeMap.containsKey(sub.getBoxNum()+"_"+sub.getMaterialHwCode())){
								throw new ServiceException("第"+sub.getBoxNum()+"箱华为CS料号"+sub.getMaterialHwCode()+"不能重复");
							}
							codeMap.put(sub.getBoxNum()+"_"+sub.getMaterialHwCode(), "第"+sub.getBoxNum()+"箱料号"+sub.getMaterialHwCode());
						}else{
							if(codeMap.containsKey(sub.getBoxNum()+"_"+sub.getMaterialCode())){
								throw new ServiceException("第"+sub.getBoxNum()+"箱TK料号"+sub.getMaterialCode()+"不能重复");
							}
							codeMap.put(sub.getBoxNum()+"_"+sub.getMaterialCode(), "第"+sub.getBoxNum()+"箱料号"+sub.getMaterialCode());
						}
						
						//设置条形码
						setBarcodeJson(sub);
					}
					projectSubService.doAdd(addList);
				}
				
				
				arm.setSuccess(true);
				arm.setMsg("导入成功.");
			}
		}catch (ServiceException e) {
			e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
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
	
	
	private ProjectSubEntity setBarcodeJson(ProjectSubEntity sub){
//		List<ProjectBarcodeVo> barcodeList = new ArrayList<>();
//		if (StringUtils.isEmpty(sub.getUuid())) {
//			if(sub.getLimitCount()==MaterialBaseEntity.limitCount_unique&&sub.getPlanAmount()>1){//唯一
//				for(int i=0;i<sub.getPlanAmount();i++){
//					barcodeList.add(new ProjectBarcodeVo(UUIDString.getUUIDString(), "",0));
//				}
//				sub.setBarcodejson(JSON.toJSONString(barcodeList));
//			}else{
//				barcodeList.add(new ProjectBarcodeVo(UUIDString.getUUIDString(), "",0));
//				sub.setBarcodejson(JSON.toJSONString(barcodeList));
//			}
//		}else{
//			if(sub.getLimitCount()==MaterialBaseEntity.limitCount_unique&&sub.getPlanAmount()>1){//唯一
//				String barcodeJson = sub.getBarcodejson();
//				if(StringUtils.isEmpty(barcodeJson)){
//					String []bArr = new String[6];
//					for(int i=0;i<6;i++){
//						bArr[i]="";
//					}
//					sub.setBarcodejson(JSON.toJSONString(bArr));
//				}else{
//					List<String> blist = JSON.parseArray(barcodeJson, String.class);
//					if(sub.getPlanAmount()>blist.size()){//增加了数量
//						for(int i=0;i<(sub.getPlanAmount()-blist.size());i++){
//							blist.add("");
//						}
//					}else if(blist.size()>sub.getPlanAmount()){//减少了数量
//						blist = blist.subList(0, sub.getPlanAmount().intValue());
//					}
//					sub.setBarcodejson(JSON.toJSONString(blist));
//				}
//			}else{
//				sub.setBarcodejson("[]");
//			}
//		}
		return sub;
	}

	@Override
	public void beforeSubmit(ProjectInfoEntity entity) throws ServiceException {
//		List<ProjectSubEntity> subList = projectSubService.findByMain(entity.getUuid());
//		StockBaseEntity stock = entity.getStock();
//		for(ProjectSubEntity sub:subList){
//			StockDetailEntity detail  = stockDetailService.findByStockAndMaterial(stock.getUuid(),sub.getMaterial().getUuid());
//			if(detail==null){
//				throw new ServiceException("仓库"+stock.getName()+"不存在物料"+sub.getMaterial().getCode());
//			}else{
//				if(detail.getSurplusAmount()<sub.getPlanAmount()){
//					throw new ServiceException("仓库"+stock.getName()+"物料"+sub.getMaterial().getCode()+"库存不足");
//				}
//			}
//		}
		super.beforeSubmit(entity);
	}

	@Override
	public void afterSubmit(ProjectInfoEntity entity) throws ServiceException {
		ProjectApplyEntity apply = new ProjectApplyEntity();
		apply.setApplyType(ProjectApplyEntity.APPLYING);
		apply.setContent("提交项目单"+entity.getCode());
		apply.setSourceBillId(entity.getUuid());
		apply.setSourceBillCode(entity.getCode());
		projectApplyService.doAdd(apply);
		
		
		List<ApproveUserEntity> userList = approveUserService.findByAppplyType(ApproveUserEntity.PROJECTINFO_TYPE);
		if(CollectionUtils.isNotEmpty(userList)){
			for(ApproveUserEntity u:userList){
				webSocketHandler.sendMessageToUser(u.getUser().getUuid(), new TextMessage(apply.getCreatorname()+" "+apply.getContent()+",请及时处理。"));
			}
		}
		super.afterSubmit(entity);
	}


	@Override
	public void beforeApprove(ProjectInfoEntity entity) throws ServiceException {
		UserEntity user = ShiroUser.getCurrentUserEntity();
		boolean hasPri = approveUserService.checkIsApproveUser(user, ApproveUserEntity.PROJECTINFO_TYPE);
		if(!hasPri){
			throw new ServiceException("您不是审核用户，不能进行审核.");
		}
		super.beforeApprove(entity);
	}

	@Override
	public void afterApprove(ProjectInfoEntity entity) throws ServiceException {
//		List<ProjectSubEntity> subList = projectSubService.findByMain(entity.getUuid());
//		stockDetailService.descStockDetail(entity, subList);
		//将申请标志为已处理
		projectApplyService.handleApply(entity.getUuid());
		super.afterApprove(entity);
	}



	@Override
	public void afterUnApprove(ProjectInfoEntity entity) throws ServiceException {
//		List<ProjectSubEntity> subList = projectSubService.findByMain(entity.getUuid());
//		stockDetailService.unApproveStockDetail(entity, subList);
		super.afterUnApprove(entity);
	}

	public ActionResultModel<ProjectInfoVo> select2Query(String codeOrName) {
		ActionResultModel<ProjectInfoVo> arm = new ActionResultModel<ProjectInfoVo>();
		List<ProjectInfoVo> voList = new ArrayList<ProjectInfoVo>();
		if(StringUtils.isEmpty(codeOrName)){
			try {
				voList =  dbDao.find(ProjectInfoVo.class, "select uuid,name,code from yy_project_info where status=1 order by createtime desc");
				arm.setSuccess(true);
			} catch (DAOException e) {
				arm.setSuccess(false);
				e.printStackTrace();
			}
		}else{
			Object [] params  = {"%"+codeOrName+"%","%"+codeOrName+"%"};
			try {
				voList =  dbDao.find(ProjectInfoVo.class, "select uuid,name,code from yy_project_info where status=1 and( code like ? or name like ? ) order by createtime desc", params);
				arm.setSuccess(true);
			} catch (DAOException e) {
				arm.setSuccess(false);
				e.printStackTrace();
			}
		}
		arm.setRecords(voList);
		return arm;
	}

	
	public ActionResultModel<ProjectInfoVo> select2BoxNumQueryselect2BoxNumQuery(String projectId,String boxNum) {
		ActionResultModel<ProjectInfoVo> arm = new ActionResultModel<ProjectInfoVo>();
		List<ProjectInfoVo> voList = new ArrayList<ProjectInfoVo>();
		if(StringUtils.isEmpty(projectId)){
			arm.setSuccess(true);
			arm.setRecords(voList);
			return arm;
		}
		if(StringUtils.isEmpty(boxNum)){
			try {
				Object [] params  = {projectId};
				voList =  dbDao.find(ProjectInfoVo.class, "select DISTINCT(box_num) from yy_project_sub where mainid=? order by createtime desc", params);
				arm.setSuccess(true);
			} catch (DAOException e) {
				arm.setSuccess(false);
				e.printStackTrace();
			}
		}else{
			Object [] params  = {projectId,"%"+boxNum+"%"};
			try {
				voList =  dbDao.find(ProjectInfoVo.class, "select DISTINCT(box_num) name from yy_project_sub where mainid=? and box_num like ? order by createtime desc", params);
				arm.setSuccess(true);
			} catch (DAOException e) {
				arm.setSuccess(false);
				e.printStackTrace();
			}
		}
		arm.setRecords(voList);
		return arm;
	}
	
	

}