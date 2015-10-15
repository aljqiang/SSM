var p_userDesktop = {zym:'',txtp:''},P_mytabs={},isFirst=false;


function initLayout_shortcut(){
	for(var prop in g_user)
		$('#'+prop).text(g_user[prop]);
	$('#shortcutArea').width($(window).width()-4);
	/*
	var topHeight = top.document.body.clientHeight;
	//var h = $(window).height()-14-$('#tab_btn').height();
	var h = topHeight-top.topHeight-30-27-7;
	$('#userInfoArea').height(h)
	.draggable({
		handle:'.userTitle',
		drag:function(ev,ui){}
	})
	.resizable()
	.css({'top':'3px',right:'0px',position:'absolute','max-height':h,'z-index':'9999'})
	*/
}

function queryShortcuts(){
	var container = $('#shortcuts');
	container.empty();
	ajaxJson({
		funcId:['33300003'],
		data:[{ygbh:g_user.ygbh}],
		func:showShortcuts
	})
}
function showShortcuts(resultObj){
	var scData = resultObj['33300003'];
	for(var i=0;i<scData.length;i++)
		addSC({menuTitle:scData[i].cdmc,page:scData[i].cdlj,icon:scData[i].tblj,id:scData[i].id});
	
}
function showSCcontext(ev){
	var OBJ = $(this),id = ev.data.id;
	if($('.shortcutPop').size()>0)$('.shortcutPop').remove();
	var ul =$('<ul class="shortcutPop"></ul>');
	var iconLi = $('<li class="changeIcon">更改图标</li>');
	var delLi = $('<li class="delItem">删除</li>');
	ul.append(iconLi).append(delLi);
	var pos = $(this).offset();
	var popTimer;
	
	ul.css('left',pos.left+30).css('top',pos.top+40)
		.children('li').hover(function(){$(this).addClass('hover')},function(){$(this).removeClass('hover')});
	ul.bind('mouseout',{obj:ul},function(ev){popTimer = setTimeout(function(){ev.data.obj.remove()},900)})
		.find('li').bind('mouseover',function(){clearTimeout(popTimer)});
	
	iconLi.bind('click',{obj:OBJ,id:id},showSCicons);
	delLi.bind('click',{obj:OBJ,id:id},delSC);
	
	$('body').append(ul);
	return false;
}
function showSCicons(ev){
	if($('.iconPreview').size()>0)$('.iconPreview').remove();
	var pos = ev.data.obj.offset();
	var div = $('<div class="iconPreview"><h4><div class="txt">更改图标</div><div class="closeBtn"></div></h4></div>');
	var leftPos = pos.left+30;
	if($('body').width()<leftPos+200)
		leftPos = $('body').width()-200;
	
	div.css('left',leftPos).css('top',pos.top+50)
		.find('.closeBtn').bind('click',function(){$(this).parent().parent().remove();});
	for(var i=1;i<=50;i++){
		var iconDiv = $('<div class="iconDiv"></div>');
		iconDiv.hover(function(){$(this).fadeTo('fast',0.6)},function(){$(this).fadeTo('fast',0.1)})
			.bind('click',{idx:i,obj:ev.data.obj,id:ev.data.id},changeIcon);
		div.append(iconDiv);
	}
	$('body').append(div);
}
function changeIcon(ev){
	$(this).parent().remove();
	ajaxJson({
		funcId:['33300004'],
		data:[{id:ev.data.id,tbbh:ev.data.idx}],
		func:function(){ev.data.obj.css('background','url('+g_kjafPath+'img/shortcuts/64/'+ev.data.idx+'.gif) no-repeat');}
	})
}
function delSC(ev){
	ajaxJson({
		funcId:['33300002'],
		data:[{id:ev.data.id,ygbh:g_user.ygbh,flag:'0'}],
		func:function(a1,a2){return function(resultObj){a1.remove();a2.remove();}}(ev.data.obj,$(this).parent())
	})
}
function addNewSC(dataObj){
	ajaxJson({
		funcId:['33300001'],
		data:[{cdbh:dataObj.id,ygbh:g_user.ygbh}],
		func:queryShortcuts
	})
}
function addSC(dataObj){
	var container = $('#shortcuts');
	var div = $('<div class="scIcon"><div>'+dataObj.menuTitle+'</div></div>');
	div.bind('click',dataObj,function(ev){top.pageTab.loadPage(ev.data.page,ev.data.menuTitle)})
		.hover(function(){$(this).addClass('hover')},function(){$(this).removeClass('hover')})
		.bind('contextmenu',{id:dataObj.id},showSCcontext);
	if(dataObj.icon && dataObj.icon >0 && dataObj.icon<=50)
		div.css('background','url('+g_kjafPath+'img/shortcuts/64/'+dataObj.icon+'.gif) no-repeat');
	container.append(div);
}

function showUploadForm(){
	var formObj = new DataForm();
	formObj.setParam({
		id:'uploadForm',
		title:'上传头像',
		column:'1',
		width_desc:80,
		width_obj:250,
		defaultButtons:false
	});
	var cols = [
		{name:'图片上传',field:'upload',type:'file',file_module:'13',file_field:'ygbh',file_num:'1',file_type:'jpg,gif,png,bmp'},
		{name:'上传新图片前请先删除旧图片文件!<br/>图片格式: jpg, gif, png, bmp<br/>图片尺寸: 80x100像素',type:'empty'},
		{name:'员工编号',field:'ygbh',type:'input',hidden:'true',val:g_user.ygbh}
	];
	formObj.addColumns(cols);
	var btns = [{name:'上传',func:'_uploadPortrait'}];
	formObj.addBtns(btns)
	formObj.draw();
}
function _uploadPortrait(formObj){
	formObj.uploadSubmit(g_user.ygbh);//以员工编号作为关联数据，进行附件上传	//附件上传后续处理
	p_uploadResponFunc.obj = formObj;
	p_uploadResponFunc.func = function(){
		getUserDesktop();
		p_uploadResponFunc.func = null;
	}
}

function showZYMform(){
	var formObj = new DataForm();
	formObj.setParam({
		id:'zymForm',
		title:'编辑座右铭',
		column:'1',
		width_desc:60,
		width_obj:250,
		defaultButtons:false
	});
	var cols = [
		{name:'座右铭',field:'zym',type:'textarea',rows:'6',max:'100'}
	];
	formObj.addColumns(cols);
	var btns = [{name:'确定',func:'_updateZYM'}];
	formObj.addBtns(btns)
	formObj.draw();
}

function _updateZYM(formObj){
	var data = formObj.getFormData();
	ajaxJson({
		funcId:['12990009'],
		data:[{ygbh:g_user.ygbh,zym:data.zym}],
		func:getUserDesktop
	})
	$('#zymForm').dialog('close');
}
function zymForm_loaded(formObj){formObj.setFormData({zym:p_userDesktop.zym})}

function getUserDesktop(){
	ajaxJson({
		funcId:['12990008'],
		data:[{ygbh:g_user.ygbh}],
		func:getUserDesktop_step2
	})
}

function getUserDesktop_step2(resultObj){
	var data = resultObj['12990008'];
	if(data.length == 0)return;
	p_userDesktop = {
		zym:data[0].zym,
		txtp:data[0].txtp
	}
	$('#zym').text(data[0].zym)
	$('#userPic').empty();
	if(data[0].txtp){ 
		$('#userPic').attr('class','haveUserPic2');
		$('#userPic').append($('<img src="'+g_contextPath+'/'+data[0].txtp+'" width="100" height="100">'));
	}
	else
		$('#userPic').attr('class','userPic2');}

	