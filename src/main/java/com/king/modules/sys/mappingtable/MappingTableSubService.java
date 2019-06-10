package com.king.modules.sys.mappingtable;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.king.frame.controller.ActionResultModel;
import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.BaseServiceImpl;

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
  		
  		// 保存子表数据
  		if(subList!=null&&subList.size()>0){
  			for (MappingTableSubEntity sub : subList) {
  				sub.setMain(savedEntity);
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
