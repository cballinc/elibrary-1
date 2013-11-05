<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.akun.elibrary.bean.Libuser"%><html>
<head>
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css" />
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <title>AKUN图书借阅平台</title>
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/jquery.ui.css" />
  <script type="text/javascript" src="<%=request.getContextPath()%>/jquery/jquery.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/jquery/jquery.ui.js"></script>
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/ext/resources/css/ext-all.css" />
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/ext/resources/css/ext/xtheme-darkgray.css" />
  <script type="text/javascript" src="<%=request.getContextPath()%>/ext/adapter/ext/ext-base.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/ext/ext-all.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/ext/src/locale/ext-lang-zh_CN.js"></script>
  <link href="<%=request.getContextPath()%>/pages/studentPages/css/templatemo_style.css" rel="stylesheet" type="text/css" />
<script src="<%=request.getContextPath()%>/pages/studentPages/js/jquery-1.2.6.min.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/pages/studentPages/js/jquery.easing.1.3.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/pages/studentPages/js/jquery.kwicks-1.5.1.pack.js" type="text/javascript"></script>
  <script type="text/javascript">
  
//图书列表--------------------------------------------------------------------
var categoryStore = new Ext.data.JsonStore({
	url : "<%=request.getContextPath()%>/listCategory.action",
	root:"nodes",
	fields:["categoryid","categoryname"] 
});
categoryStore.load();
var store = new Ext.data.JsonStore({//数据源
	url : "<%=request.getContextPath()%>/listLiterature.action", 
	root : "nodes",
	totalProperty : "total",
	fields:["literaturename","categoryid","author","press","price","num","lindex","literatureid","outnum"]
});
var limit=100;
var cm = new Ext.grid.ColumnModel([
	{
		header : "名称",
		dataIndex : "literaturename",
		width : 130,
		sortable : true
	},{
		header : "类别",
		dataIndex : "categoryid",
		width : 80,
		sortable : true,
		renderer:function(categoryid){
        var count = categoryStore.getCount();
        for(var i=0;i<=count;i++){
            var temp = categoryStore.getAt(i).get('categoryid');
        	if(temp==categoryid){
        	     return categoryStore.getAt(i).get('categoryname');  
        	}    
        }
	    }
	},{
		header : "索引号",
		dataIndex : "lindex",
		width : 50,
		sortable : true
	},{
		header : "作者",
		dataIndex : "author",
		width : 80,
		sortable : true
	},{
		header : "出版社",
		dataIndex : "press",
		width : 160,
		sortable : true
	},{
		header : "总数",
		dataIndex : "num",
		width : 40,
		sortable : true
	},{
		header : "已借出",
		dataIndex : "outnum",
		width : 50,
		sortable : true
	}
]);

var literatureGrid = new Ext.grid.GridPanel({
	bodyStyle : "padding:0px 0px 0px 0px",
	//height : 440,
	//width : 785,
	height:470,
	autoScroll : true,
	cm : cm,
	//sm : sm,
	store : store
});

var query = new Ext.form.TextField({
	id:"queryforlist",
	anchor:'90%',
	enableKeyEvents : true,
	initEvents: function() {
		var keyPress = function(e){  
			if (e.getKey() == e.ENTER) {  
				store.reload({
					params : {
						key : query.getValue(),
						start : 0,
						limit : limit
					}
				});
			} 
		};  
		this.el.on("keypress", keyPress, this);
	}
});
store.on("beforeload", function(){
	store.baseParams.searchAddition = query.getRawValue();
});
var queryLabel = new Ext.form.Label({
	text:'类型名称：'
});

var queryButton = new Ext.Button({
	text:'查询',
	width:'30',
	handler:function(){
		var queryValue = query.getValue();
		store.reload({
			params :{key:queryValue,start:0,limit:limit}
		});
	}
});

