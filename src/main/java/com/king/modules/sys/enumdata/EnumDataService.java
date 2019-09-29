package com.king.modules.sys.enumdata;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import com.king.frame.controller.ActionResultModel;
import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.BaseServiceImpl;

/**
 * 枚举业务类
 * 
 * @author xuechen
 * @date 2015年12月8日 上午9:58:41
 */
@Service
// @Transactional(rollbackFor={Exception.class})
@Transactional
public class EnumDataService extends BaseServiceImpl<EnumDataEntity, String> {
	
	private static final Log logger = LogFactory.getLog(EnumDataService.class);
	
	@Autowired
	private EnumDataDao dao;

	@Autowired
	private EnumDataSubService subService;

	@Override
	protected IBaseDAO<EnumDataEntity, String> getDAO() {
		return dao;
	}

	public ActionResultModel<EnumDataEntity> saveSelfAndSubList(EnumDataEntity entity, List<EnumDataSubEntity> subList,
			String[] deletePKs) {
		logger.info("saveSelfAndSubList>>>>>>>>>>>>>"+subList);
		ActionResultModel<EnumDataEntity> arm = new ActionResultModel<EnumDataEntity>();
		// try {
		// 删除子表一数据
		if (deletePKs != null && deletePKs.length > 0) {
			subService.delete(deletePKs);
		}
		EnumDataEntity savedEntity = null;
		// 保存自身数据
		savedEntity = this.save(entity);// doAdd(savedEntity);//
		// 保存子表数据
		for (EnumDataSubEntity sub : subList) {
			sub.setEnumdata(savedEntity);
		}
		// 判断子表编码是否重复再保存
		ActionResultModel<EnumDataEntity> result = checkEnumdataValidate(entity, subList);

		// boolean result = true;
		if (result.isSuccess()) {
			subService.save(subList);
		}else {
//			throw new ServiceException(result.getMsg());
			return result;
		}
		// 刷新缓存
		refreshEnumCache(entity.getGroupcode());
		arm.setRecords(entity);
		arm.setSuccess(true);
		return arm;
	}

	/**
	 * 刷新缓存
	 * 
	 * @param enumGroupCode
	 * @throws ServiceException
	 */
	private void refreshEnumCache(String enumGroupCode) throws ServiceException {
		List<EnumDataSubEntity> subList = this.findByGroupcode(enumGroupCode);
		EnumDataUtils.updateEnumData(enumGroupCode, subList);
	}

	/**
	 * 根据组编码返回枚举列表
	 * 
	 * @param groupCode
	 *            枚举组编码
	 * @return
	 * @throws ServiceException
	 */
	public List<EnumDataSubEntity> findByGroupcode(String groupCode) throws ServiceException {
		try {
			return dao.findByGroupcode(groupCode);
		} catch (Exception e) {
			throw new ServiceException(e.getMessage());
		}
	}

	/**
	 * 表体编码唯一校验 需要判断编码和名称都不能重复 @Title: checkEnumdataValidate @author liusheng @date 2016年5月6日 下午2:54:43 @param @param
	 * entity @param @param subList @param @return 设定文件 @return int 返回类型 0:正常 1：编码重复 2：名称重复 @throws
	 */
	private ActionResultModel<EnumDataEntity> checkEnumdataValidate(EnumDataEntity entity, List<EnumDataSubEntity> subList) {
		ActionResultModel<EnumDataEntity> arm = new ActionResultModel<EnumDataEntity>();
		if(CollectionUtils.isEmpty(subList)){
			arm.setSuccess(true);
			return arm;
		}
		Map<String, String> keyMap = new HashMap<String, String>();
		Map<String, String> nameMap = new HashMap<String, String>();
		List<String> msgKeyList = new ArrayList<>();
		List<String> msgNameList = new ArrayList<>();
		for (EnumDataSubEntity newSub : subList) {
			if(!StringUtils.isEmpty(keyMap.get(newSub.getEnumdatakey()))){
				msgKeyList.add(newSub.getEnumdatakey());
			}
			keyMap.put(newSub.getEnumdatakey(), newSub.getEnumdatakey());
			if(!StringUtils.isEmpty(nameMap.get(newSub.getEnumdataname()))){
				msgNameList.add(newSub.getEnumdataname());
			}
			nameMap.put(newSub.getEnumdataname(), newSub.getEnumdataname());
		}
		
		if (subList.size() > keyMap.size()) {
			arm.setSuccess(false);
			arm.setMsg(org.apache.commons.lang.StringUtils.join(msgKeyList, ",")+"不能重复");
			arm.setTotal(1);//设置页面判断类型
			return arm;//1;
		}
		if (subList.size() > nameMap.size()) {
			arm.setSuccess(false);
			arm.setMsg(org.apache.commons.lang.StringUtils.join(msgNameList, ",")+"不能重复");
			arm.setTotal(2);//设置页面判断类型
			return arm;// 2;
		}
		List<EnumDataSubEntity> list = subService.findByGroupId(entity.getUuid());
		if (list != null && list.size() > 0) {
			for (EnumDataSubEntity oldSub : list) {
				for (EnumDataSubEntity newSub : subList) {
					if (oldSub.getEnumdatakey().equals(newSub.getEnumdatakey())
							&& !oldSub.getUuid().equals(newSub.getUuid())) {
						arm.setSuccess(false);
						arm.setMsg(newSub.getEnumdatakey()+"不能重复");
						arm.setTotal(1);//设置页面判断类型
						return arm;// 1;
					}
					if (oldSub.getEnumdataname().equals(newSub.getEnumdataname())
							&& !oldSub.getUuid().equals(newSub.getUuid())) {
						arm.setSuccess(false);
						arm.setMsg(newSub.getEnumdataname()+"不能重复");
						arm.setTotal(2);//设置页面判断类型
						return arm;//  2;
					}
				}
			}
		}
		arm.setSuccess(true);
		arm.setMsg("");
		return arm;
	}

	/**
	 * 获取枚举数据MAP，以groupCode为key
	 * 
	 * @return
	 */
	public Map<String, List<EnumDataSubEntity>> getEnumDataMap() throws ServiceException {
		Map<String, List<EnumDataSubEntity>> map = new HashMap<String, List<EnumDataSubEntity>>();
		try {
			Iterable<EnumDataEntity> list = this.findAll(getDefaultSort());
			List<EnumDataSubEntity> sublist = (List<EnumDataSubEntity>) subService
					.findAll(new Sort(Sort.Direction.ASC, "showorder"));
			// 处多次查询数据库，效率问题有待测试
			for (EnumDataEntity en : list) {
				List<EnumDataSubEntity> rtulist = new ArrayList<EnumDataSubEntity>();
				String grpCode = en.getGroupcode();
				for (EnumDataSubEntity enumDataSubEntity : sublist) {
					if (en.getUuid().equals(enumDataSubEntity.getEnumdata().getUuid())) {
						rtulist.add(enumDataSubEntity);
					}
				}
				// List<EnumDataSubEntity> sublist = subService.findByGroupId(en.getUuid());
				map.put(grpCode, rtulist);
			}
		} catch (Exception e) {
			throw new ServiceException(e.getMessage());
		}

		return map;
	}

	
	public EnumDataEntity getByGroupcode(String groupCode) {
		return dao.getByGroupcode(groupCode);
	}
}
