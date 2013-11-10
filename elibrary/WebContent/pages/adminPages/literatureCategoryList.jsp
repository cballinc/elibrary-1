<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript">
function imgDel(delId) {
	Ext.Msg.confirm("Confirm", "Are you sure？",
		function(btn) {		    
			if (btn == "yes") {		
				Ext.Msg.alert("Notice","Completed!");
			}
		}
	);
};

var store = new Ext.data.JsonStore({//数据源
	url : "<%=request.getContextPath()%>/listCategory.action", 
	root : "nodes",
	totalProperty : "total",
	fields:["categoryname","cindex","categoryid"]
});

var limit=100;

var sm=new Ext.grid.CheckboxSelectionModel();//全选/反选 
var cm = new Ext.grid.ColumnModel([
	sm,
	//{
	//	header : "ID",
	//	dataIndex : "categoryid",
	//	width : 80,
	//	editor : new Ext.form.TextField({
	//		id : "pro_edField1"
	//	}),
	//	sortable : true
	//},
	{
		header : "Index",
		dataIndex : "cindex",
		width : 80,
		editor : new Ext.form.TextField({
			id : "pro_edField2"
		}),
		sortable : true
	},{
		header : "Category",
		dataIndex : "categoryname",
		width : 100,
		editor : new Ext.form.TextField({
			id : "pro_edField3"
		}),
		sortable : true
	}
]);

var categoryGrid = new Ext.grid.EditorGridPanel({
	bodyStyle : "padding:0px 0px 0px 0px",
	height : 440,
	width : 785,
	height:470,
	autoScroll : true,
	cm : cm,
	sm : sm,
	store : store
});

var categorynameTextFeild=new Ext.form.TextField({
	margins : '0 0 0 0',
	//name: 'userInfo.companyInfomation.address', 
	fieldLabel : 'Caregory Name',
	width:220,
	anchor:'90%',
	maxLength : 50,
	name:"category.categoryname",
	maxLengthText : "Maximum length is 20"
});
var indexTextFeild=new Ext.form.TextField({
	margins : '0 0 0 0',
	//name: 'userInfo.companyInfomation.address', 
	fieldLabel : 'Index',
	width:220,
	anchor:'90%',
	maxLength : 10,
	name:"category.cindex",
	maxLengthText : "Maximum length is 10"
});

var closeButton=new Ext.Button({
	text:'Close',				
	minWidth:80,
	handler:function(){
		addWindow.hide();
	}
});
			
var addPanel = new Ext.form.FormPanel( {
	url : "<%=request.getContextPath()%>/addCategory.action",
	method : "post",
	buttonAlign : 'center',
	labelAlign : 'right',				
	width : 500,
	//height : 1000,
	autoHeight:true,
	layout : "column",
	items:[{
		//控制padding
		columnWidth : 1,
		layout : 'form',
		height : 30,
		border : false
		
	}, {
		//类别名 
		columnWidth : 1,
		layout : 'form',
		height : 40,
		border : false,
		items : categorynameTextFeild
	},{
		//索引
		columnWidth : 1,
		layout : 'form',
		height : 40,
		border : false,
		items : indexTextFeild
	}],
	buttons:[{
		text:'Save',
		handler:function(){
			addPanel.getForm().submit({
				waitTitle : 'Wait',  
                waitMsg : 'Processing the form,please wait...', 
				success : function(f, rep) {
					Ext.MessageBox.alert("Notice", rep.result.msg);
					addWindow.hide();
					store.reload();
				}
			});
		}
	},closeButton]
});
			
