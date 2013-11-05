<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>借阅信息</title>
<script type="text/javascript">
var borrowid = "";
var returnInfo = function(tempReturn){
	var detailJsonArray1 = Ext.util.JSON.encode(tempReturn);
	Ext.Ajax.request({
		url : '<%=request.getContextPath()%>/ReturnBorrowInfo.action',
		params : {
			"returnJsonArray":detailJsonArray1
		},
		method : 'POST',
		failure : function(response, options) {
			Ext.MessageBox.alert('信息', '数据提交失败 ！');
		},
		success : function(response, options) {
			var result = Ext.util.JSON.decode(response.responseText);
			if(result.forfeit>0){
				Ext.MessageBox.alert('提示', "归还成功 ！                                                   "+result.msg+"    学号："+snumberIndex.getValue());
			}else{
				Ext.MessageBox.alert('提示', "归还成功 ！");
			};	
			loadpage("<%=request.getContextPath()%>/pages/userPages/returnBorrowInfo.jsp");
			if (result.error == 'false') {
				store.rejectChanges();
				loadpage("<%=request.getContextPath()%>/pages/userPages/returnBorrowInfo.jsp");
			} else {
				Ext.Msg.alert('失败', "保存失败!");
			}
		}
	});
};
//格式化日期
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
var emptyStore = new Ext.data.JsonStore({//数据源
	url : "<%=request.getContextPath()%>/returnEmptyJson.action", 
	root : "list",
	fields:["categoryname1","literaturename1","totalnum1","num1","returned1","returntime1","borrowtime1","expectedreturntime1","sname1","snumber1","borrowid","lindex1","lindex_snumber1"]
    //fields:[]
    //fields:["literaturename1","categoryid1","author1","press1","price1","num1","lindex1","literatureid1","outnum1"]
});
emptyStore.load();
var store = new Ext.data.JsonStore({//数据源
	url : "<%=request.getContextPath()%>/listBorrowListNotReturned.action", 
	root : "list",
	totalProperty : "total",
	fields:["categoryname","literaturename","totalnum","num","returned","returntime","borrowtime","expectedreturntime","sname","snumber","borrowid","lindex","lindex_snumber"]
});
store.load();
var literatureIndex= new Ext.form.TextField({
	fieldLabel:'索引号',
	anchor:"80%",
	allowBlank:false, 
	blankText:"请输入索引号",
	maxLength:25,
	maxLengthText : "请输入合法图书索引号",
    regex:/^[\u4E00-\u9FA5A-Za-z0-9]+$/,
	regexText:'只能输入汉字、英文、数字',
	width:80
});
var snumberIndex= new Ext.form.TextField({
	fieldLabel:'学号',
	anchor:"80%",
	allowBlank:false, 
	blankText:"请输入学号",
	maxLength:25,
	maxLengthText : "请输入合法学号",
    regex:/^[\u4E00-\u9FA5A-Za-z0-9]+$/,
	regexText:'只能输入汉字、英文、数字',
	width:80
});

var info_input_ok= new Ext.Button({
	text:'确定',
	handler:function(){
		if(!panel.form.isValid()){
			 Ext.Msg.alert('提示', '项目信息录入不完整！');
			 return;
		}		
		var tempReturn=[];
		var flag = true;
		emptyStore.each(function(record){
				tempReturn.push(record.data);  
		});
		if(emptyStore.getCount()<1)
		{
			Ext.Msg.alert("提示","数目不能为空!");
			return;
		}
		Ext.Msg.confirm("信息","确定操作?",function(btn){
			if(btn=='yes')
			{
				returnInfo(tempReturn);
			}
		});
	}
});

var sm=new Ext.grid.CheckboxSelectionModel({
	singleSelect:false
});
var returnProInfoListCM = new Ext.grid.ColumnModel([
     new Ext.grid.RowNumberer(),
     sm,
     {
 		header : "类别名",
 		dataIndex : "categoryname1",
 		width : 80,
 		sortable : true
 	},{
 		header : "名称",
 		dataIndex : "literaturename1",
 		width : 100,
 		sortable : true
 	},{
 		header : "学生名",
 		dataIndex : "sname1",
 		width : 80
 	},{
 		header :"学号",
 		dataIndex : "snumber1",
 		width : 80,
 		sortable : true
 	},{
 		header : "借阅时间",
 		dataIndex : "borrowtime1",
 		width : 90,
 		renderer : dateRender,
 		sortable : true
 	},{
 		header : "应还时间",
 		dataIndex : "expectedreturntime1",
 		width : 90,
 		renderer : dateRender,
 		sortable : true
 	},{
 		header : "归还时间",
 		dataIndex : "returntime1",
 		width : 90,
 		renderer : dateRender,
 		sortable : true
 	},{
 		header : "borrowid",
 		dataIndex : "borrowid",
 		hidden: true,
 		renderer : dateRender,
 		sortable : true
 	}
	]);


