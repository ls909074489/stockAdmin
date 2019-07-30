package com.king.modules.info.streamborrow;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.beans.factory.annotation.Autowired;
import javax.servlet.ServletRequest;
import org.springframework.stereotype.Controller;
import com.king.frame.controller.BaseController;
import org.springframework.ui.Model;

/**
 * 挪料
 * @author ls2008
 * @date 2019-07-30 16:02:33
 */
@Controller
@RequestMapping(value = "/info/streamborrow")
public class StreamBorrowController extends BaseController<StreamBorrowEntity> {

	@Autowired
	private StreamBorrowService service;

	/**
	 * 
	 * @Title: listView
	 * @author ls2008
	 * @date 2019-07-30 16:02:33
	 * @param @param model
	 * @param @return 设定文件 
	 * @return String 返回类型 
	 * @throws
	 */
	@RequestMapping("/list")
	public String listView(Model model) {
		return "modules/info/streamborrow/streamborrow_list";
	}

	@Override
	public String addView(Model model, ServletRequest request) {
		return "modules/info/streamborrow/streamborrow_edit";
	}

	@Override
	public String editView(Model model, ServletRequest request, StreamBorrowEntity entity) {
		return "modules/info/streamborrow/streamborrow_edit";
	}

	@Override
	public String detailView(Model model, ServletRequest request, StreamBorrowEntity entity) {
		return "modules/info/streamborrow/streamborrow_detail";
	}

}