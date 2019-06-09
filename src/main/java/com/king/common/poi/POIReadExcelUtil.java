package com.king.common.poi;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.text.DecimalFormat;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;

public class POIReadExcelUtil {
	private File excelFile;

	private InputStream fileInStream;

	private Workbook workBook;

	public POIReadExcelUtil(File file) throws Exception {
		this.excelFile = file;
		this.fileInStream = new FileInputStream(this.excelFile);
		this.workBook = WorkbookFactory.create(this.fileInStream);
	}
	/**
	 * 删除一个sheet
	 * 
	 * @param sheetName
	 *            sheet的名称
	 */
	public void removeSheet(String sheetName) {
		Sheet sheet = getSheet(sheetName);
		if(sheet != null){
			this.workBook.removeSheetAt(this.workBook.getSheetIndex(sheetName));
		}
	}
	/**
	 * 读取一个单元格的值
	 * 
	 * @param sheetName
	 *            sheet的名称
	 * @param columnRowNum
	 *            单元格的位置
	 * @return
	 * @throws Exception
	 */
	public Object readCellValue(String sheetName, String columnRowNum)
			throws Exception {
		Sheet sheet = this.workBook.getSheet(sheetName);
		int[] rowNumColumnNum = convertToRowNumColumnNum(columnRowNum);
		int rowNum = rowNumColumnNum[0];
		int columnNum = rowNumColumnNum[1];
		Row row = sheet.getRow(rowNum);
		if (row != null) {
			Cell cell = row.getCell(columnNum);
			if (cell != null) {
				return getCellValue(cell);
			}
		}
		return null;
	}
	/**
	 * 将单元格的行列位置转换为行号和列号
	 * 
	 * @param columnRowNum
	 *            行列位置
	 * @return 长度为2的数组，第1位为行号，第2位为列号
	 */
	public static int[] convertToRowNumColumnNum(String columnRowNum) {
		columnRowNum = columnRowNum.toUpperCase();
		char[] chars = columnRowNum.toCharArray();
		int rowNum = 0;
		int columnNum = 0;
		for (char c : chars) {
			if ((c >= 'A' && c <= 'Z')) {
				columnNum = columnNum * 26 + ((int) c - 64);
			} else {
				rowNum = rowNum * 10 + new Integer(c + "");
			}
		}
		return new int[] { rowNum - 1, columnNum - 1 };
	}
	/**
	 * 单元格是否为空
	 * @param sheetName
	 * @param rowNum
	 * @param cellNum
	 * @return
	 */
	public boolean getValue(Sheet sheet,int rowNum,int cellNum){
		Row row = sheet.getRow(rowNum);
		if(row != null){
			Cell cell = row.getCell(cellNum);
			if(cell != null){
				Object object = getCellValue(cell);
				if(object == null || object.equals("")){
					return false;
				}
			}else{
				return false;
			}
		}else{
			return false;
		}
		return true;
	}
	/**
	 * Excel 数字行号转字母行号
	 * @param num
	 * @return	String
	 */
	public  String getExcelColumnLabel(int num) {  
	    String temp = "";  
	    double i = Math.floor(Math.log(25.0 * (num) / 26.0 + 1) / Math.log(26)) + 1;  
	    if (i > 1) {  
	        double sub = num - 26 * (Math.pow(26, i - 1) - 1) / 25;  
	        for (double j = i; j > 0; j--) {  
	            temp = temp + (char) (sub / Math.pow(26, j - 1) + 65);  
	            sub = sub % Math.pow(26, j - 1);  
	        }  
	    } else {  
	        temp = temp + (char) (num + 65);  
	    }  
	    return temp;  
	}
	
	/**
	 * 获取单元格中的值
	 * @param cell 单元格
	 * @return
	 */
	public  Object getCellValue(Cell cell) {
		DecimalFormat df = new DecimalFormat("#0.0000");
		if (cell == null)
			return "";
		switch (cell.getCellType()) {
		case HSSFCell.CELL_TYPE_NUMERIC:
			if(HSSFDateUtil.isCellDateFormatted(cell)){
				return HSSFDateUtil.getJavaDate(cell.getNumericCellValue());
			}
			return cell.getNumericCellValue();
		case HSSFCell.CELL_TYPE_STRING:
			return cell.getStringCellValue();
		case HSSFCell.CELL_TYPE_FORMULA:
			return cell.getCellFormula();
		case HSSFCell.CELL_TYPE_BLANK:
			return "";
		case HSSFCell.CELL_TYPE_BOOLEAN:
			return cell.getBooleanCellValue() + "";
		case HSSFCell.CELL_TYPE_ERROR:
			return cell.getErrorCellValue() + "";
		}
		return "";
		/*int type = cell.getCellType();
		//1、判断是否是数值格式  
		//if(cell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC){  
		    short format = cell.getCellStyle().getDataFormat();  
		    SimpleDateFormat sdf = null;  
		    if(format == 14 || format == 31 || format == 57 || format == 58){  
		        //日期  
		        sdf = new SimpleDateFormat("yyyy-MM-dd");  
		    }else if (format == 20 || format == 32) {  
		        //时间  
		        sdf = new SimpleDateFormat("HH:mm");  
		    }  
		    double value1 = cell.getNumericCellValue();  
		    Date date = org.apache.poi.ss.usermodel.DateUtil.getJavaDate(value1);  
		  //  result = sdf.format(date);  
		//} 
		switch (type) {
		
		case Cell.CELL_TYPE_STRING:      //String 
			return (Object) cell.getStringCellValue();
		case Cell.CELL_TYPE_NUMERIC:
			Double value = cell.getNumericCellValue();
			return (Object) (value.intValue());
		case Cell.CELL_TYPE_BOOLEAN:
			return (Object) cell.getBooleanCellValue();
		case Cell.CELL_TYPE_FORMULA:  // date
			return	(Object)cell.getDateCellValue();
			///return (Object) cell.getArrayFormulaRange().formatAsString();
		case Cell.CELL_TYPE_BLANK:
			return (Object) "";
		default:
			return null;
		}*/
	}
	public Sheet getSheet(String sheetName){
		return this.workBook.getSheet(sheetName);
	}
}
