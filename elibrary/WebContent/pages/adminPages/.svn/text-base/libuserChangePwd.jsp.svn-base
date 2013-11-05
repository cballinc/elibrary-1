<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">

var oldPwdTextFeild=new Ext.form.TextField({
	margins : '0 0 0 0',
	fieldLabel : '原密码',
	width:220,
	anchor:'90%',
	maxLength : 15,
	name:"oldPwd",
	maxLengthText : "最大长度为15",
	allowBlank : false,
    blankText : "请输入原密码密码",
    	inputType:'password'
});
var newPwdTextFeild=new Ext.form.TextField({
	margins : '0 0 0 0',
	fieldLabel : '新密码',
	width:220,
	anchor:'90%',
	maxLength : 15,
	minLength: 4,
	name:"newPwd",
	maxLengthText : "最大长度为16",
	minLengthText:"最小长度为4",
	allowBlank : false,
    blankText : "请输入新密码",
    inputType:'password'
});
var newPwdTextFeild2=new Ext.form.TextField({
	margins : '0 0 0 0',
	fieldLabel : '再次输入新密码',
	width:220,
	anchor:'90%',
	maxLength : 15,
	minLength: 4,
	name:"newPwd2",
	maxLengthText : "最大长度为16",
	minLengthText:"最小长度为4",
	allowBlank : false,
    blankText : "请再次输入新密码密码",
    inputType:'password'
});
var libuserChangePwd = new Ext.form.FormPanel( {
	url : "<%=request.getContextPath()%>/changeLibuserPwd.action",
	//bodyStyle : 'padding:100 100 100 100',
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
		height : 100,
		border : false
		
	},{
		//原密码
		columnWidth : 1,
		layout : 'form',
		height : 40,
		border : false,
		items : oldPwdTextFeild
	},{
		//新密码
		columnWidth : 1,
		layout : 'form',
		height : 40,
		border : false,
		items : newPwdTextFeild
	},{
		//新密码2
		columnWidth : 1,
		layout : 'form',
		height : 40,
		border : false,
		items : newPwdTextFeild2
	}],
	buttons:[{
		text:'保存',
		handler:function(){
		    libuserChangePwd.getForm().submit({
				waitTitle : '请稍候',  
                waitMsg : '正在提交表单数据,请稍候...', 
				success : function(f, rep) {
					Ext.MessageBox.alert("提示", rep.result.msg);
				}
			});
		}
	}]
});
Ext.onReady(function() {
	Ext.QuickTips.init();//表单错误提示
	Ext.form.Field.prototype.msgTarget = 'under';
	libuserChangePwd.render("libuserChangePwd");
});
</script>
</head>
<body>
<div id="libuserChangePwd"></div>
</body>
</html>