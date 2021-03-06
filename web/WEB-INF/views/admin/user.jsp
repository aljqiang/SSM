<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../inc.jsp"></jsp:include>
<meta http-equiv="X-UA-Compatible" content="edge" />
<c:if test="${fn:contains(sessionInfo.resourceList, '/user/edit')}">
	<script type="text/javascript">
		$.canEdit = true;
	</script>
</c:if>
<c:if test="${fn:contains(sessionInfo.resourceList, '/user/delete')}">
	<script type="text/javascript">
		$.canDelete = true;
	</script>
</c:if>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户管理</title>
	<script type="text/javascript">
	var dataGrid;
	var organizationTree;
	$(function() {
	
		organizationTree = $('#organizationTree').tree({
			url : '${ctx}/organization/tree',
			parentField : 'pid',
			lines : true,
			onClick : function(node) {
				dataGrid.datagrid('load', {
				    organizationId: node.id
				});
			}
		});
	
		dataGrid = $('#dataGrid').datagrid({
			url : '${ctx}/user/dataGrid',
			striped : true,
			rownumbers : true,
			pagination : true,
			singleSelect : true,
			idField : 'id',
			sortName : 'createdatetime',
			sortOrder : 'asc',
			pageSize : 50,
			pageList : [ 10, 20, 30, 40, 50, 100, 200, 300, 400, 500 ],
			frozenColumns : [ [ ] ],
			columns : [ [{
				width : '100',
				title : '登录名',
				field : 'loginname',
				sortable : true
			}, {
				width : '80',
				title : '姓名',
				field : 'name',
				sortable : true
			},{
				width : '80',
				title : '部门ID',
				field : 'organizationId',
				hidden : true
			},{
				width : '80',
				title : '所属部门',
				field : 'organizationName'
			}, {
				width : '150',
				title : '创建时间',
				field : 'createdatetime',
				sortable : true
			},  {
				width : '50',
				title : '性别',
				field : 'sex',
				sortable : true,
				formatter : function(value, row, index) {
					switch (value) {
					case 0:
						return '男';
					case 1:
						return '女';
					}
				}
			}, {
				width : '50',
				title : '年龄',
				field : 'age',
				sortable : true
			}, {
				width : '80',
				title : '用户角色',
				field : 'trole',
				sortable : true,
				formatter:function(value,row,index){
					return value.userrole;
				}
			}, {
				width : '80',
				title : '用户类型',
				field : 'tdictionary',
				sortable : true,
				formatter:function(value,row,index){
//					var jsonObjs = $.parseJSON(value);
//					return jsonObjs.text;
//					alert(value.text);
					return value.text;
				}
			},{
				width : '80',
				title : '是否默认',
				field : 'isdefault',
				sortable : true,
				formatter : function(value, row, index) {
					switch (value) {
					case 0:
						return '默认';
					case 1:
						return '否';
					}
				}
			},{
				width : '80',
				title : '状态',
				field : 'state',
				sortable : true,
				formatter : function(value, row, index) {
					switch (value) {
					case 0:
						return '正常';
					case 1:
						return '停用';
					}
				}
			} , {
				width : '100',
				title : '座右铭',
				field : 'zym',
				sortable : true
			},{
				field : 'action',
				title : '操作',
				width : 100,
				formatter : function(value, row, index) {
					var str = '';
					if(row.isdefault!=0){
						if ($.canEdit) {
//							str += $.formatString('<a href="javascript:void(0)" onclick="editFun(\''+ row.OPTID + '\',\''+rec.OPTPER + '\');" >编辑</a>', row.id);
							str += $.formatString('<a href="javascript:void(0)" onclick="editFun(\''+ row.ID + '\');" >编辑</a>', row.id);
						}
						str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
						if ($.canDelete) {
							str += $.formatString('<a href="javascript:void(0)" onclick="deleteFun(\'{0}\');" >删除</a>', row.id);
						}
					}
					return str;
				}
			}] ],
			toolbar : '#toolbar'
		});
	});
	
	function addFun() {
		parent.$.modalDialog({
			title : '添加',
			width : 500,
			height : 300,
			href : '${ctx}/user/addPage',
			buttons : [ {
				text : '添加',
				handler : function() {
					parent.$.modalDialog.openner_dataGrid = dataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
					var f = parent.$.modalDialog.handler.find('#userAddForm');
					f.submit();
				}
			} ]
		});
	}
	
	function deleteFun(id) {
		if (id == undefined) {//点击右键菜单才会触发这个
			var rows = dataGrid.datagrid('getSelections');
			id = rows[0].id;
		} else {//点击操作里面的删除图标会触发这个
			dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		}
		parent.$.messager.confirm('询问', '您是否要删除当前用户？', function(b) {
			if (b) {
				var currentUserId = '${sessionInfo.id}';/*当前登录用户的ID*/
				if (currentUserId != id) {
					progressLoad();
					$.post('${ctx}/user/delete', {
						id : id
					}, function(result) {
						if (result.success) {
							parent.$.messager.alert('提示', result.msg, 'info');
							dataGrid.datagrid('reload');
						}
						progressClose();
					}, 'JSON');
				} else {
					parent.$.messager.show({
						title : '提示',
						msg : '不可以删除自己！'
					});
				}
			}
		});
	}
	
	function editFun(id) {
		if (id == undefined) {
			var rows = dataGrid.datagrid('getSelections');
			id = rows[0].id;
		} else {
			dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		}
		parent.$.modalDialog({
			title : '编辑',
			width : 500,
			height : 300,
			href : '${ctx}/user/editPage?id=' + id,
			buttons : [ {
				text : '编辑',
				handler : function() {
					parent.$.modalDialog.openner_dataGrid = dataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
					var f = parent.$.modalDialog.handler.find('#userEditForm');
					f.submit();
				}
			} ]
		});
	}
	
	function searchFun() {
		dataGrid.datagrid('load', $.serializeObject($('#searchForm')));
	}
	function cleanFun() {
		$('#searchForm input').val('');
		dataGrid.datagrid('load', {});
	}
	</script>
