package com.king.modules.info.orderinfo;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.king.frame.controller.ActionResultModel;
import com.king.frame.controller.BaseController;
import com.king.modules.info.material.MaterialEntity;

import net.sf.json.JSONObject;

/**
 * 订单
 * @author null
 * @date 2019-06-17 22:38:46
 */
@Controller
@RequestMapping(value = "/info/orderinfo")
public class OrderInfoController extends BaseController<OrderInfoEntity> {

	@Autowired
	private OrderInfoService service;
	@Autowired
	private OrderSubService subService;

	/**
	 * 
	 * @Title: listView
	 * @author null
	 * @date 2019-06-17 22:38:46
	 * @param @param model
	 * @param @return 设定文件 
	 * @return String 返回类型 
	 * @throws
	 */
	@RequestMapping("/list")
	public String listView(Model model) {
		return "modules/info/orderinfo/orderinfo_list";
	}

	@Override
	public String addView(Model model, ServletRequest request) {
		return "modules/info/orderinfo/orderinfo_add";
	}

	@Override
	public String editView(Model model, ServletRequest request, OrderInfoEntity entity) {
		return "modules/info/orderinfo/orderinfo_edit";
	}

	@Override
	public String detailView(Model model, ServletRequest request, OrderInfoEntity entity) {
		return "modules/info/orderinfo/orderinfo_detail";
	}

	
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/addwithsub")
	@ResponseBody
	public ActionResultModel addwithsub(ServletRequest request, Model model, @Valid OrderInfoEntity entity,
			@RequestParam(value = "subList[]", required = false) String[] subArrs,
			@RequestParam(value = "deletePKs[]", required = false) String[] deletePKs) {
		ActionResultModel<OrderInfoEntity> arm = new ActionResultModel<OrderInfoEntity>();
		arm.setSuccess(true);
		List<OrderSubEntity> subList = this.convertToEntities(subArrs);
		try {
			arm = subService.saveSelfAndSubList(entity, subList, deletePKs);
		}catch (Exception e) {
			arm.setSuccess(false);
			arm.setMsg("保存失败");
			e.printStackTrace();
		}
		return arm;
	}

	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/updatewithsub")
	@ResponseBody
	public ActionResultModel update(ServletRequest request, Model model, @Valid @ModelAttribute("preloadEntity") OrderInfoEntity entity,
			@RequestParam(value = "subList[]", required = false) String[] subArrs,
			@RequestParam(value = "deletePKs[]", required = false) String[] deletePKs) {
		ActionResultModel<OrderInfoEntity> arm = new ActionResultModel<OrderInfoEntity>();
		arm.setSuccess(true);
		List<OrderSubEntity> subList = this.convertToEntities(subArrs);
		try {
			arm = subService.saveSelfAndSubList(entity, subList, deletePKs);
		} catch (Exception e) {
			arm.setSuccess(false);
			arm.setMsg("保存失败");
			e.printStackTrace();
		}
		return arm;
	}

	
	private List<OrderSubEntity> convertToEntities(String[] paramArr) {
		List<OrderSubEntity> returnList = new ArrayList<OrderSubEntity>();
		if (paramArr == null || paramArr.length == 0)
			return returnList;
		
		for (String data : paramArr) {
			JSONObject jsonObject = new JSONObject();
			String[] properties = data.split("&");
			for (String property : properties) {
				String[] nameAndValue = property.split("=");
				if (nameAndValue.length == 2) {
					try {
						nameAndValue[0] = URLDecoder.decode(nameAndValue[0], "UTF-8");
						nameAndValue[1] = URLDecoder.decode(nameAndValue[1], "UTF-8");
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}
					jsonObject.put(nameAndValue[0], nameAndValue[1]);
				}
			}
			OrderSubEntity obj = (OrderSubEntity) JSONObject.toBean(jsonObject,
					OrderSubEntity.class);
			MaterialEntity material = new MaterialEntity();
			material.setUuid(obj.getMaterialId());
			obj.setMaterial(material);
//			if(StringUtils.isEmpty(obj.getUuid())){
//				for(int i=0;i<500;i++){
//					OrderSubEntity bbb = (OrderSubEntity) JSONObject.toBean(jsonObject,
//							OrderSubEntity.class);
//					MaterialEntity material2 = new MaterialEntity();
//					material2.setUuid(obj.getMaterialId());
//					bbb.setMaterial(material2);
//					returnList.add(bbb);
//				}	
//			}
			returnList.add(obj);
		}
		return returnList;
	}
	
}