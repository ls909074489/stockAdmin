package com.king.modules.info.orderinfo;

import java.util.ArrayList;
import javax.servlet.ServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import com.king.frame.controller.ActionResultModel;
import com.king.frame.controller.BaseController;

/**
 * 
 * @ClassName: OrderSubController
 * @author liusheng
 * @date 2017年11月21日 下午5:50:47
 */
@Controller
@RequestMapping(value = "/info/orderinfoSub")
public class OrderSubController extends BaseController<OrderSubEntity> {

	@Override
	protected ActionResultModel<OrderSubEntity> doQuery(ServletRequest request) {
		String mainId = request.getParameter("search_EQ_main.uuid");
		if(StringUtils.isEmpty(mainId)){
				return new ActionResultModel<>(new ArrayList<OrderSubEntity>());
		}
		return super.doQuery(request);
	}

}
