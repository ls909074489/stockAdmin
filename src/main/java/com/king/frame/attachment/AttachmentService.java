package com.king.frame.attachment;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import com.king.common.fileupload.FileUploadFactory;
import com.king.common.fileupload.FileUploadHandle;
import com.king.common.utils.DateUtil;
import com.king.frame.dao.IBaseDAO;
import com.king.frame.security.ShiroUser;
import com.king.frame.service.BaseServiceImpl;
import com.king.frame.utils.RequestUtil;
import com.king.frame.utils.ZipUtil;
import com.king.modules.sys.enumdata.EnumDataUtils;
import com.king.modules.sys.param.ParameterUtil;
import com.king.modules.sys.user.UserEntity;

/*
*	版权信息 (c) RAP 保留所有权利.
*
*	维护记录
*	新建： RAP Codegen
*   修改：
*/
/**
 * 附件库 服务类
 * 
 * @author RAP Team
 *
 */

@Service
@Transactional(rollbackFor = { Exception.class })
public class AttachmentService extends BaseServiceImpl<AttachmentEntity, String> {
	public static final String CONTENT_TYPE = "application/octet-stream; charset=utf-8";
	public static final String CONTENT_LENGTH = "Content-Length";
	public static final String CONTENT_DISPOSITION = "Content-Disposition";
	FileUploadHandle handle;
	@Autowired
	private AttachmentDAO dao;

	@SuppressWarnings("unchecked")
	@Override
	protected IBaseDAO getDAO() {
		return dao;
	}

	/**
	 * 
	 * 附件及附件实体信息保存
	 * 
	 * @date 2013-12-17 上午10:36:02
	 * @param files
	 * @param entity
	 * @return
	 * @throws ServiceException
	 * @throws IOException
	 */
	public List<AttachmentEntity> save(List<MultipartFile> files, AttachmentEntity entity)
			throws ServiceException, IOException {
		List<AttachmentEntity> entities = new ArrayList<AttachmentEntity>();
		// UserEntity loginUser = ShiroUser.getCurrentUserEntity();
		boolean hasException = false;
		for (MultipartFile file : files) {
			AttachmentEntity attach = new AttachmentEntity();
			attach.setEntityType(entity.getEntityType());
			attach.setEntityUuid(entity.getEntityUuid());
			attach.setAttaType(entity.getAttaType());
			attach.setTag(entity.getTag());
			String fileName = file.getOriginalFilename();
			attach.setFileName(fileName);
			attach.setFileSize(String.valueOf(file.getSize()));
			// attach.setFileType(file.getContentType());
			attach.setFileType(fileName.substring(fileName.lastIndexOf(".") + 1, fileName.length()).toUpperCase());
			attach.setUploadDate(new Date()); // 上传时间
			// attach.setUploadUser(loginUser);//上传用户
			UserEntity user = ShiroUser.getCurrentUserEntity();
			attach.setUploadUserId(user.getUuid());
			attach.setUploadUserName(user.getUsername());
			attach.setOrgiName(entity.isOrgiName());
			try {
				super.save(attach);
				if (upLoad(file, attach)) {
					entities.add(attach);
				} else {
					hasException = true;
					break;
				}
			} catch (IOException e) {
				hasException = true;
				break;
			}
		}
		if (hasException) {
			delete(entities);
		}
		return entities;
	}

