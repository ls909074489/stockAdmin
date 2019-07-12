package com.king.modules.info.projectinfo;

import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import com.king.frame.controller.ActionResultModel;
import com.king.frame.dao.IBaseDAO;
import com.king.frame.security.ShiroUser;
import com.king.frame.service.BaseServiceImpl;
import com.king.modules.sys.user.UserEntity;

/**
 * OrderSubService
 * @author liusheng
 *
 */
@Service
@Transactional(readOnly=true)
public class ProjectSubService extends BaseServiceImpl<ProjectSubEntity, String> {

	@Autowired
	private ProjectSubDao dao;
	@Lazy
	@Autowired
	private ProjectInfoService mainService;

	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	protected IBaseDAO getDAO() {
		return dao;
	}

	/**
	 * 保存
	 * @param entity
	 * @param subList
	 * @param deletePKs
	 * @return
	 */
	@Transactional
	public ActionResultModel<ProjectInfoEntity> saveSelfAndSubList(ProjectInfoEntity entity, List<ProjectSubEntity> subList,
			String[] deletePKs) {
		ActionResultModel<ProjectInfoEntity> arm = new ActionResultModel<ProjectInfoEntity>();
      try {
    	// 删除子表一数据
  		if (deletePKs != null && deletePKs.length > 0) {
  			delete(deletePKs);
  		}
  		ProjectInfoEntity savedEntity = null;
  		// 保存自身数据
  		savedEntity = mainService.save(entity);
  		
  		UserEntity user = ShiroUser.getCurrentUserEntity();
  		// 保存子表数据
  		if(subList!=null&&subList.size()>0){
  			for (ProjectSubEntity sub : subList) {
  				if(StringUtils.isEmpty(sub.getUuid())){
  	  				sub.setCreator(user.getUuid());
  	  				sub.setCreatorname(user.getUsername());
  	  				sub.setCreatetime(new Date());
  				}
  				sub.setMain(savedEntity);
  				sub.setMid(savedEntity.getUuid());
  				sub.setModifier(user.getUuid());
  				sub.setModifiername(user.getUsername());
  				sub.setModifytime(new Date());
  				sub.setActualAmount(sub.getPlanAmount());
  			}
  			save(subList);
  		}
  		arm.setRecords(savedEntity);
  		arm.setSuccess(true);
      } catch (Exception e) {
    	  arm.setSuccess(false);
    	  arm.setMsg(e.getMessage());
    	  e.printStackTrace();
      }
	  return arm;
	}

	
	@Transactional(readOnly=true)
	public List<ProjectSubEntity> findByMain(String mainId) {
		return dao.findByMain(mainId);
	}

	
	/**
	 * 更新条形码
	 * @param newBarcode
	 * @param subId
	 * @return
	 */
	@Transactional
	public ActionResultModel<ProjectSubEntity> updateBarcode(String newBarcode, String subId) {
		ActionResultModel<ProjectSubEntity> arm = new ActionResultModel<ProjectSubEntity>();
		ProjectSubEntity sub = getOne(subId);
		sub.setBarcode(newBarcode);
		arm.setSuccess(true);
		arm.setMsg("操作成功");
		return arm;
	}



	
}
