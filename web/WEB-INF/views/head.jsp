<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>话务条</title>


<head>

<script>
	
	
	function signIn(){
		XLP.ui.agent.login("phone",'15323886590',xlp_cno);
		
	}
	
	function await(){
		XLP.ui.agent.logoff(xlp_cno);
		
	}
	
	function busy(){
	   
		//if(XLP.agent[xlp_cno].status=='ready'){
		    XLP.ui.agent.makebusy();
		//}
		   	   
	}
	function ready(){
		if(XLP.agent[xlp_cno].status=='busy'){
			XLP.ui.agent.ready(config);
		}
	}
</script>


</head>
<body class="top" jQuery1421128318964="1" onload="">
<div class="callBar">
<table class="lampTableContainer" cellSpacing="0" cellPadding="0">
<tbody>
<tr>
<td>

<table class="lampTable" id="callBar" cellSpacing="0" cellPadding="0">
 <tbody>
  <tr id="callBarTr">
   <td class="callBtnTD signIn" id="callBtn_signIn" vAlign="bottom" onclick="signIn();">
    未签入
   </td>
   <td class="callBtnTD await offline" id="callBtn_await" vAlign="bottom" onclick="await();">
    签出
   </td>
   <td class="callBtnTD busy" id="callBtn_busy" vAlign="bottom" onclick="busy();">
    示忙
   </td>
   <td class="divider" vAlign="bottom"></td>
   <td class="callBtnTD answer" id="callBtn_answer" vAlign="bottom">
    应答
   </td>
   <td class="callBtnTD hangup" id="callBtn_hangup" vAlign="bottom">
    挂机
   </td>
   <td class="callBtnTD callout" id="callBtn_callout" vAlign="bottom">
    呼出
   </td>
   <td class="callBtnTD transfer" id="callBtn_transfer" vAlign="bottom">
    转移
   </td>
   <td class="callBtnTD mute" id="callBtn_mute" vAlign="bottom">
    静音
   </td>
  
   <td class="callBtnTD hold" id="callBtn_hold" vAlign="bottom">
    保持
   </td>
   <td class="callBtnTD subscribe" id="callBtn_subscribe" vAlign="bottom">
    回访
   </td>
   <td class="divider" vAlign="bottom"></td>
   <td class="callBtnTD register" id="callBtn_register" vAlign="bottom">
    登记
   </td>
   <td class="callBtnTD monitor" id="callBtn_monitor" vAlign="bottom">
    监听
   </td>
  </tr>
 </tbody>
</table>

</td>
</tr>
</tbody>
</table>
</div></body></html>