//资料列表主显panel 
var literaturePanel = new Ext.Panel( {
	title : "<center><p><font size=3>图书查询</font></p></center>",
	width : 600,
	frame : true,
	headerAsText:false,
	height : 300,
	tbar : ["->",{//搜索框
		xtype :"label",
		text:"名称关键字:",
		width:120
	},query,"&nbsp",queryButton],
	items:[{
		columnWidth : 1,
		layout : 'form',
		border : false,
		items : literatureGrid
	}],
	//右下角显示分页信息
	bbar : new Ext.PagingToolbar( {
		pageSize : 15,
		displayInfo : true,
		displayMsg : '显示第 {0} 条到 {1} 条记录，一共 {2} 条',
		store:store,
		emptyMsg : "没有记录"
	})
});
//学生登录----------------------------------------------------------------------
    //验证用户名是否存在空格
function validationBlank( value ){
      var str = value.match(/\s/g); 
      if(str != null){
       return true;
      }
      return false;
    };
function login() {
      if(validationBlank(document.loginform.username.value)){//验证用户名是否存在空格
        alert("提示: 用户名中不可有空格！");
        return;
      }
      if(validationBlank(document.loginform.password.value)){//验证用户名是否存在空格
        alert("提示: 密码输入错误！");
        return;
      }     
      if ("" == document.loginform.username.value) {
        alert("用户名不能为空，请输入用户名！");
        document.loginform.username.focus();
      } else if ("" == document.loginform.password.value){
        alert("密码不能为空，请输入密码！");
        document.loginform.password.focus();
      } else {
    	  $.ajax({
 	        type : "post",
 	        url : "<%=request.getContextPath()%>/studentLogin.action",
 	        data : {
 	        	loginSnumber : document.loginform.username.value, 
 	          loginStudentPwd : document.loginform.password.value
 	        },
 	        success : function(data) {
 	 	        //alert(data);
 	        	var result = eval( "(" + data + ")" );
 	        	//alert(result.error)
 	        	if ('false' == result.error) {
                   Ext.Msg.alert("提示","登陆成功!正在为您跳转页面。。。");
 	               window.location = "<%=request.getContextPath()%>/pages/studentPages/loginedStudentPage.jsp";
            } else {
              Ext.Msg.alert("提示","学号或密码错误！");
            }
 	        }
 	      }, "json");
      }
    }
//Ext.onReady--------------------------------------------------------------------------
Ext.onReady(function() {
	Ext.QuickTips.init();//表单错误提示
	Ext.form.Field.prototype.msgTarget = 'under';
	literaturePanel.render("literatureListPanel");
	store.load({params : {key:'',start:0,limit:15}});//传分页控制参数 
});
	
</script>
<script type="text/javascript">
	$().ready(function() {  
		$('.kwicks').kwicks({  
			max : 710,  
			spacing : 0,  
			sticky: true
		});  
	}); 
</script>