var addWindow = new Ext.Window( {
	layout : 'fit',
	hidden : true,
	width : 400,
	closeAction : 'hide',
	//height : 260,
	autoHeight:true,
	resizable : false,
	shadow : true,
	modal : true,
	closable : true,
	draggable :false,
	bodyStyle : 'padding:5 5 5 5',
	animCollapse : true,
	items : [ addPanel ]
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

//类别列表主显panel 
var categoryPanel = new Ext.Panel( {
	title : "<center><p><font size=3>Category Management</font></p></center>",
	width : "768",
	frame : true,
	height : 510,
	tbar : ['-', {
		text : "Add",
		width:80,
		handler : function() {						
			addWindow.show();//添加图书大类弹窗
			addPanel.form.reset();
			addWindow.setTitle('Add Category');							
		}
	},'-',{
		xtype :"button",
		width:80,
		text:"Delete",
		handler:function(){
			var wh =  categoryGrid.getSelectionModel().getSelections();//通过多选框删除
			var ids="";
			if(wh.length<1){
				Ext.Msg.alert('Notice', 'Please select at least one record!');
				return;
			}
			for(var i=0;i<wh.length;i++){
				ids+=wh[i].get("categoryid")+",";// 获取所选类别id
			}
			
			if(ids!=""){
				ids=ids.substring(0,ids.length-1);
			}
            //alert(ids[0]+10);
			Ext.Msg.confirm("Confirm","Delete？",function(btn){

				if (btn == 'yes'){
					 Ext.Ajax.request({//删除action
						url: '<%=request.getContextPath()%>/deleteCategory.action',
						success: function(res){
							Ext.Msg.alert('Notice', res.responseText);
							store.reload();//重新加载列表
						},
						failure: function(res){
							alert(res);
						},
						params: {idsToDelete: ids }//传给deleteAction的参数（id）
					});
				}
			});
		}
	} ,"->",{//搜索框
		xtype :"label",
		text:"Category Name Key Words:",
		width:120
	},query,"&nbsp",queryButton],
	items:[{
		columnWidth : 1,
		layout : 'form',
		border : false,
		items : categoryGrid
	}],
	//右下角显示分页信息与保存按钮 
	bbar : new Ext.PagingToolbar( {
		pageSize : 15,
		displayInfo : true,
		displayMsg : 'List {0} to {1} records，total {2} ',
		store:store,
		emptyMsg : "No records"
	}),	
	buttons :[
	{
		text:'Save',
		xtype:'button',
		handler : function() {
			var mr = store.getModifiedRecords(); // 获取所有更新过的记录
			if (mr.length > 0) {
				var tempUpdate = "[";
				for (var i = 0; i < mr.length; i++) {
					if (mr[i].get("cindex").trim() != null
					 && mr[i].get("cindex").trim() != ""&&mr[i].get("categoryname").trim() != null
					  && mr[i].get("categoryname").trim() != "") {
						var data="{";
						data+='"categoryid":"'+mr[i].get("categoryid")+' ",';
						data+='"cindex":"'+mr[i].get("cindex")+' ",';
						data+='"categoryname":"' + mr[i].get("categoryname")+' ",';
						data+="}";
						tempUpdate+=data+",";
					}
				}
				if(tempUpdate != "["){
					tempUpdate=tempUpdate.substring(0,tempUpdate.length-1);
				}
				tempUpdate+="]";

				var tempUpdate2 = "[";
				for (var i = 0; i < mr.length; i++) {
					if (mr[i].get("cindex").trim() != null
					 && mr[i].get("cindex").trim() != ""&&mr[i].get("categoryname").trim() != null
					  && mr[i].get("categoryname").trim() != "") {
						var data="{";
						data+='"cindex":"'+mr[i].get("cindex")+' ",';
						data+='"categoryname":"' + mr[i].get("categoryname")+' ",';
						data+="}";
						tempUpdate2+=data+",";
					}
				}
				if(tempUpdate2 != "["){
					tempUpdate2=tempUpdate2.substring(0,tempUpdate2.length-1);
				}
				tempUpdate2+="]";

									  						
				if (tempUpdate.length >2) {
					Ext.Ajax.request({//更新大类信息ACTION
						url : '<%=request.getContextPath()%>/updateCategory.action',
						params : {
							updateCategoryList : tempUpdate,
							updateCategoryList2 : tempUpdate2
						},
						method : 'POST',
						success: function(res){
							Ext.Msg.alert('Notice', res.responseText);
							store.reload();
							mr.length=0;			  											
						},
						failure : function(response, options) {}
					});
				}
			}
		}
	}]
});
//var classesList = new Ext.data.JsonStore({
//
//    url : "
//    root: "root",
//    fields:["classid","cname"]
//});

Ext.onReady(function() {
	Ext.QuickTips.init();//表单错误提示
	Ext.form.Field.prototype.msgTarget = 'under';
	categoryPanel.render("literatureCategoryListPanel");
	store.load({params : {key:'',start:0,limit:15}});//传分页控制参数 
});
	
</script>
</head>
<body>
<div id="literatureCategoryListPanel"></div>
</body>
</html>