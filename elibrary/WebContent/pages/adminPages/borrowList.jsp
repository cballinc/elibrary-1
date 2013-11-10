<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript">
function imgDel(delId) {
	Ext.Msg.confirm("Confirm", "Delete?",
		function(btn) {		    
			if (btn == "yes") {		
				Ext.Msg.alert("Notice","Detete successfully.");
			}
		}
	);
};
// Format date
function dateRender(value){
	if(value!="null"&&value){
		if (typeof value == "string") { 
			return value = value.substr(0,10); 		
		}
		return value.format("Y-m-d");
		//return value;
	}else{
		return '';
	}
};

var limit = 15;//Numbers of records in one page

var store = new Ext.data.JsonStore({//Datasource
	url : "<%=request.getContextPath()%>/listBorrowList.action", 
	root : "list",
	totalProperty : "total",
	fields:["categoryname","literaturename","totalnum","num","returned","returntime","borrowtime","expectedreturntime","sname","snumber","borrowid","literatureid"]
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
		header : "Student",
		dataIndex : "sname",
		width : 80
	},{
		header :"SID",
		dataIndex : "snumber",
		width : 80,
		sortable : true
	},{
		header : "BorrowNum",
		dataIndex : "num",									
		width : 50,
		renderer : dateRender,
		sortable : true
	},{
		header : "Sum",
		dataIndex : "totalnum",
		width : 50,
		sortable : true
	},{
		header : "Time",
		dataIndex : "borrowtime",
		width : 90,
		renderer : dateRender,
		sortable : true
	},{
		header : "Return Time",
		dataIndex : "expectedreturntime",
		width : 90,
		renderer : dateRender,
		sortable : true
	},{
		header : "Returned",
		dataIndex : "returned",
		width : 50,
		renderer:function(value){
          if(value==0){
            return "No";
          }else{
            return "Yes";
          }
	    },
		sortable : true
	},{
		header : "ReturnTime",
		dataIndex : "returntime",
		width : 90,
		renderer : dateRender,
		sortable : true
	}
]);

var borrowListGrid = new Ext.grid.EditorGridPanel({
	bodyStyle : "padding:0px 0px 0px 0px",
	height : 440,
	width : 785,
	height:470,
	autoScroll : true,
	cm : cm,
	//sm : sm,
	store : store,
	listeners: {
		"rowclick":function(sm,rows){
			var id = this.getStore().getAt(rows).get("literatureid");
			loadpage("<%=request.getContextPath()%>/pages/adminPages/borrowListByid.jsp?literatureid="+id);
		}
	}
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
	text:'Category Name：'
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

//Table Main Panel 
var borrowListPanel = new Ext.Panel( {
	title : "<center><p><font size=3>Borrow Info List</font></p></center>",
	width : "768",
	frame : true,
	height : 510,
	tbar : [
	"->",{//Query Box
		xtype :"label",
		text:"Search by Student ID:",
		width:120
	},query,"&nbsp",queryButton],
	items:[{
		columnWidth : 1,
		layout : 'form',
		border : false,
		items : borrowListGrid
	}],
	 
	bbar : new Ext.PagingToolbar( {
		pageSize : 5,
		displayInfo : true,
		displayMsg : 'List {0} to {1} records，total {2} ',
		store:store,
		emptyMsg : "No records"
	})
});


Ext.onReady(function() {
	Ext.QuickTips.init();
	Ext.form.Field.prototype.msgTarget = 'under';
	borrowListPanel.render("borrowListPanel");
	store.load({params : {key:'',start:0,limit:15}});//Page parameters 
});
	
</script>
</head>
<body>
<div id="borrowListPanel"></div>
</body>
</html>