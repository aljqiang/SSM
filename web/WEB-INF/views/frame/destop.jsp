<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>MAIN PAGE</title>
	<script src="../../KJAF/include.js" type="text/javascript"></script>
	<script src="js/desktop.js" type="text/javascript"></script>
<script type="text/javascript">
$(function(){  
	getUserDesktop();
	initLayout_shortcut(); 
	queryShortcuts();
	
	top.hideLoading('桌面'); 
});
</script>
<style>
html{overflow:hidden;} 
.shortcutContainer .scIcon{position:static;}
.shortcutContainer .scIcon div{position:static;margin-top:65px;} 

.userInfoArea2{}
#userPic{float:left;}
.userPic2{width:100px;height:100px;border:1px solid #ccc;margin:6px 0 0 10px;background:url(../../KJAF/img/noPic.gif) no-repeat;}
.haveUserPic2{width:100px;height:100px;border:1px solid #ccc;margin:6px 0 0 10px;}
.userInfo2{margin:6px 0 0 120px;list-style:none;}
.userInfo2 li{margin:4px;color:#999;}
.userInfo2 li span{color:#333;}
.userInfo2 li a{color:#444ACC;}
.userInfo2 li a:hover{color:#FF6A11}
</style>
</head>
<body>
<div class="welcomeTitle">
	<div class="txt scTxt">个人信息</div>
</div>
<div class="userInfoArea2">
	<div id="userPic" class="userPic2"></div>
	<ul class="userInfo2">
		<li>用户姓名: <span id="ygxm"></span>[<span id="ygbh"></span>]</li>
		<li>所属部门: <span id="dwmc"></span></li>
		<li>工作岗位: <span id="zwmc"></span></li>
		<li>座&nbsp;右&nbsp;铭: <span id="zym"></span></li>
		<li><a href="#" onclick="showUploadForm(this)">上传头像</a> | <a href="#" onclick="showZYMform(this)">编辑座右铭</a></li>
	</ul>
</div>
<div class="welcomeTitle">
	<div class="txt scTxt">快捷方式 <span>(右键点击系统菜单项可添加快捷方式; 右键点击快捷方式可修改图标或删除)</span></div>
</div>
<div id="shortcutArea" class="shortcutArea">
	<div id="shortcuts" class="shortcutContainer"></div>
</div>
	

<div id="uploadForm" dlg="true" dlg_width="400" dlg_minheight="10" dlg_modal="false" dlg_position="center,50"></div>
<div id="zymForm" dlg="true" dlg_width="400" dlg_minheight="10" dlg_modal="false" dlg_position="center,50"></div>
</body>
</html>
