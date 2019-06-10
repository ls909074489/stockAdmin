package com.king.modules.sys.mappingtable;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.king.frame.controller.ActionResultModel;
import com.king.frame.controller.BaseController;

import net.sf.json.JSONObject;

/**
 * 
 * @ClassName: AuditColsController
 * @author liusheng
 * @date 2017年11月21日 下午5:50:34
 */
@Controller
@RequestMapping(value = "/info/mappingTable")
public class MappingTableController extends BaseController<MappingTableEntity> {

	@Autowired
	private MappingTableSubService subService;

	@RequestMapping(method = RequestMethod.GET)
	public String listView(Model model,HttpServletRequest request) {
		return "modules/sys/mappingtable/mappingtable_list";
	}
	
	

	@Override
	public Map<String, Object> addSearchParam(ServletRequest request) {
		Map<String, Object> addParam = new HashMap<String, Object>();
//		if(station!=null){
//			addParam.put("EQ_station.uuid", station.getUuid());
//		}else{
//			addParam.put("EQ_station.uuid", "xxxx");//为空不返回，xxxx为不存在的机构id
//		}
		return addParam;
	}



	@Override
	public String addView(Model model, ServletRequest request) {
		return "modules/sys/mappingtable/mappingtable_edit";
	}

	@Override
	public String editView(Model model, ServletRequest request, MappingTableEntity entity) {
		return "modules/sys/mappingtable/mappingtable_edit";
	}

	@Override
	public String detailView(Model model, ServletRequest request, MappingTableEntity entity) {
		return "modules/sys/mappingtable/mappingtable_detail";
	}

	

	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/addwithsub")
	@ResponseBody
	public ActionResultModel addwithsub(ServletRequest request, Model model, @Valid MappingTableEntity entity,
			@RequestParam(value = "subList[]", required = false) String[] subArrs,
			@RequestParam(value = "deletePKs[]", required = false) String[] deletePKs) {
		ActionResultModel<MappingTableEntity> arm = new ActionResultModel<MappingTableEntity>();
		arm.setSuccess(true);
		List<MappingTableSubEntity> subList = this.convertToEntities(subArrs);
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
	public ActionResultModel update(ServletRequest request, Model model, @Valid @ModelAttribute("preloadEntity") MappingTableEntity entity,
			@RequestParam(value = "subList[]", required = false) String[] subArrs,
			@RequestParam(value = "deletePKs[]", required = false) String[] deletePKs) {
		ActionResultModel<MappingTableEntity> arm = new ActionResultModel<MappingTableEntity>();
		arm.setSuccess(true);
		List<MappingTableSubEntity> subList = this.convertToEntities(subArrs);
		try {
			arm = subService.saveSelfAndSubList(entity, subList, deletePKs);
		} catch (Exception e) {
			arm.setSuccess(false);
			arm.setMsg("保存失败");
			e.printStackTrace();
		}
		return arm;
	}

	private List<MappingTableSubEntity> convertToEntities(String[] paramArr) {
		List<MappingTableSubEntity> returnList = new ArrayList<MappingTableSubEntity>();
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
			MappingTableSubEntity obj = (MappingTableSubEntity) JSONObject.toBean(jsonObject,
					MappingTableSubEntity.class);
			returnList.add(obj);
		}
		return returnList;
	}
}
