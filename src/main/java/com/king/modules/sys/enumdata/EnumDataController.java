package com.king.modules.sys.enumdata;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.validation.Valid;

import org.hibernate.service.spi.ServiceException;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.king.frame.controller.ActionResultModel;
import com.king.frame.controller.BaseController;

import net.sf.json.JSONObject;

/**
 * 枚举数据控制类
 * 
 * @author xuechen
 * @date 2015年11月27日 下午2:38:33
 */
@Controller
@RequestMapping(value = "/sys/enumdata")
public class EnumDataController extends BaseController<EnumDataEntity> {
	private EnumDataService getService() {
		return (EnumDataService) super.baseService;
	}

	@RequestMapping(method = RequestMethod.GET)
	public String view() {
		return "/modules/sys/enum/enum_main";
	}

	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/addwithsub")
	@ResponseBody
	public ActionResultModel addwithsub(ServletRequest request, Model model, @Valid EnumDataEntity entity,
			@RequestParam(value = "subList[]", required = false) String[] subArrs,
			@RequestParam(value = "deletePKs[]", required = false) String[] deletePKs) {
		ActionResultModel<EnumDataEntity> arm = new ActionResultModel<EnumDataEntity>();
		arm.setSuccess(true);
		List<EnumDataSubEntity> subList = this.convertToEntities(subArrs);
		try {
			arm = getService().saveSelfAndSubList(entity, subList, deletePKs);
		} catch (ServiceException e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
			e.printStackTrace();
		} catch (DataIntegrityViolationException e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
			e.printStackTrace();
		} catch (Exception e) {
			arm.setSuccess(false);
			arm.setMsg("保存失败");
			e.printStackTrace();
		}
		return arm;
	}

	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/updatewithsub")
	@ResponseBody
	public ActionResultModel update(ServletRequest request, Model model, @Valid EnumDataEntity entity,
			@RequestParam(value = "subList[]", required = false) String[] subArrs,
			@RequestParam(value = "deletePKs[]", required = false) String[] deletePKs) {
		ActionResultModel<EnumDataEntity> arm = new ActionResultModel<EnumDataEntity>();
		arm.setSuccess(true);
		List<EnumDataSubEntity> subList = this.convertToEntities(subArrs);
		try {
			arm = getService().saveSelfAndSubList(entity, subList, deletePKs);
		} catch (ServiceException e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
			e.printStackTrace();
		} catch (DataIntegrityViolationException e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
			e.printStackTrace();
		} catch (Exception e) {
			arm.setSuccess(false);
			arm.setMsg("保存失败");
			e.printStackTrace();
		}
		return arm;
	}

	private List<EnumDataSubEntity> convertToEntities(String[] paramArr) {
		List<EnumDataSubEntity> returnList = new ArrayList<EnumDataSubEntity>();
		if (paramArr == null || paramArr.length == 0)
			return returnList;
		for (String data : paramArr) {
			JSONObject jsonObject = new JSONObject();
			String[] properties = data.split("&");
			for (String property : properties) {
				String[] nameAndValue = property.split("=");
				if (nameAndValue.length == 2) {
					try {
						if(nameAndValue[0].equals("descript ion")){//页面转换过来会有空格
							nameAndValue[0] = "description";
							nameAndValue[1] = URLDecoder.decode(nameAndValue[1], "UTF-8");
						}else{
							nameAndValue[0] = URLDecoder.decode(nameAndValue[0], "UTF-8");
							nameAndValue[1] = URLDecoder.decode(nameAndValue[1], "UTF-8");
						}
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}
					jsonObject.put(nameAndValue[0], nameAndValue[1]);
				}
			}
			EnumDataSubEntity obj = (EnumDataSubEntity) JSONObject.toBean(jsonObject, EnumDataSubEntity.class);
			returnList.add(obj);
		}
		return returnList;
	}

	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/getEnumDataMap")
	@ResponseBody
	private ActionResultModel getEnumDataMap() {
		ActionResultModel arm = new ActionResultModel();
		try {
			Map<String, List<EnumDataSubEntity>> map = EnumDataUtils.mapEnum;
			if (map == null) {
				map = getService().getEnumDataMap();
			}
			EnumDataUtils.setYearEnumToMap(map);
			arm.setRecords(map);
			arm.setSuccess(true);
		} catch (ServiceException e) {
			// e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
		}

		return arm;
	}
}
