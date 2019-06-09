package com.king.common.poi;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.DataFormat;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.ss.util.CellRangeAddressList;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFDataValidation;
import org.apache.poi.xssf.usermodel.XSSFDataValidationConstraint;
import org.apache.poi.xssf.usermodel.XSSFDataValidationHelper;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

/**
 * Excel工具类
 * 
 * <pre>
 * 基于Apache的POI类库
 * </pre>
 */
public class POIExcelMakerUtil {

	private File excelFile;

	private InputStream fileInStream;

	private Workbook workBook;

	private Sheet sheet = null;

	private Row row;

	private Cell cell;

	private Workbook zxssf;

	public POIExcelMakerUtil() {

	}

	public POIExcelMakerUtil(File file) throws Exception {
		this.excelFile = file;
		this.fileInStream = new FileInputStream(this.excelFile);
		this.workBook = WorkbookFactory.create(this.fileInStream);
	}

	public POIExcelMakerUtil(File file, String sheetname) throws Exception {
		this.excelFile = file;
		this.fileInStream = new FileInputStream(this.excelFile);
		this.workBook = WorkbookFactory.create(this.fileInStream);
		this.sheet = this.workBook.getSheet(sheetname);
	}

	public void closePoi() {
		this.workBook = null;
		this.fileInStream = null;
		this.excelFile = null;
	}

	public POIExcelMakerUtil(File file, String sheetname, int i) throws Exception {
		this.excelFile = file;
		this.fileInStream = new FileInputStream(this.excelFile);
		this.zxssf = WorkbookFactory.create(this.fileInStream);
		this.workBook = new SXSSFWorkbook((XSSFWorkbook) this.zxssf, 500);
		this.sheet = this.workBook.getSheet(sheetname);
	}

	/**
	 * 根据地址，创建表格，并建立名为sheetName的页签 直接创建文件
	 * 
	 * @param path
	 * @param sheetName
	 * @throws Exception
	 */
	public POIExcelMakerUtil(String path, String sheetName) throws Exception {
		XSSFWorkbook workbook = new XSSFWorkbook();
		FileOutputStream fileOut = new FileOutputStream(path);
		workbook.createSheet(sheetName);
		workbook.write(fileOut);
		fileOut.close();
		workbook.close();
		generateWorkBook(path, sheetName);

	}

	/**
	 * 
	 * @param path
	 * @throws Exception
	 */
	private void generateWorkBook(String path, String sheetname) throws Exception {
		File file = new File(path);
		this.excelFile = file;
		this.fileInStream = new FileInputStream(this.excelFile);
		this.workBook = WorkbookFactory.create(this.fileInStream);
		this.sheet = this.workBook.getSheet(sheetname);
	}

	/**
	 * 自动设置列宽 this.sheet
	 * 
	 * @param num
	 */
	public void setSizeColumn(int num, int valuelength) {
		// this.workBook.getSheet(sheetName).autoSizeColumn(num);
		// this.sheet.autoSizeColumn(num);
		this.sheet.setColumnWidth(num, valuelength * 256 + 256);
	}

	/**
	 * 自动设置列宽
	 * 
	 * @param sheetName
	 * @param num
	 */
	public void setSizeColumn(String sheetName, int num, int valuelength) {
		// this.workBook.getSheet(sheetName).autoSizeColumn(num);
		this.workBook.getSheet(sheetName).setColumnWidth(num, valuelength * 256 + 256);
	}

	/**
	 * 得到一个字符串的长度,显示的长度,一个汉字或日韩文长度为2,英文字符长度为1
	 * 
	 * @param String
	 *            s 需要得到长度的字符串
	 * @return int 得到的字符串长度
	 */
	public int length(String s) {
		if (s == null)
			return 0;
		char[] c = s.toCharArray();
		int len = 0;
		for (int i = 0; i < c.length; i++) {
			len++;
			if (!isLetter(c[i])) {
				len++;
			}
		}
		return len;
	}

	public boolean isLetter(char c) {
		int k = 0x80;
		return c / k == 0 ? true : false;
	}

	/**
	 * 隐藏行列 不隐藏行 row = -1 不隐藏列 num = -1
	 * 
	 * @param sheetName
	 * @param row
	 *            行
	 * @param num
	 *            列
	 */
	public void setHidden(String sheetName, int row, int num) {
		if (row > -1) { // 影藏行
			this.workBook.getSheet(sheetName).getRow(row).setZeroHeight(true);
		}
		if (num > -1) { // 隐藏列
			this.workBook.getSheet(sheetName).setColumnHidden(num, true);
		}
	}

