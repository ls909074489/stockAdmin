package com.king.modules.info.orderinfo;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletRequest;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;

import com.king.common.enums.BillStatus;
import com.king.frame.controller.ActionResultModel;
import com.king.frame.controller.BaseController;
import com.king.modules.info.stockstream.StockStreamEntity;
import com.king.modules.info.stockstream.StockStreamService;

/**
 * 
 * @ClassName: OrderSubController
 * @author liusheng
 * @date 2017年11月21日 下午5:50:47
 */
@Controller
@RequestMapping(value = "/info/orderinfoSub")
public class OrderSubController extends BaseController<OrderSubEntity> {

	@Autowired
	private StockStreamService stockStreamService;
	@Autowired
	private OrderInfoService orderService;
	
	@Override
	protected ActionResultModel<OrderSubEntity> doQuery(ServletRequest request) {
		String mainId = request.getParameter("search_EQ_main.uuid");
		if(StringUtils.isEmpty(mainId)){
				return new ActionResultModel<>(new ArrayList<OrderSubEntity>());
		}
		ActionResultModel<OrderSubEntity> arm =  super.doQuery(request);
		OrderInfoEntity main = orderService.getOne(mainId);
		if(main.getBillstatus()==BillStatus.APPROVAL.toStatusValue()){
			List<StockStreamEntity> streamList = stockStreamService.findBySourceId(mainId);
			if(CollectionUtils.isEmpty(streamList)){
				return arm;
			}
			List<OrderSubEntity> subList = arm.getRecords();
			for(OrderSubEntity sub:subList){
				for(StockStreamEntity stream:streamList){
					if(sub.getUuid().equals(stream.getSourceSubId())){
						sub.setSurplusAmount(stream.getSurplusAmount());
						break;
					}
				}
			}
		}
		return arm;
	}

}
