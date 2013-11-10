<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript">
// Format Date

var limit = 15;//每页显示记录数
var id = '<%=request.getParameter("literatureid")%>';
var store = new Ext.data.JsonStore({//数据源
	url : "<%=request.getContextPath()%>/listBorrowListByid.action?theliteratureid="+id, 
	root : "list",
	fields:["categoryname","literaturename","totalnum","num"]
});
		
//var sm=new Ext.grid.CheckboxSelectionModel();//全选/反选 
var cm = new Ext.grid.ColumnModel([
	//sm,
	{
		header : "Category",
		dataIndex : "categoryname",
		width : 80,
		sortable : true
	},{
		header : "Name",
		dataIndex : "literaturename",
		width : 100,
		sortable : true
	},{
		header : "BorrowNum",
		dataIndex : "num",									
		width : 50,
		sortable : true
	},{
		header : "Sum",
		dataIndex : "totalnum",
		width : 50,
		sortable : true
	}
]);

var borrowListByidGrid = new Ext.grid.GridPanel({
	bodyStyle : "padding:0px 0px 0px 0px",
	height : 440,
	width : 785,
	height:470,
	autoScroll : true,
	cm : cm,
	//sm : sm,
	store : store
});



//列表主显panel 
var borrowListByidPanel = new Ext.Panel( {
	title : "<center><p><font size=3>Borrorw Info List by Book Name</font></p></center>",
	width : "768",
	frame : true,
	height : 510,
	items:[{
		columnWidth : 1,
		layout : 'form',
		border : false,
		items : borrowListByidGrid
	}],
	//右下角显示分页信息与保存按钮 
	bbar : new Ext.PagingToolbar( {
		pageSize : 5,
		displayInfo : true,
		displayMsg : 'List {0} to {1} records，total {2} ',
		store:store,
		emptyMsg : "No record"
	})
});


Ext.onReady(function() {
	Ext.QuickTips.init();//表单错误提示
	Ext.form.Field.prototype.msgTarget = 'under';
	borrowListByidPanel.render("borrowListByidPanel");
	store.load({params : {key:'',start:0,limit:15}});//传分页控制参数 
});
	
</script>
</head>
<body>
<div id="borrowListByidPanel"></div>
</body>
</html>