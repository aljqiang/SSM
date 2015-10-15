<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="photo" value="${pageContext.request.contextPath}${sessionInfo.photo}"/>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="inc.jsp"></jsp:include>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
function addFun() {
	parent.$.modalDialog({
		title : '上传图片',
		width : 300,
		height : 150,
		href : '${ctx}/admin/destopPage',
		buttons : [ {
			text : '上传',
			handler : function() {
				var f = parent.$.modalDialog.handler.find('#uploadForm');
				f.submit();
			}
		} ,{
			text : '取消',
			handler : function() {
				parent.$.modalDialog.handler.dialog('close');
			}
		} 
		]
	});
}
function showZYMform() {
	parent.$.modalDialog({
		title : '编辑座右铭',
		width : 300,
		height : 150,
		href : '${ctx}/admin/destopPageZym',
		buttons : [ {
			text : '提交',
			handler : function() {
				var f = parent.$.modalDialog.handler.find('#editZymForm');
				f.submit();
			}
		} ,{
			text : '取消',
			handler : function() {
				parent.$.modalDialog.handler.dialog('close');
			}
		} 
		]
	});
}

</script>
<style>

.scTxt{margin:10px 0 0 20px; font-size:20px;font-weight:bold}

.userInfoArea2{}
#userPic{float:left;}
.userPic2{width:100px;height:100px;border:1px solid #ccc;margin:0px 0 0 20px;background:url(${photo}) no-repeat;}
.haveUserPic2{width:100px;height:100px;border:1px solid #ccc;margin:0px 0 0 20px;}
.userInfo2{margin:0px 0 0 100px;list-style:none;}
.userInfo2 li{margin:6px;color:#999;}
.userInfo2 li span{color:#333;}
.userInfo2 li a{color:#444ACC;}
.userInfo2 li a:hover{color:#FF6A11}
</style>
</head>
<div class="easyui-layout" data-options="fit:true,border:false" >
	<div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;" >
			<div id="deskinfo" title="桌面" data-options="border:false" style="overflow: hidden;">
					
					  <div class="scTxt">个人信息</div>
				
					<div class="userInfoArea2">
						<div id="userPic" class="userPic2"></div>
						<ul class="userInfo2">
							<li>用户姓名:${sessionInfo.loginname}[${sessionInfo.id}]</li>
							<li>所属部门:${sessionInfo.dep} </li>
							<li>座&nbsp;右&nbsp;铭: ${sessionInfo.zym}</li>
							<li><a onclick="addFun();" href="javascript:void(0);">上传头像</a>  <a href="javascript:void(0);" onclick="showZYMform();">编辑座右铭</a><li></li>
						</ul>
					</div>
				</div>
	</div>
</div>
