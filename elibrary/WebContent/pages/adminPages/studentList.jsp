<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript">
function imgDel(delId) {
	Ext.Msg.confirm("Comfirm", "Delete？",
		function(btn) {		    
			if (btn == "yes") {		
				Ext.Msg.alert("Notice","Completed");
			}
		}
	);
};
// 格式化日期
function dateRender(value){
	if(value){
		if (typeof value == "string") { 
			return value = value.substr(0,10); 		
		}
		return value.format("Y-m-d");
		//return value;
	}else{
		return '';
	}
};

var limit = 5;//每页显示记录数

var classesList = new Ext.data.JsonStore({

    url : "<%=request.getContextPath()%>/listClasses.action",
    root: "root",
    fields:["classnumber","cname"]
});
classesList.load();

var store = new Ext.data.JsonStore({//数据源
	url : "<%=request.getContextPath()%>/showStudent.action", 
	root : "nodes",
	totalProperty : "total",
	fields:["snumber","classnumber","sname","sex","birthdate","tel","address","zipcode"]
});



var classesCombo=new Ext.form.ComboBox({
	margins:'0 0 0 0', 
	fieldLabel: '<font color = "red">*</font>Class',		    	
	allowBlank:false, 
	width:220,
	height: 25,
	anchor:'90%',
	editable : false,
	hiddenName:"student.classnumber",
	mode:'local',
	//store:[["C01", '1.1'],["C02", '1.2'],["C03", '1.3'],["C04", '1.4'],["C05", '1.5'],["C06", '2.1'],["C07", '2.2'],["C08", '2.3'],["C09", '2.4'],["C10", '2.5'],["C11", '3.1'],["C12", '3.2'],["C13", '3.3'],["C14", '3.4'],["C15", '3.5']],
	store:classesList,
	valueField: 'classnumber',
    displayField: 'cname',
	triggerAction : 'all'
});
var sexCombo=new Ext.form.ComboBox({
	margins:'0 0 0 0', 
	fieldLabel: '<font color = "red">*</font>Sex',		    	
	displayField:'',
	valueField:'',
	allowBlank:false, 
	width:220,
	height: 25,
	anchor:'90%',
	editable : false,
	hiddenName:"student.sex",
	mode:'local',
	store: [[1, 'Male'],[0, 'Female']],
	triggerAction : 'all'		
});
		
var sm=new Ext.grid.CheckboxSelectionModel();//全选/反选 
var cm = new Ext.grid.ColumnModel([
	sm,
	{
		header : "SID",
		dataIndex : "snumber",
		width : 80,
		sortable : true
	},{
		header : "Name",
		dataIndex : "sname",
		width : 100,
		editor : new Ext.form.TextField({
			id : "pro_edField1"
		}),
		sortable : true
	},{
		header : "Sex",
		dataIndex : "sex",
		width : 50,
		renderer:function(value){
          if(value == 0){
              return "Female";
          }else{
              return "Male";
          }
	    }
	},{
		header :"Class",
		dataIndex : "classnumber",
		width : 80,
		sortable : true
	},{
		header : "Birthdate",
		dataIndex : "birthdate",									
		width : 100,
		renderer : dateRender,
		editor : new Ext.form.DateField ({
			allowBlank : false,
			blankText: 'Please type in birthdate！',								
			editable : false,
			format : "Y-m-d"
		}),
		
		sortable : true
	},{
		header : "Tel",
		dataIndex : "tel",
		width : 100,
		editor : new Ext.form.TextField({
			id : "pro_edField3"
		}),
		sortable : true
	},{
		header : "Address",
		dataIndex : "address",
		width : 140,
		editor : new Ext.form.TextField({
			id : "pro_edField4"
		}),
		sortable : true
	},{
		header : "Zip Code",
		dataIndex : "zipcode",
		width : 100,
		editor : new Ext.form.TextField({
			id : "pro_edField5"
		}),
		sortable : true
	}
]);

var studentGrid = new Ext.grid.EditorGridPanel({
	bodyStyle : "padding:0px 0px 0px 0px",
	height : 440,
	width : 785,
	height:470,
	autoScroll : true,
	cm : cm,
	sm : sm,
	store : store
});

