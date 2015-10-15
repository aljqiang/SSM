var showBottomBar = true;// 是否显示底部条
var menuWidth = 180;//菜单宽度
var topHeight = 114;//92// 顶部帧高度

var showAnnouncements = true;	//是否显示公告栏
var annouceFrmHeight = 150;//公告栏目高度
var minimizedOnload = false;	//公告栏加载默认最小化

var bottomConf ={
   //sysText : '深圳市金慧盈通数据服务有限公司',
   sysText:'深圳市金证科技股份有限公司 版权所有',
   icons :{// 底部条图标
      debug:{icon:g_kjafPath+'img/bottom_icon_debug.gif',title:'测试工具',func:function(){toggleConsole(this)}},
      //help:{icon:g_kjafPath+'img/bottom_icon_help.gif',title:'帮助',func:function(){alert('帮助功能尚未实现，请等待更新!');}},
      Option:{icon:g_kjafPath+'img/bottom_icon_option.gif',title:'界面选项',func:function(){showOptionsList(this);}}
   }
};

$(function(){
	log.debug("frame loading...");
	sysconfig();
	//cacheData();//修改工作流翻译后，已不再需要此操作, 20100315
	showLoading();
	setTimeout(function(a,b){return function(){a();b();}}(initFrames,initTabs),1)
	log.debug("frame loaded...");
	document.title= g_sysConfig[g_sysConfig.sysName].titleText;
	if(g_sysParam['8899']&&g_sysParam['8899'].csqz==1)
		alert("平台测试中...");
});

function onResizeHandler(){
	resizeFrames();
	var contentDoc = $("#menuFrame").contents();
	contentDoc.find('div[id*="subMenu"]').height($('#menuFrame').height() - (contentDoc.find('li.menuItem').height()+3)* contentDoc.find('li.menuItem').size());
	$('#scrollRight').css('left',$(window).width()-10);
};
var resizeTimer = null;
$(window).bind('resize', 
	function() {
		if (resizeTimer) clearTimeout(resizeTimer);
		resizeTimer = setTimeout(onResizeHandler, 100);
	}
);

function initFrames(){
	var aHeight = showAnnouncements?annouceFrmHeight:0;
	$('iframe').each(function(){
		switch($(this).attr('id')){
			case 'topFrame':
			$(this).width($(window).width()).height(topHeight).attr('src', '../callManage/callManage.htm');
			break;
			case 'menuFrame':
			$(this).width(menuWidth).height($(window).height() - aHeight -22-$('#topFrame').height()).attr('src', 'menu.htm').css({'float':'left','clear':'both'}).after('<div id="switch"></div>');
			break;
			case 'mainFrame':
			var a = ( $.browser.msie && $.browser.version == '6.0') ? 4 : 0;
			$(this).width($(window).width() - $('#menuFrame').width() - a).height($('#menuFrame').height()-30-22).css('float', 'left');
			break;
		}
	})
	if(showAnnouncements){
		AnnouncePanel.init();
		setKnowledgeStatus();
	}
	if(showBottomBar){
		$('#mainFrame').after('<div id="bottomBar"><div id="bottomTxt"><div>' + bottomConf.sysText + '</div></div><div id="bottomInfo"><div class="errList"></div></div><div id="bottomIcon"><ul></ul></div></div>');
		$('#menuFrame').height($('#menuFrame').height() - $('#bottomBar').height());
		$('#mainFrame').height($('#mainFrame').height() - $('#bottomBar').height());
		for(var prop in bottomConf.icons){
			$('#bottomIcon ul').append('<li id="bottomIcon_'+prop+'" title="'+bottomConf.icons[prop].title+'"></li>');
			$('#bottomIcon_' + prop).css('background', 'url(' + bottomConf.icons[prop].icon + ') no-repeat').click(bottomConf.icons[prop].func)
				.fadeTo('fast',0.5).hover(function(){$(this).fadeTo('slow',1)},function(){$(this).fadeTo('slow',0.5)});
		}
	}
	$('#switch').addClass('menuSwitch').hover(function(){$(this).fadeTo('normal',0.5);},function(){$(this).fadeTo('normal',1);}).bind('click',switchMenu).css('left',$('#menuFrame').width()).css('top',($(window).height()-$('#topFrame').height())/2).attr('title','展开/折叠菜单栏');
}

