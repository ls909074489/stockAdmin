package com.king.modules.sys.alertmsg;

import java.text.MessageFormat;
import java.util.HashMap;
import java.util.Map;

/**
 * 消息提示工具类
 * 
 * 
 */
public class YYMsg {
	// 系统启动后自动缓存加载参数到该map
	public static Map<String, AlertmsgEntity> cacheMap;

	static {
		cacheMap = new HashMap<String, AlertmsgEntity>();
	}

	/**
	 * 从参数缓存map中获取参数对象
	 * 
	 * @param key
	 * @return
	 */
	public static AlertmsgEntity getEntity(String key) {
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
	public static void updateEntity(AlertmsgEntity entity) {
		cacheMap.put(entity.getAcode(), entity);
	}

	/**
	 * 批量更新参数缓存
	 * 
	 * @param pes
	 */
	public static void updateEntitys(Iterable<AlertmsgEntity> entitys) {
		for (AlertmsgEntity entity : entitys) {
			updateEntity(entity);
		}
	}

	/**
	 * 删除参数缓存
	 * 
	 * @param entity
	 */
	public static void removeEntity(AlertmsgEntity entity) {
		cacheMap.remove(entity.getAcode());
	}

	/**
	 * 从参数缓存map中获取参数对象
	 * 
	 * @param key
	 * @return
	 */
	public static String alertMsg(String key, String... msg) {
		if (cacheMap != null && cacheMap.containsKey(key)) {
			String alertmsg = cacheMap.get(key).getAlertmsg();
			if (msg == null || msg.length == 0) {
				return alertmsg;
			} else {
				MessageFormat form = new MessageFormat(alertmsg);
				return form.format(msg);
			}
		}

		return null;
	}

}
