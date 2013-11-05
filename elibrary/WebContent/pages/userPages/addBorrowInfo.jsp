<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>借阅信息</title>
<script type="text/javascript">
var borrowid = "";
var updateInfo = function(tempUpdate){
	var detailJsonArray = Ext.util.JSON.encode(tempUpdate);
	
	Ext.Ajax.request({
		url : '<%=request.getContextPath()%>/BorrowInfoSave.action',
		params : {
			"snumber" : studentNumber.getValue(),
			"detailJsonArray":detailJsonArray		
		},
		method : 'POST',
		failure : function(response, options) {
			Ext.MessageBox.alert('信息', '数据库非法操作，借阅数大于库存数 ！');
		},
		success : function(response, options) {
			var result = Ext.util.JSON.decode(response.responseText);
			if (result.error == 'false') {
				store.rejectChanges();
				Ext.MessageBox.alert('信息', '数据提交成功 ！');
				loadpage("<%=request.getContextPath()%>/pages/userPages/borrowInfo.jsp");
			} else {
				Ext.Msg.alert('失败', "保存失败!");
			}
		}
	});
};
function renderCol(data, cell, record, rowIndex, columnIndex, store) {  
    cell.attr = "style=background-color:#F5C0C0";   //设置单元格的背景色  
    return data;  
  } 
var literatureIndex= new Ext.form.TextField({
	fieldLabel:'图书索引号',
	anchor:"80%",
	allowBlank:false, 
	blankText:"请输入索引号",
	maxLength:25,
	maxLengthText : "请输入合法图书索引号",
    regex:/^[\u4E00-\u9FA5A-Za-z0-9]+$/,
	regexText:'只能输入汉字、英文、数字',
	width:80
});

var studentNumber= new Ext.form.TextField({
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
		var tempUpdate=[];
		var flag = true;
		emptyStore.each(function(record){
			//alert(record.get("borrownum"));
			if(!record.get("borrownum"))
			{        
				flag=false;
		    }else {
				tempUpdate.push(record.data);  
		    }   					 
		});
		if(emptyStore.getCount()<1)
		{
			Ext.Msg.alert("提示","数目不能为空!");
			return;
		}
		if(flag==false)
		{
			Ext.Msg.alert('提示', '必填信息录入不完整，请检查后重试！');
			return;
		}
		Ext.Msg.confirm("信息","确定保存?",function(btn){
			if(btn=='yes')
			{
				updateInfo(tempUpdate);
			}
		});
	}
});
var emptyStore = new Ext.data.JsonStore({//数据源
	url : "<%=request.getContextPath()%>/returnEmptyJson.action", 
	root : "list",
	fields:["lindex1","literaturename1","categoryid1","author1","num1","outnum1","borrownum"]
    //fields:[]
    //fields:["literaturename1","categoryid1","author1","press1","price1","num1","lindex1","literatureid1","outnum1"]
});
emptyStore.load();
var sm=new Ext.grid.CheckboxSelectionModel({
	singleSelect:false
});
var borrowProInfoListCM = new Ext.grid.ColumnModel([
     new Ext.grid.RowNumberer(),
     sm,
     {
  		header : "索引号",
  		dataIndex : "lindex1",
  		width : 50,
  		sortable : true
  	},{
 		header : "名称",
 		dataIndex : "literaturename1",
 		width : 150,
 		sortable : true
 	},{
 		header : "类别",
 		dataIndex : "categoryid1",
 		width : 100,
 		sortable : true
 	},{
 		header : "作者",
 		dataIndex : "author1",
 		width : 80,
 		sortable : true
 	},{
 		header : "出版社",
 		dataIndex : "press1",
 		width : 150,
 		sortable : true
 	},{
 		header : "总数",
 		dataIndex : "num1",
 		width : 50,
 		sortable : true
 	},{
 		header : "已借出",
 		dataIndex : "outnum1",
 		width : 70,
 		sortable : true
 	},{
 		header : "借阅数",
 		dataIndex : "borrownum",
 		width : 50,
 		sortable : true,
 		renderer: renderCol,
 		editor : new Ext.form.ComboBox({
		      typeAhead: true,
		      triggerAction: 'all',
		      lazyRender : true,
		      allowBlank : false,
		      blankText : "请选择数量",
		      selectOnFocus : true,
		      editable : true,
		      mode : 'remote',
		      store: [[1, '1'],[2, '2'],[3, '3'],[4, '4'],[5, '5'],[6, '6'],[7, '7'],[8, '8'],[9, '9'],[10, '10']],
		      displayField:'',
		      valueField:''
		      //hiddenName:"student.sex",
	})
 	}
	]);
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
store.load();

