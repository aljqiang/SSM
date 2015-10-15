var p_form1,p_form2;
$(function(){
//tabs标签配置
//var tabParam = {loginTab:{tabs:{'座席人员登录':'form1_container','考生登录':'form2_container'}}};
var tabParam = {loginTab:{tabs:{'座席人员登录':'form1_container'}}};
//生成tabs
$tabs(tabParam);

//登录验证
var pageParam = getUrlParam(location);
if(pageParam)
{
	_request_code = pageParam.code || _request_code;
	_request_msg = pageParam.msg || _request_msg;
}
if(_request_code != 'null' && parseFloat(_request_code) != 0)
	$('body').append('<div id="loginError">'+_request_msg+'</div>');
//if(top!=self)
	//top.location.href=g_contextPath + '/page/frame/login.jsp';

//改变tabs 样式布局
$('#loginTab').addClass('login').css('left',($(window).width()-$('.login_logo').width())/2).css('top',$(window).height()*0.2+$('.login_logo').height());
$('.login div[class*="pic_"]').show();//将系统图片先隐藏再显示，解决"跳动"问题。

//改变logos 区域样式布局
$('.login_logo').append('<div id="coLogo"></div><div id="sysLogo"></div><div id="helpBtn"></div>')
	.css('left',($(window).width()-$('.login_logo').width())/2).css('top',$(window).height()*0.2);
$('.login_logo #coLogo').addClass(g_sysConfig[g_sysConfig.sysName].login_logo_class);
$('.login_logo #sysLogo').addClass(g_sysConfig[g_sysConfig.sysName].login_sysLogo_class);
document.title = g_sysConfig[g_sysConfig.sysName].titleText;

//读cookie 和登录IP, 配置成form 入参
var paramObj1 = {
	ygbh:$.cookie('_ygbh')||'',
	telNumber:$.cookie('_telNumber')||'',
	agentType:$.cookie('_agentType')||'',
	kz_bc:$.cookie('_kz_bc')||'',
	dllx:$.cookie('_dllx')||'',
	sjlx:$.cookie('_sjlx')||'',
	dlIP:'127.0.0.1'
};
var paramObj2 = {}
//创建form1 对象
p_form1 = new DataForm();
//配置form1 列 (因为不读config 配置信息，所以列内容等信息需要在页面上配好)
var cols = [
	{name:'用户名',field:'ygbh',type:'input',must:'true'},
	{name:'密码',field:'ygmm',type:'password',must:'true'},
	{name:'签入类型',field:'agentType',type:'select',option:'座席分机:1|办公电话:2|移动电话:3|其他方式:4',must:'true',switchField:'4:telNumber'},
	{name:'电话号码',field:'telNumber',type:'input',valType:'number'},
	//{name:'班次',field:'kz_bc',type:'select',option:'白天A班:1|白天B班:2|晚上A班:3|晚上B班:4',must:'true'},
	{name:'登录IP',field:'dlIP',type:'input',disabled:'true',hidden:'true'}
];
//设置其他 form1 配置参数
p_form1.setParam({
	id:'form1',	//挂载点div id
	title:'座席人员登录',	//表单标题。在登录页面上已被隐藏
	cols:cols,	//列配置
	column:1,	//列数
	width_desc:70,	//文字栏宽度
	width_obj:200,	//表单对象（文本框等）栏宽度
	passParam:paramObj1,	//form1 入参
	submitAjax:false, //不采用ajax 方式提交登录请求，而是发送url 串
	submitUrl:'login.do?forward=success&',
	submitFuncId:'11900001' //提交请求
});
//绘制form1 对象
p_form1.draw();

//考生登录表单，配置方法同form1
p_form2 = new DataForm();
var cols2 = [
	{name:'号码类型',field:'dllx',type:'select',must:'true',option:'员工工号:1|考生编号:2|证件号码:3'},
	{name:'考生号码',field:'dlhm',type:'input',must:'true',max:'30'},
	{name:'考生密码',field:'dlmm',type:'password',must:'true',max:'32'},
	{name:'登录类型',field:'sjlx',type:'select',option:'正式考试:1|模拟练习:2|成绩查询:3',must:'true'}
];
p_form2.setParam({
	id:'form2',
	title:'考生登录',
	cols:cols2,
	column:1,
	width_desc:70,
	width_obj:200,
	passParam:paramObj1,
	submitAjax:false,
	submitUrl:'login.do?forward=success&',
	submitFuncId:'68010510'
});
p_form2.draw();
//改变帮助按钮样式局
$('#helpBtn').hover(function(){$(this).fadeTo("slow", 0.2)},function(){$(this).fadeTo("slow",1)}).attr('title','登录指南').bind('click',showHelp);

checkSysRequirements();
});

