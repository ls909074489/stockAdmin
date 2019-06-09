package com.king.common.utils;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Enumeration;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;

public class FileUtil {
	// 文件打包下载
	public static HttpServletResponse downLoadFiles(List<File> files, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		try {
			/**
			 * 创建一个临时压缩文件， 我们会把文件流全部注入到这个文件中 这里的文件你可以自定义是.rar还是.zip
			 */
			File file = new File("d:/certpics.rar");
			if (!file.exists()) {
				file.createNewFile();
			}
			response.reset();
			// response.getWriter()
			// 创建文件输出流
			FileOutputStream fous = new FileOutputStream(file);
			/**
			 * 打包的方法我们会用到ZipOutputStream这样一个输出流, 所以这里我们把输出流转换一下
			 */
			ZipOutputStream zipOut = new ZipOutputStream(fous);
			/**
			 * 这个方法接受的就是一个所要打包文件的集合， 还有一个ZipOutputStream
			 */
			zipFiles(files, zipOut);
			zipOut.close();
			fous.close();
			return downloadFile(file, request ,response);
		} catch (Exception e) {
			e.printStackTrace();
		}
		/**
		 * 直到文件的打包已经成功了， 文件的打包过程被我封装在FileUtil.zipFile这个静态方法中，
		 * 稍后会呈现出来，接下来的就是往客户端写数据了
		 */
		return response;
	}

	public static HttpServletResponse downloadFile(File file,  HttpServletRequest request,
			HttpServletResponse response) {
		OutputStream os=null;
		try {
			// 以流的形式下载文件。
			InputStream fis = new BufferedInputStream(new FileInputStream(file.getPath()));
			byte[] buffer = new byte[fis.available()];
			fis.read(buffer);
			fis.close();
			// 清空response
			response.reset();

			os = new BufferedOutputStream(response.getOutputStream());
			response.setContentType("application/octet-stream");

			String explorerType = "";
			try {
				String agent = request.getHeader("User-Agent");
				if (StringUtils.isBlank(agent))
					return null;
				if (agent.contains("MSIE")) {
					explorerType = agent.split(";")[1];
				} else if (agent.contains("Firefox")) {
					explorerType = "Firefox";
				} else if (agent.contains("Chrome")) {
					explorerType = "Chrome";
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			// 如果输出的是中文名的文件，在此处就要用URLEncoder.encode方法进行处理
			if (explorerType == null || explorerType.contains("IE")) {// IE
				response.setHeader("Content-Disposition",
						"attachment; filename=\"" + java.net.URLEncoder.encode(file.getName(), "UTF-8") + "\"");
			} else {// fireFox/Chrome
				response.setHeader("Content-Disposition",
						"attachment; filename=" + new String(file.getName().getBytes("UTF-8"),"ISO-8859-1"));
			}
			
			os.write(buffer);
			os.flush();
			os.close();
		} catch (IOException ex) {
			ex.printStackTrace();
		} finally {
			try {
				if(os!=null){
					os.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return response;
	}

	
	public static void downloadFile(String fileName,String filePath, HttpServletResponse response) throws UnsupportedEncodingException {
		response.reset();  
		response.setHeader("Content-Disposition", "attachment;filename="+URLEncoder.encode(fileName, "UTF-8"));  
		response.setHeader("Connection", "close");  
		response.setHeader("Content-Type", "application/octet-stream");  
			  
		OutputStream ops = null;  
		FileInputStream fis =null;  
		byte[] buffer = new byte[8192];  
		int bytesRead = 0;  
		try {  
		    ops = response.getOutputStream();  
		    fis = new FileInputStream(filePath);  
		    while((bytesRead = fis.read(buffer, 0, 8192)) != -1){  
			 ops.write(buffer, 0, bytesRead);  
		    }  
		    ops.flush();  
		 } catch (IOException e) {  
		    e.printStackTrace();  
		 } finally {  
		    try {  
				if(fis != null){  
					fis.close();  
				}  
				if(ops != null){  
					ops.close();  
				}  
		    } catch (IOException e) {  
		    	e.printStackTrace();  
		    }  
		}  
	}
	
	/**
	 * 把接受的全部文件打成压缩包
	 * 
	 * @param List<File>;
	 * @param org.apache.tools.zip.ZipOutputStream
	 */
	public static void zipFiles(List<File> files, ZipOutputStream outputStream) {
		int size = files.size();
		for (int i = 0; i < size; i++) {
			File file = (File) files.get(i);
			zipFile(file, outputStream);
		}
	}
	
	/**
	 * 根据输入的文件与输出流对文件进行打包
	 * 
	 * @param File
	 * @param org.apache.tools.zip.ZipOutputStream
	 */
	public static void zipFile(File inputFile, ZipOutputStream ouputStream) {
		try {
			if (inputFile.exists()) {
				/**
				 * 如果是目录的话这里是不采取操作的， 至于目录的打包正在研究中
				 */
				if (inputFile.isFile()) {
					FileInputStream IN = new FileInputStream(inputFile);
					BufferedInputStream bins = new BufferedInputStream(IN, 512);
					// org.apache.tools.zip.ZipEntry
					ZipEntry entry = new ZipEntry(inputFile.getName());
					ouputStream.putNextEntry(entry);
					// 向压缩文件中输出数据
					int nNumber;
					byte[] buffer = new byte[512];
					while ((nNumber = bins.read(buffer)) != -1) {
						ouputStream.write(buffer, 0, nNumber);
					}
					// 关闭创建的流对象
					bins.close();
					IN.close();
				} else {
					try {
						File[] files = inputFile.listFiles();
						for (int i = 0; i < files.length; i++) {
							zipFile(files[i], ouputStream);
						}
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	 /**
     * 解压缩
     * 
     * @param zipfile File 需要解压缩的文件
     * @param descDir String 解压后的目标目录
     */
    public static void unZipFiles(File zipfile, String descDir) {
        try {
            // Open the ZIP file
            ZipFile zf = new ZipFile(zipfile);
            for (Enumeration entries = zf.entries(); entries.hasMoreElements();) {
                // Get the entry name
                ZipEntry entry = ((ZipEntry) entries.nextElement());
                String zipEntryName = entry.getName();
                InputStream in = zf.getInputStream(entry);
                // System.out.println(zipEntryName);
                OutputStream out = new FileOutputStream(descDir + zipEntryName);
                byte[] buf1 = new byte[1024];
                int len;
                while ((len = in.read(buf1)) > 0) {
                    out.write(buf1, 0, len);
                }
                // Close the file and stream
                in.close();
                out.close();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
