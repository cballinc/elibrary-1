<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">

var oldPwdTextFeild=new Ext.form.TextField({
	margins : '0 0 0 0',
	fieldLabel : 'Previous Password',
	width:220,
	anchor:'90%',
	maxLength : 15,
	name:"oldPwd",
	maxLengthText : "Max length is 15",
	allowBlank : false,
    blankText : "Please type in the previous password!",
    	inputType:'password'
});
var newPwdTextFeild=new Ext.form.TextField({
	margins : '0 0 0 0',
	fieldLabel : 'New Password',
	width:220,
	anchor:'90%',
	maxLength : 15,
	minLength: 4,
	name:"newPwd",
	maxLengthText : "Max length is 16",
	minLengthText:"Min Length is 4",
	allowBlank : false,
    blankText : "Please type in the previous password!",
    inputType:'password'
});
var newPwdTextFeild2=new Ext.form.TextField({
	margins : '0 0 0 0',
	fieldLabel : 'Comfirm Password',
	width:220,
	anchor:'90%',
	maxLength : 15,
	minLength: 4,
	name:"newPwd2",
	maxLengthText : "Max length is 16",
	minLengthText:"Min length is 4",
	allowBlank : false,
    blankText : "Please type in previous password again!",
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
		text:'Save',
		handler:function(){
		    libuserChangePwd.getForm().submit({
				waitTitle : 'Wait...',  
                waitMsg : 'Processing the form, please wait...', 
				success : function(f, rep) {
					Ext.MessageBox.alert("Notice", rep.result.msg);
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