function resizeFrames(){
	var bottomHeight = 0,aHeight=0;
	if(showAnnouncements){
		aHeight = AnnouncePanel.isMinimized()?23:annouceFrmHeight;
	}
	var a = ( $.browser.msie && $.browser.version == '6.0') ? 4 : 0;
	if(showBottomBar){
		$('#bottomBar').width($(window).width());
		bottomHeight = $('#bottomBar').height();
	}

	$('#topFrame').width($(window).width());	
	$('#menuFrame').height($(window).height()-aHeight-$('#topFrame').height()-bottomHeight);
	if($('#fullScreen').size()==0)
		$('iframe[id*="mainFrame"]').width($(window).width()-$('#menuFrame').width() -a).height($(window).height()-$('#topFrame').height()-bottomHeight-30);
	$('#tabs').width($('#mainFrame').width());
}

function switchMenu(){
   if($('#menuFrame').width() == 0){
   		$(this).css('left',menuWidth);
      $('#menuFrame').width(menuWidth);
      var a = ( $.browser.msie && $.browser.version == '6.0') ? 4 : 0;
      $('iframe[tab]').width($(window).width() - $('#menuFrame').width() - a);
      if($('#scrollLeft').size() > 0){
         var l = $('#scrollLeft').css('left');
         $('#scrollLeft').css('left', parseFloat(l) + menuWidth);
      }
      if(showAnnouncements){
      	$('#announcements').show();
      }
   }
   else{
   		$(this).css('left',0)
      var w = $('#menuFrame').width();
      var w2 = $('#mainFrame').width();
      $('#menuFrame').width(0);
      $('iframe[tab]').width(w + w2);
      if($('#scrollLeft').size() > 0){
         var l = $('#scrollLeft').css('left');
         $('#scrollLeft').css('left', parseFloat(l) - menuWidth);
      }
      if(showAnnouncements){
      	$('#announcements').hide();
      }
   }
   $('#tabs').width($('#mainFrame').width());
}

var pageTab;
function initTabs(){
	log.debug("tab loading...");
	pageTab = new FrameTab();
	pageTab.init();
	pageTab.addTab('main.htm', '我的桌面');
	hideLoading('主框架');
	log.debug("tab loaded...");
}

function showLoading(){
	$('body').append('<div id="frameLoadingDiv">正在加载，请稍候.... <span id="loadingMsg">0%</span><div class="progress"><div class="filled"></div></div><ul><li class="zkj">主框架</li><li class="zm">桌面</li><li class="hwt">话务条</li><li class="cd">菜单</li></ul></div><div id="frameLoadingMask"></div>');
	$('#frameLoadingMask').width($(window).width()).height($(window).height());
	$('#frameLoadingDiv').width(400).height(200).css('left',($(window).width()-300)/2).css('top',$(window).height()*0.3);
}

