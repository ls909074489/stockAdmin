package com.king.modules.sys.imexlate;

import java.util.HashMap;
import java.util.Map;

/**
 * 导入导出工具类
 * @ClassName: ImexlateUtil
 * @author liusheng
 * @date 2016年9月19日 上午11:22:44
 */
public class ImexlateUtil {

	// 系统启动后自动缓存加载导入导出模板到该map
	public static Map<String, ImexlateEntity> mapImexlate;

	static {
		mapImexlate = new HashMap<String, ImexlateEntity>();
	}

	/**
	 * 从导入导出模板缓存map中获取导入导出模板对象
	 * @Title: getParamEntity 
	 * @author liusheng
	 * @date 2016年9月19日 上午11:25:12 
	 * @param @param coding
	 * @param @return 设定文件 
	 * @return ImexlateEntity 返回类型 
	 * @throws
	 */
	public static ImexlateEntity getImexlateEntity(String coding) {
		if (mapImexlate != null && mapImexlate.containsKey(coding)){
			return mapImexlate.get(coding);
		}else{
			return null;
		}
	}


	/**
	 * 更新导入导出模板缓存
	 * @Title: updateImexlate 
	 * @author liusheng
	 * @date 2016年9月19日 上午11:25:44 
	 * @param @param pe 设定文件 
	 * @return void 返回类型 
	 * @throws
	 */
	public static void updateImexlate(ImexlateEntity pe) {
		mapImexlate.put(pe.getCoding(), pe);
	}

	/**
	 * 批量更新导入导出模板缓存
	 * @Title: updateParam 
	 * @author liusheng
	 * @date 2016年9月19日 上午11:25:52 
	 * @param @param pes 设定文件 
	 * @return void 返回类型 
	 * @throws
	 */
	public static void updateImexlate(Iterable<ImexlateEntity> pes) {
		for (ImexlateEntity pe : pes) {
			updateImexlate(pe);
		}
	}

	/**
	 * 删除导入导出模板缓存
	 * @Title: removeImexlate 
	 * @author liusheng
	 * @date 2016年9月19日 上午11:25:59 
	 * @param @param pe 设定文件 
	 * @return void 返回类型 
	 * @throws
	 */
	public static void removeImexlate(ImexlateEntity pe) {
		mapImexlate.remove(pe.getCoding());
	}

	
	/**
	 * 删除导入导出模板缓存
	 * @Title: removeImexlate 
	 * @author liusheng
	 * @date 2016年9月19日 上午11:28:16 
	 * @param @param coding 设定文件 
	 * @return void 返回类型 
	 * @throws
	 */
	public static void removeImexlate(String coding) {
		mapImexlate.remove(coding);
	}
}
