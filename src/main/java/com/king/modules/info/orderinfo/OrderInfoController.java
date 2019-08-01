package com.king.modules.info.orderinfo;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.king.common.utils.Constants;
import com.king.frame.controller.ActionResultModel;
import com.king.frame.controller.SuperController;
import com.king.modules.info.material.MaterialBaseEntity;
import com.king.modules.info.stockinfo.StockBaseEntity;
import com.king.modules.info.supplier.SupplierEntity;
import com.king.modules.sys.param.ParameterUtil;

import net.sf.ezmorph.object.DateMorpher;
import net.sf.json.JSONObject;
import net.sf.json.util.JSONUtils;

/**
 * 订单
 * @author null
 * @date 2019-06-17 22:38:46
 */
@Controller
@RequestMapping(value = "/info/orderinfo")
public class OrderInfoController extends SuperController<OrderInfoEntity> {

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
		model.addAttribute("templatePath", ParameterUtil.getParamValue("orderinfoImpTemplate", "/template/订单导入模板.xlsx"));
		return "modules/info/orderinfo/orderinfo_list";
	}

	@Override
	public String addView(Model model, ServletRequest request) {
		model.addAttribute("defaultStockName",ParameterUtil.getParamValue("defaultStockName"));
		model.addAttribute("defaultStock",ParameterUtil.getParamValue("defaultStock"));
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
			if(StringUtils.isEmpty(entity.getSupplierId())){
				entity.setSupplier(null);
			}else{
				SupplierEntity supplier = new SupplierEntity();
				supplier.setUuid(entity.getSupplierId());
				entity.setSupplier(supplier);
			}
			arm = subService.saveSelfAndSubList(entity, subList, deletePKs);
		}catch (DataIntegrityViolationException e) {
			e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg(Constants.getConstraintMsg(e.getMessage()));
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
			StockBaseEntity stock = new StockBaseEntity();
			stock.setUuid(entity.getStockId());
			entity.setStock(stock);
			if(StringUtils.isEmpty(entity.getSupplierId())){
				entity.setSupplier(null);
			}else{
				SupplierEntity supplier = new SupplierEntity();
				supplier.setUuid(entity.getSupplierId());
				entity.setSupplier(supplier);
			}
			arm = subService.saveSelfAndSubList(entity, subList, deletePKs);
		}catch (DataIntegrityViolationException e) {
			e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg(Constants.getConstraintMsg(e.getMessage()));
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
			JSONUtils.getMorpherRegistry().registerMorpher(new DateMorpher(new String[] {"yyyy-MM-dd", "yyyy-MM-dd HH:mm:ss"}));
			OrderSubEntity obj = (OrderSubEntity) JSONObject.toBean(jsonObject,
					OrderSubEntity.class);
			MaterialBaseEntity material = new MaterialBaseEntity();
			material.setUuid(obj.getMaterialId());
			obj.setMaterial(material);
			returnList.add(obj);
		}
		return returnList;
	}
	
	
	
	
	/**
	 * 跳到导入页面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("/toImport")
	public String toImport(Model model) {
		model.addAttribute("templatePath", ParameterUtil.getParamValue("orderinfoImpTemplate", "/template/订单导入模板.xlsx"));
		model.addAttribute("defaultStockName",ParameterUtil.getParamValue("defaultStockName"));
		model.addAttribute("defaultStock",ParameterUtil.getParamValue("defaultStock"));
		return "modules/info/orderinfo/orderinfo_import_page";
	}



	@ResponseBody
	@RequestMapping(value = "/import")
	public ActionResultModel<OrderInfoEntity> importExcel(MultipartHttpServletRequest request,OrderInfoEntity orderInfo,
			HttpServletResponse response) {
		ActionResultModel<OrderInfoEntity> arm = new ActionResultModel<OrderInfoEntity>();
		try {
			response.setCharacterEncoding("UTF-8");
			MultipartFile file = request.getFile("attachment");
			if(StringUtils.isEmpty(orderInfo.getSupplierId())){
				orderInfo.setSupplier(null);
			}else{
				SupplierEntity supplier = new SupplierEntity();
				supplier.setUuid(orderInfo.getSupplierId());
				orderInfo.setSupplier(supplier);
			}
			arm = subService.importExcel(file, orderInfo);
		} catch (Exception e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
		}
		return arm;
	}
	
}