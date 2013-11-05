<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>借阅信息</title>
<style type="text/css">
.x-grid-record-red {   
    background: #F5C0C0;   //修改背景颜色
    color:#000000;  //修改字体颜色
}
</style>
<script type="text/javascript">
	var pagerNumber=0;
	var selectModel =new Ext.grid.RowSelectionModel({
        singleSelect:true
		});
	var searchString = "";
	// 格式化日期
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
	var borrowInfoListCM = new Ext.grid.ColumnModel([
	{
		header : "类别名",
		dataIndex : "categoryname",
		width : 80,
		sortable : true
		//renderer: function(data, cell, record, rowIndex, columnIndex, store) { 
		//if(record.get("expired")==1){
	    //cell.attr = "style=background-color:#F5C0C0";
		//}
		//return record.get("categoryname"); 
	    //}
	},{
		header : "名称",
		dataIndex : "literaturename",
		width : 100,
		sortable : true
	},{
		header : "学生名",
		dataIndex : "sname",
		width : 80
	},{
		header :"学号",
		dataIndex : "snumber",
		width : 80,
		sortable : true
	},{
		header : "借阅数",
		dataIndex : "num",									
		width : 50,
		renderer : dateRender,
		sortable : true
	},{
		header : "总数",
		dataIndex : "totalnum",
		width : 50,
		sortable : true
	},{
		header : "借阅时间",
		dataIndex : "borrowtime",
		width : 90,
		renderer : dateRender,
		sortable : true
	},{
		header : "应还时间",
		dataIndex : "expectedreturntime",
		width : 90,
		renderer : dateRender,
		sortable : true
	},{
		header : "已还",
		dataIndex : "returned",
		width : 50,
		renderer:function(value){
          if(value==0){
            return "否";
          }else{
            return "是";
          }
	    },
		sortable : true
	},{
		header : "归还时间",
		dataIndex : "returntime",
		width : 90,
		renderer : dateRender,
		sortable : true
	}]);

	var store = new Ext.data.JsonStore({
		url : "<%=request.getContextPath()%>/listBorrowList.action", 
		root : "list",
		totalProperty : "total",
		fields:["categoryname","literaturename","totalnum","num","returned","returntime","borrowtime","expectedreturntime","sname","snumber","borrowid","expired"]
	});
	var borrowInfoListGrid = new Ext.grid.GridPanel({
		id:'borrowInfoListGrid',
		autoScroll:true,
		bodyStyle:'padding:0px 0px 0px',
		height : 350,
		width : 785,
		stripeRows:true,
		defaults : {
			autoHeight : true,
			autoWidth : true
		},
		cm:borrowInfoListCM,
		sm:selectModel,
		store:store,
		viewConfig : {
			 forceFit :true,
			 getRowClass : function(record,rowIndex,rowParams,store){
			  //禁用数据显示红色
			  //alert(record.data.expired);
			 // alert(record.data.returned);
			  if(record.data.expired=='1'&&record.data.returned=="0"){
			   return 'x-grid-record-red';
			  }else{
			   return '';
			  }     
			 }
			}
	});

	var query = new Ext.form.TextField({
		id:"queryforlist",
		//name:'searchKey',
		anchor:'90%',
		enableKeyEvents : true,
		initEvents: function() {
		var keyPress = function(e){  
			if (e.getKey() == e.ENTER) {  
				store.load({
					params : {
						start : 0,
						limit : 15
					}
				});
			}  
		};  
		this.el.on("keypress", keyPress, this);}
	});
	store.on("beforeload", function(){
		store.baseParams.searchKey = query.getRawValue();
	});
	var queryLabel = new Ext.form.Label({
		text:'按学号查询：'
	});
	var queryButton = new Ext.Button({
		text:'查询',
		width:'30',
		enableKeyEvents : true, 
		handler:function(){
			store.load({
				params:{
					start:0,
					limit:15
				}
			});
		}
	});
	var borrowInfoPanel = new Ext.Panel({
		title : '<center><p><font size=3>借阅信息</font></p></center>',
		region:'east',
		bodyStyle : "padding:0px 0px 0px",
		frame : true,
		width : '768',
		tbar:[{
			text:"借阅",
			width:80,
			handler:function(){
				loadpage("<%=request.getContextPath()%>/pages/userPages/addBorrowInfo.jsp");
			}
		},'->',queryLabel,query,queryButton],
		items : [{
			columnWidth : 1,
			layout : 'form',
			border : false,
			items : [borrowInfoListGrid]
		}],
		bbar:new Ext.PagingToolbar({
			pageSize:15,
			store:store,
			displayInfo:true,
			displayMsg: '显示第{0}条到{1}条记录，共{2}条',
			emptyMsg:'没有记录'
		})
	});	 
	Ext.onReady(function(){
		Ext.QuickTips.init();
		borrowInfoPanel.render("borrowInfoDisPlay");
		store.reload({
			params:{
				start:0,
				limit:15
			}
		});
	});
</script>
</head>
<body>
<div id="borrowInfoDisPlay"></div>
</body>
</html>