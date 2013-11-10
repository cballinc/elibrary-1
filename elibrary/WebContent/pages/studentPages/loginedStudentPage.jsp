<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.akun.elibrary.bean.Student"%><html>
<head>
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css" />
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <title>Library Management System</title>
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
var limit=15;
var cm = new Ext.grid.ColumnModel([
    new Ext.grid.RowNumberer(),
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
		header : "Total Num",
		dataIndex : "num",
		width : 40,
		sortable : true
	},{
		header : "Borrowed Num",
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
	text:'Category：'
});

var queryButton = new Ext.Button({
	text:'Search',
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
	title : "<center><p><font size=3>Book Search</font></p></center>",
	width : 600,
	frame : true,
	headerAsText:false,
	height : 300,
	tbar : ["->",{//搜索框
		xtype :"label",
		text:"Name Keywords:",
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
		displayMsg : 'List {0} to {1} records，total {2} ',
		store:store,
		emptyMsg : "No record"
	})
});
//特定学生借阅信息----------------------------------------------------------------------------------
var borrowedstore = new Ext.data.JsonStore({//数据源
	url : "<%=request.getContextPath()%>/listLoginedStudentBorrowedLiterature.action", 
	root : "list",
	fields:["borrowedliteraturename","borrowedcategoryname","borrowedborrownum","borrowedborrowtime","borrowedexpectedreturntime","borrowedlindex","borrowedborrowid"]
});
function renderCol(data, cell, record, rowIndex, columnIndex, store) {  
    cell.attr = "style=background-color:#F5C0C0";   //设置单元格的背景色  
    return data;  
  } 
var sm=new Ext.grid.CheckboxSelectionModel();//全选/反选 
var borrowedcm = new Ext.grid.ColumnModel([
	sm,
	{
		header : "Name",
		dataIndex : "borrowedliteraturename",
		width : 130,
		sortable : true
	},{
		header : "BorrowNum",
		dataIndex : "borrowedborrownum",
		width : 60,
		sortable : true
	},{
		header : "BorrowTime",
		dataIndex : "borrowedborrowtime",
		width : 155,
		sortable : true
	},{
		header : "Supposed Return Time",
		dataIndex : "borrowedexpectedreturntime",
		width : 155,
		sortable : true
	},{
 		header : "Defer",
 		dataIndex : "defer",
 		width : 60,
 		sortable : true,
 		renderer: renderCol,
 		editor : new Ext.form.ComboBox({
		      typeAhead: true,
		      triggerAction: 'all',
		      lazyRender : true,
		      allowBlank : false,
		      editable : true,
		      mode : 'remote',
		      store: [[1, 'One Month']],
		      displayField:'',
		      valueField:''
 		})
	}
]);
var studentBorrowedLiteratureGrid = new Ext.grid.EditorGridPanel({
	bodyStyle : "padding:0px 0px 0px 0px",
	//height : 440,
	//width : 785,
	height:470,
	autoScroll : true,
	sm:sm,
	cm : borrowedcm,
	store : borrowedstore
	
});

var studentBorrowedliteraturePanel = new Ext.Panel( {
	title : "<center><p><font size=3>Book Search</font></p></center>",
	width : 600,
	frame : true,
	headerAsText:false,
	height : 300,
	items:[{
		columnWidth : 1,
		layout : 'form',
		border : false,
		items : studentBorrowedLiteratureGrid 
	}],
	buttons :[
	      	{
	      		text:'Confirm',
	      		xtype:'button',
	      		handler:function(){
				var wh =  studentBorrowedLiteratureGrid.getSelectionModel().getSelections();//通过多选框删除
				var ids="";
				var expectedReturnTimes="";
				if(wh.length<1){
					Ext.Msg.alert('Notice', 'Please select at lease one record!');
					return;
				}
				for(var i=0;i<wh.length;i++){
					ids+=wh[i].get("borrowedborrowid")+",";// 获取所borrowid
					expectedReturnTimes+=wh[i].get("borrowedexpectedreturntime")+",";
				}
				if(ids!=""){
					ids=ids.substring(0,ids.length-1);
				}
				if(expectedReturnTimes!=""){
					expectedReturnTimes=expectedReturnTimes.substring(0,expectedReturnTimes.length-1);
				}
				Ext.Msg.confirm("Confirm","Are you sure？",function(btn){
					if (btn == 'yes'){
						 Ext.Ajax.request({//续借action
							url: '<%=request.getContextPath()%>/deferBorrow.action',
							success: function(res){
								Ext.Msg.alert('Notice', res.responseText);
								borrowedstore.reload();
								wh.length=0;			  											
							},
							failure : function(response, options) {},
							params: {deferBorrowids: ids,deferExpectedReturnTimes:expectedReturnTimes  }//传给deferBorrow.action的参数
						});
					}
				});
			}
	      	}]
});
//Ext.onReady--------------------------------------------------------------------------
Ext.onReady(function() {
	Ext.QuickTips.init();//表单错误提示
	Ext.form.Field.prototype.msgTarget = 'under';
	literaturePanel.render("literatureListPanel");
	studentBorrowedliteraturePanel.render("studentBorrowedliteraturePanel");
	store.load({params : {key:'',start:0,limit:15}});//传分页控制参数 
	borrowedstore.load({params : {start:0,limit:15}});
	
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
		   <br/>
		   <% Student loginedStudent= new Student() ; if(null != session.getAttribute("loginedStudent")) { loginedStudent = (Student) session.getAttribute("loginedStudent"); } %>
        <span style="color:white">Welcome，<%=loginedStudent.getSname() %>！</span><a style="color:lightblue" href="<%=request.getContextPath()%>/studentLogout.action">注销</a>
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
					    <h2>Personal Borrow History</h2>
						<div id="studentBorrowedliteraturePanel"></div>
						
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