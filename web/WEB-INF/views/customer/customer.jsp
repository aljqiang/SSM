<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>

<jsp:include page="../inc.jsp"></jsp:include>
<meta http-equiv="X-UA-Compatible" content="edge" />
<c:if test="${fn:contains(sessionInfo.resourceList, '/customer/edit')}">
	<script type="text/javascript">
		$.canEdit = true;
	</script>
</c:if>
<c:if test="${fn:contains(sessionInfo.resourceList, '/customer/delete')}">
	<script type="text/javascript">
		$.canDelete = true;
	</script>
</c:if>

<title>客户管理</title>
	<script type="text/javascript">
	var dataGrid;
	$(function() {
		dataGrid = $('#dataGrid').datagrid({
			url : '${ctx}/customer/dataGrid',
			striped : true,
			rownumbers : true,
			pagination : true,
			singleSelect : true,
			fitColumns:false,
			idField : 'id',
			sortName : 'id',
			sortOrder : 'asc',
			pageSize : 50,
			pageList : [ 10, 20, 30, 40, 50, 100, 200, 300, 400, 500 ],
			columns : [ [  {
				field : 'action',
				title : '操作',
				width : 100,
				formatter : function(value, row, index) {
					var str = '';
					if(row.isdefault!=0){
						
						if ($.canEdit) {
							str += $.formatString('<a href="javascript:void(0)" onclick="editFun(\'{0}\');" >编辑</a>', row.id);
						}
						str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
						if ($.canDelete) {
							str += $.formatString('<a href="javascript:void(0)" onclick="deleteFun(\'{0}\');" >删除</a>', row.id);
						}
					}
					return str;
				}
			} , {
				width : '10%',
				title : '客户名称',
				field : 'customerName',
				sortable : true
			}, {
				width : '10%',
				title : '证件类型',
				field : 'cardType',
				sortable : true,
				formatter : function(value, row, index) {
					var jsonObjs = $.parseJSON('${cardtypeJson}');
					for(var i =0;i<jsonObjs.length;i++){
						var jsonobj = jsonObjs[i];
						if(jsonobj.code==value){
							return jsonobj.text;
						}
					}
					return "未知类型";
				}
			}, {
				width : '10%',
				title : '证件号码',
				field : 'cardNum',
				sortable : true
			}, {
				width : '10%',
				title : '客户性别',
				field : 'customerSex',
				sortable : true,
				formatter : function(value, row, index) {
					switch (value) {
					case '0':
						return '男';
					case '1':
						return '女';
					}
				}
			} , {
				width : '10%',
				title : '办公电话',
				field : 'customerBGDH',
				sortable : true
			}, {
				width : '10%',
				title : '移动电话',
				field : 'customerMobilePhone',
				sortable : true
			}, {
				width : '10%',
				title : '家庭电话',
				field : 'customerJTDH',
				sortable : true
			}, {
				width : '10%',
				title : 'EMAIL',
				field : 'customerEMail',
				sortable : true
			}, {
				width : '10%',
				title : '地址',
				field : 'customerAddress',
				sortable : true
			}, {
				width : '10%',
				title : '创建时间',
				field : 'customerCreateTime',
				sortable : true
			}, {
				width : '10%',
				title : '修改时间',
				field : 'customerUpdateTime',
				sortable : true
			}, {
				width : '10%',
				title : '备注',
				field : 'customerRemark'
			} ] ],
			toolbar : '#toolbar'
		});
	});
	function addFun() {
		parent.$.modalDialog({
			title : '添加',
			width : 500,
			height : 350,
			href : '${ctx}/customer/addPage',
			buttons : [ {
				text : '添加',
				handler : function() {
					parent.$.modalDialog.openner_dataGrid = dataGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
					var f = parent.$.modalDialog.handler.find('#customerAddForm');
					f.submit();
				}
			}, {
				text : '取消',
				handler : function() {
					parent.$.modalDialog.handler.dialog('close');
				}
			} ]
		});
	}
	function deleteFun(id) {
		parent.$.messager.confirm('询问', '您是否要删除当前客户？', function(b) {
				if(b){
					
					progressLoad();
					$.post('${ctx}/customer/delete', {
						id : id
					}, function(result) {
						if (result.success) {
							parent.$.messager.alert('提示', result.msg, 'info');
							dataGrid.datagrid('reload');
						}
						progressClose();
					}, 'JSON');
				
				}
		});
	}
	
	function editFun(id) {
		parent.$.modalDialog({
			title : '编辑',
			width : 500,
			height : 350,
			href : '${ctx}/customer/editPage?id=' + id,
			buttons : [ {
				text : '编辑',
				handler : function() {
					parent.$.modalDialog.openner_dataGrid = dataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
					var f = parent.$.modalDialog.handler.find('#customerEditForm');
					f.submit();
				}
			} ]
		});
	}
	</script>
	
</head>
<body class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',fit:true,border:false">
		<table id="dataGrid"  data-options="fit:true,border:false" style="border:solid 1px ;margin:0 auto;">
	
		</table>
	</div>
	
	
	<div id="toolbar" style="display: none;">
		<c:if test="${fn:contains(sessionInfo.resourceList, '/customer/add')}">
			<a onclick="addFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon_add'">添加</a>
		</c:if>
	</div>
</body>
</html>