<script type="text/javascript" src="<%=request.getContextPath()%>/pages/studentPages/js/jquery-1-4-2.min.js"></script> 
<link rel="stylesheet" href="<%=request.getContextPath()%>/pages/studentPages/css/slimbox2.css" type="text/css" media="screen" /> 
<script type="text/JavaScript" src="<%=request.getContextPath()%>/pages/studentPages/js/slimbox2.js"></script> 
</head>
<body>
<div id="templatemo_wrapper">
	<div id="templatemo_main">
	
		<div id="site_title">
			<h1><a href="http://www.templatemo.com">Free CSS Templates</a></h1>
		<div id="hd_loginbar">

        <form id="loginform" name="loginform"  method="post" onkeydown="if(event.keyCode==13) { login(); }">

          <div style="width:168px; float:left">

            <div style="font-family:微软雅黑; color:white">用户名：<input type="text" id="username" name="username" style="height:18px; width:108px; line-height:18px" /></div>

            <div style="font-family:微软雅黑; color:white">密　码：<input type="password" id="password" name="password" style="height:18px; width:108px; line-height:18px" /></div>

          </div>      

          <div style="width:72px; float:left">

            <a href="javascript:void(0)"></a><br/>

            <input id="btnLogin" type="button" name="btn" style="height:26px; width:60px; font-family:微软雅黑; line-height:14px" value="登 录" onclick="login()" />

          </div>

        </form>

      </div>
		</div>
		
		<div id="templatemo_content">
			<ul class="kwicks">
			
				<li id="home"><span class="header"></span>
					<div class="inner">
						<h2>欢迎使用AKUN图书馆借阅平台</h2>
						<p><em>————————————————————————————————————————————————————————</em></p>
						<img src="images/templatemo_image_01.jpg" alt="Image 01" class="image_fl" />
						<div class="col_half float_r">
							<p>———————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————— </p>
							<h3>----------</h3>
							<ul class="templatemo_list">
								<li>——————————————————</li>
								<li>——————————————————</li>
								<li>——————————————————</li>
								<li>——————————————————</li>
								<li>——————————————————</li>
							</ul>
						</div>
					</div>
				</li>
			
				<li id="about"><span class="header"></span>
					<div class="inner">
					    <h2>图书查询</h2>
						<div id="literatureListPanel"></div>
						
					</div>
				</li>
			
				 <li id="social"><span class="header"></span>
					<div class="inner">
						<div id="studentValidate"></div>
						<h2>未登录</h2>
					</div>
				</li> 
			
				<li id="portfolio"><span class="header"></span>
					<div class="inner">
						<h2>平台介绍</h2>
						<!-- 
						<ul id="gallery">
							<li><a href="images/portfolio/01-l.jpg" rel="lightbox[portfolio]" title="Curabitur facilisis auctor risus, eget lacinia leo feugiat ac."><img src="images/portfolio/01.jpg" alt="Image 01" /></a></li>
							<li><a href="images/portfolio/02-l.jpg" rel="lightbox[portfolio]" title="Nulla varius laoreet tellus, non volutpat mi iaculis a."><img src="images/portfolio/02.jpg" alt="Image 02" /></a></li>
							<li><a href="images/portfolio/03-l.jpg" class="no_margin_right" rel="lightbox[portfolio]" title="Vestibulum euismod mi et massa volutpat lobortis."><img src="images/portfolio/03.jpg" alt="Image 03" /></a></li>
							<li><a href="images/portfolio/04-l.jpg" rel="lightbox[portfolio]" title="Quisque volutpat nunc a felis lobortis aliquet."><img src="images/portfolio/04.jpg" alt="Image 04" /></a></li>
							<li><a href="images/portfolio/05-l.jpg" rel="lightbox[portfolio]" title="Nullam dictum enim et quam posuere dapibus."><img src="images/portfolio/05.jpg" alt="Image 05" /></a></li>
							<li><a href="images/portfolio/06-l.jpg" class="no_margin_right" rel="lightbox[portfolio]" title="Phasellus condimentum nisi et mi feugiat dapibus."><img src="images/portfolio/06.jpg" alt="Image 06" /></a></li>
						</ul>
						 -->
					</div>
				</li>
				
				<li id="contact"><span class="header"></span>
					<div class="inner">
						<h2>制作人</h2>
						<p>本平台由个人于2012.2-2012.5，历时三个月完成，基本流程和主要功能都已实现，虽做了大量输入验证，但由于
						时间和精力限制，还有不完善的地方。如发现有bug存在，欢迎与我联系并指正。谢谢您的关注！</p>
						<h4>杨宗昆</h4> &nbsp;&nbsp;&nbsp;<h4>指导老师：李浩</h4>
						<div id="contact_form"  class="col_w280 float_l">
							<img src="images/portfolio/06.jpg"></img>
						</div>
                        
                        <div class="col_w280 float_r">
                            <h4><strong>联系信息</strong></h4>
                            <h4><strong>云南大学软件学院</strong></h4>
                            <br/>
                            <strong>QQ:</strong> 371505199<br />   <br/>       
                            <strong>Email:</strong> <a href="mailto:zk.yang1012@gmail.com">zk.yang1012@gmail.com</a>
               			</div>
						
					</div>
				</li>
			
			</ul>
			
		</div> <!-- END of content -->
	</div> <!-- END of templatemo_main -->
	<div id="entrances">
	 <a href="<%=request.getContextPath()%>/pages/userPages/userPage.jsp">员工入口</a>&nbsp;|&nbsp;
     <a href="<%=request.getContextPath()%>/pages/adminPages/login.jsp">管理员入口</a>
	</div>
    <div id="templatemo_footer">
    <span>Copyright © 2012 - 2013 Zongkun Yang All Rights Reserved.</span><br /><span>云南大学 杨宗昆 版权所有</span> 
    </div>
</div> 

</body>
</html>