//form1 提交前执行的页面函数，参数为form1 对象
//可在此函数内通过 return false 来阻止提交
function form1_beforeSubmit(obj)
{
	var data = obj.getFormData();
	if(data.agentType == '4' && !data.telNumber){
		obj.showVerification('telNumber','选择其它方式签入时必须输入电话号码!');
		return false;
	}
	$.cookie('_ygbh',data.ygbh,{expires:9999});//{expires: 7, path: ‘/’, domain: ‘jquery.com’, secure: true}
	$.cookie('_telNumber',data.telNumber,{expires:9999});
	$.cookie('_agentType',data.agentType,{expires:9999});
	$.cookie('_kz_bc',data.kz_bc,{expires:9999});
	
	/*//如果检测到浏览器问题禁止登录
	if(p_sysReqFail){
		var ul = $('#browserWarning');
		var li = $('#noSubmitWarning');
		li = li.size() == 0?$('<li id="noSubmitWarning">在更正以上问题前您不能登录!</li>'):li;
		ul.append(li);
		shakeWarning(ul);
		return false;
	}
	*/
	//return false;
}
function shakeWarning(obj){
	var div = obj.parent();
	var leftAmt = obj.offset().left-23;
	var count = 2;
	var func = function(){
		var a = count%2 == 0?5:0;
		div.css('left',leftAmt-a);
		//div.css('top',topAmt-a);
		count++;
	}
	var shakeInt = setInterval(func,100);
	setTimeout(function(){window.clearInterval(shakeInt)},600)
}

function form2_beforeSubmit(obj)
{
	var data = obj.getFormData();
	$.cookie('_dllx',data.dllx,{expires:9999});
	$.cookie('_sjlx',data.sjlx,{expires:9999});
	/*//如果检测到浏览器问题禁止登录
	if(p_sysReqFail){
		var ul = $('#browserWarning');
		var li = $('#noSubmitWarning');
		li = li.size() == 0?$('<li id="noSubmitWarning">在更正以上问题前您不能登录!</li>'):li;
		ul.append(li);
		shakeWarning(ul);
		return false;
	}
	*/
}

