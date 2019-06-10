package com.king.modules.sys.demo;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.binary.Base64;
import org.hibernate.service.spi.ServiceException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.king.common.bean.TreeBaseBean;
import com.king.common.utils.DelAllFile;
import com.king.common.utils.FileUtils;
import com.king.common.utils.FileZip;
import com.king.common.utils.Freemarker;


/**
 * 
 * @ClassName: DemoControllerw
 * @author liusheng
 * @date 2015年12月18日 上午10:48:49
 */
@Controller
@RequestMapping(value = "/demo")
public class DemoController {
	@RequestMapping(value = "/upload", method = RequestMethod.GET)
	public String view() {
		return "modules/demo/upload";
	}

	/**
	 * shiro测试页面 @Title: shiro @author liusheng @date 2015年12月28日 下午4:30:15 @param @return 设定文件 @return String
	 * 返回类型 @throws
	 */
	@RequestMapping(value = "/shiro", method = RequestMethod.GET)
	public String shiro() {
		return "modules/demo/shiro_list";
	}

	/**
	 * 弹出提示框例子 @Title: dialog @author liusheng @date 2015年12月30日 下午4:47:03 @param @return 设定文件 @return String
	 * 返回类型 @throws
	 */
	@RequestMapping(value = "/dialog", method = RequestMethod.GET)
	public String dialog() {
		return "modules/demo/dialog_list";
	}

	/**
	 * 树例子 @Title: tree @author liusheng @date 2016年1月4日 上午11:42:13 @param @return 设定文件 @return String 返回类型 @throws
	 */
	@RequestMapping(value = "/tree", method = RequestMethod.GET)
	public String tree(String type, Model model) {
		model.addAttribute("type", type);
		return "modules/demo/tree_list";
	}

	/**
	 * 表单例子 @Title: form @author liusheng @date 2016年1月4日 上午11:42:05 @param @return 设定文件 @return String 返回类型 @throws
	 */
	@RequestMapping(value = "/form", method = RequestMethod.GET)
	public String form() {
		return "modules/demo/form_list";
	}

	/**
	 * 代码生成 @Title: code @author liusheng @date 2016年1月4日 上午11:41:54 @param @return 设定文件 @return String 返回类型 @throws
	 */
	@RequestMapping(value = "/code", method = RequestMethod.GET)
	public String code() {
		return "modules/demo/code_list";
	}

	@RequestMapping(value = "/{toPage}", method = RequestMethod.GET)
	public String toPage(@PathVariable String toPage) {
		return "modules/demo/" + toPage;
	}

	
	
	
	/**
	 * 跳到文件列表
	 * @Title: toPage 
	 * @author liusheng
	 * @date 2016年11月22日 上午9:40:46 
	 * @param @param request
	 * @param @return 设定文件 
	 * @return String 返回类型 
	 * @throws
	 */
	@RequestMapping(value = "/toListFiles")
	public String toPage(HttpServletRequest request,Model model) {
		String showType=request.getParameter("showType");
		if(StringUtils.isEmpty(showType)){
			model.addAttribute("showType", 1);
		}else{
			model.addAttribute("showType", 0);
		}
		return "modules/demo/listFile";
	}
	
	
	/**
	 * 遍历递归获取文件夹
	 * @Title: dataFiles 
	 * @author liusheng
	 * @date 2016年11月22日 上午10:20:07 
	 * @param @param request
	 * @param @return 设定文件 
	 * @return List<TreeBaseBean> 返回类型 
	 * @throws
	 */
	@ResponseBody
	@RequestMapping(value = "/dataFiles")
	public List<TreeBaseBean> dataFiles(HttpServletRequest request) {
		List<TreeBaseBean> filelist=new ArrayList<TreeBaseBean>();
		String path=new String(Base64.decodeBase64(request.getParameter("path").getBytes()));
		System.out.println(path);
		getFiles(path,0,"0",filelist);
		return filelist;
	}

	
	