var borrowProrInfoListCM = new Ext.grid.EditorGridPanel({
	id:'borrowProrInfoListCM',
	clicksToEdit:1,
	autoScroll:true,
	bodyStyle:'padding:0px 0px 0px',
	height : 240,
	width:760,
	stripeRows:true,
	cm:borrowProInfoListCM,
	sm:sm,
	store:emptyStore
	//store:store
});
borrowProrInfoListCM.on("afteredit", afterEdit, borrowProrInfoListCM);  

function afterEdit(obj){
	var record = obj.record;//获取被修改的行
	var row = obj.field;
};
var borrowProPanel = new Ext.Panel({
	title : '图书列表',
	region:'east',
	bodyStyle : "padding:0px 0px 0px",
	frame : true,
	width : '100%',
	height:310,
	tbar:[{
		xtype :"button",
		width:80,
		text:"添加",
		handler:function(){

		var index = store.find('lindex',literatureIndex.getValue());   

		     
		//alert(store.getAt(index).get('literaturename')); 
        
	        var plant = borrowProrInfoListCM.getStore().recordType;
	        //var plant = borrowProrInfoListCM.cm.recordType;
	        var newPlant = new plant({
	        	literaturename1:store.getAt(index).get('literaturename'),
	        	categoryid1:store.getAt(index).get('categoryid'),
	        	lindex1:store.getAt(index).get('lindex'),
	        	author1:store.getAt(index).get('author'),
	        	press1:store.getAt(index).get('press'),
	        	price1:store.getAt(index).get('price'),
	        	num1:store.getAt(index).get('num'),
	        	outnum1:store.getAt(index).get('outnum')
	        });
	        borrowProrInfoListCM.stopEditing();
	        emptyStore.insert(0, newPlant);
	        borrowProrInfoListCM.startEditing(0, 1);
		}
		},'-',{
			xtype:"button",
			text:"重置",
			width:80,
			handler:function(){
				store.reload();
			}
		},'-',{
			xtype :"button",
			width:80,
			text:"删除",
			handler:function(){
				if(borrowProrInfoListCM.getSelectionModel().getSelected()==null){
					Ext.Msg.alert("信息","请选择一行");
					return;
				}else{
					if(store.getCount()<=1){
						Ext.Msg.alert("提示","选择至少一条数据!");
						return;
					}
					var selections = borrowProrInfoListCM.getSelectionModel().getSelections();
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
	items : borrowProrInfoListCM		
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
	title: '<center><p><font size=3>借阅栏</font></p></center>', 
	bodyStyle:'padding:0 0 0 0', 
	width : 790,
	autoHeight : true,
	layout:"column",
	//autoScroll: true,
	buttonAlign:'right',
	labelAlign : 'right',
	waitMsgTarget : true,
	labelWidth:80,
	items:[{
		columnWidth:.5,
		layout: 'form',
		border:false,
		items:literatureIndex
	},{
		columnWidth:.5,
		layout:'form',
		border:false,
		items:studentNumber
	},{
		columnWidth:1,
		layout:'column',
		height:300,
		border:false,
		items:borrowProPanel
	}],
	buttons:[info_input_ok,info_input_back]
});

Ext.onReady(function(){
	Ext.QuickTips.init("");
	Ext.form.Field.prototype.msgTarget = 'under';
	panel.render("addBorrowPanel");
});
</script>
</head>
<body>
<div id="addBorrowPanel"></div>
</body>
</html>