package com.king.common.result;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

/**
 * 接口返回值 
 * @author WangMin
 * @param <T>
 *
 */
public class ReturnMessage<T> implements Serializable {

	private static final long serialVersionUID = 1L;
	private String messageNum;   // 200 500 成功或错误的代码
	private String messageInfo;  // 详细信息
	private List<T> list ;       // list列表
	private Map<String,T> map;   // 详细数据

	public String getMessageNum() {
		return messageNum;
	}

	public void setMessageNum(String messageNum) {
		this.messageNum = messageNum;
	}

	public String getMessageInfo() {
		return messageInfo;
	}

	public void setMessageInfo(String messageInfo) {
		this.messageInfo = messageInfo;
	}

    public List<T> getList() {
        return list;
    }

    public void setList(List<T> list) {
        this.list = list;
    }

    public Map<String, T> getMap() {
        return map;
    }

    public void setMap(Map<String, T> map) {
        this.map = map;
    }

    public static long getSerialversionuid() {
		return serialVersionUID;
	}

}