var returnProrInfoListCM = new Ext.grid.EditorGridPanel({
	id:'returnProrInfoListCM',
	clicksToEdit:1,
	autoScroll:true,
	bodyStyle:'padding:0px 0px 0px',
	height : 240,
	width:760,
	stripeRows:true,
	cm:returnProInfoListCM,
	sm:sm,
	store:emptyStore
});
returnProrInfoListCM.on("afteredit", afterEdit, returnProrInfoListCM);  

function afterEdit(obj){
	var record = obj.record;//获取被修改的行
	var row = obj.field;
};
var returnProPanel = new Ext.Panel({
	title : '图书列表',
	region:'east',
	bodyStyle : "padding:0px 0px 0px",
	frame : true,
	width : '100%',
	height:310,
	
	items : returnProrInfoListCM		
});
var info_input_back= new Ext.Button({
	text:'返回',
	handler:function(){
		loadpage("<%=request.getContextPath()%>/pages/userPages/borrowInfo.jsp");
	}
});
var panel = new Ext.FormPanel({
	fileUpload:true,
	frame:true,
	title: '<center><p><font size=3>图书归还栏</font></p></center>', 
	bodyStyle:'padding:0 0 0 0', 
	width : 790,
	autoHeight : true,
	layout:"column",
	//autoScroll: true,
	buttonAlign:'right',
	labelAlign : 'right',
	waitMsgTarget : true,
	labelWidth:80,
	tbar:[{
		xtype :"button",
		width:80,
		text:"添加",
		handler:function(){
		var lindex_snumber = literatureIndex.getValue()+snumberIndex.getValue();
		var index = store.find('lindex_snumber',lindex_snumber);
	        var plant = returnProrInfoListCM.getStore().recordType;
	        var newPlant = new plant({
	        	categoryname1:store.getAt(index).get('categoryname'),
	        	literaturename1:store.getAt(index).get('literaturename'),
	        	sname1:store.getAt(index).get('sname'),
	        	snumber1:store.getAt(index).get('snumber'),
	        	borrowtime1:store.getAt(index).get('borrowtime'),
	        	expectedreturntime1:store.getAt(index).get('expectedreturntime'),
	        	returntime1:store.getAt(index).get('returntime'),
	        	borrowid:store.getAt(index).get('borrowid')
	        	
	        });
	        returnProrInfoListCM.stopEditing();
	        emptyStore.insert(0, newPlant);
	        returnProrInfoListCM.startEditing(0, 1);
		}
		},"-",{
			xtype:"button",
			text:"重置",
			width:80,
			handler:function(){
				store.reload();
			}
		},"-",{
			xtype :"button",
			width:80,
			text:"删除",
			handler:function(){
				if(returnProrInfoListCM.getSelectionModel().getSelected()==null){
					Ext.Msg.alert("信息","请选择一行");
					return;
				}else{
					if(store.getCount()<=1){
						Ext.Msg.alert("提示","选择至少一条数据!");
						return;
					}
					var selections = returnProrInfoListCM.getSelectionModel().getSelections();
					var length = selections.length;
					if(length==store.getCount()){
						Ext.Msg.alert("信息","至少有一行不能被删除!");
						return;
					}
					Ext.Msg.confirm("信息","确定删除？",function(btn){
						if(btn=="yes"){								
							store.remove(selections);										
						}
					});
				}
			}
		}
	],
	items:[{
		columnWidth:.5,
		layout: 'form',
		border:false,
		items:literatureIndex
	},{
		columnWidth:.5,
		layout: 'form',
		border:false,
		items:snumberIndex
	},{
		columnWidth:1,
		layout:'column',
		height:300,
		border:false,
		items:returnProPanel
	}],
	buttons:[info_input_ok,info_input_back]
});

Ext.onReady(function(){
	Ext.QuickTips.init();
	panel.render("returnBorrowPanel");
	store.load({params : {key:''}});
});
</script>
</head>
<body>
<div id="returnBorrowPanel"></div>
</body>
</html>