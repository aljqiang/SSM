/**
 * Project Name:lightmvc
 * File Name:AgentWindwo.java
 * Package Name:light.mvc.pageModel.base
 * Date:2015-2-6上午10:35:58
 * Copyright (c) 2015, chenzhou1025@126.com All Rights Reserved.
 *
*/

package com.ssm.pageModel.base;

public class AgentWindow implements java.io.Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 2985901780870978485L;
	private String customerId;
	private String customerName;
	private String customerType;
	private String callType;
	private String callNum;
	private String customerSex;
	private String customerAccountId;    //账户
	private String customerBGDH;  //办公电话
	private String customerMobilePhone;  //移动电话
	private String customerJTDH;  //家庭电话
	private String customerEMail;
	private String customerRemark;
	private String customerAddress;
	private String caller;
	private String serialno;
	
	public String getCustomerId() {
		return customerId;
	}
	public void setCustomerId(String customerId) {
		this.customerId = customerId;
	}
	public String getCustomerName() {
		return customerName;
	}
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}
	public String getCustomerType() {
		return customerType;
	}
	public void setCustomerType(String customerType) {
		this.customerType = customerType;
	}
	
	public String getCallType() {
		return callType;
	}
	public void setCallType(String callType) {
		this.callType = callType;
	}
	public String getCallNum() {
		return callNum;
	}
	public void setCallNum(String callNum) {
		this.callNum = callNum;
	}
	public String getCustomerSex() {
		return customerSex;
	}
	public void setCustomerSex(String customerSex) {
		this.customerSex = customerSex;
	}
	public String getCustomerAccountId() {
		return customerAccountId;
	}
	public void setCustomerAccountId(String customerAccountId) {
		this.customerAccountId = customerAccountId;
	}
	public String getCustomerBGDH() {
		return customerBGDH;
	}
	public void setCustomerBGDH(String customerBGDH) {
		this.customerBGDH = customerBGDH;
	}
	public String getCustomerMobilePhone() {
		return customerMobilePhone;
	}
	public void setCustomerMobilePhone(String customerMobilePhone) {
		this.customerMobilePhone = customerMobilePhone;
	}
	public String getCustomerJTDH() {
		return customerJTDH;
	}
	public void setCustomerJTDH(String customerJTDH) {
		this.customerJTDH = customerJTDH;
	}
	public String getCustomerEMail() {
		return customerEMail;
	}
	public void setCustomerEMail(String customerEMail) {
		this.customerEMail = customerEMail;
	}
	public String getCustomerRemark() {
		return customerRemark;
	}
	public void setCustomerRemark(String customerRemark) {
		this.customerRemark = customerRemark;
	}
	public String getCustomerAddress() {
		return customerAddress;
	}
	public void setCustomerAddress(String customerAddress) {
		this.customerAddress = customerAddress;
	}
	public String getCaller() {
		return caller;
	}
	public void setCaller(String caller) {
		this.caller = caller;
	}
	public String getSerialno() {
		return serialno;
	}
	public void setSerialno(String serialno) {
		this.serialno = serialno;
	}

}

