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
var limit=1000;
var store = new Ext.data.JsonStore({//数据源
	url : "<%=request.getContextPath()%>/listLibuser.action", 
	root : "nodes",
	totalProperty : "total",
	fields:["username","realname","tel","email","userid"]
});


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
		header : "真实姓名",
		dataIndex : "realname",
		width : 80,
		editor : new Ext.form.TextField({
			id : "pro_edField2"
		}),
		sortable : true
	},{//用户名不得更改
		header : "用户名",
		dataIndex : "username",
		width : 100,
		sortable : true
	},{
		header : "联系电话",
		dataIndex : "tel",
		width : 80,
		editor : new Ext.form.TextField({
			id : "pro_edField2"
		}),
		sortable : true
	},{
		header : "电子邮件",
		dataIndex : "email",
		width : 100,
		editor : new Ext.form.TextField({
			id : "pro_edField3"
		}),
		sortable : true
	}
]);

var libuserGrid = new Ext.grid.EditorGridPanel({
	bodyStyle : "padding:0px 0px 0px 0px",
	height : 440,
	width : 785,
	height:470,
	autoScroll : true,
	cm : cm,
	sm : sm,
	store : store
});

var usernameTextFeild=new Ext.form.TextField({
	margins : '0 0 0 0',
	fieldLabel : '用户名',
	width:220,
	anchor:'90%',
	maxLength : 20,
	name:"libuser.username",
	maxLengthText : "最大长度为20",
	allowBlank: false,
    blankText: "用户名不能为空"
});
var userpwdTextFeild=new Ext.form.TextField({
	margins : '0 0 0 0',
	fieldLabel : '初始密码',
	width:220,
	anchor:'90%',
	maxLength : 15,
	name:"libuser.userpwd",
	maxLengthText : "最大长度为15",
	allowBlank : false,
    blankText : "请为用户设置初始密码"
});
var realnameTextFeild=new Ext.form.TextField({
	margins : '0 0 0 0',
	fieldLabel : '真实姓名',
	width:220,
	anchor:'90%',
	maxLength : 20,
	name:"libuser.realname",
	maxLengthText : "最大长度为20"
});
var telTextFeild=new Ext.form.TextField({
	margins : '0 0 0 0',
	fieldLabel : '联系电话',
	width:220,
	anchor:'90%',
	maxLength : 15,
	name:"libuser.tel",
	maxLengthText : "最大长度为15"
});
var emailTextFeild=new Ext.form.TextField({
	margins : '0 0 0 0',
	fieldLabel : '邮箱',
	width:220,
	anchor:'90%',
	name:"libuser.email",
	vtype: 'email'
});

var closeButton=new Ext.Button({
	text:'关闭',				
	minWidth:80,
	handler:function(){
		addWindow.hide();
	}
});
			
var addPanel = new Ext.form.FormPanel( {
	url : "<%=request.getContextPath()%>/addLibuser.action",
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
		//用户名
		columnWidth : 1,
		layout : 'form',
		height : 40,
		border : false,
		items : usernameTextFeild
	},{
		//初始密码
		columnWidth : 1,
		layout : 'form',
		height : 40,
		border : false,
		items : userpwdTextFeild
	},{
		//真实姓名
		columnWidth : 1,
		layout : 'form',
		height : 40,
		border : false,
		items : realnameTextFeild
	},{
		//联系电话
		columnWidth : 1,
		layout : 'form',
		height : 40,
		border : false,
		items : telTextFeild
	},{
		//邮箱
		columnWidth : 1,
		layout : 'form',
		height : 40,
		border : false,
		items : emailTextFeild
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

//员工列表主显panel 
var libuserPanel = new Ext.Panel( {
	title : "<center><p><font size=3>员工管理</font></p></center>",
	width : "768",
	frame : true,
	height : 510,
	tbar : ['-', {
		text : "添加",
		width:80,
		handler : function() {						
			addWindow.show();//添加员工账户弹窗
			addPanel.form.reset();
			addWindow.setTitle('添加员工账户');							
		}
	},'-',{
		xtype :"button",
		width:80,
		text:"删除",
		handler:function(){
			var wh =  libuserGrid.getSelectionModel().getSelections();//通过多选框删除
			var ids="";
			if(wh.length<1){
				Ext.Msg.alert('提示', '请选中至少一条数据');
				return;
			}
			for(var i=0;i<wh.length;i++){
				ids+=wh[i].get("userid")+",";// 获取所选id
			}
			
			if(ids!=""){
				ids=ids.substring(0,ids.length-1);
			}
            //alert(ids[0]+10);
			Ext.Msg.confirm("操作确认","是否确认删除？",function(btn){

				if (btn == 'yes'){
					 Ext.Ajax.request({//删除action
						url: '<%=request.getContextPath()%>/deleteLibuser.action',
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
		text:"类别名关键字:",
		width:120
	},query,"&nbsp",queryButton],
	items:[{
		columnWidth : 1,
		layout : 'form',
		border : false,
		items : libuserGrid
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
					if (mr[i].get("realname").trim() != null
					 && mr[i].get("realname").trim() != ""){
						var data="{";
						data+='"userid":"'+mr[i].get("userid")+' ",';
						data+='"realname":"'+mr[i].get("realname")+' ",';
						data+='"tel":"'+mr[i].get("tel")+' ",';
						data+='"email":"' + mr[i].get("email")+' ",';
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
					if (mr[i].get("realname").trim() != null
							 && mr[i].get("realname").trim() != ""){
						var data="{";
						data+='"realname":"'+mr[i].get("realname")+' ",';
						data+='"tel":"'+mr[i].get("tel")+' ",';
						data+='"email":"' + mr[i].get("email")+' ",';
						data+="}";
						tempUpdate2+=data+",";
					}
				}
				if(tempUpdate2 != "["){
					tempUpdate2=tempUpdate2.substring(0,tempUpdate2.length-1);
				}
				tempUpdate2+="]";

									  						
				if (tempUpdate.length >2) {
					Ext.Ajax.request({//更新员工信息ACTION
						url : '<%=request.getContextPath()%>/updateLibuser.action',
						params : {
							updateLibuserList : tempUpdate,
							updateLibuserList2 : tempUpdate2
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
	libuserPanel.render("libuserListPanel");
	store.load({params : {key:'',start:0,limit:15}});//传分页控制参数 
});
	
</script>
</head>
<body>
<div id="libuserListPanel"></div>
</body>
</html>