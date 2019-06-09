package com.king.common.fileupload;

public class FileUploadFactory {
	private static final String FILE_SAVE_TYPE_FTP = "FTP";
	private static final String FILE_SAVE_TYPE_LOCAL = "LOCAL";
	private static FileUploadHandle fileUploadHandle = null;

	public static FileUploadHandle createFileUploadHandle(String fileSaveType) {
		if (fileUploadHandle == null || (!(fileUploadHandle instanceof LocalFileUploadHandle)))
			fileUploadHandle = new LocalFileUploadHandle();
		return fileUploadHandle;
	}
}