	public List<AttachmentEntity> save(List<MultipartFile> files, AttachmentEntity entity, String[] deleteFilePKs,
			String[] fileId, String[] fileClass, String[] fileMemo) {
		List<AttachmentEntity> entities = new ArrayList<AttachmentEntity>();
		// UserEntity loginUser = ShiroUser.getCurrentUserEntity();
		boolean hasException = false;
		
		int oldFileCount=0;
		if(fileId!=null&&fileId.length>0){
			final String objId=entity.getEntityUuid();
			//查看投诉分类start
			Specification<AttachmentEntity> spec = new Specification<AttachmentEntity>() {
				@Override
				public Predicate toPredicate(Root<AttachmentEntity> root,
						CriteriaQuery<?> query, CriteriaBuilder cb) {
					Predicate p1 = cb.equal(root.get("entityUuid"), objId);
					Predicate p2 = cb.equal(root.get("status"), "1");
			        query.where(cb.and(p1,p2)); //cb.and(p3,cb.or(p1,p2)); 
			        query.orderBy(cb.asc(root.get("createtime").as(String.class)));
			        return query.getRestriction();  
				}
			};
			List<AttachmentEntity> oldFileList=findAll(spec);
			if(oldFileList!=null&&oldFileList.size()>0){
				for(int i=0;i<fileId.length;i++){
					if(!StringUtils.isEmpty(fileId[i])){
						oldFileCount++;
						for(AttachmentEntity old:oldFileList){
							if(old.getUuid().equals(fileId[i])){
								old.setFileClass(fileClass[i]);
								if(fileMemo!=null&&fileMemo.length>i){
									old.setFileMemo(fileMemo[i]);
								}else{
									old.setFileMemo("");
								}
								doUpdate(old);
								break;
							}
						}
					}
				}
			}
		}
		
		for (MultipartFile file : files) {
			AttachmentEntity attach = new AttachmentEntity();
			attach.setEntityType(entity.getEntityType());
			attach.setEntityUuid(entity.getEntityUuid());
			attach.setAttaType("0");//attach.setAttaType(entity.getAttaType());
			attach.setTag(entity.getTag());
			String fileName=file.getOriginalFilename();
			attach.setFileName(fileName);
			attach.setFileSize(String.valueOf(file.getSize()));
//			attach.setFileType(file.getContentType());
			attach.setFileType(fileName.substring(fileName.lastIndexOf(".")+1, fileName.length()).toUpperCase());
			attach.setUploadDate(new Date()); // 上传时间
			// attach.setUploadUser(loginUser);//上传用户
			UserEntity user = ShiroUser.getCurrentUserEntity();
			attach.setUploadUserId(user.getUuid());
			attach.setUploadUserName(user.getUsername());
			
			attach.setFileClass(fileClass[oldFileCount]);
			
			if(fileMemo==null||fileMemo.length==0){
				attach.setFileMemo("");
			}
			
			
			oldFileCount++;
			try {
				super.save(attach);
				if (upLoad(file, attach)) {
					entities.add(attach);
					super.doUpdate(attach);//上传后设置了文件的路径url需要更新 edit by ls
				} else {
					hasException = true;
					break;
				}
			} catch (IOException e) {
				hasException = true;
				break;
			}
		}
		//删除附件
		if (deleteFilePKs != null && deleteFilePKs.length > 0) {
			delete(deleteFilePKs);
		}
		if (hasException) {
			delete(entities);
		}
		return entities;
	}
	
	
	public void deleteFiles(List<AttachmentEntity> entities) throws ServiceException {
		for (AttachmentEntity entity : entities) {
			deleteAttachment(entity);
		}
	}

	/**
	 * 附件及附件实体信息删除
	 */
	@Override
	public void delete(String[] pks) throws ServiceException {
		for (String pk : pks) {
			AttachmentEntity entity = getOne(pk);
			if (entity == null) {
				continue;
			}
			deleteAttachment(entity);
			super.delete(pk);
		}

	}

	@Override
	public void delete(Iterable<AttachmentEntity> entities) throws ServiceException {
		for (AttachmentEntity entity : entities) {
			deleteAttachment(entity);
			super.delete(entity);
		}
	}

	/**
	 * 
	 * 根据实体uuid删除附件及附件实体信息
	 * 
	 * @date 2013-12-17 上午10:37:49
	 * @param entityUuid
	 * @throws ServiceException
	 */
	public void deleteByEntityUuid(String entityUuid) throws ServiceException {
		List<AttachmentEntity> entities = dao.findByEntityUuid(entityUuid);
		for (AttachmentEntity entity : entities) {
			deleteAttachment(entity);
		}
		dao.deleteByEntityUuid(entityUuid);
	}

