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
var sm=new Ext.grid.CheckboxSelectionModel();//全选/反选 
var cm = new Ext.grid.ColumnModel([
	sm,
	{
		header : "名称",
		dataIndex : "literaturename",
		width : 150,
		editor : new Ext.form.TextField({
			id : "pro_edField1"
		}),
		sortable : true
	},{
		header : "类别",
		dataIndex : "categoryid",
		width : 100,
		sortable : true,
		renderer:function(categoryid){
        var count = categoryStore.getCount();
        for(var i=0;i<=count;i++){
            var temp = categoryStore.getAt(i).get('categoryid');
        	if(temp==categoryid){
        	     return categoryStore.getAt(i).get('categoryname');  
        	}    
        }
	},
		editor : new Ext.form.ComboBox({
			      typeAhead: true,
			      triggerAction: 'all',
			      lazyRender : true,
			      allowBlank : false,
			      blankText : "请选择类别",
			      editable : false,
			      mode : 'remote',
			      store:categoryStore,
			      valueField: 'categoryid',
			      displayField: 'categoryname'
		})
	},{
		header : "索引号",
		dataIndex : "lindex",
		width : 50,
		editor : new Ext.form.TextField({
			id : "pro_edField6"
		}),
		sortable : true
	},{
		header : "作者",
		dataIndex : "author",
		width : 80,
		editor : new Ext.form.TextField({
			id : "pro_edField2"
		}),
		sortable : true
	},{
		header : "出版社",
		dataIndex : "press",
		width : 150,
		editor : new Ext.form.TextField({
			id : "pro_edField3"
		}),
		sortable : true
	},{
		header : "标价",
		dataIndex : "price",
		width : 50,
		editor : new Ext.form.TextField({
			id : "pro_edField4"
		}),
		sortable : true
	},{
		header : "总数",
		dataIndex : "num",
		width : 50,
		editor : new Ext.form.TextField({
			id : "pro_edField5"
		}),
		sortable : true
	},{
		header : "已借出",
		dataIndex : "outnum",
		width : 70,
		editor : new Ext.form.TextField({
			id : "pro_edField6"
		}),
		sortable : true
	}
]);

var literatureGrid = new Ext.grid.EditorGridPanel({
	bodyStyle : "padding:0px 0px 0px 0px",
	height : 440,
	width : 785,
	height:470,
	autoScroll : true,
	cm : cm,
	sm : sm,
	store : store
});
var literaturenameTextFeild=new Ext.form.TextField({
	margins : '0 0 0 0',
	fieldLabel : '<font color = "red">*</font>名称',
	allowBlank: false,
	blankText: '不允许为空',
	width:220,
	anchor:'90%',
	maxLength : 50,
	name:"literature.literaturename",
	maxLengthText : "最大长度为20"
});
var lindexTextFeild=new Ext.form.TextField({
	margins : '0 0 0 0',
	fieldLabel : '<font color = "red">*</font>索引号',
	allowBlank: false,
	blankText: '不允许为空',
	width:220,
	anchor:'90%',
	maxLength : 10,
	name:"literature.lindex",
	maxLengthText : "最大长度为10"
});
var authorTextFeild=new Ext.form.TextField({
	margins : '0 0 0 0',
	fieldLabel : '<font color = "red">*</font>作者',
	allowBlank: false,
	blankText: '不允许为空',
	width:220,
	anchor:'90%',
	maxLength : 20,
	name:"literature.author",
	maxLengthText : "最大长度为20"
});
var pressTextFeild=new Ext.form.TextField({
	margins : '0 0 0 0',
	fieldLabel : '<font color = "red">*</font>出版社',
	allowBlank: false,
	blankText: '不允许为空',
	width:220,
	anchor:'90%',
	maxLength : 50,
	name:"literature.press",
	maxLengthText : "最大长度为50"
});
var priceTextFeild=new Ext.form.TextField({
	margins : '0 0 0 0',
	fieldLabel : '<font color = "red">*</font>定价',
	allowBlank: false,
	blankText: '不允许为空',
	width:220,
	anchor:'90%',
	maxLength : 50,
	name:"literature.price",
	maxLengthText : "最大长度为10"
});
var numTextFeild=new Ext.form.TextField({
	margins : '0 0 0 0',
	fieldLabel : '<font color = "red">*</font>总数',
	allowBlank: false,
	blankText: '不允许为空',
	width:220,
	anchor:'90%',
	maxLength : 10,
	name:"literature.num",
	maxLengthText : "最大长度为10"
});
var categoryCombo=new Ext.form.ComboBox({
	margins:'0 0 0 0', 
	fieldLabel: '<font color = "red">*</font>类别',		    	
	allowBlank:false, 
	width:220,
	height: 25,
	anchor:'90%',
	editable : false,
	hiddenName:"category.categoryid",
	mode:'local',
	store:categoryStore,
	valueField: 'categoryid',
    displayField: 'categoryname',
	triggerAction : 'all'
});

