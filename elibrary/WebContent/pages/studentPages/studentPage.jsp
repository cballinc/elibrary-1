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
		header : "Name",
		dataIndex : "literaturename",
		width : 130,
		sortable : true
	},{
		header : "Category",
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
		header : "Index",
		dataIndex : "lindex",
		width : 50,
		sortable : true
	},{
		header : "Author",
		dataIndex : "author",
		width : 80,
		sortable : true
	},{
		header : "Press",
		dataIndex : "press",
		width : 160,
		sortable : true
	},{
		header : "TotalNum",
		dataIndex : "num",
		width : 40,
		sortable : true
	},{
		header : "BorrowedNum",
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

var queryAuthor = new Ext.form.TextField({
	id:"queryAuthorforlist",
	anchor:'90%',
	enableKeyEvents : true
});

store.on("beforeload", function(){
	store.baseParams.searchAddition = query.getRawValue();
});
var queryLabel = new Ext.form.Label({
	text:'Category：'
});

var queryButton = new Ext.Button({
	text:'Search',
	width:'30',
	handler:function(){
		var queryValue = query.getValue()+'_'+queryAuthor.getValue();
		store.reload({
			params :{key:queryValue,start:0,limit:limit}
		});
	}
});

//资料列表主显panel 
var literaturePanel = new Ext.Panel( {
	title : "<center><p><font size=3>Book Search</font></p></center>",
	width : 600,
	frame : true,
	headerAsText:false,
	height : 300,
	tbar : ["->",{
		xtype :"label",
		text:"Book Name Keywords:",
		width:120
	},query,"&nbsp","-",{
		xtype :"label",
		text:"Author Name Keywords:",
		width:120
	},queryAuthor,"&nbsp",queryButton],
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
		displayMsg : 'List {0} to {1} records，total {2}',
		store:store,
		emptyMsg : "No record"
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
        alert("Notice: there should not be blank space！");
        return;
      }
      if(validationBlank(document.loginform.password.value)){//验证用户名是否存在空格
        alert("Notice: password is not correct！");
        return;
      }     
      if ("" == document.loginform.username.value) {
        alert("The username cannot be blank！");
        document.loginform.username.focus();
      } else if ("" == document.loginform.password.value){
        alert("Please type in password！");
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
                   Ext.Msg.alert("Notice","Login Succeed!Jumping page..");
 	               window.location = "<%=request.getContextPath()%>/pages/studentPages/loginedStudentPage.jsp";
            } else {
              Ext.Msg.alert("Notice","SID or password is not correct！");
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

          <div style="width:200px; float:left">

            <div style="color:white">
            User Name：<input type="text" id="username" name="username" style="height:18px; width:108px; line-height:18px" />
            &nbsp;
            Password：<input type="password" id="password" name="password" style="height:18px; width:108px; line-height:18px" />
            </div>
          </div>      

          <div style="width:72px; float:left">

            <a href="javascript:void(0)"></a><br/>

            <input id="btnLogin" type="button" name="btn" style="height:26px; width:60px; line-height:14px" value="Login" onclick="login()" />

          </div>

        </form>

      </div>
		</div>
		
		<div id="templatemo_content">
			<ul class="kwicks">
			
				<li id="home"><span class="header"></span>
					<div class="inner">
						<h2>Welcome to use Library Management System</h2>
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
					    <h2>Book Search</h2>
						<div id="literatureListPanel"></div>
						
					</div>
				</li>
			
				 <li id="social"><span class="header"></span>
					<div class="inner">
						<div id="studentValidate"></div>
						<h2>Please Login</h2>
					</div>
				</li> 
			
				<li id="portfolio"><span class="header"></span>
					<div class="inner">
						<h2>Platform Introduction</h2>
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
				
			</ul>
			
		</div> <!-- END of content -->
	</div> <!-- END of templatemo_main -->
	<div id="entrances">
	 <a href="<%=request.getContextPath()%>/pages/userPages/userPage.jsp">Librarian Entrance</a>&nbsp;|&nbsp;
     <a href="<%=request.getContextPath()%>/pages/adminPages/login.jsp">System Administrator Entrance</a>
	</div>
</div> 

</body>
</html>