var helpInfo = [//帮助信息内容
	'<a href="/UPLOAD/长江证券零售服务系统用户操作手册.zip" class="blue">下载操作手册</a></br><a href="/UPLOAD/客户端软件安装说明.zip" class="blue">下载安装说明</a></br><a href="/UPLOAD/ICDCONFIG.zip" class="blue">下载坐席话务条控件</a></br><a href="/UPLOAD/ICD.zip" class="blue">下载交换机通信组件</a></br><a href="/UPLOAD/设置IE浏览器站点.zip" class="blue">设置IE浏览器站点</a></br>    请使用Internet Explorer 7.0 或以上版本浏览器登录本系统，为保证系统正常运行，请先将系统地址加入IE 信任站点，启用ActiveX 控件，并关闭弹出窗口拦截功能',
	'<hr/><b>操作步骤:</b>',
	'<hr/>1. 打开浏览器菜单中的（1）“<span class="green">工具</span>”--（2）“<span class="green">Internet 选项</span>”<br/><img src="'+g_kjafPath+'img/tutorial1.jpg"/>',
	'<hr/>2. 在弹出的"Internet 选项"对话框中，<br/>（1）选择顶部的“<span class="green">安全</span>”标签，<br/>（2）点击“<span class="green">可信站点</span>”，<br/>（3）点击“<span class="green">站点</span>”按钮<br/><img src="'+g_kjafPath+'img/tutorial2.jpg"/>',
	'<hr/>3. 在弹出的"可信站点"对话框中，<br/>（1）输入本系统地址。<br/>（2）输入完成后点击“<span class="green">添加</span>”，<br/>（3）点击“<span class="green">关闭</span>”按钮<br/><img src="'+g_kjafPath+'img/tutorial3.jpg"/>',
	'<hr/>4. 返回到刚才的"Internet 选项"对话框，<br/>（1）拖动<span class="green">安全级别滑块</span>到最低，<br/>（2）点击“<span class="green">应用</span>”按钮，<br/>（3）点击“<span class="green">应用</span>”按钮后，点击“<span class="green">自定义级别</span>”按钮<br/><img src="'+g_kjafPath+'img/tutorial4.jpg"/>',
	'<hr/>5. 在弹出的"安全设置-受信任的站点区域"对话框中:<br/>（1）在“设置”一栏找到“<span class="green">对未标记为可安全执行脚本的 ActiveX 控件初始化并执行脚本</span>”，然后点击“<span class="green">启用</span>”单选框<br/>（2）点击“<span class="green">确定</span>”按钮<br/><img src="'+g_kjafPath+'img/tutorial5.jpg"/>',
	'<hr/>6. 在弹出的警告对话框上点击“<span class="green">是</span>”<br/><img src="'+g_kjafPath+'img/tutorial6.jpg"/>',
	'<hr/>7. 在"Internet 选项"对话框上点击“<span class="green">确定</span>”按钮<br/><img src="'+g_kjafPath+'img/tutorial7.jpg"/>'
	
	//<br/>（操作步骤: 选择<span class="red">"internet选项"</span>并点击<span class="red">"安全"</span>标签，选择<span class="red">"可信站点"</span>，并将<span class="red">"该区域安全级别"</span>处的滑块拉到最低，然后点击<span class="red">"站点"</span>按钮，在弹出对话框中输入本系统地址并点击<span class="red">"添加"</span>）<br><img src="'+g_kjafPath+'img/helpPic1.jpg"/>
	//,
	//'<a href="help.doc" class="blue">下载系统帮助文档</a><br/>（如果不能弹出下载界面,请点右键,选择<span class="red">"目标另存为"</span>）'
];
function showHelp()//帮助信息弹出
{

    if ($('#helpContainer').size()>0)
    {
		$('#helpContainer').remove();
        return;
    }
	$('body').append('<div id="helpContainer"></div>');
	var container = $('#helpContainer');
    var col = ['r1c1','r1c2','r1c3','r2c1','r2c2','r2c3','r3c1','r3c2','r3c3'];
    for (var i = 0; i < 9; i++)
    {
        container.append('<div class="' + col[i] + '" id="' + col[i] + '">');
        if ((i + 1) % 3 == 0)
			container.append('<br/>');
    }
    $('#r1c3').bind('click',function(){$('#helpContainer').remove()});
    $('#r2c2').append('<div class="helpTitle">登录帮助指南</div><ul id="helpInfo"></ul>');
    for(var i=0;i<helpInfo.length;i++)
		$('#helpInfo').append('<li>'+helpInfo[i]+'</li>');

	container.width(400).height($(window).height()-80).css('left',$(window).width()-container.width()-20).css('top',20);
	$('#r1c2').width(container.width() - 40);
	$('#r2c2').width(container.width() - 40);
	$('#r3c2').width(container.width() - 40);
	$('#r2c1').height($(window).height() - 80 - 50);
	$('#r2c2').height($(window).height() - 80 - 50);
	$('#r2c3').height($(window).height() - 80 - 50);
}
var p_sysReqFail = false;
function checkSysRequirements(){
	if (!$.browser.msie){
 		sysReqFail('browser',$.browser); p_sysReqFail = true;
	}
	else if($.browser.version<7 && !isIE5730_11()){
		sysReqFail('version',$.browser.version);p_sysReqFail = true;
	}
	try{var actObj = new ActiveXObject("Excel.Application");}
	catch(ex){
		sysReqFail('activex',ex.description);p_sysReqFail = true;
	}
	if(p_sysReqFail){
		var ul = $('#browserWarning');
		var div = ul.parent();
		div.show();
		var pos = $('#form1').offset(),h = $('#form1').height();
		div.css('left',pos.left).css('top',pos.top+h)
		//p_form1.disableBtn([0,1]);
		//p_form2.disableBtn([0,1]);
		//ul.append('<li>登录表单已被禁用! 请在修改以上兼容性问题后<a href="javascript:location.reload()" class="green">刷新</a>重试</li>')
	}
}
function isIE5730_11(){
	var agent= navigator.userAgent.toLowerCase();
	var ver = parseInt(navigator.appVersion);

	var ie = agent.indexOf("msie")>=0;
	var ie6=ie && agent.indexOf("msie 6")>=0;
	var ie7=ie && agent.indexOf("msie 7")>=0;

	var ff=!ie && agent.indexOf("mozilla")>=0;
	var ff2=ff && ver==4;
	var ff3=ff && ver==5;
	var chk1=false,chk2=false;
	if (ff3)chk1 = false;
	else if (ie6)chk1 = false;
	else if (ie7)chk1 = true;
	else chk1 = false;

	if (ff3)chk2 = false;
	else if (ie7)chk2 = false;
	else if (ie6)chk2 = true;
	else chk2 = false;
	if(chk1 && chk2)return true;
	else return false;
}
function sysReqFail(type,val){
	var ul = $('#browserWarning'),msgStr = '';
	switch(type){
		case 'browser':
		var b;
		for(var prop in val){
			if(val[prop])b = prop;
		}
		var bType = {msie:'微软 Internet Explorer',safari:'Safari',opera:'Opera',mozilla:'Mozilla Firefox'}
		msgStr = '您当前使用的浏览器为 '+bType[b]+'. 请使用微软Internet Explorer 7.0 或以上版本!';
		break;
		case 'version':
		msgStr = '您当前的浏览器版本为'+val+'. 请使用IE 7.0 或以上版本!';
		break;
		case 'activex':
		msgStr = '您的浏览器禁用了ActiveX 控件! 请参照"<a href="javascript:showHelp()">登录指南</a>"修改相关设置.';
		break;
	}
	var li = $('<li>'+msgStr+'</li>')
	ul.append(li);
}
