package ${packageName};

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.yy.frame.controller.BaseController;

/**
 * ${entityChinese}controller
 * @ClassName: ${commonEntityName}Controller
 * @author  
 * @date ${createDate}
 */
@Controller
@RequestMapping(value = "${controllerPath}")
public class ${commonEntityName}Controller extends BaseController<${entityName}> {

	@Autowired
	private ${commonEntityName}Service ${shortEntityName}Service;

	/**
	 * 
	 * @Title: ${entityChinese}
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


	
}