	public List<AttachmentEntity> findByEntityUuid(String entityUuid) throws ServiceException {
		try {
			List<AttachmentEntity> entities = dao.findByEntityUuid(entityUuid);
			return entities;
		} catch (Exception e) {
			throw new ServiceException(e.getMessage());
		}
	}

	/**
	 * 
	 * 附件上传
	 * 
	 * @date 2013-12-17 上午10:38:16
	 * @param file
	 * @param uuid
	 * @throws IOException
	 * @throws ServiceException
	 */
	public boolean upLoad(MultipartFile file, AttachmentEntity entity) throws IOException, ServiceException {
		InputStream input = file.getInputStream();

		String path = getFileRelativePath(entity.getEntityType(), entity.getUploadDate());
		String fileSaveType = ParameterUtil.getParamValue(ParameterUtil.PARAM_CODE_FILE_SAVE_TYPE);
		String fileName="";
		if(entity.isOrgiName()){
			fileName=entity.getFileName();
		}else{
			fileName=genFileName(entity.getUuid(), entity.getFileName());
		}
		entity.setUrl(FileUploadHandle.attaFileName+File.separator+path+fileName);
		handle = FileUploadFactory.createFileUploadHandle(fileSaveType);
		if (handle == null)
			throw new ServiceException("请联系系统管理员在系统参数中设置文件管理模式！");
		return handle.uploadFile(input, path,fileName);
	}

	/**
	 * 
	 * 附件删除
	 * 
	 * @param picture
	 * @return
	 * @throws ServiceException
	 */
	public boolean deleteAttachment(AttachmentEntity entity) throws ServiceException {
		String fileName = genFileName(entity.getUuid(), entity.getFileName());
		String path = getFileRelativePath(entity.getEntityType(), entity.getUploadDate());
		String fileSaveType = ParameterUtil.getParamValue(ParameterUtil.PARAM_CODE_FILE_SAVE_TYPE);
		handle = FileUploadFactory.createFileUploadHandle(fileSaveType);
		if (handle == null)
			throw new ServiceException("请联系系统管理员在系统参数中设置文件管理模式！");
		return handle.deleteFile(path, fileName);
	}

	/**
	 * 
	 * 附件下载
	 * 
	 * @date 2013-12-17 上午10:55:25
	 * @param request
	 * @param pk
	 * @param request
	 * @throws ServiceException
	 * @throws IOException
	 */
	public void downLoad(HttpServletRequest request, HttpServletResponse response, String pk)
			throws ServiceException, IOException {
		AttachmentEntity att = getOne(pk);

		String path = getFileRelativePath(att.getEntityType(), att.getUploadDate());
		String name = genFileName(att.getUuid(), att.getFileName());
		String fileSaveType = ParameterUtil.getParamValue(ParameterUtil.PARAM_CODE_FILE_SAVE_TYPE);
		handle = FileUploadFactory.createFileUploadHandle(fileSaveType);
		if (handle == null)
			throw new ServiceException("请联系系统管理员在系统参数中设置文件管理模式！");
		setResponseBeforeDownload(request, response, att.getFileName());
		response.setHeader(CONTENT_LENGTH, String.valueOf(att.getFileSize()));
		handle.readFile(path, name, response.getOutputStream());
	}

