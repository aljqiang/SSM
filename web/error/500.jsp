<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<%
if(exception != null){
	//exception.printStackTrace();
	//System.out.println("-------------------------");
	java.io.StringWriter sw = new java.io.StringWriter();
	//exception.printStackTrace(out);
//	exception.printStackTrace(new java.io.PrintWriter(sw));
	out.println(exception.getMessage());
}else{
	out.println("请与系统管理员联系！");
}
%>