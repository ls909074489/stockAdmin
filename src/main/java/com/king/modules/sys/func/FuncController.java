package com.king.modules.sys.func;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletRequest;
import javax.validation.Valid;

import org.hibernate.service.spi.ServiceException;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.king.common.bean.TreeBaseBean;
import com.king.common.utils.Constants;
import com.king.frame.controller.ActionResultModel;
import com.king.frame.controller.TreeController;
import com.king.frame.tree.TreeNode;
import com.king.frame.tree.TreeUtils;
import com.king.modules.sys.func.action.FuncActionEntity;

import net.sf.json.JSONObject;

@Controller
@RequestMapping(value = "/sys/func")
public class FuncController extends TreeController<FuncEntity> {
	
	private FuncService getService() {
		return (FuncService) super.baseService;
	}
	

	@RequestMapping(method = RequestMethod.GET)
	public String view() {
		return "modules/sys/func/func_main";
	}

	@RequestMapping(value = "/selectFunc")
	public String selectFunc() {
		return "modules/sys/func/func_select";
	}

	@RequestMapping(value = "/selectIcon")
	public String selectIcon() {
		return "modules/sys/func/func_icons";
	}

	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/getTreeNodes")
	@ResponseBody
	private ActionResultModel getTreeNodes(ServletRequest request,
			@RequestParam(value = "node", defaultValue = "") String pid) {
		ActionResultModel<TreeNode> arm = new ActionResultModel<TreeNode>();
		try {
			List<FuncEntity> list = getService().findByParentId(pid);// <FuncEntity>
			List allList = (List) getService().findAll(new Sort(Sort.Direction.ASC, "func_code"));// (ITreeEntity)
																									// list.get(0),
			TreeNode tree = TreeUtils.getTreeNode(list.get(0), allList);
			arm.setRecords(tree);
			arm.setTotal(0);
			arm.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			arm.setMsg(e.getMessage());
		}
		return arm;
	}
	
	
	/**
	 * 获取菜单列表
	 * @Title: dataFuncList 
	 * @author liusheng
	 * @date 2016年6月6日 下午2:01:33 
	 * @param @return 设定文件 
	 * @return List<TreeBaseBean> 返回类型 
	 * @throws
	 */
	@ResponseBody
	@RequestMapping(value = "/dataFuncList")
	private List<TreeBaseBean> dataFuncList() {
		List<TreeBaseBean> treeList = new ArrayList<TreeBaseBean>();
		TreeBaseBean bean = null;
		List<FuncEntity> orgList = (List<FuncEntity>) getService().findAll(new Sort(Sort.Direction.ASC, "func_code"));
		if (orgList != null && orgList.size() > 0) {
			for (FuncEntity d : orgList) {
				bean = new TreeBaseBean(d.getUuid(), d.getName(), d.getParentId(), false, false, d);
				treeList.add(bean);
			}
		}
		return treeList;
	}
	
	

	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/addwithsub")
	@ResponseBody
	public ActionResultModel addwithsub(ServletRequest request,Model model,@Valid FuncEntity entity,
			@RequestParam(value = "subList[]",required=false) String[] subArrs,
			@RequestParam(value = "deletePKs[]",required=false) String[] deletePKs){
		ActionResultModel<FuncEntity> arm = new ActionResultModel<FuncEntity>();
		arm.setSuccess(true);
		List<FuncActionEntity> subList = this.convertToEntities(subArrs);
		try {
			arm=getService().saveSelfAndSubList(entity,subList,deletePKs);
		}catch (DataIntegrityViolationException e) {
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
	public ActionResultModel update(ServletRequest request, Model model,
			@Valid FuncEntity entity,@RequestParam(value = "subList[]",required=false) String[] subArrs,
			@RequestParam(value = "deletePKs[]",required=false) String[] deletePKs) {
		ActionResultModel<FuncEntity> arm = new ActionResultModel<FuncEntity>();
		arm.setSuccess(true);
		List<FuncActionEntity> subList = this.convertToEntities(subArrs);
		try {
			arm=getService().saveSelfAndSubList(entity,subList,deletePKs);
		}catch (DataIntegrityViolationException e) {
			arm.setSuccess(false);
			String eMsg=e.getMessage();
			if(eMsg.contains("actioncode")){
				arm.setMsg("按钮编码不能重复");
			}else{
				arm.setMsg(e.getMessage());
			}
			e.printStackTrace();
		} catch (Exception e) {
			arm.setSuccess(false);
			arm.setMsg("保存失败");
			e.printStackTrace();
		}
		return arm;
	}
	
	
	
	private List<FuncActionEntity> convertToEntities(String[] paramArr) {
		List<FuncActionEntity> returnList = new ArrayList<FuncActionEntity>();
		if(paramArr==null||paramArr.length==0)
			return returnList;
		
		for(String data:paramArr){
			JSONObject jsonObject = new JSONObject();
			String[] properties = data.split("&");
			for(String property : properties){
				String[] nameAndValue =property.split("=");
				if(nameAndValue.length==2){
					try {
						nameAndValue[0] = URLDecoder.decode(nameAndValue[0], "UTF-8");
						nameAndValue[1] = URLDecoder.decode(nameAndValue[1], "UTF-8");
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}
					jsonObject.put(nameAndValue[0], nameAndValue[1]);
				}
			}
			FuncActionEntity obj = (FuncActionEntity)JSONObject.toBean(jsonObject,FuncActionEntity.class);
			returnList.add(obj);
		}
		return returnList;
	}


	
	@Override
	public ActionResultModel<FuncEntity> delete(ServletRequest request, Model model, String[] pks) {
		//return getService().deleFunc(pks);
		ActionResultModel<FuncEntity> arm=new ActionResultModel<>();
		try {
			arm=getService().deleFunc(pks);
		}catch (ServiceException e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
		}catch (Exception e) {
			arm.setSuccess(false);
			arm.setMsg("删除失败");
			e.printStackTrace();
		}
		return arm;
	}
	
	
}