	/**
	 * 设置某些列的值只能输入预制的数据,显示下拉框. this.sheet
	 * 
	 * @param textlist
	 *            下拉框显示的内容
	 * @param firstRow
	 *            开始行
	 * @param endRow
	 *            结束行
	 * @param firstCol
	 *            开始列
	 * @param endCol
	 *            结束列
	 * @return 设置好的sheet.
	 */
	public void setAllFValidation(String sheetName, String[] textlist, int firstRow, int endRow, int firstCol,
			int endCol, String path) {
		/*
		 * // 加载下拉列表内容 DVConstraint constraint = CTDataValidation.createExplicitListConstraint(textlist); //
		 * 设置数据有效性加载在哪个单元格上,四个参数分别是：起始行、终止行、起始列、终止列 CellRangeAddressList regions = new
		 * CellRangeAddressList(firstRow,endRow, firstCol, endCol); // 数据有效性对象 XSSFDataValidation data_validation_list =
		 * new XSSFDataValidation(regions, (CTDataValidation) constraint);
		 */
		File file = new File(path);
		InputStream fileInStreams = null;
		Workbook workBooks = null;
		try {
			fileInStreams = new FileInputStream(file);
			workBooks = new XSSFWorkbook(fileInStreams);
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		XSSFDataValidationHelper dvHelper = new XSSFDataValidationHelper((XSSFSheet) workBooks.getSheet(sheetName));
		XSSFDataValidationConstraint dvConstraint = (XSSFDataValidationConstraint) dvHelper
				.createExplicitListConstraint(textlist);
		CellRangeAddressList addressList = new CellRangeAddressList(firstRow, endRow, firstCol, endCol);
		XSSFDataValidation validation = (XSSFDataValidation) dvHelper.createValidation(dvConstraint, addressList);
		validation.createErrorBox("输入值有误", "请从下拉框中选择");
		validation.setShowErrorBox(true);
		workBooks.getSheet(sheetName).addValidationData(validation);
		if (workBooks != null) {
			try {
				FileOutputStream fileOutStream = new FileOutputStream(file);
				workBooks.write(fileOutStream);

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if (fileInStreams != null) {
					try {
						fileInStreams.close();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} finally {
						fileInStreams = null;
					}
				}
				if (workBooks != null) {
					try {
						workBooks.close();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} finally {
						workBooks = null;
					}
				}
			}
		}
	}

	/**
	 * 设置某些列的值只能输入预制的数据,显示下拉框.
	 * 
	 * @param sheetName
	 *            要设置的sheetName.
	 * @param textlist
	 *            下拉框显示的内容
	 * @param firstRow
	 *            开始行
	 * @param endRow
	 *            结束行
	 * @param firstCol
	 *            开始列
	 * @param endCol
	 *            结束列
	 * @return 设置好的sheet.
	 */
	public void setHSSFValidation(String sheetName, String[] textlist, int firstRow, int endRow, int firstCol,
			int endCol) {
		/*
		 * // 加载下拉列表内容 DVConstraint constraint = CTDataValidation.createExplicitListConstraint(textlist); //
		 * 设置数据有效性加载在哪个单元格上,四个参数分别是：起始行、终止行、起始列、终止列 CellRangeAddressList regions = new
		 * CellRangeAddressList(firstRow,endRow, firstCol, endCol); // 数据有效性对象 XSSFDataValidation data_validation_list =
		 * new XSSFDataValidation(regions, (CTDataValidation) constraint);
		 */

		// Workbook workBook =
		XSSFDataValidationHelper dvHelper = new XSSFDataValidationHelper((XSSFSheet) this.workBook.getSheet(sheetName));
		XSSFDataValidationConstraint dvConstraint = (XSSFDataValidationConstraint) dvHelper
				.createExplicitListConstraint(textlist);
		CellRangeAddressList addressList = new CellRangeAddressList(firstRow, endRow, firstCol, endCol);
		XSSFDataValidation validation = (XSSFDataValidation) dvHelper.createValidation(dvConstraint, addressList);
		validation.createErrorBox("输入值有误", "请从下拉框中选择");
		validation.setShowErrorBox(true);
		this.workBook.getSheet(sheetName).addValidationData(validation);

	}

	/**
	 * 设置某些列的值只能输入预制的数据,显示下拉框.
	 * 
	 * @param sheetName
	 *            要设置的sheetName.
	 * @param textlist
	 *            下拉框显示的内容
	 * @param firstRow
	 *            开始行
	 * @param endRow
	 *            结束行
	 * @param firstCol
	 *            开始列
	 * @param endCol
	 *            结束列
	 * @return 设置好的sheet.
	 */
	public void setHSSFValidationNotSheet(String[] textlist, int firstRow, int endRow, int firstCol, int endCol) {
		/*
		 * // 加载下拉列表内容 DVConstraint constraint = CTDataValidation.createExplicitListConstraint(textlist); //
		 * 设置数据有效性加载在哪个单元格上,四个参数分别是：起始行、终止行、起始列、终止列 CellRangeAddressList regions = new
		 * CellRangeAddressList(firstRow,endRow, firstCol, endCol); // 数据有效性对象 XSSFDataValidation data_validation_list =
		 * new XSSFDataValidation(regions, (CTDataValidation) constraint);
		 */

		XSSFDataValidationHelper dvHelper = new XSSFDataValidationHelper((XSSFSheet) this.sheet);
		XSSFDataValidationConstraint dvConstraint = (XSSFDataValidationConstraint) dvHelper
				.createExplicitListConstraint(textlist);
		CellRangeAddressList addressList = new CellRangeAddressList(firstRow, endRow, firstCol, endCol);
		XSSFDataValidation validation = (XSSFDataValidation) dvHelper.createValidation(dvConstraint, addressList);
		validation.createErrorBox("输入值有误", "请从下拉框中选择");
		validation.setShowErrorBox(true);
		this.sheet.addValidationData(validation);
	}

	/**
	 * 设置单元格上提示
	 * 
	 * @param sheetName
	 *            要设置的sheet.
	 * @param promptTitle
	 *            标题
	 * @param promptContent
	 *            内容
	 * @param firstRow
	 *            开始行
	 * @param endRow
	 *            结束行
	 * @param firstCol
	 *            开始列
	 * @param endCol
	 *            结束列
	 * 
	 */
	public void setHSSFPrompt(String sheetName, String promptTitle, String promptContent, int firstRow, int endRow,
			int firstCol, int endCol) {
		/*
		 * // 构造constraint对象 DVConstraint constraint = DVConstraint.createCustomFormulaConstraint("BB1"); //
		 * 四个参数分别是：起始行、终止行、起始列、终止列 CellRangeAddressList regions = new CellRangeAddressList(firstRow,endRow,firstCol,
		 * endCol); // 数据有效性对象 HSSFDataValidation data_validation_view = new HSSFDataValidation(regions,constraint);
		 * data_validation_view.createPromptBox(promptTitle, promptContent);
		 * this.workBook.getSheet(sheetName).addValidationData(data_validation_view);
		 */
		XSSFDataValidationHelper dvHelper = new XSSFDataValidationHelper((XSSFSheet) this.workBook.getSheet(sheetName));
		/*
		 * XSSFDataValidationConstraint dvConstraint = (XSSFDataValidationConstraint) dvHelper
		 * .createExplicitListConstraint(textlist);
		 */
		XSSFDataValidationConstraint dvConstraint = (XSSFDataValidationConstraint) dvHelper
				.createCustomConstraint(promptContent);
		CellRangeAddressList addressList = new CellRangeAddressList(firstRow, endRow, firstCol, endCol);
		XSSFDataValidation validation = (XSSFDataValidation) dvHelper.createValidation(dvConstraint, addressList);
		validation.createPromptBox(promptTitle, promptContent);
		this.workBook.getSheet(sheetName).addValidationData(validation);
	}

	/**
	 * 根据sheet合并单元格
	 * 
	 * @param firstRow
	 * @param lastRow
	 * @param firstCol
	 * @param lastCol
	 * @param sheetName
	 */
	public void MergeCells(int firstRow, int lastRow, int firstCol, int lastCol, String sheetName) {
		CellRangeAddress cra = new CellRangeAddress(firstRow, lastRow, firstCol, lastCol);
		this.workBook.getSheet(sheetName).addMergedRegion(cra);
	}

	/**
	 * 根据sheet合并单元格 this
	 * 
	 * @param firstRow
	 * @param lastRow
	 * @param firstCol
	 * @param lastCol
	 * 
	 */
	public void MergeCells(int firstRow, int lastRow, int firstCol, int lastCol) {
		CellRangeAddress cra = new CellRangeAddress(firstRow, lastRow, firstCol, lastCol);
		this.sheet.addMergedRegion(cra);
	}

	/**
	 * 新建sheet
	 * 
	 * @param sheetName
	 */
	public void createSheet(String sheetName) {
		this.workBook.createSheet(sheetName);
	}

	/**
	 * 按位置新建sheet
	 * 
	 * @param sheetName
	 */
	public void createSheet(String sheetName, int pos) {
		this.workBook.createSheet(sheetName);
		this.workBook.setSheetOrder(sheetName, pos);
	}

	/**
	 * 设置sheet位置
	 * 
	 * @param sheetName
	 */
	public void setSheetOrder(String sheetName, int pos) {
		this.workBook.setSheetOrder(sheetName, pos);
	}

	public void setColor(String sheetName, int row, int num) {
		CellStyle style = getCellStyle();
		Cell cellNum = getCell(sheetName, row, num);
		Font font = getFont();
		font.setColor(HSSFColor.RED.index);
		style.setFont(font);
		cellNum.setCellStyle(style);
	}

	/**
	 * 设置样式 this.sheetName
	 * 
	 * @param row
	 * @param num
	 * @param sizeBo
	 * @param size
	 * @param center
	 * @param Boldweight
	 * @param isRed
	 * @param isRet
	 * @param ret
	 * @param lock
	 */
	public void setUpStyle(int row, int num, boolean sizeBo, int size, boolean center, boolean Boldweight,
			boolean isRed, boolean isRet, boolean ret) {
		CellStyle style = getCellStyle();
		Cell cellNum = getCell(row, num);
		Font font = getFont();

		if (center) {
			style.setAlignment(CellStyle.ALIGN_CENTER); // 居中
		}
		if (Boldweight) {
			font.setBoldweight(Font.BOLDWEIGHT_BOLD); // 粗体
		}
		if (sizeBo) {
			font.setFontHeightInPoints((short) size);
		} //
		if (isRed) {
			font.setColor(HSSFColor.RED.index);
		}
		style.setFont(font);
		if (isRet) {
			if (ret) { // 设置背景色
				style.setFillForegroundColor((short) 13);// 设置背景色
				style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
			} else {
				style.setFillForegroundColor((short) 49);// 设置背景色
				style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
			}
		}
		// style.setLocked(lock);
		cellNum.setCellStyle(style);
	}

	/**
	 * 设置数字格式
	 * 
	 * @param row
	 * @param num
	 * @param format
	 *            整数："#,#0"，保留两位小数："#,##0.00"。
	 */
	public void setUpStyleNum(int row, int num, String format) {
		Cell cellNum = getCell(row, num);
		cellNum.setCellType(Cell.CELL_TYPE_STRING);
		// int aa = cellNum.getCellType();

		CellStyle style = getCellStyle();
		style.setAlignment(CellStyle.ALIGN_RIGHT); // 居右
		DataFormat df = this.workBook.createDataFormat(); // 此处设置数据格式
		if (format == null) {
			format = "#,##0.00";
		}
		style.setDataFormat(df.getFormat(format));// 数据格式只显示整数
		cellNum.setCellStyle(style);
	}

	/**
	 * 设置样式
	 * 
	 * @param sheetName
	 * @param row
	 * @param num
	 * @param sizeBo
	 * @param size
	 * @param center
	 * @param Boldweight
	 * @param isRed
	 * @param isRet
	 * @param ret
	 * @param lock
	 */
	public void setUpStyle(String sheetName, int row, int num, boolean sizeBo, int size, boolean center,
			boolean Boldweight, boolean isRed, boolean isRet, boolean ret) {
		CellStyle style = getCellStyle();
		Cell cellNum = getCell(sheetName, row, num);
		Font font = getFont();

		if (center) {
			style.setAlignment(CellStyle.ALIGN_CENTER); // 居中
		}
		if (Boldweight) {
			font.setBoldweight(Font.BOLDWEIGHT_BOLD); // 粗体
		}
		if (sizeBo) {
			font.setFontHeightInPoints((short) size);
		} //
		if (isRed) {
			font.setColor(HSSFColor.RED.index);
		}
		style.setFont(font);
		if (isRet) {
			if (ret) { // 设置背景色
				style.setFillForegroundColor((short) 13);// 设置背景色
				style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
			} else {
				style.setFillForegroundColor((short) 49);// 设置背景色
				style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
			}
		}
		// style.setLocked(lock);
		cellNum.setCellStyle(style);
	}

	/**
	 * 
	 * @param sheetName
	 * @param row
	 * @param num
	 * @param top
	 *            上边框
	 * @param bottom
	 *            下边框
	 * @param left
	 *            左边框
	 * @param right
	 *            右边框
	 */
	public void setUpStyle(String sheetName, int row, int num, boolean top, boolean bottom, boolean left,
			boolean right) {
		CellStyle style = getCellStyle();
		Cell cellNum = getCell(sheetName, row, num);
		if (bottom) {
			style.setBorderBottom(CellStyle.BORDER_THIN); // 下边框
		}
		if (left) {
			style.setBorderLeft(CellStyle.BORDER_THIN);// 左边框
		}
		if (top) {
			style.setBorderTop(CellStyle.BORDER_THIN);// 上边框
		}
		if (right) {
			style.setBorderRight(CellStyle.BORDER_THIN);// 右边框
		}
		cellNum.setCellStyle(style);
	}

	/**
	 * 字体样式
	 * 
	 * @return
	 */
	public Font getFont() {
		return this.workBook.createFont();
	}

	/**
	 * 单元格样式 待设置
	 * 
	 * @return
	 */
	public CellStyle getCellStyle() {
		CellStyle style = this.workBook.createCellStyle();
		return style;
	}

	/**
	 * 单元格 this.sheet
	 * 
	 * @param sheetName
	 * @param row
	 * @param num
	 * @return
	 */
	public Cell getCell(int row, int num) {
		// Sheet sheet = this.workBook.getSheet(sheetName);
		this.row = this.sheet.getRow(row);
		this.cell = this.row.getCell(num);
		return cell;
	}

	/**
	 * 单元格
	 * 
	 * @param sheetName
	 * @param row
	 * @param num
	 * @return
	 */
	public Cell getCell(String sheetName, int row, int num) {
		Sheet sheet = this.workBook.getSheet(sheetName);
		Row rowRow = sheet.getRow(row);
		Cell cellNum = rowRow.getCell(num);
		return cellNum;
	}

	/**
	 * 复制行 this.sheet
	 * 
	 * @param rowNum
	 * @param toSheetName
	 * @param toRowNum
	 * @param copyValueFlag
	 * @throws Exception
	 */
	public void copyCell(int rowNum, String toSheetName, int toRowNum, boolean copyValueFlag) throws Exception {

		Sheet toSheet = this.workBook.getSheet(toSheetName);
		Row newRow = toSheet.createRow(toRowNum);
		Row oldRow = this.sheet.getRow(rowNum);
		for (int i = oldRow.getFirstCellNum(); i < oldRow.getLastCellNum(); i++) {
			Cell oldCell = oldRow.getCell(i);
			if (oldCell != null) {
				Cell newCell = newRow.createCell(i);
				CellStyle cellStyle = oldCell.getCellStyle();
				newCell.setCellStyle(cellStyle);
				if (copyValueFlag) {
					int srcCellType = oldCell.getCellType();
					newCell.setCellType(srcCellType);
					if (srcCellType == Cell.CELL_TYPE_NUMERIC) {
						if (HSSFDateUtil.isCellDateFormatted(oldCell)) {
							newCell.setCellValue(oldCell.getDateCellValue());
						} else {
							newCell.setCellValue(oldCell.getNumericCellValue());
						}
					} else if (srcCellType == Cell.CELL_TYPE_STRING) {
						newCell.setCellValue(oldCell.getRichStringCellValue());
					} else if (srcCellType == Cell.CELL_TYPE_BLANK) {
						// nothing21
					} else if (srcCellType == Cell.CELL_TYPE_BOOLEAN) {
						newCell.setCellValue(oldCell.getBooleanCellValue());
					} else if (srcCellType == Cell.CELL_TYPE_ERROR) {
						newCell.setCellErrorValue(oldCell.getErrorCellValue());
					} else if (srcCellType == Cell.CELL_TYPE_FORMULA) {
						newCell.setCellFormula(oldCell.getCellFormula());
					} else { // nothing29
					}
				}
			}
		}
	}

	/**
	 * 复制行
	 * 
	 * @param sheetName
	 * @param rowNum
	 * @param toSheetName
	 * @param toRowNum
	 * @param copyValueFlag
	 * @throws Exception
	 */
	public void copyCell(String sheetName, int rowNum, String toSheetName, int toRowNum, boolean copyValueFlag)
			throws Exception {
		Sheet sheet = this.workBook.getSheet(sheetName);
		Sheet toSheet = this.workBook.getSheet(toSheetName);
		Row newRow = toSheet.createRow(toRowNum);
		Row oldRow = sheet.getRow(rowNum);
		for (int i = oldRow.getFirstCellNum(); i < oldRow.getLastCellNum(); i++) {
			Cell oldCell = oldRow.getCell(i);
			if (oldCell != null) {
				Cell newCell = newRow.createCell(i);
				CellStyle cellStyle = oldCell.getCellStyle();
				newCell.setCellStyle(cellStyle);
				if (copyValueFlag) {
					int srcCellType = oldCell.getCellType();
					newCell.setCellType(srcCellType);
					if (srcCellType == Cell.CELL_TYPE_NUMERIC) {
						if (HSSFDateUtil.isCellDateFormatted(oldCell)) {
							newCell.setCellValue(oldCell.getDateCellValue());
						} else {
							newCell.setCellValue(oldCell.getNumericCellValue());
						}
					} else if (srcCellType == Cell.CELL_TYPE_STRING) {
						newCell.setCellValue(oldCell.getRichStringCellValue());
					} else if (srcCellType == Cell.CELL_TYPE_BLANK) {
						// nothing21
					} else if (srcCellType == Cell.CELL_TYPE_BOOLEAN) {
						newCell.setCellValue(oldCell.getBooleanCellValue());
					} else if (srcCellType == Cell.CELL_TYPE_ERROR) {
						newCell.setCellErrorValue(oldCell.getErrorCellValue());
					} else if (srcCellType == Cell.CELL_TYPE_FORMULA) {
						newCell.setCellFormula(oldCell.getCellFormula());
					} else { // nothing29
					}
				}
			}
		}
	}

	/**
	 * 根据单元格位置创建单元格
	 * 
	 * @param rowCell
	 * @param sheetName
	 */
	public void createCell(int rowNum, int cellNum, String sheetName) {
		Sheet sheet = this.workBook.getSheet(sheetName);

		if (this.row == null) {
			this.row = sheet.createRow(rowNum);
		}
		this.cell = this.row.getCell(cellNum);
		if (this.cell == null) {
			row.createCell(cellNum);
		}
		this.cell = null;
		this.row = null;
		// sheet = null*/;
	}

	/**
	 * 根据单元格位置创建单元格
	 * 
	 * @param rowCell
	 * @param sheetName
	 */
	public void createCell(int rowNum, int cellNum) {
		// Sheet sheet = this.workBook.getSheet(sheetName);
		if (this.sheet != null) {
			this.row = this.sheet.getRow(rowNum);
		}
		if (this.row == null) {
			this.row = this.sheet.createRow(rowNum);
		}
		this.cell = this.row.getCell(cellNum);
		if (this.cell == null) {
			row.createCell(cellNum);
		}
		this.cell = null;
		this.row = null;
		// sheet = null*/;
	}

	/**
	 * 设置单元格 生成模板
	 * 
	 * @param rowCell
	 * @param ret
	 */
	public void SetUpThe(int[] rowCell, boolean ret) {
		XSSFSheet hssfheet = (XSSFSheet) workBook.getSheetAt(0);
		XSSFRow xssfRow = hssfheet.getRow(rowCell[0]);
		XSSFCell xssfCell = xssfRow.getCell(rowCell[1]);
		CellStyle style = workBook.createCellStyle();

		if (ret) { // 设置背景色
			style.setFillForegroundColor(HSSFColor.AQUA.index);
		} else {
			style.setFillForegroundColor(HSSFColor.GOLD.index);
		}
		Font font = workBook.createFont();
		font.setBoldweight(Font.BOLDWEIGHT_BOLD); // 设置粗体
		style.setFont(font);
		style.setFillPattern(CellStyle.SOLID_FOREGROUND);
		xssfCell.setCellStyle(style);

	}

	/**
	 * 写入一组值
	 * 
	 * @param sheetNum
	 *            写入的sheet的编号
	 * @param fillRow
	 *            是写入行还是写入列
	 * @param startRowNum
	 *            开始行号
	 * @param startColumnNum
	 *            开始列号
	 * @param contents
	 *            写入的内容数组
	 * @throws Exception
	 */
	public void writeArrayToExcel(int sheetNum, boolean fillRow, int startRowNum, int startColumnNum, Object[] contents)
			throws Exception {
		Sheet sheet = this.workBook.getSheetAt(sheetNum);
		writeArrayToExcel(sheet, fillRow, startRowNum, startColumnNum, contents);
	}

	/**
	 * 写入一组值
	 * 
	 * @param sheetNum
	 *            写入的sheet的名称
	 * @param fillRow
	 *            是写入行还是写入列
	 * @param startRowNum
	 *            开始行号
	 * @param startColumnNum
	 *            开始列号
	 * @param contents
	 *            写入的内容数组
	 * @throws Exception
	 */
	public void writeArrayToExcel(String sheetName, boolean fillRow, int startRowNum, int startColumnNum,
			Object[] contents) throws Exception {
		Sheet sheet = this.workBook.getSheet(sheetName);
		writeArrayToExcel(sheet, fillRow, startRowNum, startColumnNum, contents);
	}

	private void writeArrayToExcel(Sheet sheet, boolean fillRow, int startRowNum, int startColumnNum, Object[] contents)
			throws Exception {
		for (int i = 0, length = contents.length; i < length; i++) {
			int rowNum;
			int columnNum;
			// 以行为单位写入
			if (fillRow) {
				rowNum = startRowNum;
				columnNum = startColumnNum + i;
			}
			// 以列为单位写入
			else {
				rowNum = startRowNum + i;
				columnNum = startColumnNum;
			}
			this.writeToCell(sheet, rowNum, columnNum, convertString(contents[i]));
		}
	}

	/**
	 * 向一个单元格写入值
	 * 
	 * @param sheetNum
	 *            sheet的编号
	 * @param rowNum
	 *            行号
	 * @param columnNum
	 *            列号
	 * @param value
	 *            写入的值
	 * @throws Exception
	 */
	public void writeToExcel(int sheetNum, int rowNum, int columnNum, Object value) throws Exception {
		Sheet sheet = this.workBook.getSheetAt(sheetNum);
		this.writeToCell(sheet, rowNum, columnNum, value);
	}

	/**
	 * 向一个单元格写入值(数值)
	 * 
	 * @param sheetName
	 *            sheet的名称
	 * @param columnRowNum
	 *            单元格的位置
	 * @param value
	 *            写入的值
	 * @throws Exception
	 */
	public void writeToExcel(int rowNum, int columnNum, Integer value) throws Exception {
		this.writeToCell(this.sheet, rowNum, columnNum, value);
	}

	/**
	 * 向一个单元格写入值
	 * 
	 * @param sheetName
	 *            sheet的名称
	 * @param columnRowNum
	 *            单元格的位置
	 * @param value
	 *            写入的值
	 * @throws Exception
	 */
	public void writeToExcel(int rowNum, int columnNum, Double value) throws Exception {
		// Sheet sheet = this.workBook.getSheet(sheetName);
		this.writeToCell(this.sheet, rowNum, columnNum, value);
	}

	/**
	 * 向一个单元格写入值
	 * 
	 * @param sheetName
	 *            sheet的名称
	 * @param columnRowNum
	 *            单元格的位置
	 * @param value
	 *            写入的值
	 * @throws Exception
	 */
	public void writeToExcel(int rowNum, int columnNum, Object value) throws Exception {
		// Sheet sheet = this.workBook.getSheet(sheetName);
		this.writeToCell(this.sheet, rowNum, columnNum, value);
	}

	/**
	 * 向一个单元格写入值
	 * 
	 * @param sheetName
	 *            sheet的名称
	 * @param columnRowNum
	 *            单元格的位置
	 * @param value
	 *            写入的值
	 * @throws Exception
	 */
	public void writeToExcel(String sheetName, int rowNum, int columnNum, Object value) throws Exception {
		Sheet sheet = this.workBook.getSheet(sheetName);
		this.writeToCell(sheet, rowNum, columnNum, value);
	}

	/**
	 * 向一个单元格写入值
	 * 
	 * @param sheetNum
	 *            sheet的编号
	 * @param columnRowNum
	 *            单元格的位置
	 * @param value
	 *            写入的值
	 * @throws Exception
	 */
	public void writeToExcel(int sheetNum, String columnRowNum, Object value) throws Exception {
		Sheet sheet = this.workBook.getSheetAt(sheetNum);
		this.writeToCell(sheet, columnRowNum, value);
	}

	/**
	 * 向一个单元格写入值
	 * 
	 * @param sheetNum
	 *            sheet的名称
	 * @param columnRowNum
	 *            单元格的位置
	 * @param value
	 *            写入的值
	 * @throws Exception
	 */
	public void writeToExcel(String sheetName, String columnRowNum, Object value) throws Exception {
		Sheet sheet = this.workBook.getSheet(sheetName);
		this.writeToCell(sheet, columnRowNum, value);
	}

	private void writeToCell(Sheet sheet, String columnRowNum, Object value) throws Exception {
		int[] rowNumColumnNum = convertToRowNumColumnNum(columnRowNum);
		int rowNum = rowNumColumnNum[0];
		int columnNum = rowNumColumnNum[1];
		this.writeToCell(sheet, rowNum, columnNum, value);
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
	 * 写入值
	 * 
	 * @param sheet
	 * @param rowNum
	 * @param columnNum
	 * @param value
	 * @throws Exception
	 */
	private void writeToCell(Sheet sheet, int rowNum, int columnNum, Object value) throws Exception {
		this.row = sheet.getRow(rowNum);
		if (this.row == null) {
			this.row = sheet.createRow(rowNum);
		}
		this.cell = this.row.getCell(columnNum);
		if (this.cell == null) {
			this.cell = this.row.createCell(columnNum);
		}
		this.cell.setCellValue(convertString(value));
		this.cell = null;
		this.row = null;
		// sheet = null;
	}

	/**
	 * 写入值
	 * 
	 * @param sheet
	 * @param rowNum
	 * @param columnNum
	 * @param value
	 * @throws Exception
	 */
	private void writeToCell(Sheet sheet, int rowNum, int columnNum, Double value) throws Exception {
		this.row = sheet.getRow(rowNum);
		if (this.row == null) {
			this.row = sheet.createRow(rowNum);
		}
		this.cell = this.row.getCell(columnNum);
		if (this.cell == null) {
			this.cell = this.row.createCell(columnNum);
		}
		this.cell.setCellValue(value);
		this.cell = null;
		this.row = null;
		// sheet = null;

	}

	/**
	 * 写入值
	 * 
	 * @param sheet
	 * @param rowNum
	 * @param columnNum
	 * @param value
	 * @throws Exception
	 */
	private void writeToCell(Sheet sheet, int rowNum, int columnNum, Integer value) throws Exception {
		this.row = sheet.getRow(rowNum);
		if (this.row == null) {
			this.row = sheet.createRow(rowNum);
		}
		this.cell = this.row.getCell(columnNum);
		if (this.cell == null) {
			this.cell = this.row.createCell(columnNum);
		}
		this.cell.setCellValue(value);
		this.cell = null;
		this.row = null;
		// sheet = null;

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
	public Object readCellValue(String sheetName, String columnRowNum) throws Exception {
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
	 * 获取单元格中的值
	 * 
	 * @param cell
	 *            单元格
	 * @return
	 */
	private static Object getCellValue(Cell cell) {
		int type = cell.getCellType();
		switch (type) {
		case Cell.CELL_TYPE_STRING:
			return (Object) cell.getStringCellValue();
		case Cell.CELL_TYPE_NUMERIC:
			Double value = cell.getNumericCellValue();
			return (Object) (value.intValue());
		case Cell.CELL_TYPE_BOOLEAN:
			return (Object) cell.getBooleanCellValue();
		case Cell.CELL_TYPE_FORMULA:
			return (Object) cell.getArrayFormulaRange().formatAsString();
		case Cell.CELL_TYPE_BLANK:
			return (Object) "";
		default:
			return null;
		}
	}

	/**
	 * 插入一行并参照与上一行相同的格式
	 * 
	 * @param sheetNum
	 *            sheet的编号
	 * @param rowNum
	 *            插入行的位置
	 * @throws Exception
	 */
	public void insertRowWithFormat(int sheetNum, int rowNum) throws Exception {
		Sheet sheet = this.workBook.getSheetAt(sheetNum);
		insertRowWithFormat(sheet, rowNum);
	}

	/**
	 * 插入一行并参照与上一行相同的格式
	 * 
	 * @param sheetName
	 *            sheet的名称
	 * @param rowNum
	 *            插入行的位置
	 * @throws Exception
	 */
	public void insertRowWithFormat(String sheetName, int rowNum) throws Exception {
		Sheet sheet = this.workBook.getSheet(sheetName);
		insertRowWithFormat(sheet, rowNum);
	}

	private void insertRowWithFormat(Sheet sheet, int rowNum) throws Exception {
		sheet.shiftRows(rowNum, rowNum + 1, 1);
		Row newRow = sheet.createRow(rowNum);
		Row oldRow = sheet.getRow(rowNum - 1);
		for (int i = oldRow.getFirstCellNum(); i < oldRow.getLastCellNum(); i++) {
			Cell oldCell = oldRow.getCell(i);
			if (oldCell != null) {
				CellStyle cellStyle = oldCell.getCellStyle();
				newRow.createCell(i).setCellStyle(cellStyle);
			}
		}
	}

	/**
	 * 重命名一个sheet
	 * 
	 * @param sheetNum
	 *            sheet的编号
	 * @param newName
	 *            新的名称
	 */
	public void renameSheet(int sheetNum, String newName) {
		this.workBook.setSheetName(sheetNum, newName);
	}

	/**
	 * 重命名一个sheet
	 * 
	 * @param oldName
	 *            旧的名称
	 * @param newName
	 *            新的名称
	 */
	public void renameSheet(String oldName, String newName) {
		int sheetNum = this.workBook.getSheetIndex(oldName);
		this.renameSheet(sheetNum, newName);
	}

	/**
	 * 删除一个sheet
	 * 
	 * @param sheetName
	 *            sheet的名称
	 */
	public void removeSheet(String sheetName) {
		Sheet sheet = this.workBook.getSheet(sheetName);
		if (sheet != null) {
			this.workBook.removeSheetAt(this.workBook.getSheetIndex(sheetName));
		}
	}

	/**
	 * 写入Excel文件并关闭
	 */
	public void writeAndClose() {
		if (this.workBook != null) {
			try {
				FileOutputStream fileOutStream = new FileOutputStream(this.excelFile);
				this.workBook.write(fileOutStream);

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if (this.fileInStream != null) {
					try {
						this.fileInStream.close();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} finally {
						this.fileInStream = null;
					}
				}
				if (this.workBook != null) {
					try {
						this.workBook.close();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} finally {
						this.workBook = null;
					}
				}
			}
		}

	}

	private static String convertString(Object value) {
		if (value == null) {
			return "";
		} else {
			return value.toString();
		}
	}

}