var snumberTextFeild=new Ext.form.TextField({
	margins : '0 0 0 0',
	//name: 'userInfo.companyInfomation.address', 
	fieldLabel : '<font color = "red">*</font>学号',
	allowBlank : false,
	width:220,
	anchor:'90%',
	blankText: 'Please type in SID！',
	maxLength : 15,
	name:"student.snumber",
	maxLengthText : "Maximum Length of SID is 15"
});

var studentNameTextFeild=new Ext.form.TextField({
	margins : '0 0 0 0',
	//name: 'userInfo.companyInfomation.address', 
	fieldLabel : '<font color = "red">*</font>Student Name',
	allowBlank : false,
	width:220,
	anchor:'90%',
	blankText: 'Please type in student name！',
	maxLength : 25,
	name:"student.sname",
	maxLengthText : "Maximun length of studnet name is 25"
});
var btn =snumberTextFeild; //addPanel.getForm().findField('SS');
//焦点离开时触发
btn.on('blur', function() { 
			 //获得输入的值
			var SON = btn.getValue();
			//alert(SON);
			//向远程服务器发送一http请求
		Ext.Ajax.request( { 
					method : 'post', 
					url : '<%=request.getContextPath()%>/checkSnumber.action', 
					params : {             //params中放得时要传递的参数
						addSnumber : SON
					},
					success: function(res){
						alert(res.responseText);
						if(res.responseText=="The SID already exits!"){
						Ext.Msg.alert('Notice', res.responseText);
						snumberTextFeild.setValue("");
						//store.reload();
						}
					}
				});
	});
var birthdateFeild = new Ext.form.DateField( {
	margins : '0 0 0 0',
	//name: 'userInfo.companyInfomation.address', 
	fieldLabel : 'Birthdate',
	allowBlank : true,
	width:220,
	anchor:'90%',
	blankText: 'Please type in birthdate！',
	editable : false,
	name:"student.birthdate",
	format : "Y-m-d",
	anchor : '90%',
	maxValue:new Date(),
	maxText:"The birthdate is invalid!"
});

var studentTelTextFeild=new Ext.form.TextField({
	margins : '0 0 0 0',
	//name: 'userInfo.companyInfomation.address', 
	fieldLabel : 'Tel',
	width:220,
	anchor:'90%',
	maxLength : 15,
	name:"student.tel",
	maxLengthText : "Maximum length is 15"
});
var studentAddressTextFeild=new Ext.form.TextField({
	margins : '0 0 0 0',
	//name: 'userInfo.companyInfomation.address', 
	fieldLabel : 'Address',
	width:220,
	anchor:'90%',
	maxLength : 50,
	name:"student.address",
	maxLengthText : "Maximum length is 50"
});
var studentZipcodeTextFeild=new Ext.form.TextField({
	margins : '0 0 0 0',
	//name: 'userInfo.companyInfomation.address', 
	fieldLabel : 'Zip Code',
	width:220,
	anchor:'90%',
	maxLength : 10,
	name:"student.zipcode",
	maxLengthText : "The length of Zip code must be 5"
});

var closeButton=new Ext.Button({
	text:'Close',				
	minWidth:80,
	handler:function(){
		addWindow.hide();
	}
});
			
