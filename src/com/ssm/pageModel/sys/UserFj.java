/**
 * Project Name:lightmvc
 * File Name:UserFj.java
 * Package Name:light.mvc.pageModel.sys
 * Date:2014-12-23下午3:45:23
 * Copyright (c) 2014, chenzhou1025@126.com All Rights Reserved.
 *
*/

package com.ssm.pageModel.sys;

public class UserFj implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -8141624322194915242L;
   
	private Long id;
	private String url; // 原图地址
	private String slturl;// 缩略图地址
	private String wjm;// 文件名
	private String createTime;// 创建时间
	private String tomcatUrl;
	private Long userId ;
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getSlturl() {
		return slturl;
	}
	public void setSlturl(String slturl) {
		this.slturl = slturl;
	}
	public String getWjm() {
		return wjm;
	}
	public void setWjm(String wjm) {
		this.wjm = wjm;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	public String getTomcatUrl() {
		return tomcatUrl;
	}
	public void setTomcatUrl(String tomcatUrl) {
		this.tomcatUrl = tomcatUrl;
	}
	
	
	
}

