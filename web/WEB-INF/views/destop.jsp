<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
	$(function() {

		$('#uploadForm').form({
			url : '${pageContext.request.contextPath}/upload/upload?floder=photo',
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
					parent.$.messager.alert('成功', result.msg, 'info');
					parent.$.modalDialog.handler.dialog('close');
					var currTab = parent.index_tabs.tabs('getSelected');  
					var content = currTab.panel('options').content;
					parent.index_tabs.tabs('update',{  
						tab:currTab,  
						options:{  
							content: content
							}    
					});
				} else {
					parent.$.messager.alert('错误', result.msg, 'error');
				}
			}
		});
	});
</script>
<div class="easyui-layout" data-options="fit:true,border:false" >
	<div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;" >
		<form form id="uploadForm" method="post"  enctype="multipart/form-data">
			<table class="grid">
		    <tr> 
           		<td align="center">图片上传：   
           			 <input id="photo" type="file" name="photo"/> 
           		</td>
           </tr>
           <tr>  
            	<td align="center" style="color: red">图片格式:jpg,gif,png,bmp 图片尺寸:80*100像素</td>
           </tr>
			</table>
		</form>
	</div>
</div>
