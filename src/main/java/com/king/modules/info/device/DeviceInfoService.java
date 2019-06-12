package com.king.modules.info.device;

import java.util.Date;
import java.util.List;
import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import com.king.common.fileupload.FileUploadHandle;
import com.king.common.utils.DateUtil;
import com.king.common.utils.QRCodeUtil;
import com.king.frame.attachment.AttachmentEntity;
import com.king.frame.attachment.AttachmentService;
import com.king.frame.dao.IBaseDAO;
import com.king.frame.security.ShiroUser;
import com.king.frame.service.BaseServiceImpl;
import com.king.modules.sys.param.ParameterUtil;
import com.king.modules.sys.user.UserEntity;

/**
 * 设备信息
 * @author ls2008
 * @date 2017-11-17 23:22:24
 */
@Service
@Transactional(readOnly=true)
public class DeviceInfoService extends BaseServiceImpl<DeviceInfoEntity,String> {

	@Autowired
	private DeviceInfoDao dao;
	@Autowired
	private AttachmentService attachmentService;
	//@Autowired
	//private DbUtilsDAO dbDao;

	protected IBaseDAO<DeviceInfoEntity, String> getDAO() {
		return dao;
	}

	@Override
	public DeviceInfoEntity baseSave(DeviceInfoEntity entity) throws ServiceException {
//		if(!(entity.getInterval()!=null&&!StringUtils.isEmpty(entity.getInterval().getUuid()))){
//			entity.setInterval(null);
//		}
//		if(!(entity.getSupplier()!=null&&!StringUtils.isEmpty(entity.getSupplier().getUuid()))){
//			entity.setSupplier(null);
//		}
		return super.baseSave(entity);
	}


	@Transactional
	public DeviceInfoEntity addDevice(DeviceInfoEntity entity, List<MultipartFile> files) {
		DeviceInfoEntity afterEntity=doAdd(entity);
		for (MultipartFile file : files) {
			AttachmentEntity attach = new AttachmentEntity();
			String fileName = file.getOriginalFilename();
			attach.setFileName(fileName);
			attach.setEntityType("DeviceInfo");
			attach.setEntityUuid(afterEntity.getUuid());
			attach.setAttaType("");
			attach.setFileSize(String.valueOf(file.getSize()));
			attach.setFileType(fileName.substring(fileName.lastIndexOf(".") + 1, fileName.length()).toUpperCase());
			attach.setUploadDate(new Date()); // 上传时间
			UserEntity user = ShiroUser.getCurrentUserEntity();
			attach.setUploadUserId(user.getUuid());
			attach.setUploadUserName(user.getUsername());
			try {
				attachmentService.save(attach);
				attachmentService.upLoad(file, attach);
				entity.setSketch(fileName);
				entity.setSketchUrl(attach.getUrl());
			} catch (Exception e) {
				e.printStackTrace();
				throw new ServiceException("保存文件失败");
			}
		}
		try {
			if(!StringUtils.isEmpty(entity.getBarcode())){
				String savePath=ParameterUtil.getParamValue("UploadFilePath", "E:\\project\\");
				String absPath=FileUploadHandle.attaFileName+"\\qrcode\\"+DateUtil.getDate()+"\\";
				String qrcodePath=savePath+absPath;
				String qrcodeName=QRCodeUtil.encode(entity.getBarcode(), qrcodePath, true);
				entity.setBarcodeUrl(absPath+qrcodeName);
			}else{
				entity.setBarcodeUrl("");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return afterEntity;
	}

	@Transactional
	public DeviceInfoEntity updateDevice(DeviceInfoEntity bean, List<MultipartFile> files) {
		DeviceInfoEntity entity=getOne(bean.getUuid());
		if(!(bean.getStation()!=null&&!StringUtils.isEmpty(bean.getStation().getUuid()))){
			entity.setStation(null);
		}else{
			entity.setStation(bean.getStation());
		}
		entity.setName(bean.getName());
		entity.setTid(bean.getTid());
		entity.setFactoryDate(bean.getFactoryDate());
		entity.setBarcode(bean.getBarcode());
		entity.setApplicate(bean.getApplicate());
		entity.setSetupDate(bean.getSetupDate());
		entity.setArgument(bean.getArgument());
		entity.setContext(bean.getContext());
		
		for (MultipartFile file : files) {
			AttachmentEntity attach = new AttachmentEntity();
			String fileName = file.getOriginalFilename();
			attach.setFileName(fileName);
			attach.setEntityType("DeviceInfo");
			attach.setEntityUuid(entity.getUuid());
			attach.setAttaType("");
			attach.setFileSize(String.valueOf(file.getSize()));
			attach.setFileType(fileName.substring(fileName.lastIndexOf(".") + 1, fileName.length()).toUpperCase());
			attach.setUploadDate(new Date()); // 上传时间
			UserEntity user = ShiroUser.getCurrentUserEntity();
			attach.setUploadUserId(user.getUuid());
			attach.setUploadUserName(user.getUsername());
			try {
				attachmentService.save(attach);
				attachmentService.upLoad(file, attach);
				entity.setSketch(fileName);
				entity.setSketchUrl(attach.getUrl());
			} catch (Exception e) {
				e.printStackTrace();
				throw new ServiceException("保存文件失败");
			}
		}
		try {
			if(!StringUtils.isEmpty(entity.getBarcode())){
				String qrcodePath=FileUploadHandle.qrcodeFileName+"\\"+DateUtil.getDate()+"\\";
				String qrcodeName=QRCodeUtil.encode(entity.getBarcode(), ParameterUtil.getParamValue("UploadFilePath", "E:\\project\\")+qrcodePath, true);
				entity.setBarcodeUrl(qrcodePath+qrcodeName);
			}else{
				entity.setBarcodeUrl("");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return doUpdate(entity);
	}

	
	
}