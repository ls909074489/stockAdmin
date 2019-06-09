package com.king.modules.sys.org;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.king.common.dao.DbUtilsDAO;
import com.king.common.exception.DAOException;
import com.king.frame.attachment.AttachmentEntity;
import com.king.frame.attachment.AttachmentService;
import com.king.frame.dao.IBaseDAO;
import com.king.frame.security.ShiroUser;
import com.king.frame.service.TreeServiceImpl;
import com.king.modules.sys.user.UserEntity;

@Service
@Transactional
public class OrgService extends TreeServiceImpl<OrgEntity, String> {

	@Autowired
	private OrgDAO dao;

	@Autowired
	private DbUtilsDAO dbDao;
	@Autowired
	private AttachmentService attachmentService;
	
	@Override
	protected IBaseDAO<OrgEntity, String> getDAO() {
		return dao;
	}

	@Override
	public void afterSave(OrgEntity entity) {
		super.beforeSave(entity);
		OrgUtils.updateEntity(entity);
	}

	@Override
	public void afterDelete(OrgEntity entity) throws ServiceException {
		super.afterDelete(entity);
		OrgUtils.removeEntity(entity);
	}

	/**
	 * 获取第一级节点
	 * 
	 * @return
	 */
	public List<OrgEntity> getFirstLevel() {
		return dao.getFirstLevel();
	}

	/**
	 * 根据父节点ID获取子节点，如果传入null或者空字符串，则返回第一级节点
	 * 
	 * @param parentId
	 * @return
	 */
	public List<OrgEntity> findByParentId(String parentId) {
		if (StringUtils.isBlank(parentId)) {
			return getFirstLevel();
		}
		return dao.findByParentId(parentId);
	}

	/**
	 * 
	 * @param userID
	 * @param sysId
	 * @return
	 * @throws ServiceException
	 */
	public List<OrgEntity> getUserOrgList(String userID, String sysId) throws ServiceException {
		OrgEntity entity = this.getOne(sysId);
		List<OrgEntity> list = dao.findByUuidNotAndNodepathLikeOrderByNodepathAsc(sysId,
				"%" + entity.getNodepath() + "%");
		return list;
	}

	/**
	 * 按照机构类型查询,大于这个类型的结构
	 * 
	 * @param orgtype
	 */
	public List<OrgEntity> findByOrgtypeGt(String orgtype) {
		return dao.findByOrgtypeGt(orgtype);
	}

	/**
	 * 按照机构类型查询,大于这个类型的结构
	 * 
	 * @param orgtype
	 */
	public List<OrgEntity> findByOrgtype(String orgtype) {
		return dao.findByOrgtype(orgtype);
	}

	/**
	 * @Description: 根据组织编码查找组织 @param @param orgCode 组织编码 @param @return @return List<OrgEntity> @throws
	 */
	public List<OrgEntity> findByOrgCode(String orgCode) {
		return dao.findByOrgCode(orgCode);

	}

	public List<OrgEntity> findByWhere(String where) throws ServiceException {
		StringBuilder sql = new StringBuilder();
		List<OrgEntity> orgList = new ArrayList<OrgEntity>();
		sql.append("select * from yy_org ");
		if (where != null || !"".equals("")) {
			sql.append("where ");
			sql.append(where);
		}
		try {
			orgList = dbDao.find(OrgEntity.class, sql.toString());
		} catch (DAOException e) {
			throw new ServiceException("组织查询失败！");
		}
		return orgList;
	}

	@Transactional
	public OrgEntity addOrg(OrgEntity entity, List<MultipartFile> files) {
		OrgEntity afterEntity=doAdd(entity);
		for (MultipartFile file : files) {
			AttachmentEntity attach = new AttachmentEntity();
			String fileName = file.getOriginalFilename();
			attach.setFileName(fileName);
			attach.setEntityType("OrgInfo");
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
		return afterEntity;
	}

	@Transactional
	public OrgEntity updateOrg(OrgEntity bean, List<MultipartFile> files) {
		OrgEntity entity=getOne(bean.getUuid());
		entity.setOrg_code(bean.getOrg_code());
		entity.setOrg_name(bean.getOrg_name());
		entity.setParentid(bean.getParentid());
		entity.setActive(bean.getActive());
		entity.setOrgtype(bean.getOrgtype());
		entity.setOrg_index(bean.getOrg_index());
		entity.setDescription(bean.getDescription());
		
		for (MultipartFile file : files) {
			AttachmentEntity attach = new AttachmentEntity();
			String fileName = file.getOriginalFilename();
			attach.setFileName(fileName);
			attach.setEntityType("OrgInfo");
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
		return doUpdate(entity);
	}

	/**
	 * 查询所有未删除的
	 * @Title: findAllByStatus 
	 * @author liusheng
	 * @date 2017年12月9日 下午3:22:57 
	 * @param @return 设定文件 
	 * @return List<OrgEntity> 返回类型 
	 * @throws
	 */
	public List<OrgEntity> findAllByStatus() {
		return dao.findAllByStatus();
	}

	
}