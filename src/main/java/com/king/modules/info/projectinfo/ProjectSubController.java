package com.king.modules.info.projectinfo;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletRequest;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.beanutils.converters.DateConverter;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.king.common.utils.DateUtil;
import com.king.common.utils.Json;
import com.king.frame.controller.ActionResultModel;
import com.king.frame.controller.BaseController;
import com.king.frame.controller.QueryRequest;
import com.king.frame.security.ShiroUser;
import com.king.frame.service.IService;
import com.king.modules.info.approve.ApproveUserEntity;
import com.king.modules.info.approve.ApproveUserService;
import com.king.modules.info.material.MaterialBaseEntity;
import com.king.modules.info.receive.ProjectReceiveEntity;
import com.king.modules.info.receive.ProjectReceiveService;
import com.king.modules.info.stockstream.StockStreamEntity;
import com.king.modules.info.stockstream.StockStreamService;
import com.king.modules.sys.enumdata.EnumDataSubEntity;
import com.king.modules.sys.enumdata.EnumDataUtils;

/**
 * 
 * @ClassName: OrderSubController
 * @author liusheng
 * @date 2017年11月21日 下午5:50:47
 */
@Controller
@RequestMapping(value = "/info/projectinfoSub")
public class ProjectSubController extends BaseController<ProjectSubEntity> {

	@Autowired
	private ProjectSubService projectSubService;
	@Autowired
	private ApproveUserService approveUserService;
	@Autowired
	private ProjectReceiveService receiveService;
	@Autowired
	private StockStreamService streamService;
	@Autowired
	private ProjectSubBarcodeService projectSubBarcodeService;
	
	
	@Override
	public Map<String, Object> addSearchParam(ServletRequest request) {
		Map<String, Object> addParam = new HashMap<String, Object>();
		addParam.put("EQ_status", "1");
		return addParam;
	}

	@RequestMapping(value = "/query")
	@ResponseBody
	public ActionResultModel<ProjectSubEntity> query(ServletRequest request, Model model) {
		String isShowReceiveLog = request.getParameter("isShowReceiveLog");
		if(isShowReceiveLog!=null&&isShowReceiveLog.equals("1")){
			ActionResultModel<ProjectSubEntity> arm = doQuery(request);
			List<ProjectSubEntity> list = arm.getRecords();
			if(CollectionUtils.isNotEmpty(list)){
				List<ProjectReceiveEntity> rList = receiveService.findByMainSql(request.getParameter("search_EQ_main.uuid"));
				Map<String,List<ProjectReceiveEntity>> map = changeToMap(rList);
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				for(ProjectSubEntity sub:list){
					setReceiveLog(sub, map.get(sub.getUuid()), sdf);
				}
			}
		}
		return doQuery(request);
	}
	
	private Map<String,List<ProjectReceiveEntity>> changeToMap(List<ProjectReceiveEntity> rList){
		Map<String,List<ProjectReceiveEntity>> map = new HashMap<String,List<ProjectReceiveEntity>>();
		if(CollectionUtils.isNotEmpty(rList)){
			List<ProjectReceiveEntity> list = null;
			for(ProjectReceiveEntity r:rList){
				list =map.get(r.getSubId());
				if(list ==null){
					list = new ArrayList<>();
				}
				list.add(r);
				map.put(r.getSubId(), list);
			}
		}
		return map;
	}
	
	private void setReceiveLog(ProjectSubEntity sub,List<ProjectReceiveEntity> list,SimpleDateFormat sdf){
		if(list==null){
			sub.setReceiveLog("");
		}else{
			StringBuilder str = new StringBuilder();
			for(ProjectReceiveEntity r:list){
				str.append(r.getCreatorname()).append(sdf.format(r.getCreatetime()));
				str.append(" 收货数量").append(r.getReceiveAmount()).append(";");
			}
			sub.setReceiveLog(str.toString());
		}
	}

