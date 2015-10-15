package com.ssm.framework.constant;

import java.util.TreeMap;

public class GlobalConstant {

	public static final String SESSION_INFO = "sessionInfo";
	public static final String AGENTWINDOW_INFO = "agentWindowInfo";

	public static final Integer ENABLE = 0; // 启用
	public static final Integer DISABLE = 1; // 禁用
	
	
	public static final Integer DEFAULT = 0; // 默认
	public static final Integer NOT_DEFAULT = 1; // 非默认
	
	public static final TreeMap sexlist = new TreeMap(){{ put("0", "男");  put("1", "女");} };
	public static final TreeMap statelist = new TreeMap(){{ put("0", "启用");  put("1", "停用");} };

	public static final TreeMap cardType=new TreeMap(){{ put("0", "身份证");  put("1", "其他证件");} };
}
