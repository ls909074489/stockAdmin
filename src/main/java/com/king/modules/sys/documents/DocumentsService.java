package com.king.modules.sys.documents;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.service.spi.ServiceException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.king.frame.dao.IBaseDAO;
import com.king.frame.redis.YYRedisCache;
import com.king.frame.service.BaseServiceImpl;

/**
 * 单据号生成策略service
 * 
 * @ClassName: DocumentsService
 * @author dsp
 * @date 2016年08月22日 04:16:12
 */
@Service
// @Transactional
public class DocumentsService extends BaseServiceImpl<DocumentsEntity, String> {
	@Autowired
	private DocumentsDao dao;

	@Autowired
	YYRedisCache yyRedisCache;

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	protected IBaseDAO getDAO() {
		return dao;
	}

	private static Logger logger = LoggerFactory.getLogger(BillCodeService.class);

	private int total = 0;

	/**
	 * 单据号生成
	 * 
	 * @param billtype
	 * @param simplename岗位
	 * @param force强制从数据库取数据
	 * @return
	 */
	@Transactional(propagation = Propagation.REQUIRES_NEW, rollbackFor = { Exception.class })
	protected String generateDocuments(String billtype, String simplename, boolean force) throws ServiceException {
		DocumentsEntity doc = null;
		if (force) {
			doc = dao.findByDocuType(billtype);
			DocumentsUtil.putDom(billtype, doc);
		} else if (DocumentsUtil.containsDom(billtype)) {
			doc = DocumentsUtil.getDom(billtype);
		} else {
			doc = dao.findByDocuType(billtype);
			DocumentsUtil.putDom(billtype, doc);
		}
		if (doc == null) {
			return "";
		}
		StringBuffer documents = handleBillCode(simplename, doc);
		try {
			doc = dao.save(doc);
			DocumentsUtil.putDom(billtype, doc);
		} catch (org.springframework.orm.ObjectOptimisticLockingFailureException e1) {
			total += 100;
			logger.info("单据类型" + billtype + "并发生成单据号失败" + (total / 100) + "次,系统重新生成。");
			// 如果生成失败
			try {
				Thread.sleep(100);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			// 如果没有命中
			if (total <= 300) {
				generateDocuments(billtype, simplename, false);
			} else if (total <= 1000) {// 设置重新从数据库查询
				generateDocuments(billtype, simplename, true);
			} else {
				total = 0;
				throw new ServiceException("单据类型" + billtype + "生成单据号失败");
			}
		} catch (Exception e2) {
			total = 0;
			throw new ServiceException("单据号生成失败," + e2);
		}
		total = 0;
		return documents.toString();
	}

	/**
	 * 单据号生成-redis的方式
	 * 
	 * @param billtype
	 * @param simplename岗位
	 * @param force强制从数据库取数据
	 * @return
	 */
	@Transactional(propagation = Propagation.REQUIRES_NEW, rollbackFor = { Exception.class })
	protected String generateDocumentsByRedis(String billtype, String simplename, boolean force)
			throws ServiceException {
		DocumentsEntity doc = null;
		// 如果从缓存中查找不到，或者强制从数据库中查询
		if (yyRedisCache.get(billtype) == null || force) {
			doc = dao.findByDocuType(billtype);
			yyRedisCache.put(billtype, doc);
		} else {
			doc = (DocumentsEntity) yyRedisCache.get(billtype).get();
		}
		if (doc == null) {
			doc = dao.findByDocuType(billtype);
			yyRedisCache.put(billtype, doc);
		}
		if (doc == null) {
			return "";
		}
		StringBuffer documents = handleBillCode(simplename, doc);

		try {
			doc = dao.save(doc);
			yyRedisCache.put(billtype, doc);
		} catch (org.springframework.orm.ObjectOptimisticLockingFailureException e1) {
			total += 100;
			logger.info("单据类型" + billtype + "并发生成单据号失败" + (total / 100) + "次,系统将重新生成。");
			// 如果生成失败
			try {
				Thread.sleep(100);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			// 如果没有命中
			if (total <= 300) {
				generateDocumentsByRedis(billtype, simplename, false);
			} else if (total <= 1000) { // 设置重新从数据库查询
				generateDocumentsByRedis(billtype, simplename, true);
			} else {
				total = 0;
				throw new ServiceException("单据类型" + billtype + "生成单据号失败");
			}
		} catch (Exception e2) {
			total = 0;
			throw new ServiceException("单据号生成失败," + e2);
		}
		total = 0;
		return documents.toString();
	}

	/**
	 * 计算单据号
	 * 
	 * @param simplename
	 * @param doc
	 * @return
	 */
	private StringBuffer handleBillCode(String simplename, DocumentsEntity doc) {
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		// 生成规则 前缀 + 年 + 月 + 日 + 流水号
		Date date = new Date();
		String[] dates = df.format(date).split("-");
		StringBuffer documents = new StringBuffer(doc.getPrefix());
		if (!StringUtils.isEmpty(simplename)) {
			documents.append(simplename); // 岗位
		}
		if (WhetherOrNot(doc.getIsAadYears())) {
			documents.append(dates[0]);
		}
		if (WhetherOrNot(doc.getIsAddMonth())) {
			documents.append(dates[1]);
		}
		if (WhetherOrNot(doc.getIsAddDay())) {
			documents.append(dates[2]);
		}
		// 判断是否归零
		if (doc.getCreationTime() == null || "".equals(doc.getCreationTime().toString())) {

		} else { // 归零
			if (doc.getZeroMark() != null && !doc.getZeroMark().equals("")) {
				SimpleDateFormat sid = new SimpleDateFormat("yyyy-MM-dd");
				Calendar cal = Calendar.getInstance();
				cal.setTime(doc.getCreationTime());
				if (doc.getZeroMark().equals("y")) {
					cal.add(Calendar.YEAR, 1);
				}
				if (doc.getZeroMark().equals("m")) {
					cal.add(Calendar.MONTH, 1);
				}
				if (doc.getZeroMark().equals("d")) {
					cal.add(Calendar.DATE, 1);
				}
				Date newDate = cal.getTime();
				long diff = newDate.getTime() - date.getTime();
				if (diff < 0) {
					doc.setNewSerialNumber(0);
					String dateStr = sid.format(date) + " 00:00:00";
					try {
						doc.setCreationTime(sid.parse(dateStr));
					} catch (ParseException e) {
						e.printStackTrace();
					}
				}
			}
		}

		// 流水号
		if (doc.getNewSerialNumber() == null) { // 第一次使用单据类型生成单据号
			documents.append(String.format("%0" + doc.getSerialNumber() + "d", 1));
			doc.setNewSerialNumber(1);
			try {
				doc.setCreationTime(df.parse(dates[0] + "-" + dates[1] + "-" + dates[2] + " 00:00:00"));
			} catch (ParseException e) {
				e.printStackTrace();
				throw new ServiceException("转换时间：" + e);
			}
		} else {
			if ((doc.getNewSerialNumber() + 1) / 10 > doc.getSerialNumber()) {

			}
			documents.append(String.format("%0" + doc.getSerialNumber() + "d", doc.getNewSerialNumber() + 1));
			doc.setNewSerialNumber(doc.getNewSerialNumber() + 1);
		}
		return documents;
	}

	public boolean WhetherOrNot(String y) {
		if ("y".equals(y)) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * 判断单据号是否存在
	 * 
	 * @param documentType
	 * @param uuid
	 * @return
	 */
	public boolean queryDocumentType(String documentType, String uuid) {
		List<DocumentsEntity> docs = dao.findByDocumentType(documentType);
		if (docs.size() > 1) {
			return false;
		} else if (docs.size() == 1) {
			if (docs.get(0).getUuid().equals(uuid)) {
				return true;
			} else {
				return false;
			}
		} else {
			return true;
		}
	}

	/**
	 * 查询单据号实体
	 * 
	 * @author linjq
	 * @return
	 */
	public DocumentsEntity findDocumentType(String documentType) {
		List<DocumentsEntity> docs = dao.findByDocumentType(documentType);
		if (docs != null && docs.size() > 0) {
			return docs.get(0);
		}
		return null;
	}

	/**
	 * 创建单据号by redis
	 * 
	 * @param billtype
	 * @param role
	 * @return
	 */
	public String createBillCodeByRedis(String billtype, String role) {
		DocumentsEntity doc = null;
		// 如果从缓存中查找不到，或者强制从数据库中查询
		if (yyRedisCache.get("billtype:" + billtype) == null) {
			doc = dao.findByDocuType(billtype);
			yyRedisCache.put("billtype:" + billtype, doc);
		} else {
			doc = (DocumentsEntity) yyRedisCache.get("billtype:" + billtype).get();
		}
		if (doc == null) {
			doc = dao.findByDocuType(billtype);
			yyRedisCache.put("billtype:" + billtype, doc);
		}
		if (doc == null) {
			return "";
		}
		long num = yyRedisCache.buildNum("billcode:" + billtype, 1);
		return handleBillCode(role, doc, num).toString();
	}

	/**
	 * 计算单据号 by redis
	 * 
	 * @param simplename
	 * @param doc
	 * @return
	 */
	private StringBuffer handleBillCode(String simplename, DocumentsEntity doc, long count) {
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		// 生成规则 前缀 + 年 + 月 + 日 + 流水号
		Date date = new Date();
		String[] dates = df.format(date).split("-");
		StringBuffer documents = new StringBuffer(doc.getPrefix());
		if (!StringUtils.isEmpty(simplename)) {
			documents.append(simplename); // 岗位
		}
		if (WhetherOrNot(doc.getIsAadYears())) {
			documents.append(dates[0]);
		}
		if (WhetherOrNot(doc.getIsAddMonth())) {
			documents.append(dates[1]);
		}
		if (WhetherOrNot(doc.getIsAddDay())) {
			documents.append(dates[2]);
		}
		// 判断是否归零
		if (doc.getCreationTime() == null || "".equals(doc.getCreationTime().toString())) {

		} else { // 归零
			if (doc.getZeroMark() != null && !doc.getZeroMark().equals("")) {
				SimpleDateFormat sid = new SimpleDateFormat("yyyy-MM-dd");
				Calendar cal = Calendar.getInstance();
				cal.setTime(doc.getCreationTime());
				if (doc.getZeroMark().equals("y")) {
					cal.add(Calendar.YEAR, 1);
				}
				if (doc.getZeroMark().equals("m")) {
					cal.add(Calendar.MONTH, 1);
				}
				if (doc.getZeroMark().equals("d")) {
					cal.add(Calendar.DATE, 1);
				}
				Date newDate = cal.getTime();
				long diff = newDate.getTime() - date.getTime();
				if (diff < 0) {
					doc.setNewSerialNumber(0);
					String dateStr = sid.format(date) + " 00:00:00";
					try {
						doc.setCreationTime(sid.parse(dateStr));
					} catch (ParseException e) {
						e.printStackTrace();
					}
				}
			}
		}

		// 流水号
		if (count == 0) { // 第一次使用单据类型生成单据号
			documents.append(String.format("%0" + doc.getSerialNumber() + "d", 1));
			doc.setNewSerialNumber(1);
			try {
				doc.setCreationTime(df.parse(dates[0] + "-" + dates[1] + "-" + dates[2] + " 00:00:00"));
			} catch (ParseException e) {
				e.printStackTrace();
				throw new ServiceException("转换时间：" + e);
			}
		} else {
			if ((count + 1) / 10 > doc.getSerialNumber()) {

			}
			documents.append(String.format("%0" + doc.getSerialNumber() + "d", count + 1));
			doc.setNewSerialNumber((int) (count + 1));
		}
		return documents;
	}

	/**
	 * 更新单据号的最新编码到redis
	 */
	public void refreshToRedis() {
		Iterable<DocumentsEntity> documentsEntitys = this.findAll();
		for (DocumentsEntity entity : documentsEntitys) {
			yyRedisCache.setCacheObject("billcode:" + entity.getDocumentType(),
					entity.getNewSerialNumber() == null ? "0" : entity.getNewSerialNumber().toString());
		}
	}

	/**
	 * 更新redis的缓存到单据号设置
	 */
	public void refreshToBill() {
		Iterable<DocumentsEntity> documentsEntitys = this.findAll();
		for (DocumentsEntity entity : documentsEntitys) {
			if (yyRedisCache.getCacheObject("billcode:" + entity.getDocumentType()) != null) {
				Object newSerialNumber = yyRedisCache.getCacheObject("billcode:" + entity.getDocumentType());
				entity.setNewSerialNumber(Integer.parseInt(newSerialNumber.toString()));
				handleBillCode(null, entity);
				this.save(entity);
			}
		}
		refreshToRedis();
	}

	/**
	 * 清楚所有的缓存
	 */
	public void cleanAllRedisCache() {
		yyRedisCache.clear();
	}

}