	/**
	 * 下载所有的文件
	 * @Title: downloadAllFiles 
	 * @author liusheng
	 * @date 2017年8月16日 下午8:06:15 
	 * @param @param request
	 * @param @param response
	 * @param @param entityUuid
	 * @param @throws ServiceException
	 * @param @throws IOException 设定文件 
	 * @return void 返回类型 
	 * @throws
	 */
	public void downloadAllFiles(HttpServletRequest request, HttpServletResponse response, String entityUuid,String entityType)
			throws ServiceException, IOException {
		List<AttachmentEntity> list=findByEntityUuidAndEntityType(entityUuid, entityType);
		
		List<File> srcfile=new ArrayList<File>();  
		String fileSaveType = ParameterUtil.getParamValue(ParameterUtil.PARAM_CODE_FILE_SAVE_TYPE);
		handle = FileUploadFactory.createFileUploadHandle(fileSaveType);
		String tmpPath=handle.getCompletePath("\\tmp");
		if(list!=null&&list.size()>0){
	        FileInputStream input = null;
	        BufferedInputStream inBuff= null; 
	  
	        // 新建文件输出流并对它进行缓冲   
	        FileOutputStream output =  null;  
	        BufferedOutputStream outBuff= null;
			for(AttachmentEntity att:list){
				try {
					String randomPath=tmpPath+"\\"+System.currentTimeMillis()+"";
					File randomPathFile=new File(randomPath);
					if(!randomPathFile.exists()){
						randomPathFile.mkdirs();
					}
					String newFilePath=randomPath+"\\"+att.getFileName();
			        
			        input = new FileInputStream(handle.getAbsCompletePath(att.getUrl()));  
			        inBuff=new BufferedInputStream(input);  
			  
			        // 新建文件输出流并对它进行缓冲   
			        output = new FileOutputStream(newFilePath);  
			        outBuff=new BufferedOutputStream(output);  
			        // 缓冲数组   
			        byte[] b = new byte[1024 * 5];  
			        int len;  
			        while ((len =inBuff.read(b)) != -1) {  
			            outBuff.write(b, 0, len);  
			        }  
			        // 刷新此缓冲的输出流   
			        outBuff.flush();  
			          
//				    srcfile.add(new File(handle.getAbsCompletePath(att.getUrl())));  
			        srcfile.add(new File(newFilePath));
				} catch (Exception e) {
					 srcfile.add(new File(handle.getAbsCompletePath(att.getUrl())));  
					 e.printStackTrace();
				}finally {
			        //关闭流   
			        inBuff.close();  
			        outBuff.close();  
			        output.close();  
			        input.close(); 
				}
			}
		}
		
		File tmpPathFile=new File(tmpPath);
		if(!tmpPathFile.exists()){
			tmpPathFile.mkdirs();
		}
		String zipFilePath=tmpPath+"\\"+System.currentTimeMillis()+".zip";
        File zipfile = new File(zipFilePath);  
        ZipUtil.zipFiles(srcfile, zipfile);  
		
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd_HHmmss");//可以方便地修改日期格
        String tm= dateFormat.format(new Date());
        String zipname=tm+".zip";
        InputStream in =new FileInputStream(zipFilePath); //获取文件的流  
        OutputStream os = response.getOutputStream();
        int len = 0;  
        byte buf[] = new byte[1024];//缓存作用 
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/octet-stream; charset=UTF-8");
        response.addHeader("Content-Disposition", "attachment; filename=\""+new String(zipname.getBytes("GB2312"),"ISO8859-1")+"\";");// 
        os = response.getOutputStream();//输出流  
        while( (len = in.read(buf)) > 0 ) {  
             os.write(buf, 0, len);//向客户端输出，实际是把数据存放在response中，然后web服务器再去response中读取  
         }
        in.close();
        os.close();
//        deleteZip(temppath);//导出后删除zip
	}
	
	

	/**
	 * 写附件到输出流
	 * 
	 * @author wzw 2015年4月15日
	 * @param att
	 * @return
	 * @throws ServiceException
	 */
	public void writeFileToOutputStream(AttachmentEntity att, OutputStream outputStream) throws ServiceException {
		String path = getFileRelativePath(att.getEntityType(), att.getUploadDate());
		String name = genFileName(att.getUuid(), att.getFileName());
		String fileSaveType = ParameterUtil.getParamValue(ParameterUtil.PARAM_CODE_FILE_SAVE_TYPE);
		handle = FileUploadFactory.createFileUploadHandle(fileSaveType);
		if (handle == null)
			throw new ServiceException("请联系系统管理员在系统参数中设置文件管理模式！");
		handle.readFile(path, name, outputStream);
	}

