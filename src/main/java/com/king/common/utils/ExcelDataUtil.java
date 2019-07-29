package com.king.common.utils;

import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.hibernate.service.spi.ServiceException;
import org.springframework.util.StringUtils;


public class ExcelDataUtil {

	public static final String EMPTY = "";
	public static final String POINT = ".";
	public static final String OFFICE_EXCEL_2003_POSTFIX = "xls";
	public static final String OFFICE_EXCEL_2010_POSTFIX = "xlsx";
	
	public static Pattern p = Pattern.compile("\\s*|\t|\r|\n");//去掉回车换行退格
	
	
	public static void main(String[] args) {
		String col="CD";
		System.out.println(excelColtoNum(col,col.length()- 1));
		System.out.println(excelColIndexToStr(excelColtoNum(col,col.length()- 1)));
		
		System.out.println("--"+replaceSpace(" 11 ")+"===");
	}
	  
	
	public static String replaceSpace(String str){
		if(StringUtils.isEmpty(str)){
			throw new ServiceException("不能为空");
		}
		Matcher m = p.matcher(str);
		str = m.replaceAll("");
		str=str.replaceAll(" ", "");//去掉全角空格
		return str.trim();
	}
	
	
	/**
	 * 将excel的列转为数值 
	 * excelColtoNum(col,col.length()- 1)
	 * @param x
	 * @param end
	 * @return
	 */
	public static int excelColtoNum(String x, int end) {  
        int n = x.toCharArray()[end] - 'A';  
        if (end == 0){
        	 return n;
        }
        return (excelColtoNum(x, end - 1) + 1) * 26 + n;  
    }  
	    
	/**
	 * 将EXCEL中A,B,C,D,E列映射成0,1,2,3
	 * 
	 * @param col
	 */
	public static int getExcelCol(String col) {
		col = col.toUpperCase();
		// 从-1开始计算,字母重1开始运算。这种总数下来算数正好相同。
		int count = -1;
		char[] cs = col.toCharArray();
		for (int i = 0; i < cs.length; i++) {
			count += (cs[i] - 64) * Math.pow(26, cs.length - 1 - i);
		}
		return count;
	}


	/** 
     * 该方法用来将具体的数据转换成Excel中的ABCD列 
     * @param int：需要转换成字母的数字 
     * @return column:ABCD列名称 
     * **/  
    public static String excelColIndexToStr(int columnIndex) {  
        if (columnIndex <= 0) {  
            return null;  
        }  
        String columnStr = "";  
        columnIndex--;  
        do {  
            if (columnStr.length() > 0) {  
                columnIndex--;  
            }  
            columnStr = ((char) (columnIndex % 26 + (int) 'A')) + columnStr;  
            columnIndex = (int) ((columnIndex - columnIndex % 26) / 26);  
        } while (columnIndex > 0);  
        return columnStr;  
    }  
	
	
	public static String getPostfix(String path) {
		if (path == null || ExcelDataUtil.EMPTY.equals(path.trim())) {
			return ExcelDataUtil.EMPTY;
		}
		if (path.contains(ExcelDataUtil.POINT)) {
			return path.substring(path.lastIndexOf(ExcelDataUtil.POINT) + 1, path.length());
		}
		return ExcelDataUtil.EMPTY;
	}
	