hideLoading.progress = 0;
function hideLoading(flag){
	switch(flag){
		case '菜单':
			this.menuLoaded = true;
			$('#frameLoadingDiv li.cd').addClass('loaded');
			hideLoading.progress += 40;
			break;
		case '主框架':
			this.frameLoaded = true;
			$('#frameLoadingDiv li.zkj').addClass('loaded');
			hideLoading.progress += 15;
			break;
		case '话务条':
			this.topLoaded = true;
			$('#frameLoadingDiv li.hwt').addClass('loaded');
			hideLoading.progress += 30;
			break;
		case '桌面':
			this.desktopLoaded = true;
			$('#frameLoadingDiv li.zm').addClass('loaded');
			hideLoading.progress += 15;
	}
	if(this.menuLoaded && this.frameLoaded && this.topLoaded && this.desktopLoaded){
		$('#frameLoadingDiv .filled').width(220);
		$('#loadingMsg').text('完成!');
		setTimeout(function(){$('#frameLoadingMask').fadeOut(1200);$('#frameLoadingDiv').fadeOut(500);},1000);
		document.getElementById("topFrame").contentWindow.allFramesLoaded();
	}
	else {
		$('#frameLoadingDiv .filled').width(220*(hideLoading.progress/100));
		$('#loadingMsg').text(hideLoading.progress+'%');
	}
}
window.onbeforeunload = _exitRequest_confirm;
window.onunload=_exitRequest;
var _unloadText = '按"确定"后系统将自动注销您的登录。'
var _unloadFlag = true;	//超时跳转 relogin.jsp 将此值修改为false. 为false 时将不再尝试清空session
function _exitRequest_confirm(evt){
	evt = window.event?window.event:evt;
	evt.returnValue=_unloadText;
}
function _exitRequest(needForward){
	if(needForward){
		try{
			top.location.href=g_contextPath + "/page/frame/login.jsp";
		}
		catch(ex){}
	}
	else if(_unloadFlag){
		$.ajax({url:g_contextPath+'/page/frame/logout.jsp'}); 
		//window.open(g_contextPath+'/page/frame/logout.jsp','_blank','left=2000,top=2150,width=100,height=80');
	}
}
function sysconfig(){	//获取系统配置参数,相当于原sysconfig.jsp
	var _urlParam = getUrlParam(location);
	g_user = {telNumber:_urlParam.telNumber,agentType:_urlParam.agentType};
	//请求用户信息
	ajax({
		funcId:'12300001',
		data:{ygbh:_urlParam.ygbh},
		func:function(xmlDoc){setSysconfig(xmlDoc,'user')},
		sync:true
	})

	//请求系统参数
	ajax({
		funcId:'11010001',
		data:{csbh:'-1'},
		func:function(xmlDoc){setSysconfig(xmlDoc,'param')},
		sync:true
	})
}
function cacheData(){//登录缓存数据,目前只定义了员工和员工组
	var funcAry = ['12300001','12200001'];
	var paramAry = [{ygbh:'-1',kglbs:'0',dwbh:'-1'},{fzbh:'-1',fzyt:'-1'}];
	var keyAry = [
		['12300001','ygbh','yg'],
		['12200001','fzbh','ygz']
	];
	ajaxJson({
		funcId:funcAry,
		data:paramAry,
		func:function(resultObj){makeCacheData(resultObj,keyAry)}
	})
}
function makeCacheData(resultObj,keyAry){
	/*
	for(var i=0;i<keyAry.length;i++){
		if(resultObj._result[keyAry[i][0]].flag !='1'){
			alert('缓存数据出错，请联系系统管理员!');
			return;
		}
	}
	*/
	var obj = {};
	for(var i=0;i<keyAry.length;i++){
		var records = resultObj[keyAry[i][0]];
		var tmpObj = {};
		for(var j=0;j<records.length;j++)
			tmpObj[records[j][keyAry[i][1]]] = records[j];
		obj[keyAry[i][2]] = tmpObj;
	}
	top.g_cache = obj;
}
function setSysconfig(xmlDoc,type){
	var record = $('record',xmlDoc);
	if(type == 'user'){
		var tags = record.children();
		tags.each(function(){
			g_user[this.tagName] = $(this).text().trim();
		});
	}
	if(type == 'param'){
		g_sysParam = {};
		record.each(function(i){
			//g_sysParam[i]={};
			var tmpObj = {};
			var tags = $(this).children();
			tags.each(function(){
				tmpObj[this.tagName] = $(this).text().trim();
			});
			g_sysParam[tmpObj.csbh] = tmpObj;
		});
	}
}

function showOptionsList(obj){
	if($('#uiOption').size()>0)return;
	var fontSize = $.cookie('_uiFontSize')||'12';
	var pos = $(obj).offset();
	var htmlStr = '<div id="uiOption" class="uiOption">';
			htmlStr+= '<h4><div class="title">界面选项</div><div class="btn_close"></div></h4>';
			htmlStr+= '<div class="uiOptionDiv">字体大小(<span id="fontSizeIndicator">'+fontSize+'</span>像素): <a href="#" onclick="uiFontSize_toDefault()">默认</a><div id="fontSizeSlider" class="uiSlider_font"></div></div>';//'字体大小: <input type="text" id="uiFontSize" value="'+fontSize+'" /><br/>';
			htmlStr+= '</div>';
	$('body').append($(htmlStr));
	$('#uiOption').css({left:pos.left-$('#uiOption').width()+20,top:pos.top-$('#uiOption').height()-5})
		.find('.btn_close').bind('click',function(){$('#uiOption').remove()})

	$('#fontSizeSlider').slider({
		min:1,
		max:30,
		step:1,
		range:'min',
		value:fontSize,
		slide:function(evt,ui){
			$('#fontSizeIndicator').text(ui.value);
			submitUiOption(ui.value);
		}
	})
	
}
function uiFontSize_toDefault(){
	$('#fontSizeIndicator').text(12);
	$('#fontSizeSlider').slider('option','value',12)
	submitUiOption(12);
}
var p_uiFontsize = 12;
function submitUiOption(val){
	var ifrms = top.$('iframe[tabId]');
	ifrms.each(function(){
		var w = $(this)[0].contentWindow;
		w.$('body').css('font-size',val);
		w.$('input').css('font-size',val);
		w.$('select').css('font-size',val);
	});
	$.cookie('_uiFontSize',val,{expires:9999});
}
function checkUIfontSize(){
	var s = $.cookie('_uiFontSize');
	if(s!=12)
		submitUiOption(s);
}
function setKnowledgeStatus(){
	 var _urlParam = getUrlParam(location);
		ajax({
		funcId:'84000030',
		data:{ygbh:_urlParam.ygbh},
		sync:true
	})
}


