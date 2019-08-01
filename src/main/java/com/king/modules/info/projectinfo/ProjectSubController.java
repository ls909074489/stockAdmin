package com.king.modules.info.projectinfo;

import java.lang.reflect.InvocationTargetException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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

import com.alibaba.fastjson.JSON;
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
		QueryRequest<ProjectSubEntity> qr = getQueryRequest(request, addParam);
		ActionResultModel<ProjectSubEntity> arm =  execDetailQuery(request,qr, baseService);
		List<ProjectSubEntity> subList = arm.getRecords();
		if(CollectionUtils.isEmpty(subList)){
			return arm;
		}
		List<ProjectSubEntity> resultList = new ArrayList<>();
		List<String> subBarcodelist = null;
		ProjectSubEntity desSub = null;
		Set<String> projectIdSet = new HashSet<>();
		List<EnumDataSubEntity> enumList = EnumDataUtils.getEnumSubList("barCodeExtract");
		for(ProjectSubEntity sub : subList){
			projectIdSet.add(sub.getMain().getUuid());
			if(sub.getLimitCount()==MaterialBaseEntity.limitCount_unique&&sub.getPlanAmount()>1){//唯一
				if(StringUtils.isNotEmpty(sub.getBarcodejson())){
					subBarcodelist = JSON.parseArray(sub.getBarcodejson(), String.class);
				}
				if(subBarcodelist==null){
					subBarcodelist = new ArrayList<String>();
				}
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
					if(i<subBarcodelist.size()){
						desSub.setBarcode(subBarcodelist.get(i));
					}else{
						desSub.setBarcode("");
					}
					checkStyle(desSub,enumList);
					resultList.add(desSub);
				}
			}else{
				checkStyle(sub,enumList);
				sub.setNewUuid("0_"+sub.getUuid());
				sub.setFirstRow("1");
				resultList.add(sub);
			}
		}
		List<StockStreamEntity> streamList = streamService.findSurplusAllBySourceIdsIn(new ArrayList<String>(projectIdSet));
		Map<String,List<StockStreamEntity>> streamMap = changeToStreamMap(streamList);
		for(ProjectSubEntity sub : resultList){
			sub.setSurplusAmount(calcSurplusAmount(sub,streamMap.get(sub.getUuid())));
		}
		arm.setRecords(resultList);
		return arm;
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
	public ActionResultModel<ProjectSubEntity> updateBarcode(ServletRequest request,String newUuid,String newBarcode) {
		boolean hasPri = approveUserService.checkIsApproveUser(ShiroUser.getCurrentUserEntity(), ApproveUserEntity.PROJECTINFO_TYPE);
		if(!hasPri){
			ActionResultModel<ProjectSubEntity> arm = new ActionResultModel<ProjectSubEntity>();
			arm.setSuccess(false);
			arm.setMsg("您不是审核用户，不能进行操作.");
			return arm;
		}
		return projectSubService.updateBarcode(newBarcode,newUuid);
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
}
