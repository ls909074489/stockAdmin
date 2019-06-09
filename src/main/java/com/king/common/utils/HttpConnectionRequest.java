package com.king.common.utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;

import com.king.common.exception.base.CustomException;

/**
 * 网络请求
 * @author WangMin
 *
 */
public class HttpConnectionRequest {
    
    /** 请求方式 **/
    public static final String RequestPostMethod = "POST";
    public static final String RequestGetMethod = "GET";
	
	/**
	 * 请求网络,返回json字符串
	 * @param urlStr
	 * @return
	 * @throws IOException
	 */
	public static String processROSRequest(String urlStr,String requestMethod,String key) throws IOException {
		StringBuffer responseStr = new StringBuffer();
		URL url = new URL(urlStr);
		URLConnection c = (HttpURLConnection) url.openConnection();
		HttpURLConnection con = (HttpURLConnection) c;
		con.setRequestMethod(requestMethod);
		con.setDoOutput(true);
		con.setDoInput(true);
		con.setUseCaches(false);
		String dateStr = DateUtil.formatDate(new Date(), "yyyy-MM-dd HH:00:00");
		String pwdKey = MD5.MD5Encode(dateStr + key);
		con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
		con.setRequestProperty("Pragma", "no-cache");
		con.setRequestProperty("ros-auth", pwdKey);
		String lines;
		BufferedReader reader = new BufferedReader(new InputStreamReader(con.getInputStream(),"UTF-8"));
		while ((lines = reader.readLine()) != null) {
			responseStr.append(lines);
		}
		reader.close();
		con.disconnect();// 断开连接
		return responseStr.toString();
	}
	
	/**
	 * 请求网络,返回json字符串
	 * @param urlStr
	 * @return
	 * @throws IOException
	 */
	public static String processRequest(HttpURLConnection con) throws IOException {
		con.setDoOutput(true);// 是否输入参数
		con.setDoInput(true);
		con.setUseCaches(false);
		String lines = null;
		BufferedReader reader = new BufferedReader(new InputStreamReader(con.getInputStream(),"UTF-8"));
		StringBuffer responseStr = new StringBuffer();
		while ((lines = reader.readLine()) != null) {
			responseStr.append(lines);
		}
		reader.close();
		con.disconnect();// 断开连接
		return responseStr.toString();
	}
	
	/**
     * 请求网络,返回json字符串
     * @param urlStr
     * @return
     * @throws IOException
     */
    public static String processRequest(HttpURLConnection con,String requestMethod) throws IOException {
        con.setRequestMethod(requestMethod);//设置是post请求还是get方式请求
        con.setDoOutput(true);// 是否输入参数
        con.setDoInput(true);
        con.setUseCaches(false);
        String lines = null;
        BufferedReader reader = new BufferedReader(new InputStreamReader(con.getInputStream(),"UTF-8"));
        StringBuffer responseStr = new StringBuffer();
        while ((lines = reader.readLine()) != null) {
            responseStr.append(lines);
        }
        reader.close();
        con.disconnect();// 断开连接
        return responseStr.toString();
    }
    