	/**
	 * 获取附件输出流
	 * 
	 * @author wzw 2015年4月15日
	 * @param att
	 * @return
	 * @throws ServiceException
	 */
	public OutputStream getFileOutputStream(AttachmentEntity att) throws ServiceException {
		File file = getFile(att);
		OutputStream out;
		try {
			out = new FileOutputStream(file);
		} catch (FileNotFoundException e) {
			throw new ServiceException("创建临时文件失败");
		}
		return out;
	}

	public File getFile(AttachmentEntity att) throws ServiceException {
//		String path = getFileRelativePath(att.getEntityType(), att.getUploadDate());
		String name = genFileName(att.getUuid(), att.getFileName());
		String fileSaveType = ParameterUtil.getParamValue(ParameterUtil.PARAM_CODE_FILE_SAVE_TYPE);
		handle = FileUploadFactory.createFileUploadHandle(fileSaveType);
		if (handle == null)
			throw new ServiceException("请联系系统管理员在系统参数中设置文件管理模式！");
		File file = null;
		// if(handle instanceof FTPFileUploadHandle){
		// //从文件服务器下载到应用服务器临时目录
		// file = new File( ParameterUtil.getParamValue(ParameterUtil.PARAM_CODE_TEMPPATH)+name);
		// OutputStream out;
		// try {
		// out = new FileOutputStream(file);
		// } catch (FileNotFoundException e) {
		// throw new ServiceException("创建临时文件失败");
		// }
		// handle.readFile(path, name, out);
		// }else{
		file = new File(getFilePath(att.getEntityType(), att.getUploadDate()) + name);
		// }
		return file;
	}

	/**
	 * 
	 * 显示图片附件类型
	 * 
	 * @date 2013-12-17 下午11:13:14
	 * @param response
	 * @param pk
	 * @throws ServiceException
	 * @throws IOException
	 */
	public void showImg(HttpServletResponse response, String pk) throws ServiceException, IOException {
		AttachmentEntity att = getOne(pk);

		String path = getFileRelativePath(att.getEntityType(), att.getUploadDate());
		String name = genFileName(att.getUuid(), att.getFileName());

		response.setContentType(att.getFileType());
		String fileSaveType = ParameterUtil.getParamValue(ParameterUtil.PARAM_CODE_FILE_SAVE_TYPE);
		handle = FileUploadFactory.createFileUploadHandle(fileSaveType);
		if (handle == null)
			throw new ServiceException("请联系系统管理员在系统参数中设置文件管理模式！");
		handle.readFile(path, name, response.getOutputStream());
	}

	private void setOutputStream(final HttpServletResponse response, final File file) throws IOException {
		BufferedOutputStream output = null;
		BufferedInputStream input = null;

		try {
			input = new BufferedInputStream(new FileInputStream(file));
			output = new BufferedOutputStream(response.getOutputStream());
			byte[] buff = new byte[2048];
			int readLen = 0;
			while ((readLen = input.read(buff, 0, buff.length)) != -1) {
				output.write(buff, 0, readLen);
			}
			output.flush();
		} catch (IOException e) {
			throw e;
		} finally {
			if (input != null) {
				try {
					input.close();
				} catch (IOException e) {
				} finally {
					input = null;
				}
			}
			if (output != null) {
				try {
					output.close();
				} catch (IOException e) {
				} finally {
					output = null;
				}
			}
		}
	}