	 /*
	  * 通过递归得到某一路径下所有的目录及其文件
	  */
	private List<TreeBaseBean> getFiles(String filePath,int level,String pid,List<TreeBaseBean> filelist){
		level++;
		File root = new File(filePath);
	    File[] files = root.listFiles();
	    int j=0;
	    for(File file:files){     
	     if(file.isDirectory()){
	    	 j++;
		     filelist.add(new TreeBaseBean(pid+"_"+j, file.getName(), pid+"", false, false));
		     // 递归调用	      
	         getFiles(file.getAbsolutePath(),level,pid+"_"+j,filelist);
	     }   
	   }
 	   return filelist; 
	}   
	    
	    
	    
	/**
	 * 
	 * @Title: createCode 
	 * @author liusheng
	 * @date 2016年11月21日 下午3:22:13 
	 * @param @param request
	 * @param @param response
	 * @param @param packageName
	 * @param @param entityName 实体名
	 * @param @param colName 实体的字段名
	 * @param @param colNameDb 生成表的字段名
	 * @param @param colDesc 字段的描述
	 * @param @param eleType  显示的类型，文本框、下拉框...
	 * @param @param colType
	 * @param @param isShow
	 * @param @param extendsEntity
	 * @param @param tableName
	 * @param @param templateType
	 * @param @param jspPath
	 * @param @param entityChinese
	 * @param @param controllerPath
	 * @param @throws Exception 设定文件 
	 * @return void 返回类型 
	 * @throws
	 */
	@RequestMapping(value = "/createCode")
	public void createCode(HttpServletRequest request, HttpServletResponse response, String packageName,
			String entityName, String[] colName,String []colNameDb, String[] colDesc,String []eleType, String[] colType,String []colLength,
			String[] isShow,String extendsEntity, String tableName, String templateType, String jspPath, String entityChinese,
			String controllerPath) throws Exception {

		Map<String, Object> root = new HashMap<String, Object>(); // 创建数据模型

		String shortEntityName = entityName.replaceAll("Entity", "").toLowerCase();
		String commonEntityName = entityName.replaceAll("Entity", "").substring(0, 1).toUpperCase()
				+ entityName.replaceAll("Entity", "").substring(1, shortEntityName.length());

		List<String> colNameList = new ArrayList<String>();
		if (colName != null && colName.length > 0) {
			for (String cName : colName) {
				colNameList.add(cName);
			}
		}

		List<String> colDescList = new ArrayList<String>();
		if (colDesc != null && colDesc.length > 0) {
			for (String cDesc : colDesc) {
				colDescList.add(cDesc);
			}
		}

		List<String[]> fieldList = new ArrayList<String[]>(); // 属性集合 ========4
		if (colName != null && colName.length > 0) {
			String col = "";
			String colNDb="";
			for (int i = 0; i < colName.length; i++) {
				col = colName[i].substring(0, 1).toUpperCase() + colName[i].substring(1, colName[i].length());
				colNDb=colNameDb[i];
				if(StringUtils.isEmpty(colNameDb)){
					colNDb=colName[i];
				}
				colNDb=colNDb.toLowerCase();
				fieldList.add(new String[] { colName[i], colDesc[i], colType[i], col, isShow[i],colNDb,eleType[i],colLength[i] }); // 属性放到集合里面
			}
		}
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy年mm月dd日 hh:HH:ss");

		jspPath=jspPath.replaceAll("\\\\", "/");
		packageName=packageName.replaceAll("\\\\", ".");
		
		
		root.put("packageName", packageName);// 包名，如com.meizu.modules
		root.put("jspPath", jspPath);// 包名，如com.meizu.modules
		root.put("entityName", entityName);// 实体名 ，如 UserEntity
		root.put("entityChinese", entityChinese);// 实体名 ，如 UserEntity
		root.put("extendsEntity", extendsEntity);// 实体名继承的父类
		root.put("shortEntityName", shortEntityName);// 短实体名，如user
		root.put("commonEntityName", commonEntityName);// 普通的实体类名，如User
		root.put("colNameList", colNameList);// 字段名
		root.put("colDescList", colDescList);// 字段名描述
		root.put("fieldList", fieldList);// 封装后的列值
		root.put("createDate", sdf.format(new Date()));// 生成的时间
		root.put("controllerPath", controllerPath);// 生成的时间
		if (StringUtils.isEmpty(tableName)) {
			root.put("tableName", "yy_" + shortEntityName);// 表名字
		} else {
			root.put("tableName", tableName);// 表名字
		}

		root.put("contextPath", "${pageContext.request.contextPath}");
		root.put("ctx", "${ctx}");
		root.put("serviceurl", "${serviceurl}");

		String path = request.getServletContext().getRealPath("/");

		DelAllFile.delFolder(path + "demo/ftl/code"); // 生成代码前,先清空之前生成的代码

		String filePath = "demo/ftl/code/"; // 存放路径

		/* ============================================================================================= */
		if (templateType.equals("1")) {
			String ftlPath = path + "demo/ftl/clientPaging"; // 前端分页

			Freemarker.printFile("entityTemplate.ftl", root, "/" + commonEntityName + "Entity.java", path + filePath,
					ftlPath);
			Freemarker.printFile("controllerTemplate.ftl", root, "/" + commonEntityName + "Controller.java",
					path + filePath, ftlPath);
			Freemarker.printFile("serverTemplate.ftl", root, "/" + commonEntityName + "Service.java", path + filePath,
					ftlPath);
			Freemarker.printFile("daoTemplate.ftl", root, "/" + commonEntityName + "Dao.java", path + filePath,
					ftlPath);

			Freemarker.printFile("jspMain.ftl", root, "/" + shortEntityName + "_main.jsp", path + filePath, ftlPath);
			//Freemarker.printFile("jspList.ftl", root, "/" + shortEntityName + "_list.jsp", path + filePath, ftlPath);
			Freemarker.printFile("jspEdit.ftl", root, "/" + shortEntityName + "_edit.jsp", path + filePath, ftlPath);
			Freemarker.printFile("jspDetail.ftl", root, "/" + shortEntityName + "_detail.jsp", path + filePath,
					ftlPath);
			Freemarker.printFile("jspScript.ftl", root, "/" + shortEntityName + "_script.jsp", path + filePath,
					ftlPath);
		}
		if (templateType.equals("3")) {
			String ftlPath = path + "demo/ftl/serverPaging"; // 服务器端分页

			Freemarker.printFile("entityTemplate.ftl", root, "/" + commonEntityName + "Entity.java", path + filePath,
					ftlPath);
			Freemarker.printFile("controllerTemplate.ftl", root, "/" + commonEntityName + "Controller.java",
					path + filePath, ftlPath);
			Freemarker.printFile("serverTemplate.ftl", root, "/" + commonEntityName + "Service.java", path + filePath,
					ftlPath);
			Freemarker.printFile("daoTemplate.ftl", root, "/" + commonEntityName + "Dao.java", path + filePath,
					ftlPath);

			Freemarker.printFile("jspMain.ftl", root, "/" + shortEntityName + "_main.jsp", path + filePath, ftlPath);
			Freemarker.printFile("jspList.ftl", root, "/" + shortEntityName + "_list.jsp", path + filePath, ftlPath);
			Freemarker.printFile("jspEdit.ftl", root, "/" + shortEntityName + "_edit.jsp", path + filePath, ftlPath);
			Freemarker.printFile("jspDetail.ftl", root, "/" + shortEntityName + "_detail.jsp", path + filePath,
					ftlPath);
			Freemarker.printFile("jspScript.ftl", root, "/" + shortEntityName + "_script.jsp", path + filePath,
					ftlPath);
		} else if (templateType.equals("2")) {
			String ftlPath = path + "demo/ftl/treeTemplate"; // ftl路径

			Freemarker.printFile("entityTemplate.ftl", root, "/" + commonEntityName + "Entity.java", path + filePath,
					ftlPath);
			Freemarker.printFile("controllerTemplate.ftl", root, "/" + commonEntityName + "Controller.java",
					path + filePath, ftlPath);
			Freemarker.printFile("serverTemplate.ftl", root, "/" + commonEntityName + "Service.java", path + filePath,
					ftlPath);
			Freemarker.printFile("daoTemplate.ftl", root, "/" + commonEntityName + "DAO.java", path + filePath,
					ftlPath);

			Freemarker.printFile("jspMain.ftl", root, "/" + shortEntityName + "_main.jsp", path + filePath, ftlPath);
			Freemarker.printFile("jspScript.ftl", root, "/" + shortEntityName + "_script.jsp", path + filePath,
					ftlPath);
			
		
		}

		// /*生成的全部代码压缩成zip文件*/
		FileZip.zip(path + filePath, path + "demo/ftl/code.zip");

		// /*下载代码*/
		fileDownload(response,request, path + "demo/ftl/code.zip", "code.zip");
		
		//将文件生成到workspace的路径下
		///genOnWorkspace(path, filePath, request.getParameter("javaWorkspace"), request.getParameter("jspWorkspace"));
		
	}
	