	@RequestMapping("/detailList")
	public String detailList(Model model,String sourceBillId) {
		List<EnumDataSubEntity> subList = EnumDataUtils.getEnumSubList("barCodeExtract");
		if(subList==null){
			subList = new ArrayList<>();
		}
		model.addAttribute("subList", Json.toJson(subList));
		model.addAttribute("sourceBillId", sourceBillId);
		model.addAttribute("curDate", DateUtil.getCurrentDate("yyyy-MM-dd"));
		return "modules/info/projectinfo/projectinfo_detail_list";
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	protected ActionResultModel<ProjectSubEntity> execDetailQuery(ServletRequest request,QueryRequest<ProjectSubEntity> qr, IService service) {
		ActionResultModel<ProjectSubEntity> arm = new ActionResultModel<ProjectSubEntity>();
		try {
			String mainId = request.getParameter("search_LIKE_main.uuid");
			if(StringUtils.isNotEmpty(mainId)){//按照项目查询不做分页
				List<ProjectSubEntity> list = service.findAll(qr.getSpecification(), qr.getSort());
				arm.setRecords(list);
				arm.setTotal(list.size());
				arm.setTotalPages(1);
				arm.setPageNumber(0);
			}else{
				if (qr.getPageRequest() != null) {
					Page<ProjectSubEntity> data = service.findAll(qr.getSpecification(), qr.getPageRequest());
					arm.setRecords(data.getContent());
					arm.setTotal(data.getTotalElements());
					arm.setTotalPages(data.getTotalPages());
					arm.setPageNumber(data.getNumber());
				} else {
					List<ProjectSubEntity> list = service.findAll(qr.getSpecification(), qr.getSort());
					arm.setRecords(list);
					arm.setTotal(list.size());
					arm.setTotalPages(1);
				}
			}
			arm.setSuccess(true);
		} catch (ServiceException e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
			e.printStackTrace();
		}

		return arm;
	}
	
	@RequestMapping(value = "/dataDetail")
	@ResponseBody
	public ActionResultModel<ProjectSubEntity> dataDetail(ServletRequest request) {
		Map<String, Object> addParam = new HashMap<String, Object>();
		addParam.put("EQ_stock.uuid", request.getParameter("stockId"));
		addParam.put("EQ_material.uuid", request.getParameter("materialId"));
		addParam.put("EQ_status", "1");
		String custom_search_barcode = request.getParameter("custom_search_barcode");
		boolean isSearchBarcode = false;//是否查询条码
		String mainId = request.getParameter("search_LIKE_main.uuid");
		if(StringUtils.isNotEmpty(custom_search_barcode)){
			List<ProjectSubBarcodeEntity> searchBarcodeList = projectSubBarcodeService.findLikeBarcode(mainId,custom_search_barcode);
			if(CollectionUtils.isEmpty(searchBarcodeList)){
				return new ActionResultModel<>(true, "没有记录");
			}
			Set<String> projectIdInSet = new HashSet<>();
			Set<String> subIdInSet = new HashSet<>();
			for(ProjectSubBarcodeEntity bc:searchBarcodeList){
				projectIdInSet.add(bc.getMain().getUuid());
				subIdInSet.add(bc.getSub().getUuid());
			}
			addParam.put("IN_main.uuid", StringUtils.join(projectIdInSet, ","));
			addParam.put("IN_uuid", StringUtils.join(subIdInSet, ","));
			isSearchBarcode = true;
		}
		String checkVal = request.getParameter("checkVal");
//		if(barCodeNull!=null&&barCodeNull.equals("1")){//查询条码为空
//			List<ProjectSubBarcodeEntity> searchBarcodeList = projectSubBarcodeService.findBarcodeNull(mainId);
//			if(CollectionUtils.isEmpty(searchBarcodeList)){
//				return new ActionResultModel<>(true, "没有记录");
//			}
//			Set<String> subIdInSet = new HashSet<>();
//			for(ProjectSubBarcodeEntity bc:searchBarcodeList){
//				subIdInSet.add(bc.getSubId());
//			}
//			addParam.put("IN_uuid", StringUtils.join(subIdInSet, ","));
//		}
		if(checkVal!=null&&checkVal.equals("2")){//查询条码重复
			List<ProjectSubBarcodeEntity> searchBarcodeList = projectSubBarcodeService.findBarcodeRepeat();
			if(CollectionUtils.isEmpty(searchBarcodeList)){
				return new ActionResultModel<>(true, "没有记录");
			}
			Set<String> projectIdInSet = new HashSet<>();
			Set<String> subIdInSet = new HashSet<>();
			for(ProjectSubBarcodeEntity bc:searchBarcodeList){
				projectIdInSet.add(bc.getMainId());
				subIdInSet.add(bc.getSubId());
			}
			addParam.put("IN_main.uuid", StringUtils.join(projectIdInSet, ","));
			addParam.put("IN_uuid", StringUtils.join(subIdInSet, ","));
		}
		
		QueryRequest<ProjectSubEntity> qr = getQueryRequest(request, addParam);
		ActionResultModel<ProjectSubEntity> arm =  execDetailQuery(request,qr, baseService);
		List<ProjectSubEntity> subList = arm.getRecords();
		if(CollectionUtils.isEmpty(subList)){
			return arm;
		}
		List<EnumDataSubEntity> enumList = EnumDataUtils.getEnumSubList("barCodeExtract");
		List<ProjectSubEntity> resultList = new ArrayList<>();
		ProjectSubEntity desSub = null;
		Set<String> projectIdSet = new HashSet<>();
		Map<String,Long> subActualMap = new HashMap<String,Long>();
		for(ProjectSubEntity sub : subList){
			subActualMap.put(sub.getUuid(), sub.getSurplusAmount());
			projectIdSet.add(sub.getMain().getUuid());
		}
		List<StockStreamEntity> streamList = streamService.findSurplusAllBySourceIdsIn(new ArrayList<String>(projectIdSet));
		Map<String,List<StockStreamEntity>> streamMap = changeToStreamMap(streamList);
		List<ProjectSubBarcodeEntity> barcodeList = projectSubBarcodeService.findByProjectIds(new ArrayList<String>(projectIdSet));
		Map<String,List<ProjectSubBarcodeEntity>> barcodeMap = changeToBarcodeMap(barcodeList);
		List<ProjectSubBarcodeEntity> subBarcodelist = null;
//		StringBuilder barcodeHis = null;
		for(ProjectSubEntity sub : subList){
			subBarcodelist = barcodeMap.get(sub.getUuid());
			if(sub.getSubReceiveType()!=null&&sub.getSubReceiveType().equals(ProjectInfoEntity.receiveType_no)
					&&sub.getReceiveTime()==null&&sub.getActualAmount()!=null&&sub.getActualAmount()!=0){
				sub.setReceiveTime(new Date());
			}
			if(sub.getLimitCount()==MaterialBaseEntity.limitCount_unique&&sub.getPlanAmount()>1){//唯一
				for(int i=0;i<sub.getPlanAmount();i++){
					desSub = new ProjectSubEntity();
					try {
						ConvertUtils.register(new DateConverter(null), java.util.Date.class);
						BeanUtils.copyProperties(desSub, sub);
					} catch (Exception e) {e.printStackTrace();}
					desSub.setFirstRow(i==0?"1":"0");
					setSubBarcode(subBarcodelist, desSub, i);
//					desSub.setBarcodeHis(desSub.getBarcode());
					checkStyle(desSub,enumList);
					desSub.setSurplusAmount(calcSurplusAmount(desSub,streamMap.get(desSub.getUuid())));
					if(isSearchBarcode){
						if(desSub.getBarcode().contains(custom_search_barcode)){
							resultList.add(desSub);
						}
					}else{
						resultList.add(desSub);
					}
				}
			}else{
				if(CollectionUtils.isEmpty(subBarcodelist)){
					sub.setFirstRow("1");
					setSubBarcode(subBarcodelist, sub, 0);
					checkStyle(sub,enumList);
					sub.setSurplusAmount(calcSurplusAmount(sub,streamMap.get(sub.getUuid())));
					if(isSearchBarcode){
						if(sub.getBarcode().contains(custom_search_barcode)){
							resultList.add(sub);
						}
					}else{
						resultList.add(sub);
					}
				}else{
					for(int i=0;i<subBarcodelist.size();i++){
						desSub = new ProjectSubEntity();
						try {
							ConvertUtils.register(new DateConverter(null), java.util.Date.class);
							BeanUtils.copyProperties(desSub, sub);
						} catch (Exception e) {e.printStackTrace();}
						desSub.setFirstRow(i==0?"1":"0");
						setSubBarcode(subBarcodelist, desSub, i);
//						desSub.setBarcodeHis(desSub.getBarcode());
						checkStyle(desSub,enumList);
						desSub.setSurplusAmount(calcSurplusAmount(desSub,streamMap.get(desSub.getUuid())));
						if(isSearchBarcode){
							if(desSub.getBarcode().contains(custom_search_barcode)){
								resultList.add(desSub);
							}
						}else{
							resultList.add(desSub);
						}
					}
				}
			}
//			System.out.println(sub.getUuid()+">>"+sub.getSurplusAmount()+">>>>>>>>>>>>"+subActualMap.get(sub.getUuid()));
		}
		if(checkVal!=null&&checkVal.equals("1")){//查询条码为空
			List<ProjectSubEntity> barcodeNullList = new ArrayList<>();
			for(ProjectSubEntity sub:resultList){
				if(StringUtils.isEmpty(sub.getBarcode())){
					barcodeNullList.add(sub);
				}
			}
			resultList = barcodeNullList;
		}
		if(checkVal!=null&&checkVal.equals("3")){//欠料查询（收货数量和计划数量不相等）
			List<ProjectSubEntity> noEqualList = new ArrayList<>();
			for(ProjectSubEntity sub:resultList){
				if(sub.getActualAmount()==null||sub.getPlanAmount()!=sub.getActualAmount()){
					noEqualList.add(sub);
				}
			}
			resultList = noEqualList;
		}
		arm.setRecords(resultList);
		if(StringUtils.isNotEmpty(mainId)){
			arm.setTotal(resultList.size());
		}
		return arm;
	}
	
	
	@RequestMapping("/toSelProjectBox")
	public String toSelProjectBox(Model model) {
		List<EnumDataSubEntity> subList = EnumDataUtils.getEnumSubList("barCodeExtract");
		if(subList==null){
			subList = new ArrayList<>();
		}
		model.addAttribute("subList", Json.toJson(subList));
		model.addAttribute("curDate", DateUtil.getCurrentDate("yyyy-MM-dd"));
		return "modules/info/projectinfo/projectinfo_detail_projectbox_select";
	}
	
	@RequestMapping("/toScanBarcode")
	public String toScanBarcode(Model model,String projectId,String boxNum) {
		List<EnumDataSubEntity> subList = EnumDataUtils.getEnumSubList("barCodeExtract");
		if(subList==null){
			subList = new ArrayList<>();
		}
		model.addAttribute("subList", Json.toJson(subList));
		model.addAttribute("curDate", DateUtil.getCurrentDate("yyyy-MM-dd"));
		model.addAttribute("projectId", projectId);
		model.addAttribute("boxNum", boxNum);
		return "modules/info/projectinfo/projectinfo_detail_scan";
	}
	
	
	
	@RequestMapping(value = "/dataUnOut")
	@ResponseBody
	public ActionResultModel<ProjectSubUnOutVo> dataUnOut(ServletRequest request) {
		ActionResultModel<ProjectSubUnOutVo> resultArm = new ActionResultModel<ProjectSubUnOutVo>();
		Map<String, Object> addParam = new HashMap<String, Object>();
//		addParam.put("EQ_stock.uuid", request.getParameter("stockId"));
		
		String hwcode = request.getParameter("hwcode");
		if(StringUtils.isNotEmpty(hwcode)){
			addParam.put("EQ_material.hwcode", hwcode);
		}
		addParam.put("EQ_status", "1");
		QueryRequest<ProjectSubEntity> qr = getQueryRequest(request, addParam);
		ActionResultModel<ProjectSubEntity> arm =  execDetailQuery(request,qr, baseService);
		List<ProjectSubEntity> subList = arm.getRecords();
		if(CollectionUtils.isEmpty(subList)){
			resultArm.setSuccess(true);
			return resultArm;
		}
		List<ProjectSubUnOutVo> resultList = new ArrayList<>();
		Set<String> projectIdSet = new HashSet<>();
		Map<String,Long> subActualMap = new HashMap<String,Long>();
		for(ProjectSubEntity sub : subList){
			subActualMap.put(sub.getUuid(), sub.getSurplusAmount());
			projectIdSet.add(sub.getMain().getUuid());
		}
//		List<StockStreamEntity> streamList = streamService.findSurplusAllBySourceIdsIn(new ArrayList<String>(projectIdSet));
//		Map<String,List<StockStreamEntity>> streamMap = changeToStreamMap(streamList);
		List<ProjectSubBarcodeEntity> barcodeList = projectSubBarcodeService.findByProjectIds(new ArrayList<String>(projectIdSet));
		Map<String,List<ProjectSubBarcodeEntity>> barcodeMap = changeToBarcodeMap(barcodeList);
		for(ProjectSubEntity sub : subList){
			ProjectSubUnOutVo vo = new ProjectSubUnOutVo(sub.getUuid(), sub.getMaterial(), sub.getLimitCount(), 
					(sub.getPlanAmount()-calcOutAmount(sub,barcodeMap.get(sub.getUuid()))),sub.getPlanAmount());
			if(vo.getUnScanCount()>0){//未扫码的
				resultList.add(vo);
			}
		}
		resultArm.setRecords(resultList);
		resultArm.setTotal(resultList.size());
		resultArm.setRecordsTotal(arm.getRecordsTotal());
		resultArm.setSuccess(arm.isSuccess());
		return resultArm;
	}
	
	
	/**
	 * 批量保存条码
	 * @param request
	 * @param barcode
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/batchSaveBarcode")
	public ActionResultModel<ProjectSubEntity> batchSaveBarcode(ServletRequest request,String []barcode) {
		ActionResultModel<ProjectSubUnOutVo> voArm = dataUnOut(request);
		List<ProjectSubUnOutVo> voList = voArm.getRecords();
		ActionResultModel<ProjectSubEntity> arm =  new ActionResultModel<ProjectSubEntity>();
		try {
			arm = projectSubService.batchSaveBarcode(barcode,voList);
		} catch (ServiceException e) {
			e.printStackTrace();
			arm.setMsg(e.getMessage());
			arm.setSuccess(false);
		}
		return arm;
	}
	
	/**
	 * 设置条码
	 * @param subBarcodelist
	 * @param sub
	 * @param i
	 * @return
	 */
	private ProjectSubEntity setSubBarcode(List<ProjectSubBarcodeEntity> subBarcodelist,ProjectSubEntity sub,int i){
		if(CollectionUtils.isEmpty(subBarcodelist)){
			sub.setNewUuid(i+"_"+sub.getUuid());
			sub.setBarcode("");
			return sub;
		}
		if(i<subBarcodelist.size()){
			sub.setNewUuid(subBarcodelist.get(i).getUuid()+"_"+sub.getUuid());
			sub.setBarcode(subBarcodelist.get(i).getBarcode());
			sub.setBarcodeUuid(subBarcodelist.get(i).getUuid());
			sub.setSubAmount(subBarcodelist.get(i).getSubAmount());
		}else{
			sub.setNewUuid(i+"_"+sub.getUuid());
			sub.setBarcode("");
		}
		return sub;
	}

	/**
	 * 计算剩余 的流水
	 * @param sub
	 * @param list
	 * @return
	 */
	private Long calcSurplusAmount(ProjectSubEntity sub, List<StockStreamEntity> list) {
		if(CollectionUtils.isEmpty(list)){
			return 0l;
		}
		Long suplusAmount = 0l;
		for(StockStreamEntity stream : list){
			suplusAmount += stream.getSurplusAmount();
		}
		return suplusAmount;
	}
	
	/**
	 * 计算出库的数量
	 * @param sub
	 * @param list
	 * @return
	 */
	private Long calcOutAmount(ProjectSubEntity sub, List<ProjectSubBarcodeEntity> list) {
		if(CollectionUtils.isEmpty(list)){
			return 0l;
		}
		Long outAmount = 0l;
		for(ProjectSubBarcodeEntity obj : list){
			outAmount += obj.getSubAmount();
		}
		return outAmount;
	}

	/**
	 * 转成流水map
	 * @param streamList
	 * @return
	 */
	private Map<String, List<StockStreamEntity>> changeToStreamMap(List<StockStreamEntity> streamList) {
		Map<String,List<StockStreamEntity>> map = new HashMap<String, List<StockStreamEntity>>();
		if(CollectionUtils.isEmpty(streamList)){
			return map;
		}
		List<StockStreamEntity> list = null;
		for(StockStreamEntity s:streamList){
			list = map.get(s.getProjectSubId());
			if(list==null){
				list = new ArrayList<StockStreamEntity>();
			}
			list.add(s);
			map.put(s.getProjectSubId(), list);
		}
		return map;
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

	
	
	private ProjectSubEntity checkStyle(ProjectSubEntity sub,List<EnumDataSubEntity> enumList){
		if(StringUtils.isEmpty(sub.getBarcode())){
			sub.setCheckStatus(ProjectSubEntity.checkStatus_init);
		}else if(sub.getBarcode().contains(sub.getMaterial().getHwcode())){
			sub.setCheckStatus(ProjectSubEntity.checkStatus_pass);
		}else{
			sub.setCheckStatus(ProjectSubEntity.checkStatus_error);
		}
		for(EnumDataSubEntity enumSub:enumList){
			String t_pre = enumSub.getEnumdatakey();
			if(sub.getBarcode()!=null&&sub.getBarcode().indexOf(t_pre)==0){//以19,39...开头的
				String limitLength = enumSub.getDescription();//限制长度
				if(limitLength!=null&&limitLength!=""&&Integer.parseInt(limitLength)!=sub.getBarcode().length()){
					sub.setBarcodeStatus(ProjectSubEntity.BARCODE_STATUS_LENGTH_WRONG);
					break;
				}
			}
		}
		return sub;
	}
	
	@ResponseBody
	@RequestMapping(value = "/updateBarcode")
	public ActionResultModel<ProjectSubEntity> updateBarcode(ServletRequest request,String newUuid,String newBarcode,Long subAmount) {
		ActionResultModel<ProjectSubEntity> arm = new ActionResultModel<ProjectSubEntity>();
		boolean hasPri = approveUserService.checkIsApproveUser(ShiroUser.getCurrentUserEntity(), ApproveUserEntity.PROJECTINFO_TYPE);
		if(!hasPri){
			arm.setSuccess(false);
			arm.setMsg("您不是审核用户，不能进行操作.");
			return arm;
		}
		try {
			if(newBarcode!=null){
				newBarcode = newBarcode.trim();
			}
			arm = projectSubService.updateBarcode(newBarcode,newUuid,subAmount,null);
		} catch (Exception e) {
			e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg("操作失败："+e.getMessage());
			return arm;
		}
		return arm;
	}
	
	/**
	 * 保存条码-批次
	 * @param request
	 * @param newUuid
	 * @param newBarcode
	 * @param subAmount
	 * @param operType 添加add 修改update
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/updateBarcodePc")
	public ActionResultModel<ProjectSubEntity> updateBarcodePc(ServletRequest request,String subId,String newBarcode,Long subAmount,String operType) {
		ActionResultModel<ProjectSubEntity> arm = new ActionResultModel<ProjectSubEntity>();
		boolean hasPri = approveUserService.checkIsApproveUser(ShiroUser.getCurrentUserEntity(), ApproveUserEntity.PROJECTINFO_TYPE);
		if(!hasPri){
			arm.setSuccess(false);
			arm.setMsg("您不是审核用户，不能进行操作.");
			return arm;
		}
		try {
			if(newBarcode!=null){
				newBarcode = newBarcode.trim();
			}
			arm = projectSubService.updateBarcodePc(newBarcode,subId,subAmount,operType,null);
		} catch (Exception e) {
			e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg("操作失败："+e.getMessage());
			return arm;
		}
		return arm;
	}
	
	/**
	 * 撤销出库
	 * @param request
	 * @param newUuid
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/unOutBySub")
	public ActionResultModel<ProjectSubEntity> unOutBySub(ServletRequest request,String newUuid) {
		ActionResultModel<ProjectSubEntity> arm = new ActionResultModel<ProjectSubEntity>();
		boolean hasPri = approveUserService.checkIsApproveUser(ShiroUser.getCurrentUserEntity(), ApproveUserEntity.PROJECTINFO_TYPE);
		if(!hasPri){
			arm.setSuccess(false);
			arm.setMsg("您不是审核用户，不能进行操作.");
			return arm;
		}
		try {
			arm = projectSubService.unOutBySub(newUuid);
		} catch (Exception e) {
			e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg("操作失败："+e.getMessage());
			return arm;
		}
		return arm;
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/checkBarcode")
	public ActionResultModel<ProjectSubEntity> checkBarcode(ServletRequest request,String subId,String newBarcode) {
		return projectSubService.checkBarcode(newBarcode,subId);
	}
	
	
	
	@RequestMapping("/toUpdateLimitCount")
	public String toUpdateLimitCount(Model model,String subId) {
		ProjectSubEntity sub = projectSubService.getOne(subId);
		model.addAttribute("entity", sub);
		return "modules/info/projectinfo/projectinfo_sub_limitcount";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/updateLimitCount")
	public ActionResultModel<ProjectSubEntity> updateLimitCount(ServletRequest request,String subId,int limitCount) {
		return projectSubService.updateLimitCount(limitCount,subId);
	}
	
	/**
	 * 保存条码确定数量
	 * @param model
	 * @param subId
	 * @return
	 */
	@RequestMapping("/toConfrimCount")
	public String toConfrimCount(Model model,String subId,Long planAmount,String newBarcodeVal) {
		model.addAttribute("subId", subId);
		model.addAttribute("planAmount", planAmount);
		if(newBarcodeVal!=null){
			newBarcodeVal = newBarcodeVal.trim();
		}
		model.addAttribute("newBarcodeVal", newBarcodeVal);
		return "modules/info/projectinfo/projectinfo_sub_confirm_count";
	}
	
	
	
	@RequestMapping("/toModifyBarcode")
	public String toModifyBarcode(Model model,String projectSubId,String barcodeUuid) {
		model.addAttribute("projectSubId", projectSubId);
		model.addAttribute("barcodeUuid", barcodeUuid);
		return "modules/info/projectinfo/projectinfo_sub_modify_barcode";
	}
	
	/**
	 * 修改条码
	 * @param model
	 * @param projectSubId
	 * @param barcodeUuid
	 * @param barcode
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/modifyBarcode")
	public ActionResultModel<ProjectSubEntity> modifyBarcode(Model model,String projectSubId,String barcodeUuid,String barcode) {
		return projectSubService.modifyBarcode(projectSubId,barcodeUuid,barcode);
	}
}
