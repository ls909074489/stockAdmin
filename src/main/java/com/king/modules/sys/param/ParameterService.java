package com.king.modules.sys.param;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.BaseServiceImpl;

/**
 * 系统参数 服务类
 * 
 */
@Component
@Transactional
public class ParameterService extends BaseServiceImpl<ParameterEntity, String> {

	@Autowired
	private ParameterDAO dao;

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	protected IBaseDAO getDAO() {
		return dao;
	}

	@Override
	public void delete(String pk) throws ServiceException {
		ParameterEntity entity = this.getOne(pk);
		if (entity.getSys() != null && entity.getSys())
			throw new ServiceException("不能删除系统参数");
		else {
			try {
				this.delete(entity);
			} catch (Exception e) {
				throw new ServiceException(e.getMessage());
			}
		}
	}

	public ParameterEntity getByCode(String paramCode) throws ServiceException {
		try {
			return dao.findByParamtercode(paramCode);
		} catch (Exception e) {
			throw new ServiceException(e.getMessage());
		}
	}

	public Map<String, String> getByGroupCode(String groupCode) {
		List<ParameterEntity> list = dao.findByGroudcode(groupCode);
		Map<String, String> map = new HashMap<String, String>(list.size());
		for (ParameterEntity param : list) {
			map.put(param.getParamtercode(), param.getParamtervalue());
		}
		return map;
	}

	/**
	 * 获取参数值
	 * 
	 * @param paramCode
	 * @return
	 * @throws ServiceException
	 */
	public String getParamValue(String paramCode) throws ServiceException {
		ParameterEntity p = getOne(paramCode);
		if (p != null)
			return p.getParamtervalue();
		else {
			throw new ServiceException("未找到参数[" + paramCode + "]");
		}
	}

	@Override
	public ParameterEntity save(ParameterEntity entity) throws ServiceException {
		ParameterEntity pe = super.save(entity);
		// 同时更新缓存
		ParameterUtil.updateParam(pe);
		return pe;
	}

	@Override
	public Iterable<ParameterEntity> save(Iterable<ParameterEntity> entities) throws ServiceException {
		Iterable<ParameterEntity> pes = super.save(entities);
		// 同时更新缓存
		ParameterUtil.updateParam(pes);
		return pes;
	}

	@Override
	public void delete(ParameterEntity entity) throws ServiceException {
		super.delete(entity);
		// 同时删除缓存
		ParameterUtil.removeParam(entity);
	}

	/**
	 * 设置为默认参数
	 * 
	 * @param pk
	 * @return
	 * @throws ServiceException
	 */
	public ParameterEntity setDefaultValue(String pk) throws ServiceException {
		ParameterEntity pe = this.getOne(pk);
		if (pe != null) {
			pe.setParamtervalue(pe.getDefaultvalue());
			this.save(pe);
		}
		return pe;
	}
}
