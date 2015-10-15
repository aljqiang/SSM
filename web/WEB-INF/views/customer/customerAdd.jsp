<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
	$(function() {

		$('#customerAddForm').form({
			url : '${pageContext.request.contextPath}/customer/add',
			onSubmit : function() {
				progressLoad();
				var isValid = $(this).form('validate');
				if (!isValid) {
					progressClose();
				}
				return isValid;
			},
			success : function(result) {
				progressClose();
				result = $.parseJSON(result);
				if (result.success) {
					parent.$.modalDialog.openner_dataGrid.datagrid('reload');//之所以能在这里调用到parent.$.modalDialog.openner_dataGrid这个对象，是因为user.jsp页面预定义好了
					parent.$.modalDialog.handler.dialog('close');
				} else {
					parent.$.messager.alert('错误', result.msg, 'error');
				}
			}
		});

	});
</script>
<div class="easyui-layout" data-options="fit:true,border:false" >
	<div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;" >
		<form id="customerAddForm" method="post">
			<table class="grid">
		
				<tr>
					<td>客户姓名</td>
					<td><input name="customerName" type="text" placeholder="请输入客户姓名" class="easyui-validatebox span2" data-options="required:true" value=""></td>
					<td>性别</td>
					<td><select name="customerSex" class="easyui-combobox" data-options="width:140,height:29,editable:false,panelHeight:'auto'">
						<c:forEach items="${sexList}" var="sexList">
							<option value="${sexList.key}" >${sexList.value}</option>
						</c:forEach>
					</select></td>
				</tr>
				<tr>
					
					<td>证件类型</td>
					<td><select name="cardType" class="easyui-combobox" data-options="width:140,height:29,editable:false,panelHeight:'auto'">
						<c:forEach items="${cardType}" var="cardType">
							<option value="${cardType.key}" >${cardType.value}</option>
						</c:forEach>
					</select>
					</td>
					<td>证件号码</td>
					<td><input name="cardNum" type="text" placeholder="请输入证件号码" class="easyui-validatebox span2" data-options="required:true" value=""></td>
				</tr>
				
				<tr>
					<td>办公电话</td>
					<td><input name="customerBGDH" type="text" placeholder="请输入办公电话" class="easyui-validatebox span2" ></td>
					<td>移动电话</td>
					<td><input name="customerMobilePhone" type="text" placeholder="请输入移动电话" class="easyui-validatebox span2"  ></td>
				</tr>
				<tr>
					<td>家庭电话</td>
					<td><input name="customerJTDH" type="text" placeholder="请输入家庭电话" class="easyui-validatebox span2" </td>
					<td>EMAIL</td>
					<td><input name="customerEMail" type="text" placeholder="请输入邮箱地址" class="easyui-validatebox span2"  ></td>
				</tr>
				<tr>
					<td>地址</td>
					<td colspan="5"><input name="customerAddress" type="text" placeholder="请输入通讯地址" class="easyui-validatebox span2" style="width: 300px;" ></td>
				</tr>
				<tr>
					<td>备注</td>
					<td colspan="5"><textarea id="customerRemark" name="customerRemark" style="width: 300px; height: 50px;" ></textarea></td>
				</tr>
			</table>
		</form>
	</div>
</div>