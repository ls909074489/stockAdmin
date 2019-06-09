package com.king.frame.security;

import org.springframework.stereotype.Component;

/**
 * 安全相关配置
 * 
 * @author Kevin 2014年11月20日 上午11:50:18
 */
@Component
public class SecurityConfig {
	// 初始化密码
	private String plainpassword = "Mz@123qwe";

	// 密码加密算法
	private String hashAlgorithm = "SHA-1";
	// 密码加密次数
	private int hashInterations = 1024;
	// 是否启用Salt（盐度）
	private boolean saltEnable = true;
	// Salt长度
	private int saltSize = 8;
	// 是否启用验证码
	private boolean captchaEnable = false;

	public String getHashAlgorithm() {
		return hashAlgorithm;
	}

	public void setHashAlgorithm(String hashAlgorithm) {
		this.hashAlgorithm = hashAlgorithm;
	}

	public int getHashInterations() {
		return hashInterations;
	}

	public void setHashInterations(int hashInterations) {
		this.hashInterations = hashInterations;
	}

	public boolean isSaltEnable() {
		return saltEnable;
	}

	public void setSaltEnable(boolean saltEnable) {
		this.saltEnable = saltEnable;
	}

	public int getSaltSize() {
		return saltSize;
	}

	public void setSaltSize(int saltSize) {
		this.saltSize = saltSize;
	}

	public boolean isCaptchaEnable() {
		return captchaEnable;
	}

	public void setCaptchaEnable(boolean captchaEnable) {
		this.captchaEnable = captchaEnable;
	}

	public String getPlainpassword() {
		return plainpassword;
	}

	public void setPlainpassword(String plainpassword) {
		this.plainpassword = plainpassword;
	}

}
