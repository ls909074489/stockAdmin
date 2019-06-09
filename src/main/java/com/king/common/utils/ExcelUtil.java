package com.king.common.utils;

import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;

import com.king.frame.utils.RequestUtil;

public class ExcelUtil {

	public void downExcel(HttpServletResponse response,HttpServletRequest request,String mainId){
		OutputStream os = null;
		Workbook wb = null;
		try {
			os = response.getOutputStream();// 取得输出流   
	        response.reset();// 清空输出流   
	        
	        response.setContentType("application/octet-stream; charset=utf-8");
			String explorerType = RequestUtil.getExplorerType(request);
			String exportName="";
			
			if (explorerType == null || explorerType.contains("IE")) {// IE
				response.setHeader("Content-Disposition",
						"attachment; filename=\"" + RequestUtil.encode(exportName, "utf-8")+".xlsx" + "\"");
			} else {// fireFox/Chrome
				response.setHeader("Content-Disposition",
						"attachment; filename=" + new String(exportName.getBytes("utf-8"), "ISO8859-1")+".xlsx");
			}
	        response.setContentType("application/msexcel");// 定义输出类型 
	        
			wb = new SXSSFWorkbook(100); 

			createSheet(wb, "test1Sheet");
			createSheet(wb, "test2Sheet");
			wb.write(os);
		}catch(Exception ex) { 
			ex.printStackTrace(); 
		}finally{
			try {
				if(wb!=null){
					wb.close();
				}
				if(os!=null){
					os.close();// 关闭流
				}
			} catch (IOException e) {
				e.printStackTrace();
			} 
		} 
	}
	
	private void createSheet(Workbook wb,String sheetname){
		Sheet sh = wb.createSheet(sheetname);
		int rownum=0;
		Row row=null;
		Cell cell =null;
		row = sh.createRow(rownum);
		
		for(int i=0;i<10;i++){
			rownum++;
			row = sh.createRow(rownum);
			
			cell = row.createCell(1);
			cell.setCellValue("第一列数据");
			cell = row.createCell(2);
			cell.setCellValue("第二列数据");
			cell = row.createCell(3);
			cell.setCellValue("第三列数据");
			cell = row.createCell(4);
			cell.setCellValue("第四列数据");
			cell = row.createCell(5);
			cell.setCellValue("第五列数据");
		}
	}
}
