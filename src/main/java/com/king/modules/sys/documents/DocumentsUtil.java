package com.king.modules.sys.documents;

import java.util.Hashtable;
import java.util.Map;

public class DocumentsUtil {

	/**
	 * 单据类型map，用来控制每个单据类型只有一个单据可以进行生成单据号
	 */
	private static Map<String, DocumentsEntity> domMap;

	static {
		domMap = new Hashtable<String, DocumentsEntity>();
	}

	public static boolean containsDom(String billtype) {
		return domMap.containsKey(billtype);
	}

	public static DocumentsEntity getDom(String billtype) {
		if (domMap.containsKey(billtype)) {
			return domMap.get(billtype);
		} else {
			return null;
		}
	}

	public static void putDom(String billtype, DocumentsEntity dom) {
		if (dom != null) {
			domMap.put(billtype, dom);
		}
	}

	public static void updateEntitys(Iterable<DocumentsEntity> documentsEntitys) {
		for (DocumentsEntity entity : documentsEntitys) {
			putDom(entity.getDocumentType(), entity);
		}
	}

}