function getTopCCWindow(){
	var obj = document.getElementById("topFrame").contentWindow;
	return obj;
}
_showSubscribeDialog.func = null;
_showSubscribeDialog.data = null;
function _showSubscribeDialog(pos,str,func,data){
	_showSubscribeDialog.func = func;
	_showSubscribeDialog.data = data;
	var div = $('<div id="_KDCC_subscribeDialog" class="_KDCC_subsribeDialog"><div class="_KDCC_subsribeDialog_title"><div>请订阅任务</div><div class="btn_close">x</div></div><div id="_KDCC_subscribeDialog_form" class="simpleForm"></div></div>');
	div.css({left:pos.left,top:pos.top+10}).find('.btn_close').bind('click',function(){$('#_KDCC_subscribeDialog').remove()})
	$('body').append(div);
	var taskForm = new DataForm();
	taskForm.setParam({
		id:'_KDCC_subscribeDialog_form',
		column:1,
		width_obj:100,
		width_desc:60,
		defaultButtons:false
	})
	taskForm.addColumn({name:'任务列表',field:'hcsjbh',type:'select',dict_type:'string',option:str,multi:'true'});
	taskForm.addBtn('订阅','_subscribeDialog_submit')
	taskForm.draw();
}
function _subscribeDialog_submit(formObj){
	var data = formObj.getFormData();
	if(!data.hcsjbh){
		formObj.showVerification('hcsjbh','请选择要订阅的任务!');
		return;
	}
	$('#_KDCC_subscribeDialog').remove();
	if(_showSubscribeDialog.func)_showSubscribeDialog.func(data.hcsjbh);
}
function _showSubscribedTask(hcsjbh,leftAmt){
	var data = _showSubscribeDialog.data;
	var ary = hcsjbh.split(','),tempObj = {};
	var list = $('<ul class="subscribedList"></ul>');
	for(var i=0;i<data.length;i++){
		tempObj[data[i].hcsjbh] = data[i].hcsjmc;
	}
	for(var i=0;i<ary.length;i++){
		var li = $('<li>'+tempObj[ary[i]]+'</li>');
		list.append(li);
	}
	leftAmt = leftAmt||730;
	list.css({left:leftAmt,top:18});
	$('body').append(list);
	setTimeout(function(){$('.subscribedList').remove()},3000);
}

