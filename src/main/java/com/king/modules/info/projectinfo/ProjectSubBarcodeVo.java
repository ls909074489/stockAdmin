package com.king.modules.info.projectinfo;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;

import com.alibaba.fastjson.JSON;

public class ProjectSubBarcodeVo {

	private String bc;//barcode

	public String getBc() {
		return bc;
	}

	public void setBc(String bc) {
		this.bc = bc;
	}
	
	public static void main(String[] args) {
		List<String> list = new ArrayList<>();
		list.add("aaaaaaa");
		list.add("bbbbbbbbbb");
		
		System.out.println(JSON.toJSONString(list));
		
		List<String> blist = JSON.parseArray("[]", String.class);
		
		for(String b:blist){
			System.out.println(b);
		}
		
		
		List<String> listc = new ArrayList<>(4);
		System.out.println("==================");
		System.out.println(listc);
		listc.add("1");
		listc.add("2");
		listc.add("3");
		listc.add("4");
		listc.add("5");
		for(String b:listc){
			System.out.println(">>>"+b);
		}
		listc = listc.subList(0, 2);
		for(String b:listc){
			System.out.println(">>>"+b);
		}
		
		String [] arr = new String[5];
		for(String a:arr){
			System.out.println(">>>>>>>>>>>>>>>>>>"+a);
		}
		System.out.println(JSON.toJSONString(arr));
		
		List<String> elist = JSON.parseArray(JSON.toJSONString(arr), String.class);
		for(String a:elist){
			System.out.println(">>>>>>>>>>>>>>>>>>"+a);
			System.out.println(StringUtils.isEmpty(a));
		}
	}
	
}
