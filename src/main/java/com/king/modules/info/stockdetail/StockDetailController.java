package com.king.modules.info.stockdetail;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.king.frame.controller.ActionResultModel;
import com.king.frame.controller.BaseController;
import com.king.frame.controller.QueryRequest;
import com.king.frame.service.IService;
import com.king.modules.info.stockstream.StockStreamEntity;
import com.king.modules.info.stockstream.StockStreamService;

/**
 * 库存明细
 * @author null
 * @date 2019-06-18 11:50:47
 */
@Controller
@RequestMapping(value = "/info/stockdetail")
public class StockDetailController extends BaseController<StockDetailEntity> {

	
	@Autowired
	private StockStreamService streamService;
	
	@RequestMapping("/search")
	public String search(Model model) {
		return "modules/info/stockdetail/stockdetail_search";
	}
	
	@RequestMapping(value = "/dataSearch")
	@ResponseBody
	public ActionResultModel<StockDetailEntity> dataSearch(ServletRequest request, Model model) {
		QueryRequest<StockDetailEntity> qr = getQueryRequest(request, addSearchParam(request));
		return execQuery(qr, baseService);
	}
	
	
	
	@Override
	protected ActionResultModel<StockDetailEntity> execQuery(QueryRequest<StockDetailEntity> qr, IService service) {
		ActionResultModel<StockDetailEntity>  arm = super.execQuery(qr, service);
		List<StockDetailEntity> list = arm.getRecords();
		if(CollectionUtils.isNotEmpty(list)){
			List<String> detailIdList = new ArrayList<String>();
			for(StockDetailEntity entity : list){
				detailIdList.add(entity.getUuid());
			}
			List<StockStreamEntity> streamList = streamService.findSurplusByDetailIds(detailIdList);
			Map<String,List<StockStreamEntity>> streamMap = changeToMap(streamList);
			for(StockDetailEntity entity : list){
				calcDetail(entity,streamMap.get(entity.getUuid()));
			}
		}
		return arm;
	}

	
	private void calcDetail(StockDetailEntity entity, List<StockStreamEntity> list) {
		if(CollectionUtils.isEmpty(list)){
			return;
		}
		for(StockStreamEntity s:list){
//			totalAmount
			entity.setSurplusAmount(entity.getSurplusAmount()+s.getSurplusAmount());
			entity.setOccupyAmount(entity.getOccupyAmount()+s.getOccupyAmount());
			entity.setActualAmount(entity.getSurplusAmount()-entity.getOccupyAmount());
		}
		
	}

	private Map<String, List<StockStreamEntity>> changeToMap(List<StockStreamEntity> streamList) {
		Map<String,List<StockStreamEntity>> map = new HashMap<String, List<StockStreamEntity>>();
		if(CollectionUtils.isEmpty(streamList)){
			return map;
		}
		List<StockStreamEntity> list = null;
		for(StockStreamEntity s:streamList){
			list = map.get(s.getStockDetailId());
			if(list==null){
				list = new ArrayList<StockStreamEntity>();
			}
			list.add(s);
			map.put(s.getStockDetailId(), list);
		}
		return map;
	}
	
	/**
	 * 
	 * @Title: listView
	 * @author null
	 * @date 2019-06-18 11:50:47
	 * @param @param model
	 * @param @return 设定文件 
	 * @return String 返回类型 
	 * @throws
	 */
	@RequestMapping("/list")
	public String listView(Model model) {
		return "modules/info/stockdetail/stockdetail_list";
	}

	@Override
	public String addView(Model model, ServletRequest request) {
		return "modules/info/stockdetail/stockdetail_edit";
	}

	@Override
	public String editView(Model model, ServletRequest request, StockDetailEntity entity) {
		return "modules/info/stockdetail/stockdetail_edit";
	}

	@Override
	public String detailView(Model model, ServletRequest request, StockDetailEntity entity) {
		return "modules/info/stockdetail/stockdetail_detail";
	}

	@Override
	public ActionResultModel<StockDetailEntity> add(ServletRequest request, Model model, StockDetailEntity entity) {
		return new ActionResultModel<StockDetailEntity>(false, "不允许操作");
	}

	@Override
	protected ActionResultModel<StockDetailEntity> doAdd(ServletRequest request, Model model,
			StockDetailEntity entity) {
		return new ActionResultModel<StockDetailEntity>(false, "不允许操作");
	}

	@Override
	public ActionResultModel<StockDetailEntity> update(ServletRequest request, Model model, StockDetailEntity entity) {
		return new ActionResultModel<StockDetailEntity>(false, "不允许操作");
	}

	@Override
	protected ActionResultModel<StockDetailEntity> doUpdate(ServletRequest request, Model model,
			StockDetailEntity entity) {
		return new ActionResultModel<StockDetailEntity>(false, "不允许操作");
	}

	@Override
	protected ActionResultModel<StockDetailEntity> doDelete(ServletRequest request, Model model, String[] pks) {
		return new ActionResultModel<StockDetailEntity>(false, "不允许操作");
	}

	@Override
	public ActionResultModel<StockDetailEntity> delete(ServletRequest request, Model model, String[] pks) {
		return new ActionResultModel<StockDetailEntity>(false, "不允许操作");
	}
	

}