var addPanel = new Ext.form.FormPanel( {
	url : "<%=request.getContextPath()%>/addStudent.action",
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
		//学号
		columnWidth : 1,
		layout : 'form',
		height : 40,
		border : false,
		items : snumberTextFeild
	},{
		//姓名 
		columnWidth : 1,
		layout : 'form',
		height : 40,
		border : false,
		items : studentNameTextFeild
	},{
		//性别
		columnWidth : 1,
		layout : 'form',
		height : 40,
		border : false,
		items : sexCombo
	}, {
		//班级
		columnWidth : 1,
		layout : 'form',
		height : 40,
		border : false,
		items : classesCombo
	}, {
		//出生日期
		columnWidth : 1,
		layout : 'form',
		height : 40,
		border : false,
		items : birthdateFeild
	}, {
		//联系方式
		columnWidth : 1,
		layout : 'form',
		height : 40,
		border : false,
		items : studentTelTextFeild
	},{
		//住址
		columnWidth : 1,
		layout : 'form',
		height : 40,
		border : false,
		items : studentAddressTextFeild
	},{
		//邮编 
		columnWidth : 1,
		layout : 'form',
		height : 40,
		border : false,
		items : studentZipcodeTextFeild
	}],
	buttons:[{
		text:'Save',
		handler:function(){
			addPanel.getForm().submit({
				waitTitle : 'Wati',  
                waitMsg : 'Processing the form, please wait...', 
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
	title : 'Add Student Information',
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

//学生列表主显panel 
var studentPanel = new Ext.Panel( {
	title : "<center><p><font size=3>Student Management</font></p></center>",
	width : "768",
	frame : true,
	height : 510,
	tbar : ['-', {
		text : "Add",
		width:80,
		handler : function() {						
			addWindow.show();//添加学生信息弹窗
			addPanel.form.reset();
			addWindow.setTitle('Add Student Information');							
		}
	},'-',{
		xtype :"button",
		width:80,
		text:"Delete",
		handler:function(){
			var wh =  studentGrid.getSelectionModel().getSelections();//通过多选框删除
			var ids="";
			if(wh.length<1){
				Ext.Msg.alert('Notice', 'Please select at least one record!');
				return;
			}
			for(var i=0;i<wh.length;i++){
				ids+=wh[i].get("snumber")+",";// 获取所选学生的snumber
			}
			if(ids!=""){
				ids=ids.substring(0,ids.length-1);
			}
			Ext.Msg.confirm("Confirm","Delete？",function(btn){
				if (btn == 'yes'){
					 Ext.Ajax.request({//删除action
						url: '<%=request.getContextPath()%>/deleteStudents.action',
						success: function(res){
							Ext.Msg.alert('Notice', res.responseText);
							store.reload();//重新加载列表
						},
						failure: function(res){
							alert(res);
						},
						params: {snumbersToDelete: ids }//传给deleteAction的参数（学生学号）
					});
				}
			});
		}
	} ,"->",{//搜索框
		xtype :"label",
		text:"Student Name Keywords:",
		width:120
	},query,"&nbsp",queryButton],
	items:[{
		columnWidth : 1,
		layout : 'form',
		border : false,
		items : studentGrid
	}],
	//右下角显示分页信息与保存按钮 
	bbar : new Ext.PagingToolbar( {
		pageSize : 5,
		displayInfo : true,
		displayMsg : 'List {0} to {1} records，total {2} ',
		store:store,
		emptyMsg : "No record"
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
					if (mr[i].get("sname") != null
					 && mr[i].get("sname").trim() != ""&&mr[i].get("snumber") != null
					  && mr[i].get("snumber").trim() != "") {
						var data="{";
						data+='"sname":"'+mr[i].get("sname")+'",';
						data+='"snumber":"'+ mr[i].get("snumber")+'",';
						data+='"sex":"'+mr[i].get("sex")+' ",';
						data+='"tel":"'+mr[i].get("tel")+'",';
						data+='"address":"'+ mr[i].get("address")+'",';
						data+='"zipcode":"'+mr[i].get("zipcode")+'",';
						data+='"birthdate":"'+mr[i].get("birthdate")+'"';
						data+="}";
						tempUpdate+=data+",";
					}
				}
				if(tempUpdate != "["){
					tempUpdate=tempUpdate.substring(0,tempUpdate.length-1);
				}
				tempUpdate+="]";					  						
				if (tempUpdate.length >2) {
					Ext.Ajax.request({//更新学生信息ACTION
						url : '<%=request.getContextPath()%>/updateStudent.action',
						params : {
							updateStudentList : tempUpdate
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


Ext.onReady(function() {
	Ext.QuickTips.init();//表单错误提示
	Ext.form.Field.prototype.msgTarget = 'under';
	studentPanel.render("studentListPanel");
	store.load({params : {key:'',start:0,limit:5}});//传分页控制参数 
});
	
</script>
</head>
<body>
<div id="studentListPanel"></div>
</body>
</html>