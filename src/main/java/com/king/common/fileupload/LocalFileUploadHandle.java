package com.king.common.fileupload;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class LocalFileUploadHandle extends FileUploadHandle {
	private static Logger logger = LoggerFactory.getLogger(LocalFileUploadHandle.class);

	public LocalFileUploadHandle() {
		// attaPath = ParameterUtils.getParamValue(ParameterUtils.PARAM_CODE_ATTACHMENT_PATH);
	}

	public boolean readFile(String path, String fileName, OutputStream outputStream) {
		boolean success = false;
		path = getCompletePath(path);
		File file = new File(path + fileName);
		try {
			setOutputStream(outputStream, file);
			success = true;
		} catch (IOException e) {
			logger.error("写文件出现IO异常：" + e.getMessage());
			e.printStackTrace();
		}
		return success;
	}

	public boolean uploadFile(InputStream input, String path, String fileName) {
		boolean success = false;
		FileOutputStream fos = null;
		try {
			path = this.getCompletePath(path);
			File f = new File(path);
			if (!f.exists())
				f.mkdirs();
			fos = new FileOutputStream(path + fileName);
			byte buffer[] = new byte[1024];
			 int len = 0;
			while ((len = input.read(buffer)) > 0) {
				fos.write(buffer,0,len);
			}
			fos.flush();
			success = true;
		} catch (IOException e) {
			logger.error("写文件出现IO异常：" + e.getMessage());
			e.printStackTrace();
		} finally {
			if (fos != null) {
				try {
					fos.close();
				} catch (IOException e) {
					// ignore
				} finally {
					fos = null;
				}
			}
		}
		return success;
	}

	private void setOutputStream(OutputStream output, File file) throws IOException {
		BufferedInputStream input = null;

		try {
			input = new BufferedInputStream(new FileInputStream(file));
			byte[] buff = new byte[2048];
			int readLen = 0;
			while ((readLen = input.read(buff, 0, buff.length)) != -1) {
				output.write(buff, 0, readLen);
			}
			output.flush();
		} catch (IOException e) {
			throw e;
		} finally {
			if (input != null) {
				try {
					input.close();
				} catch (IOException e) {
				} finally {
					input = null;
				}
			}
			if (output != null) {
				try {
					output.close();
				} catch (IOException e) {
				} finally {
					output = null;
				}
			}
		}
	}

	@Override
	public boolean deleteFile(String path, String fileName) {

		boolean flag = false;
		path = getCompletePath(path);
		File file = new File(path + fileName);
		if (file.exists()) {
			flag = file.delete();
		}
		return flag;
	}
}
