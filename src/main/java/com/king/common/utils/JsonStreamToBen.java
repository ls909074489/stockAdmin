package com.king.common.utils;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * 获取app请求体的参数流，将其转换为json，然后获取对象
 * @author WangMin
 */
public class JsonStreamToBen {

	/**
	 * 接受参数，返回bean对象
	 * @param inputStream
	 * @param o
	 * @return
	 * @throws IOException
	 */
	public static <T> Object toBean(InputStream inputStream, Class<T> o) throws IOException {
		BufferedInputStream bis = new BufferedInputStream(inputStream);
		StringBuffer sb = new StringBuffer();
		int len = 0;
		byte[] bt = new byte[2048];
		while ((len = bis.read(bt)) > 0) {
			//加上字符编码 utf-8
			sb.append(new String(bt, 0, len,"utf-8"));
		}
		//System.out.println("参数：" + sb.toString());
		String json = sb.toString();
		if(json==null||"".equals(json)){
			return null;
		}
		return JSONObject.toBean(JSONObject.fromObject(json), o);
	}
	
	/**
	 * 优化
	 * @param is
	 * @return
	 */
	public static String toBean(InputStream is) {
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		byte[] bt = new byte[1024];
		int len = 0;
		try {
			while((len = is.read(bt))!=-1){
				baos.write(bt,0,len);
			}
			is.close();
			baos.close();
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			
		}
		String result = baos.toString();
		return result;
		
	}
	
	/**
	 * 接受参数，返回json 字符串
	 * @param inputStream
	 * @return
	 * @throws IOException
	 */
	public static <T> String toJson(InputStream inputStream) throws IOException {
		BufferedInputStream bis = new BufferedInputStream(inputStream);
		StringBuffer sb = new StringBuffer();
		int len = 0;
		byte[] bt = new byte[1024];
		while ((len = bis.read(bt)) > 0) {
			sb.append(new String(bt, 0, len));
		}
		System.out.println("参数：" + sb.toString());
		String json = sb.toString();
		return json;
	}
	
	
	/**     
     * 从一个JSON数组得到一个java对象数组，形如：     
     * [{"id" : idValue, "name" : nameValue}, {"id" : idValue, "name" : nameValue}, ...]     
     * @param object     
     * @param clazz     
     * @return     
     */       
    @SuppressWarnings("rawtypes")
    public static Object[] getDTOArray(String jsonString, Class clazz){          
        JSONArray array = JSONArray.fromObject(jsonString);    
        Object[] obj = new Object[array.size()];        
        for(int i = 0; i < array.size(); i++){        
            JSONObject jsonObject = array.getJSONObject(i);        
            obj[i] = JSONObject.toBean(jsonObject, clazz);        
        }        
        return obj;        
    }   
    
    
    /**
     * 把Json转对象
     * @param <T>
     * 
     * @param object
     * @return
     */
    public static <T> List<T> toListBean(Object object,Class<T> o) {
        net.sf.json.JSONArray jsonarray = net.sf.json.JSONArray.fromObject(object.toString());
        @SuppressWarnings("unchecked")
        List<T> list = (List<T>) net.sf.json.JSONArray.toCollection(jsonarray, o);
        return list;
    }

}
