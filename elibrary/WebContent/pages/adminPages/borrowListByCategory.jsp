<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript">
// Format Date

var limit = 15;//Lines of record in one page
var id = '<%=request.getParameter("categoryid")%>';
var store = new Ext.data.JsonStore({//Data Source
	url : "<%=request.getContextPath()%>/listBorrowListByCategory.action?thecategoryid="+id, 
	root : "list",
	fields:["categoryname","literaturename","totalnum","num"]
});
		
//var sm=new Ext.grid.CheckboxSelectionModel();//Select All/Invert Selection 
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

var borrowListByCategoryGrid = new Ext.grid.GridPanel({
	bodyStyle : "padding:0px 0px 0px 0px",
	height : 440,
	width : 785,
	height:470,
	autoScroll : true,
	cm : cm,
	//sm : sm,
	store : store
});



//Table main panel 
var borrowListByCategoryPanel = new Ext.Panel( {
	title : "<center><p><font size=3>Borrorw Info List by Category</font></p></center>",
	width : "768",
	frame : true,
	height : 510,
	items:[{
		columnWidth : 1,
		layout : 'form',
		border : false,
		items : borrowListByCategoryGrid
	}],
	bbar : new Ext.PagingToolbar( {
		pageSize : 5,
		displayInfo : true,
		displayMsg : 'List {0} to {1} records，total {2} ',
		store:store,
		emptyMsg : "No record"
	})
});


Ext.onReady(function() {
	Ext.QuickTips.init();
	Ext.form.Field.prototype.msgTarget = 'under';
	borrowListByCategoryPanel.render("borrowListByCategoryPanel");
	store.load({params : {key:'',start:0,limit:15}});});
	
</script>
</head>
<body>
<div id="borrowListByCategoryPanel"></div>
</body>
</html>