	/**
	 * 
	 *  文件名生成规则. uuid_fileName
	 * 
	 * @date 2013-12-17 上午11:07:01
	 * @param uuid
	 * @param fileName
	 * @return
	 */
	public String genFileName(String uuid, String fileName) {
//		SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMddHHmmss");
//		return sdf.format(new Date())+"_"+fileName;
//		return uuid + "_" + fileName;
		// return uuid + "_" + fileName;
		 return uuid+fileName.substring(fileName.lastIndexOf("."), fileName.length());
	}

	public String getFilePath() {
		String saveType = ParameterUtil.getParamValue(ParameterUtil.PARAM_CODE_FILE_SAVE_TYPE);
		if ("FTP".equals(saveType)) {
			return ParameterUtil.getParamValue(ParameterUtil.PARAM_CODE_FTP_ATTAPATH);
		}
		return ParameterUtil.getParamValue(ParameterUtil.PARAM_CODE_ATTACHMENT_PATH);
	}

	public String getFileRelativePath(String entityType, Date date) {
		return entityType + File.separator + formatDate(date) + File.separator;
	}

	public String getFilePath(String entityType, Date date) {
		return getFilePath() + File.separator + getFileRelativePath(entityType, date);
	}

	public String formatDate(Date date) {
		return DateUtil.formatDate(date, "yyyyMMdd");
	}

	/**
	 * 根据EntityUuid和EntityType查找文件
	 * 
	 * @author wzw 2014年11月18日
	 * @return
	 */
	public List<AttachmentEntity> findByEntityUuidAndEntityType(String entityUuid, String entityType) {
		return this.dao.findByEntityUuidAndEntityType(entityUuid, entityType);
	}
	
	
	public List<AttachmentEntity> findByEntityPksAndEntityType(String[] pks, String entityType) {
		return this.dao.findByEntityUuidAndEntityType(pks, entityType);
	}

	private void setResponseBeforeDownload(HttpServletRequest request, HttpServletResponse response, String newFileName)
			throws UnsupportedEncodingException {
		response.setContentType(CONTENT_TYPE);
		String explorerType = RequestUtil.getExplorerType(request);
		if (explorerType == null || explorerType.contains("IE")) {
			// IE
			response.setHeader(CONTENT_DISPOSITION,
					"attachment; filename=\"" + RequestUtil.encode(newFileName, getSystemFileCharset()) + "\"");
		} else {
			// fireFox/Chrome
			response.setHeader(CONTENT_DISPOSITION,
					"attachment; filename=" + new String(newFileName.getBytes(getSystemFileCharset()), "ISO8859-1"));
		}
	}