</head>
<body class="easyui-layout" data-options="fit:true,border:false">

	<%--<div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #f4f4f4">--%>
		<%--<form id="searchForm">--%>
			<%--<table>--%>
				<%--<tr>--%>
					<%--<th>姓名:</th>--%>
					<%--<td><input name="name" placeholder="请输入用户姓名"/></td>--%>
					<%--<th>创建时间:</th>--%>
					<%--<td><input name="createdatetimeStart" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly" />至<input  name="createdatetimeEnd" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly" />--%>
					<%--<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon_search',plain:true" onclick="searchFun();">查询</a><a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon_cancel',plain:true" onclick="cleanFun();">清空</a></td>--%>
				<%--</tr>--%>
			<%--</table>--%>
		<%--</form>--%>
	<%--</div>--%>

	<!--搜索表格Begin-->
	<div data-options="region:'north',border:false" class="SR_searchTableBox">
		<form id="demoGridForm" name="demoGridForm" method="post">
			<table>
				<tr>
					<td class="SR_searchTitle">用户编号:</td>
					<td class="SR_searchconten"><input name="userId" class="SR_pureInput" type="text"/></td>
					<td class="SR_searchTitle">登陆账号:</td>
					<td><input name="userAccount" class="SR_pureInput" type="text"/></td>
					<td class="SR_searchTitle">用户名称:</td>
					<td><input name="userAccount" class="SR_pureInput" type="text"/></td>
				</tr>
				<tr>
					<td class="SR_searchTitle">登陆密码:</td>
					<td><input name="userPassword" class="SR_pureInput" type="text"/></td>
					<td class="SR_searchTitle">电子邮箱:</td>
					<td><input name="userEmail" class="SR_pureInput" type="text"/></td>
					<td align="right">
						<a class="SR_moduleSearch"></a>
					</td>
				</tr>
				</tr>
			</table>
		</form>
	</div>
	<!--搜索表格End-->

	<!--页面表格Begin-->
	<div data-options="region:'center',border:false,title:'用户列表'" >
		<table id="dataGrid" data-options="fit:true,border:false"></table>
	</div>
	<div data-options="region:'west',border:false,split:true,title:'组织机构'"  style="width:140px;overflow: hidden; ">
		<ul id="organizationTree"  style="width:180px;margin: 10px 10px 10px 10px">
		</ul>
	</div>
	<!--页面表格End-->

	<div id="toolbar" style="display: none;">
		<c:if test="${fn:contains(sessionInfo.resourceList, '/user/add')}">
			<a onclick="addFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon_add'">添加</a>
		</c:if>
	</div>
</body>
</html>