    /**
     * 请求网络,返回json字符串
     * @param urlStr
     * @return
     * @throws IOException
     */
    public static String processRequest(String urlStr,String requestMethod) throws IOException {
    	URL url = new URL(urlStr);
        URLConnection c = (HttpURLConnection) url.openConnection();
        HttpURLConnection con = (HttpURLConnection) c;
        con.setRequestMethod(requestMethod);//设置是post请求还是get方式请求
        con.setDoOutput(true);// 是否输入参数
        con.setDoInput(true);
        con.setUseCaches(false);
        String lines = null;
        
        int statusCode = con.getResponseCode();
        if (statusCode != 200) {
        	throw new IOException("网络请求状态:"+statusCode);
		}
        BufferedReader reader = new BufferedReader(new InputStreamReader(con.getInputStream(),"UTF-8"));
        StringBuffer responseStr = new StringBuffer();
        while ((lines = reader.readLine()) != null) {
            responseStr.append(lines);
        }
        reader.close();
        con.disconnect();// 断开连接
        return responseStr.toString();
    }
    
    
    /**
     * post请求
     * @param url
     * @param paramMap
     * @return
     * @throws IOException
     * @throws CustomException
     */
    public static String postMethodRequest(String url, Map<String, Object> paramMap) throws IOException, CustomException {
        //Calendar calendar = Calendar.getInstance();
        HttpClient httpClient = HttpClientBuilder.create().build();
        HttpPost httpPost = new HttpPost(url);
        List<BasicNameValuePair> httpParams = new ArrayList<BasicNameValuePair>();
        if(paramMap != null && !paramMap.isEmpty()) {
        	for(String key : paramMap.keySet()) {
        		httpParams.add(new BasicNameValuePair(key, String.valueOf(paramMap.get(key))));
        	}
        }
        //httpParams.add(new BasicNameValuePair("key", ""));
        //httpParams.add(new BasicNameValuePair("time", String.valueOf(time)));
        httpPost.setEntity(new UrlEncodedFormEntity(httpParams, "UTF-8"));
        RequestConfig requestConfig = RequestConfig.custom().setConnectionRequestTimeout(600000).setConnectTimeout(600000).setSocketTimeout(600000).build();                        
        httpPost.setConfig(requestConfig);
        HttpResponse response = httpClient.execute(httpPost);
        String responseStr =  EntityUtils.toString(response.getEntity(),"UTF-8");
        httpPost.releaseConnection();
        return responseStr;
    }
    
    
    /**
     * post请求
     * @param url
     * @param json
     * @return
     * @throws Exception
     */
    public static String jsonPostMethodRequest(String url, String json) throws Exception { 
        HttpClient httpClient = HttpClientBuilder.create().build();
        HttpPost httpPost = new HttpPost(url);
        StringEntity jsonEntity = new StringEntity("", "UTF-8");
		jsonEntity.setContentEncoding("UTF-8");
		httpPost.setEntity(jsonEntity);
        RequestConfig requestConfig = RequestConfig.custom().setConnectionRequestTimeout(600000).setConnectTimeout(600000).setSocketTimeout(600000).build();                        
        httpPost.setConfig(requestConfig);
        HttpResponse response = httpClient.execute(httpPost);
        String responseStr =  EntityUtils.toString(response.getEntity(),"UTF-8");
        httpPost.releaseConnection();
        return responseStr;
    }
    
    /**
     * get 请求
     * @param url
     * @param paramMap
     * @return
     * @throws Exception
     */
	public static String getMethodRequest(String url, Map<String, Object> paramMap) throws Exception {
		StringBuilder sb = new StringBuilder();
		if(paramMap == null || paramMap.isEmpty()) {
			return processRequest(url, RequestGetMethod);
		}
		int i = 0;
		int mapSize = paramMap.size();
		for(String key : paramMap.keySet()) {
			sb.append(key + "=" + String.valueOf(paramMap.get(key)));
			i++;
			if(i != mapSize) {
				sb.append("&");
			}
		}
		url = url + "?" + sb.toString();
		return processRequest(url, RequestGetMethod);
	}
    
	/**
	 * get 请求
	 * @param url
	 * @return
	 * @throws Exception
	 */
	public static String getMethodRequest(String url) throws Exception {
		return processRequest(url, RequestGetMethod);
	}
	
	/**
	 * restful 风格的请求
	 * @throws IOException 
	 */
	public static String restfulRequest(String fullUrl,String input) throws IOException{
		StringBuffer resultStr = new StringBuffer();
		
		URL targetUrl = new URL(fullUrl);
		HttpURLConnection httpConnection = (HttpURLConnection) targetUrl.openConnection();
		httpConnection.setDoOutput(true);
		httpConnection.setRequestMethod("POST");
		httpConnection.setRequestProperty("Content-Type","application/json");
		OutputStream outputStream = httpConnection.getOutputStream();
		outputStream.write(input.getBytes("utf-8"));
		outputStream.flush();
		if (httpConnection.getResponseCode() != 200) {
			throw new IOException("http请求异常 " + httpConnection.getResponseCode());
		}
		BufferedReader responseBuffer = new BufferedReader(new InputStreamReader((httpConnection.getInputStream()),"utf-8"));
		String temp ="";
		while ((temp = responseBuffer.readLine()) != null) {
			resultStr.append(temp);
		}
		httpConnection.disconnect();
		return resultStr.toString();
	}
	
}