	public static String getSystemFileCharset() {
		Properties pro = System.getProperties();
		return pro.getProperty("file.encoding");
	}

	
	/**
	 * 保存导入的excel
	 * @param fileName
	 * @param entityId
	 * @param file
	 * @throws ServiceException
	 * @throws IOException
	 */
	public void saveImportExcel(String fileName,String entityId,String entityType,MultipartFile file) throws ServiceException, IOException{
		//保存导入的excel
		AttachmentEntity attach = new AttachmentEntity();
		attach.setEntityType(entityType);
		attach.setEntityUuid(entityId);
		attach.setAttaType("0");
		attach.setFileName(fileName);
		attach.setFileSize(String.valueOf(file.getSize()));
		attach.setFileType(fileName.substring(fileName.lastIndexOf(".") + 1, fileName.length()).toUpperCase());
		attach.setUploadDate(new Date()); // 上传时间
		UserEntity user = ShiroUser.getCurrentUserEntity();
		attach.setUploadUserId(user.getUuid());
		attach.setUploadUserName(user.getUsername());
		save(attach);
		upLoad(file, attach);
	}


	
	@Transactional
	public List<AttachmentEntity> saveFiles(List<MultipartFile> files, AttachmentEntity entity, String[] deleteFilePKs,
			String[] fileId, String[] fileClass, String[] fileMemo) {
		List<AttachmentEntity> entities = new ArrayList<AttachmentEntity>();
		
		final String objId=entity.getEntityUuid();
		//查看投诉分类start
		Specification<AttachmentEntity> spec = new Specification<AttachmentEntity>() {
			@Override
			public Predicate toPredicate(Root<AttachmentEntity> root,
					CriteriaQuery<?> query, CriteriaBuilder cb) {
				Predicate p1 = cb.equal(root.get("entityUuid"), objId);
				Predicate p2 = cb.equal(root.get("status"), "1");
		        query.where(cb.and(p1,p2)); 
		        query.orderBy(cb.asc(root.get("createtime").as(String.class)));
		        return query.getRestriction();  
			}
		};
		List<AttachmentEntity> oldFileList=findAll(spec);
		entity.setUploadDate(new Date());
		int i=0;
		for (MultipartFile file : files) {
			try {
				InputStream input = file.getInputStream();
				entity.setUuid(fileId[i]);
				String orgFileName=file.getOriginalFilename();
				entity.setFileName(orgFileName);
				String path = entity.getEntityType()+File.separator;
				String fileSaveType = ParameterUtil.getParamValue(ParameterUtil.PARAM_CODE_FILE_SAVE_TYPE);
				//genFileName(entity.getUuid(), entity.getFileName());
				String fileName=EnumDataUtils.getEnumEntity(fileClass[i], "ActivityFormsType").getEnumdataname();
				fileName+=orgFileName.substring(orgFileName.lastIndexOf("."), orgFileName.length());
				entity.setUrl(FileUploadHandle.attaFileName+File.separator+path+fileName);
				handle = FileUploadFactory.createFileUploadHandle(fileSaveType);
				if (handle == null)
					throw new ServiceException("请联系系统管理员在系统参数中设置文件管理模式！");
				handle.uploadFile(input, path,fileName);
				
				for(AttachmentEntity att:oldFileList){
					if(fileId[i].equals(att.getUuid())){
						att.setUrl(entity.getUrl());
						break;
					}
				}
				i++;
			} catch (IOException e) {
				break;
			}
		}
		return entities;
	}
	
	/**
	 * 下载社团申请表
	 * @Title: downLoadFiles 
	 * @author liusheng
	 * @date 2017年9月29日 下午12:48:18 
	 * @param @param request
	 * @param @param response
	 * @param @param pk
	 * @param @throws ServiceException
	 * @param @throws IOException 设定文件 
	 * @return void 返回类型 
	 * @throws
	 */
	public void downLoadFiles(HttpServletRequest request, HttpServletResponse response, String pk)
			throws ServiceException, IOException {
		AttachmentEntity att = getOne(pk);
		String url=att.getUrl();
		String path = "";
		String fileSaveType = ParameterUtil.getParamValue(ParameterUtil.PARAM_CODE_FILE_SAVE_TYPE);
		handle = FileUploadFactory.createFileUploadHandle(fileSaveType);
		if (handle == null)
			throw new ServiceException("请联系系统管理员在系统参数中设置文件管理模式！");
		setResponseBeforeDownload(request, response, att.getFileName()+url.substring(url.lastIndexOf("."), url.length()));
		response.setHeader(CONTENT_LENGTH, String.valueOf(att.getFileSize()));
		path = handle.getAbsCompletePath(url);
		File file = new File(path);
		try {
			OutputStream output=response.getOutputStream();
			BufferedInputStream input = null;
			try {
				input = new BufferedInputStream(new FileInputStream(file));
				byte[] buff = new byte[2048];
				int readLen = 0;
				while ((readLen = input.read(buff, 0, buff.length)) != -1) {
					output.write(buff, 0, readLen);
				}
				output.flush();
			} catch (IOException e) {
				throw e;
			} finally {
				if (input != null) {
					try {
						input.close();
					} catch (IOException e) {
					} finally {
						input = null;
					}
				}
				if (output != null) {
					try {
						output.close();
					} catch (IOException e) {
					} finally {
						output = null;
					}
				}
			}

		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
