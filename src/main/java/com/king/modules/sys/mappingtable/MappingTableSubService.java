package com.king.modules.sys.mappingtable;

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
 * 
 * @ClassName: AuditColsSubService
 * @author liusheng
 * @date 2017年11月21日 下午5:44:37
 */
@Service
@Transactional(readOnly=true)
public class MappingTableSubService extends BaseServiceImpl<MappingTableSubEntity, String> {

	@Autowired
	private MappingTableSubDao dao;
	@Lazy
	@Autowired
	private MappingTableService mainService;

	
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
	public ActionResultModel<MappingTableEntity> saveSelfAndSubList(MappingTableEntity entity, List<MappingTableSubEntity> subList,
			String[] deletePKs) {
		ActionResultModel<MappingTableEntity> arm = new ActionResultModel<MappingTableEntity>();
      try {
    	// 删除子表一数据
  		if (deletePKs != null && deletePKs.length > 0) {
  			delete(deletePKs);
  		}
  		MappingTableEntity savedEntity = null;
  		// 保存自身数据
  		savedEntity = mainService.save(entity);
  		
  		UserEntity user = ShiroUser.getCurrentUserEntity();
  		// 保存子表数据
  		if(subList!=null&&subList.size()>0){
  			for (MappingTableSubEntity sub : subList) {
  				if(StringUtils.isEmpty(sub.getUuid())){
  	  				sub.setCreator(user.getUuid());
  	  				sub.setCreatorname(user.getUsername());
  	  				sub.setCreatetime(new Date());
  				}
  				sub.setMain(savedEntity);
  				sub.setModifier(user.getUuid());
  				sub.setModifiername(user.getUsername());
  				sub.setModifytime(new Date());
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



	
}