var AnnouncePanel = function(){
	var _funcId = '27300101';	//查询公告的功能号
	var _funcParam = {lsh:-1,fqrbh:-1};	//查询入参
	var _detailPage= '/page/flowAdmin/noticeDetail.htm?';	//查看详细内容页面。目前链接到公告查询页面, url入参中会传入lsh
	
	var _isMin = minimizedOnload;
	var _data = [];
	
	var thisObj = {
		init:function(){
			var aDiv = $('<div id="announcements" class="announcements"><h4><div class="title_announcement">公告栏</div><div id="announce_btn1" class="btn_collapse"></div><div id="announce_refresh" class="announce_refresh" onclick="announce_refresh();"></div></h4><div class="announce_content"></div></div>');
			aDiv.width(menuWidth-2).height(annouceFrmHeight-2).find('.announce_content').height(annouceFrmHeight-25);
			aDiv.find('#announce_btn1').bind('click',function(){thisObj.toggleMinimize()});
			aDiv.find('h4').bind('dblclick',function(){thisObj.toggleMinimize()})
			$('#menuFrame').before(aDiv);
			$('#announcements').draggable({revert:true});
			if(_isMin)thisObj.minimize();
			thisObj.requestData();
		},
		requestData:function(){
			ajaxJson({
				funcId:[_funcId],
				data:[_funcParam],
				cache:false,
				global:false,	//禁用全局事件(请稍候的提示框)
				func:function(resultObj){thisObj.requestRespon(resultObj)}
			});
			//setTimeout(function(){thisObj.requestData()},300000);
			setTimeout(function(){thisObj.requestData()},60000);
		},
		requestRespon:function(resultObj){
			_data = resultObj[_funcId];
			if(_data)thisObj.showMsg();
		},
		showMsg:function(){
			if(_data.length==0)return;
			if(!_isMin){
				var contentDiv = $('#announcements .announce_content');
				contentDiv.empty();
				var ul = $('<ul></ul>');
				for(var i=0;i<_data.length;i++){						
					var titleStr = _data[i].tzzy,titleStr2=titleStr;
					var maxLen = Math.floor((menuWidth-20)/13);
					if(maxLen<titleStr.length)
						titleStr2 = titleStr.substring(0,maxLen-3)+'...';
						
					var contentStr = _data[i].tznr,cStr = contentStr.length>100?contentStr.substring(0,100)+'...':contentStr;
					var mouseoverStr = '['+titleStr+']\n'+contentStr;
					if(_data[i].zycd == 0){
						titleStr2 = '<div class="announce_zycd0"></div>' + '['+ titleStr2 + ']';
					}else if(_data[i].zycd == 1){
						titleStr2 = '<div class="announce_zycd1"></div>' + '['+ titleStr2 + ']';
					}else{
						titleStr2 = '<div class="announce_zycd2"></div>' + '['+ titleStr2 + ']';
					}
					
					var mouseoverStr = '['+titleStr+']\n'+contentStr;
					var lsh = _data[i].lsh;
					
					var li = $('<li title="'+mouseoverStr+'"><div class="title">'+titleStr2+'</div><div class="content">'+cStr+'</div></li>');
					/*
					li.hover(function(){$(this).addClass('hover')},function(){$(this).removeClass('hover')})
						.bind('click',{obj:thisObj,lsh:lsh},function(ev){ev.data.obj.launchPage(ev.data.lsh)});
					*/
					ul.append(li);
				}
				contentDiv.append(ul);
			}
			else{
				var marq = $('#announcements marquee'),str='';
				for(var i=0;i<_data.length;i++){
					//alert(_data[i].zycd);
					var titleStr = _data[i].tzzy,contentStr = _data[i].tznr;
					str += '['+titleStr+'] '+contentStr+'  ';
				}
				marq.text(str);
			}
		},
		launchPage:function(lsh){top.pageTab.loadPage(_detailPage+'lsh='+lsh,'公告详情',true);},
		minimize:function(){	
			$('#announce_refresh').hide();
			$('#announce_btn1').attr('class','btn_expand');
			$('#announcements').height(23).find('.announce_content').hide();
			var marq = $('<marquee width="'+(menuWidth-40)+'" height="16" scrollDelay="160" direction="left" style="margin-left:20px;"></marquee>')
			$('#announcements .title_announcement').empty().append(marq);
			var menuFrm = $('#menuFrame');
			menuFrm.height(menuFrm.height()+(annouceFrmHeight-23))
			try{
				menuFrm[0].contentWindow._menu_setMenuHeight();
			}
			catch(ex){}
			_isMin = true;
		},
		restore:function(){
			$('#announce_refresh').show();
			$('#announce_btn1').attr('class','btn_collapse');
			$('#announcements').height(annouceFrmHeight).find('.announce_content').show();
			$('#announcements .title_announcement').empty().text('公告栏');
			var menuFrm = $('#menuFrame');
			menuFrm.height(menuFrm.height()-(annouceFrmHeight-23))
			try{
				menuFrm[0].contentWindow._menu_setMenuHeight();
			}
			catch(ex){}
			_isMin = false;
		},
		toggleMinimize:function(){
			if(_isMin)thisObj.restore();
			else thisObj.minimize();
		},
		isMinimized:function(){return _isMin;}
	};
	return thisObj;
}()

function announce_refresh(){
	var _funcId = '27300101';	//查询公告的功能号
	var _funcParam = {lsh:-1,fqrbh:-1};	//查询入参
	ajaxJson({
		funcId:[_funcId],
		data:[_funcParam],
		global:false,	//禁用全局事件(请稍候的提示框)
		func:function(resultObj){
			_data = resultObj[_funcId];			
			if(_data.length !=0 ){
				AnnouncePanel.requestRespon(resultObj);
			}else{
				var contentDiv = $('#announcements .announce_content');
				contentDiv.empty();
			}
		}
	});/**/
}