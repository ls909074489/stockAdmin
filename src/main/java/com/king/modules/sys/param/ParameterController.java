package com.king.modules.sys.param;

import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.servlet.ServletRequest;

import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.king.frame.controller.ActionResultModel;
import com.king.frame.controller.BaseController;

@Controller
@RequestMapping(value = "/sys/param")
public class ParameterController extends BaseController<ParameterEntity> {

	@Autowired
	private ParameterService paramService;
	
	
	@RequestMapping(method = RequestMethod.GET)
	public String view() {
		return "modules/sys/param/param_main";
	}

	/**
	 * 重写查询方法，只显示参数组不为空的，为空的则是自定义的系统参数，如邮件发送的用户名和密码
	 */
	@Override
	public ActionResultModel<ParameterEntity> query(ServletRequest request, Model model) {
		ActionResultModel<ParameterEntity> arm = new ActionResultModel<ParameterEntity>();
		try {
			Specification<ParameterEntity> spec = new Specification<ParameterEntity>() {
				@Override
				public Predicate toPredicate(Root<ParameterEntity> root,
						CriteriaQuery<?> query, CriteriaBuilder cb) {
//					Predicate p1 = cb.isNotNull(root.get("groudcode"));
					
					Predicate p1 = cb.equal(root.get("status"), 1);
					Predicate p2 = cb.equal(root.get("isshow"), true);//判断页面时是否显示
					query.where(cb.and(p1, p2)); // cb.and(p3,cb.or(p1,p2));
					query.orderBy(cb.desc(root.get("modifytime").as(String.class)));
			        return query.getRestriction();  
				}
			};
			List<ParameterEntity> list = paramService.findAll(spec);
//			List<ParameterEntity> list = (List<ParameterEntity>) paramService.findAll();
			arm.setRecords(list);
			arm.setTotal(list.size());
			arm.setTotalPages(1);
			arm.setSuccess(true);
		} catch (ServiceException e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
			e.printStackTrace();
		}

		return arm;
	}

	
	
}
