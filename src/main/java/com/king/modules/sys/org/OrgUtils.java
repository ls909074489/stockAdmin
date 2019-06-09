package com.king.modules.sys.org;

import java.util.HashMap;
import java.util.Map;

/**
 * 系统参数工具类
 * 
 * 
 */
public class OrgUtils {

//	@Autowired
//	private static OutletsService outletsService;// 网店资料

	// 系统启动后自动缓存加载参数到该map
	public static Map<String, OrgEntity> cacheMap;

	static {
		cacheMap = new HashMap<String, OrgEntity>();
	}

	/**
	 * 从参数缓存map中获取参数对象
	 * 
	 * @param key
	 * @return
	 */
	public static OrgEntity getEntity(String key) {
		if (cacheMap != null && cacheMap.containsKey(key))
			return cacheMap.get(key);
		else
			return null;
	}

	/**
	 * 更新参数缓存
	 * 
	 * @param entity
	 */
	public static void updateEntity(OrgEntity entity) {
		cacheMap.put(entity.getUuid(), entity);
	}

	/**
	 * 批量更新参数缓存
	 * 
	 * @param pes
	 */
	public static void updateEntitys(Iterable<OrgEntity> entitys) {
		for (OrgEntity entity : entitys) {
			updateEntity(entity);
		}
	}

	/**
	 * 删除参数缓存
	 * 
	 * @param entity
	 */
	public static void removeEntity(OrgEntity entity) {
		cacheMap.remove(entity.getUuid());
	}

	/**
	 * 获取当前组织的网点信息
	 * 
	 * @param orgid
	 * @return
	 */
//	public static OutletsBean getCurrentOutletsEntity() {
//		ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
//		if (user != null) {
//			return outletsService.getOutletsById(user.userEntity.getOrgid());
//		}
//		return null;
//	}

}
