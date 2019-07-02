package com.king.modules.sys.tabconstr;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.king.frame.controller.ActionResultModel;
import com.king.frame.controller.BaseController;

/**
 * 表的外键信息
 * @ClassName: TableConstraintsController
 * @author liusheng
 * @date 2016年6月17日 下午3:31:05
 */
@Controller
@RequestMapping(value = "/sys/tabconstr")
public class TableConstraintsController extends BaseController<TableConstraintsEntity> {
	
	@Autowired
	private TableConstraintsService constraintService;
	
	/**
	 * 列表
	 * @Title: view 
	 * @author liusheng
	 * @date 2016年6月17日 下午4:12:03 
	 * @param @return 设定文件 
	 * @return String 返回类型 
	 * @throws
	 */
	@RequestMapping(method = RequestMethod.GET)
	public String view() {
		return "modules/sys/tabconstr/tabconstr_main";
	}
	
	
	/**
	 * 拉取外键信息
	 * @Title: extractConst 
	 * @author liusheng
	 * @date 2016年6月17日 下午4:11:41 
	 * @param @return 设定文件 
	 * @return String 返回类型 
	 * @throws
	 */
	@ResponseBody
	@RequestMapping("/extractConst")
	public ActionResultModel<TableConstraintsEntity> extractConst() {
		return constraintService.extractConst();
	}
	
	/**
	 * 保存外键信息
	 * @Title: saveConst 
	 * @author liusheng
	 * @date 2016年6月17日 下午4:53:51 
	 * @param @return 设定文件 
	 * @return ActionResultModel<TableConstraintsEntity> 返回类型 
	 * @throws
	 */
	@ResponseBody
	@RequestMapping("/saveConst")
	public ActionResultModel<TableConstraintsEntity> saveConst() {
		return constraintService.saveConst();
	}

}
