<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript">
function imgDel(delId) {
	Ext.Msg.confirm("确认", "您确定要删除吗？",
		function(btn) {		    
			if (btn == "yes") {		
				Ext.Msg.alert("提示","删除成功");
			}
		}
	);
};
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

var limit = 15;//每页显示记录数

var store = new Ext.data.JsonStore({//数据源
	url : "<%=request.getContextPath()%>/listBorrowList.action", 
	root : "list",
	totalProperty : "total",
	fields:["categoryname","literaturename","totalnum","num","returned","returntime","borrowtime","expectedreturntime","sname","snumber","borrowid","literatureid"]
});
		
//var sm=new Ext.grid.CheckboxSelectionModel();//全选/反选 
var cm = new Ext.grid.ColumnModel([
	//sm,
	{
		header : "类别名",
		dataIndex : "categoryname",
		width : 80,
		sortable : true
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

//列表主显panel 
var borrowListPanel = new Ext.Panel( {
	title : "<center><p><font size=3>借阅列表</font></p></center>",
	width : "768",
	frame : true,
	height : 510,
	tbar : [
	//'-',{
	//	xtype :"button",
	//	width:80,
	///	text:"删除",
	//	handler:function(){
	//		var wh =  borrowListGrid.getSelectionModel().getSelections();//通过多选框删除
	//		var ids="";
	//		if(wh.length<1){
	//			Ext.Msg.alert('提示', '请选中至少一条数据');
	//			return;
	//		}
	//		for(var i=0;i<wh.length;i++){
	//			ids+=wh[i].get("borrowid")+",";// 获取所选borrowid
	//		}
	//		if(ids!=""){
	//			ids=ids.substring(0,ids.length-1);
	//		}
	//		Ext.Msg.confirm("操作确认","是否确认删除？",function(btn){
	//			if (btn == 'yes'){
	//				 Ext.Ajax.request({//删除action
	//					url: '<%=request.getContextPath()%>/deleteBorrowInfo.action',
	//					success: function(res){
	//						Ext.Msg.alert('提示', res.responseText);
	//						store.reload();//重新加载列表
	//					},
	//					failure: function(res){
	//						alert(res);
	//					},
	//					params: {idsToDelete: ids }//传给deleteBorrowInfo.action的borrowid
	//				});
	//			}
	//		});
	//	}
	//} ,
	"->",{//搜索框
		xtype :"label",
		text:"按学号查询:",
		width:120
	},query,"&nbsp",queryButton],
	items:[{
		columnWidth : 1,
		layout : 'form',
		border : false,
		items : borrowListGrid
	}],
	//右下角显示分页信息与保存按钮 
	bbar : new Ext.PagingToolbar( {
		pageSize : 5,
		displayInfo : true,
		displayMsg : '显示第 {0} 条到 {1} 条记录，一共 {2} 条',
		store:store,
		emptyMsg : "没有记录"
	})
});


Ext.onReady(function() {
	Ext.QuickTips.init();//表单错误提示
	Ext.form.Field.prototype.msgTarget = 'under';
	borrowListPanel.render("borrowListPanel");
	store.load({params : {key:'',start:0,limit:15}});//传分页控制参数 
});
	
</script>
</head>
<body>
<div id="borrowListPanel"></div>
</body>
</html>