var closeButton=new Ext.Button({
	text:'关闭',				
	minWidth:80,
	handler:function(){
		addWindow.hide();
	}
});
var addPanel = new Ext.form.FormPanel( {
	url : "<%=request.getContextPath()%>/addLiterature.action",
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
		//名称
		columnWidth : 1,
		layout : 'form',
		height : 40,
		border : false,
		items : literaturenameTextFeild
	},{
		//索引号
		columnWidth : 1,
		layout : 'form',
		height : 40,
		border : false,
		items : lindexTextFeild
	},{
		//类别
		columnWidth : 1,
		layout : 'form',
		height : 40,
		border : false,
		items : categoryCombo
	}, {
		//作者 
		columnWidth : 1,
		layout : 'form',
		height : 40,
		border : false,
		items : authorTextFeild
	},{
		//出版社
		columnWidth : 1,
		layout : 'form',
		height : 40,
		border : false,
		items : pressTextFeild
	}, {
		//价格 
		columnWidth : 1,
		layout : 'form',
		height : 40,
		border : false,
		items : priceTextFeild
	},{
		//总数
		columnWidth : 1,
		layout : 'form',
		height : 40,
		border : false,
		items : numTextFeild
	}],
	buttons:[{
		text:'保存',
		handler:function(){
			addPanel.getForm().submit({
				waitTitle : '请稍候',  
                waitMsg : '正在提交表单数据,请稍候...', 
				success : function(f, rep) {
					Ext.MessageBox.alert("提示", rep.result.msg);
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

//资料列表主显panel 
var literaturePanel = new Ext.Panel( {
	title : "<center><p><font size=3>图书管理</font></p></center>",
	width : "768",
	frame : true,
	height : 510,
	tbar : ['-', {
		text : "添加",
		width:80,
		handler : function() {						
			addWindow.show();//添加资料信息弹窗
			addPanel.form.reset();
			addWindow.setTitle('添加图书信息');							
		}
	},'-',{
		xtype :"button",
		width:80,
		text:"删除",
		handler:function(){
			var wh =  literatureGrid.getSelectionModel().getSelections();//通过多选框删除
			var ids="";
			if(wh.length<1){
				Ext.Msg.alert('提示', '请选中至少一条数据');
				return;
			}
			for(var i=0;i<wh.length;i++){
				ids+=wh[i].get("literatureid")+",";// 获取id
			}
			
			if(ids!=""){
				ids=ids.substring(0,ids.length-1);
			}
            //alert(ids[0]+10);
			Ext.Msg.confirm("操作确认","是否确认删除？",function(btn){

				if (btn == 'yes'){
					 Ext.Ajax.request({//删除action
						url: '<%=request.getContextPath()%>/deleteLiterature.action',
						success: function(res){
							Ext.Msg.alert('提示', res.responseText);
							store.reload();//重新加载列表
						},
						failure: function(res){
							alert(res);
						},
						params: {idsToDelete: ids }//传给deleteAction的参数（学生学号）
					});
				}
			});
		}
	} ,"->",{//搜索框
		xtype :"label",
		text:"名称关键字:",
		width:120
	},query,"&nbsp",queryButton],
	items:[{
		columnWidth : 1,
		layout : 'form',
		border : false,
		items : literatureGrid
	}],
	//右下角显示分页信息与保存按钮 
	bbar : new Ext.PagingToolbar( {
		pageSize : 15,
		displayInfo : true,
		displayMsg : '显示第 {0} 条到 {1} 条记录，一共 {2} 条',
		store:store,
		emptyMsg : "没有记录"
	}),	
	buttons :[
	{
		text:'保存',
		xtype:'button',
		handler : function() {
			var mr = store.getModifiedRecords(); // 获取所有更新过的记录
			if (mr.length > 0) {
				var tempUpdate = "[";
				for (var i = 0; i < mr.length; i++) {
					if (mr[i].get("lindex").trim() != null
					 && mr[i].get("lindex").trim() != ""&&mr[i].get("literaturename").trim() != null
					  && mr[i].get("literaturename").trim() != "") {
						var data="{";
						data+='"literatureid":"'+mr[i].get("literatureid")+' ",';
						data+='"literaturename":"'+mr[i].get("literaturename")+' ",';
						data+='"lindex":"'+mr[i].get("lindex")+' ",';
						data+='"categoryid":"'+mr[i].get("categoryid")+' ",';
						data+='"author":"' + mr[i].get("author")+' ",';
						data+='"press":"'+mr[i].get("press")+' ",';
						data+='"price":"'+mr[i].get("price")+' ",';
						data+='"num":"' + mr[i].get("num")+' ",';
						data+="}";
						tempUpdate+=data+",";
					}
				}
				if(tempUpdate != "["){
					tempUpdate=tempUpdate.substring(0,tempUpdate.length-1);
				}
				tempUpdate+="]";
                alert("tempUpdate");
                alert(tempUpdate);
				var tempUpdate2 = "[";
				for (var i = 0; i < mr.length; i++) {
					if (mr[i].get("lindex").trim() != null
					 && mr[i].get("lindex").trim() != ""&&mr[i].get("literaturename").trim() != null
					  && mr[i].get("literaturename").trim() != "") {
						var data="{";
						data+='"literaturename":"'+mr[i].get("literaturename")+' ",';
						data+='"lindex":"'+mr[i].get("lindex")+' ",';
						data+='"categoryid":"'+mr[i].get("categoryid")+' ",';
						data+='"author":"' + mr[i].get("author")+' ",';
						data+='"press":"'+mr[i].get("press")+' ",';
						data+='"price":"'+mr[i].get("price")+' ",';
						data+='"num":"' + mr[i].get("num")+' ",';
						data+="}";
						tempUpdate2+=data+",";
					}
				}
				if(tempUpdate2 != "["){
					tempUpdate2=tempUpdate2.substring(0,tempUpdate.length-1);
				}
				tempUpdate2+="]";
				alert("tempUpdate2");
                alert(tempUpdate2);
				if (tempUpdate.length >2) {
					Ext.Ajax.request({//更新ACTION
						url : '<%=request.getContextPath()%>/updateLiterature.action',
						params : {
							updateList : tempUpdate,
							updateList2 : tempUpdate2
						},
						method : 'POST',
						success: function(res){
							Ext.Msg.alert('提示', res.responseText);
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

Ext.onReady(function() {
	Ext.QuickTips.init();//表单错误提示
	Ext.form.Field.prototype.msgTarget = 'under';
	literaturePanel.render("literatureListPanel");
	store.load({params : {key:''}});//传分页控制参数 
});
	
</script>
</head>
<body>
<div id="literatureListPanel"></div>
</body>
</html>