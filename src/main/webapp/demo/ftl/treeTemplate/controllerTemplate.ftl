package ${packageName};

import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.yy.common.bean.TreeBaseBean;
import com.yy.frame.controller.ActionResultModel;
import com.yy.frame.controller.TreeController;


/**
 * ${entityChinese}controller
 * @ClassName: ${commonEntityName}Controller
 * @author  
 * @date ${createDate}
 */
@Controller
@RequestMapping(value = "${controllerPath}")
public class ${commonEntityName}Controller extends TreeController<${entityName}> {


	private ${commonEntityName}Service getService() {
		return (${commonEntityName}Service) super.baseService;
	}

	/**
	 * 
	 * @Title: view 
	 * @author 
	 * @date ${createDate}
	 * @param @return 设定文件 
	 * @return String 返回类型 
	 * @throws
	 */
	@RequestMapping(method = RequestMethod.GET)
	public String view() {
		return "${jspPath}/${shortEntityName}/${shortEntityName}_main";
	}

	/**
	 * 获取数据
	 * @Title: dataTreeList 
	 * @author 
	 * @date ${createDate}
	 * @param @return 设定文件 
	 * @return List<TreeBaseBean> 返回类型 
	 * @throws
	 */
	@RequestMapping(value = "/dataTreeList")
	@ResponseBody
	private List<TreeBaseBean> dataTreeList() {
		List<TreeBaseBean> treeList=new ArrayList<TreeBaseBean>();
		TreeBaseBean bean=null;
		List<${entityName}> list=(List<${entityName}>) getService().findAll();
		if(list!=null&&list.size()>0){
			for(${entityName} d:list){
				bean=new TreeBaseBean(d.getUuid(), d.getName(), d.getParentId(), false, false,d);
				treeList.add(bean);
			}
		}
		return treeList;
	}
	
	
	/**
	 * 更新
	 */
	@Override
	public ActionResultModel update(ServletRequest request, Model model,${entityName} entity) {
		if(entity.getParent()==null||StringUtils.isEmpty(entity.getParent().getUuid())){
			entity.setParent(null);
		}
		return super.update(request, model, entity);
	}
	
}
