package com.king.modules.info.isolateMaterial;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.king.frame.controller.ActionResultModel;
import com.king.frame.controller.BaseController;
import com.king.modules.info.projectinfo.ProjectSubBarcodeEntity;
import com.king.modules.info.projectinfo.ProjectSubBarcodeService;
import com.king.modules.info.projectinfo.ProjectSubEntity;
import com.king.modules.info.projectinfo.ProjectSubService;

/**
 * 
 * @author lenovo
 *
 */
@Controller
@RequestMapping(value = "/info/isolateMaterial")
public class MateialIsolateController extends BaseController<MateialIsolateEntity> {

	@Autowired
	private MateialIsolateService service;
	@Autowired
	private ProjectSubBarcodeService projectSubBarcodeService;
	@Autowired
	private ProjectSubService projectSubService;

	
	@ResponseBody
	@RequestMapping(value = "/query")
	public ActionResultModel<MateialIsolateEntity> query(ServletRequest request, Model model) {
		ActionResultModel<MateialIsolateEntity> arm =  super.query(request, model);
		if(!arm.isSuccess()){
			return arm;
		}
		List<MateialIsolateEntity> list = arm.getRecords();
		List<String> barcodeList = new ArrayList<String>();
		if(CollectionUtils.isNotEmpty(list)){
			List<MateialIsolateEntity> resultList = new ArrayList<>();
			for(MateialIsolateEntity mi:list){
				mi.setExitType("否");
				barcodeList.add(mi.getBarcode());
			}
			List<ProjectSubBarcodeEntity> searchBarcodeList = projectSubBarcodeService.findByBarcodes(barcodeList);
			if(CollectionUtils.isNotEmpty(searchBarcodeList)){
				Map<String,List<ProjectSubBarcodeEntity>> barcodeMap = new HashMap<>(); 
				List<ProjectSubBarcodeEntity> subList = null;
				for(ProjectSubBarcodeEntity sub:searchBarcodeList){
					subList = barcodeMap.get(sub.getBarcode());
					if(subList == null){
						subList = new ArrayList<>();
					}
					subList.add(sub);
					barcodeMap.put(sub.getBarcode(), subList);
				}
				for(MateialIsolateEntity mateialIsolate:list){
					subList = barcodeMap.get(mateialIsolate.getBarcode());
					if(CollectionUtils.isNotEmpty(subList)){
						for(ProjectSubBarcodeEntity sub:subList){
							MateialIsolateEntity mi = new MateialIsolateEntity();
							mi.setUuid(mateialIsolate.getUuid());
							mi.setBarcode(sub.getBarcode());
							mi.setProjectCode(sub.getMain().getCode());
							mi.setProjectBoxNum(sub.getSub().getBoxNum());
							ProjectSubEntity subEntity = projectSubService.getOne(sub.getSub().getUuid());
							mi.setProjectMaterial(subEntity.getMaterial().getCode()+"["+subEntity.getMaterial().getHwcode()+"]");
							mi.setExitType("是");
							resultList.add(mi);
						}
					}else{
						resultList.add(mateialIsolate);
					}
				}
				arm.setRecords(resultList);
			}
		}
		return arm;
	}

	/**
	 * 
	 * @Title: listView
	 * @author null
	 * @date 2019-07-17 21:13:46
	 * @param @param model
	 * @param @return 设定文件 
	 * @return String 返回类型 
	 * @throws
	 */
	@RequestMapping("/list")
	public String listView(Model model) {
		return "modules/info/isolatematerial/isolatematerial_list";
	}

	@Override
	public String addView(Model model, ServletRequest request) {
		return "modules/info/isolatematerial/isolatematerial_edit";
	}

	@Override
	public String editView(Model model, ServletRequest request, MateialIsolateEntity entity) {
		return "modules/info/isolatematerial/isolatematerial_edit";
	}

	@Override
	public String detailView(Model model, ServletRequest request, MateialIsolateEntity entity) {
		return "modules/info/isolatematerial/isolatematerial_detail";
	}

	@RequestMapping(value = "/adds")
	@ResponseBody
	public ActionResultModel<MateialIsolateEntity> adds(ServletRequest request, Model model, String []barcode) {
		ActionResultModel<MateialIsolateEntity> arm = new ActionResultModel<MateialIsolateEntity>();
		List<MateialIsolateEntity> list = new ArrayList<>();
		for(String bc:barcode){
			if(!StringUtils.isEmpty(bc)){
				MateialIsolateEntity obj = new MateialIsolateEntity();
				obj.setBarcode(bc);
				list.add(obj);
			}
		}
		service.doAdd(list);
		arm.setSuccess(true);
		arm.setMsg("保存成功");
		return arm;
	}
	

}