	/**
	 * 字符串转为日期
	 * @param dateStr
	 * @return
	 */
	public  static Date changeStrToDate(String dateStr,SimpleDateFormat sdf){
		Date date=null;
		if(!StringUtils.isEmpty(dateStr)){
			try {
				//1997/5/2
				dateStr=dateStr.replaceAll("/", "-");
				dateStr=dateStr.replaceAll("/", "-");
				dateStr=dateStr.replaceAll("年", "-");
				dateStr=dateStr.replaceAll("月", "-");
				dateStr=dateStr.replaceAll("日", "");
				String []dateArr=dateStr.split("-");//1997-5-2
				dateStr="";
				for(int i=0;i<dateArr.length;i++){
					if(dateArr[i].length()==1){
						dateArr[i]="0"+dateArr[i];//前面补0
					}
					if(i==0){
						dateStr=dateArr[i];
					}else{
						dateStr=dateStr+"-"+dateArr[i];
					}
				}
				date=sdf.parse(dateStr);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		return date;
	}
	
	public static String getValue(HSSFCell hssfCell) {
		if(hssfCell==null){
			return "";
		}
		String value="";
//		DecimalFormat df = new DecimalFormat("0");// 格式化 number String
//		// 字符
//		SimpleDateFormat sdf = new SimpleDateFormat(
//		"yyyy-MM-dd HH:mm:ss");// 格式化日期字符串
//		DecimalFormat nf = new DecimalFormat("0.00");// 格式化数字
		switch (hssfCell.getCellType()) {
		case XSSFCell.CELL_TYPE_STRING:
			value = hssfCell.getStringCellValue();
			break;
		case XSSFCell.CELL_TYPE_NUMERIC:
//			if ("@".equals(hssfCell.getCellStyle().getDataFormatString())) {
//				value = df.format(hssfCell.getNumericCellValue());
//			} else if ("General".equals(hssfCell.getCellStyle()
//			.getDataFormatString())) {
//				value = nf.format(hssfCell.getNumericCellValue());
//			} else {
//			value = sdf.format(HSSFDateUtil.getJavaDate(hssfCell
//			.getNumericCellValue()));
//			}
//			break;
			value = hssfCell.toString();
			break;
		case XSSFCell.CELL_TYPE_BOOLEAN:
			if(hssfCell.getBooleanCellValue()){
				value="真";
			}else{
				value="假";
			}
			break;
		case XSSFCell.CELL_TYPE_BLANK:
			value = "";
			break;
		default:
			value = hssfCell.toString();
		}
		return value;
	}
	
	public static String getValue(HSSFCell hssfCell,DecimalFormat df,SimpleDateFormat sdf,DecimalFormat nf) {
		if(hssfCell==null){
			return "";
		}
		String value="";
//		DecimalFormat df = new DecimalFormat("0");// 格式化 number String
//		// 字符
//		SimpleDateFormat sdf = new SimpleDateFormat(
//		"yyyy-MM-dd HH:mm:ss");// 格式化日期字符串
//		DecimalFormat nf = new DecimalFormat("0.00");// 格式化数字
		switch (hssfCell.getCellType()) {
		case XSSFCell.CELL_TYPE_STRING:
			value = hssfCell.getStringCellValue();
			break;
		case XSSFCell.CELL_TYPE_NUMERIC:
			if ("@".equals(hssfCell.getCellStyle().getDataFormatString())) {
				value = df.format(hssfCell.getNumericCellValue());
			} else if ("General".equals(hssfCell.getCellStyle()
			.getDataFormatString())) {
				value = nf.format(hssfCell.getNumericCellValue());
			} else {
			value = sdf.format(HSSFDateUtil.getJavaDate(hssfCell
			.getNumericCellValue()));
			}
			break;
		case XSSFCell.CELL_TYPE_BOOLEAN:
			if(hssfCell.getBooleanCellValue()){
				value="真";
			}else{
				value="假";
			}
			break;
		case XSSFCell.CELL_TYPE_BLANK:
			value = "";
			break;
		default:
			value = hssfCell.toString();
		}
		return value;
	}
	
	
	public static String getValue(XSSFCell xssfCell) {
		if(xssfCell==null){
			return "";
		}
		String value="";
//		DecimalFormat df = new DecimalFormat("0");// 格式化 number String
//		// 字符
//		SimpleDateFormat sdf = new SimpleDateFormat(
//		"yyyy-MM-dd HH:mm:ss");// 格式化日期字符串
//		DecimalFormat nf = new DecimalFormat("0.00");// 格式化数字
		switch (xssfCell.getCellType()) {
		case XSSFCell.CELL_TYPE_STRING:
			value = xssfCell.getStringCellValue();
			break;
		case XSSFCell.CELL_TYPE_NUMERIC:
//			if ("@".equals(hssfCell.getCellStyle().getDataFormatString())) {
//				value = df.format(hssfCell.getNumericCellValue());
//			} else if ("General".equals(hssfCell.getCellStyle()
//			.getDataFormatString())) {
//				value = nf.format(hssfCell.getNumericCellValue());
//			} else {
//			value = sdf.format(HSSFDateUtil.getJavaDate(hssfCell
//			.getNumericCellValue()));
//			}
//			break;
			value = xssfCell.toString();
			break;
		case XSSFCell.CELL_TYPE_BOOLEAN:
			if(xssfCell.getBooleanCellValue()){
				value="真";
			}else{
				value="假";
			}
			break;
		case XSSFCell.CELL_TYPE_BLANK:
			value = "";
			break;
		default:
			value = xssfCell.toString();
		}
		return value;
	}
	
	public static String getValue(XSSFCell xssfCell,DecimalFormat df,SimpleDateFormat sdf,DecimalFormat nf) {
		if(xssfCell==null){
			return "";
		}
		String value="";
//		DecimalFormat df = new DecimalFormat("0");// 格式化 number String
//		// 字符
//		SimpleDateFormat sdf = new SimpleDateFormat(
//		"yyyy-MM-dd HH:mm:ss");// 格式化日期字符串
//		DecimalFormat nf = new DecimalFormat("0.00");// 格式化数字
		switch (xssfCell.getCellType()) {
		case XSSFCell.CELL_TYPE_STRING:
			value = xssfCell.getStringCellValue();
			break;
		case XSSFCell.CELL_TYPE_NUMERIC:
			if ("@".equals(xssfCell.getCellStyle().getDataFormatString())) {
				value = df.format(xssfCell.getNumericCellValue());
			} else if ("General".equals(xssfCell.getCellStyle()
			.getDataFormatString())) {
				value = nf.format(xssfCell.getNumericCellValue());
			} else {
			value = sdf.format(HSSFDateUtil.getJavaDate(xssfCell
			.getNumericCellValue()));
			}
			break;
		case XSSFCell.CELL_TYPE_BOOLEAN:
			if(xssfCell.getBooleanCellValue()){
				value="真";
			}else{
				value="假";
			}
			break;
		case XSSFCell.CELL_TYPE_BLANK:
			value = "";
			break;
		default:
			value = xssfCell.toString();
		}
		return value;
	}
	
	public static String getValue(HSSFCell hssfCell,DecimalFormat df) {
		if(hssfCell==null){
			return "";
		}
		String value="";
//		DecimalFormat df = new DecimalFormat("0");// 格式化 number String
//		// 字符
//		SimpleDateFormat sdf = new SimpleDateFormat(
//		"yyyy-MM-dd HH:mm:ss");// 格式化日期字符串
//		DecimalFormat nf = new DecimalFormat("0.00");// 格式化数字
		switch (hssfCell.getCellType()) {
		case XSSFCell.CELL_TYPE_STRING:
			value = hssfCell.getStringCellValue();
			break;
		case XSSFCell.CELL_TYPE_NUMERIC:
//			if ("@".equals(hssfCell.getCellStyle().getDataFormatString())) {
//				value = df.format(hssfCell.getNumericCellValue());
//			} else if ("General".equals(hssfCell.getCellStyle()
//			.getDataFormatString())) {
//				value = nf.format(hssfCell.getNumericCellValue());
//			} else {
//			value = sdf.format(HSSFDateUtil.getJavaDate(hssfCell
//			.getNumericCellValue()));
//			}
//			break;
			 value=df.format(hssfCell.getNumericCellValue());  
			break;
		case XSSFCell.CELL_TYPE_BOOLEAN:
			if(hssfCell.getBooleanCellValue()){
				value="真";
			}else{
				value="假";
			}
			break;
		case XSSFCell.CELL_TYPE_BLANK:
			value = "";
			break;
		default:
			value = hssfCell.toString();
		}
		return value;
	}
	
	public static String getValue(XSSFCell xssfRow,DecimalFormat df) {
		if(xssfRow==null){
			return "";
		}
		String value="";
		// 字符
//		SimpleDateFormat sdf = new SimpleDateFormat(
//		"yyyy-MM-dd HH:mm:ss");// 格式化日期字符串
//		DecimalFormat nf = new DecimalFormat("0.00");// 格式化数字
		switch (xssfRow.getCellType()) {
			case XSSFCell.CELL_TYPE_STRING:
				value = xssfRow.getStringCellValue();
				break;
			case XSSFCell.CELL_TYPE_NUMERIC:
				/*if ("@".equals(xssfRow.getCellStyle().getDataFormatString())) {
					value = df.format(xssfRow.getNumericCellValue());
				} else if ("General".equals(xssfRow.getCellStyle()
				.getDataFormatString())) {
					value = nf.format(xssfRow.getNumericCellValue());
				} else {
					value = sdf.format(HSSFDateUtil.getJavaDate(xssfRow
							.getNumericCellValue()));
				}*/
				 value=df.format(xssfRow.getNumericCellValue());  
				break;
			case XSSFCell.CELL_TYPE_BOOLEAN:
				if(xssfRow.getBooleanCellValue()){
					value="真";
				}else{
					value="假";
				}
				break;
			case XSSFCell.CELL_TYPE_BLANK:
				value = "";
				break;
			default:
				value = xssfRow.toString();
		}
		return value.trim();
	}
	
	/**
	 * 中文性别转换为枚举类型表示
	 * @param sex
	 * @return
	 */
	public static String changeSex(String sex){
		String tSex="";
		if(!StringUtils.isEmpty(sex)){
			if("男".equals(sex.trim())){
				tSex="1";
			}else if("女".equals(sex.trim())){
				tSex="0";
			}
		}
		return tSex;
	}
	
	
	/**
	 * 备份导入的文件
	 * @Title: backupExcelFile 
	 * @author liusheng
	 * @date 2017年3月11日 下午2:10:07 
	 * @param @param file 设定文件 
	 * @return void 返回类型 
	 * @throws
	 */
//	public static void backupExcelFile(MultipartFile file,String folderName){
//		 String path = ParameterUtil.getParamValue("ImportExcelBackupPath", "E:\\project\\zsdx\\apache-tomcat-7.0.68")+File.separator+folderName;
//	        String fileName = DateUtil.getDateTimeZone()+"_"+file.getOriginalFilename();  
//	        File targetFile = new File(path, fileName);  
//	        if(!targetFile.exists()){  
//	            targetFile.mkdirs();  
//	        }  
//	        //保存  
//	        try {  
//	            file.transferTo(targetFile);  
//	        } catch (Exception e) {  
//	            e.printStackTrace();  
//	        } 
//	}
	
	
	/**
     * 分多种格式解析单元格的值
     *
     * @param cell  单元格
     * @return  单元格的值
     */
    public static String convertCellToString(Cell cell){
        //如果为null会抛出异常，应当返回空字符串
        if (cell == null)
            return "";

        //POI对单元格日期处理很弱，没有针对的类型，日期类型取出来的也是一个double值，所以同样作为数值类型
        //解决日期2006/11/02格式读入后出错的问题，POI读取后变成“02-十一月-2006”格式
        if(cell.toString().contains("-") && checkDate(cell.toString())){
            String ans = "";
            try {
                ans = new SimpleDateFormat("yyyy-MM-dd").format(cell.getDateCellValue());
            } catch (Exception e) {
                ans = cell.toString();
            }
            return ans;
        }

        cell.setCellType(XSSFCell.CELL_TYPE_STRING);
        return cell.getStringCellValue();
    }

    /**
     * 判断是否是“02-十一月-2006”格式的日期类型
     */
    private static boolean checkDate(String str){
        String[] dataArr =str.split("-");
        try {
            if(dataArr.length == 3){
                int x = Integer.parseInt(dataArr[0]);
                String y =  dataArr[1];
                int z = Integer.parseInt(dataArr[2]);
                if(x>0 && x<32 && z>0 && z< 10000 && y.endsWith("月")){
                    return true;
                }
            }
        } catch (Exception e) {
            return false;
        }
        return false;
    }
}