	/**
	 * 在工作空间生成代码
	 * @Title: genOnWorkspace 
	 * @author liusheng
	 * @date 2016年11月21日 下午9:20:48 
	 * @param @param path
	 * @param @param filePath
	 * @param @param javaWorkspace
	 * @param @param jspWorkspace 设定文件 
	 * @return void 返回类型 
	 * @throws
	 */
	public void genOnWorkspace(String path,String filePath,String javaWorkspace,String jspWorkspace){
		File f = new File(path + filePath);
		File[] fs	= f.listFiles();
		FileInputStream fis = null;
        FileOutputStream fos =null;
		for(int i=0;i<fs.length;i++){
			try {
				fis = new FileInputStream(path + filePath+"\\"+fs[i].getName());
				if(fs[i].getName().indexOf("java")>0){
			        fos = new FileOutputStream(javaWorkspace+"\\"+fs[i].getName());
				}else{
					fos = new FileOutputStream(jspWorkspace+"\\"+fs[i].getName());
				}
				int len = 0;
		        byte[] buf = new byte[1024];
		        while ((len = fis.read(buf)) != -1) {
		            fos.write(buf, 0, len);
		        }
		        
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				try {
					fis.close();
					fos.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	
	private static void fileDownload(final HttpServletResponse response,HttpServletRequest request,String filePath, String fileName){
		filePath=getWinLinux(filePath);
		OutputStream outputStream = null;
		try {
			byte[] data = FileUtils.toByteArray2(filePath);//FileUtil.toByteArray2(filePath);
			response.reset();
			response.addHeader("Content-Disposition",
					"attachment;filename=" + new String(fileName.getBytes("GB2312"), "ISO-8859-1"));
			response.addHeader("Content-Length", "" + data.length);
			response.setContentType("application/octet-stream;charset=UTF-8");
			outputStream = new BufferedOutputStream(response.getOutputStream());
			outputStream.write(data);
			outputStream.flush();
		}catch (Exception e) {
			e.printStackTrace();
			throw new ServiceException(e.getMessage());
		}finally {
			try {
				outputStream.close();
				response.flushBuffer();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	public static String getWinLinux(String path) {
		// windows下
		if ("\\".equals(File.separator)) {
			path = path.replace("/", "\\");
			//path = path.substring(0, path.length() - 1);
		}
		// linux下
		if ("/".equals(File.separator)) {
			path = path.replace("\\", "/");
		}
		path=path.replaceAll("\\.\\.", "");//去掉 .. 返回上级路径
		return path;
	}
	
	
	

	@RequestMapping(value = "/address", method = RequestMethod.GET)
	public String address() {
		return "modules/demo/addressfold_list";
	}

	@RequestMapping(value = "/echarts", method = RequestMethod.GET)
	public String echarts() {
		return "modules/demo/echarts_list";
	}

	// @ResponseBody
	// @RequestMapping(value = "/createTestUser", method = RequestMethod.GET)
	// public String createTestUser() {
	// for(int i=1;i<501;i++){
	// UserEntity user=new UserEntity();
	// user.setOrgid("1911ae16-cc04-4166-acad-34e5fbd9ea40");
	// user.setOrgname("珠海魅力科技有限公司");
	// String a=i+"";
	// if(a.length()==1){
	// a="00"+a;
	// }else if(a.length()==2){
	// a="0"+a;
	// }
	// user.setLoginname("mztest"+a);
	// user.setUsername("mztest"+a);
	// user.setPassword("1");
	// user.setUsertype(1);
	//
	// //userService.entryptPassword(user);
	// userService.doAdd(user);
	//
	// userRoleService.selecRoleUser("141",user.getUuid());
	// }
	//
	//
	// return "初始化成功";
	// }
}
