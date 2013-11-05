<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/userPages_main.css" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>AKUN后台管理系统</title>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/jquery.ui.css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/jquery/jquery.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/jquery/jquery.ui.js"></script>
	<script type="text/javascript">
	  function login() {
      var patt = /^[A-Za-z0-9_]{4,16}$/;
      if(false == patt.test($("#username").val())) {
        $("#erruname").text("仅能为4-16位的字母、数字及下划线。");
        $("#errpwd").text("");
      } else if(false == patt.test($("#password").val())) {
        $("#erruname").text("");
        $("#errpwd").text("仅能为4-16位的字母、数字及下划线。");
      } else {
        $("#erruname").text("");
        $("#errpwd").text("");
        $.ajax({
          type : "post",
          url : "<%=request.getContextPath()%>/login.action",
          data : {
            "username" : $("#username").val(),
            "userpwd" : $("#password").val()
          },
          success : function(data) {
            if ("success\r\n" == data) {
                window.location = "<%=request.getContextPath()%>/pages/userPages/center.jsp";
            } else {
              alert("用户名或密码输入错误！");
            }
          }
        });
      }
    }
	
	  $(document).ready(function() {
		  $("#navi>ul>li").mouseover(function() {
			  $(this).children("ul").removeClass();
			});
		  $("#navi>ul>li").mouseleave(function() {
        $(this).children("ul").addClass("hide");
      });
		  $("#sidebar>ul>li>a").click(function() {
		    $(this).parents("li").find("ul").toggle();
		  });

		  $("#content_page").load("<%=request.getContextPath()%>/pages/adminPages/welcome.jsp?rd=" + Math.random());

		  $("#sidebar a").click(function($e) {
		    $e.preventDefault();
		    if ($(this).attr("href") == "javascript:void(0)") {
		      return false;
		    } else {
		    	$("#content_page").load($(this).attr("href") + "?rd=" + Math.random(), function(response, status, xhr) {
			    	if (status == "error") {
			    		$("#content_page").load("<%=request.getContextPath()%>/pages/adminPages/404.jsp");
			    	}
		    	});
		    }
		  });

		  $("#btnLogin").click(function($e) {
        $e.preventDefault();
        login();
		  });
	  });
	</script>
</head>
<body>
  <div class="header_bg">
    <div id="header">
	    <div id="hd_logo"><span></span></div>
	    <div id="hd_banner"><span>AKUN图书借阅平台</span></div>
	  </div>
  </div>
  <div class="navi_bg">
	  <div id="navi">
	    <ul>
	      <li>
	        <a href="<%=request.getContextPath()%>/pages/adminPages/center.jsp">首页</a>
	      </li>
	      <li>
	        <a href="javascript:void(0)">平台介绍</a>
	        <ul class="hide">
            <li><a href="javascript:void(0)">简介</a></li>
            <li><a href="javascript:void(0)">操作指南</a></li>
            <li><a href="javascript:void(0)">联系方式</a></li>
            <li><a href="javascript:void(0)">管理办法</a></li>
          </ul>
	      </li>
	  <!--<li>
	        <a href="javascript:void(0)">新闻动态</a>
	      </li>
	      <li>
	        <a href="javascript:void(0)">政策法规</a>
	      </li>
	      <li>
	        <a href="javascript:void(0)">软件企业</a>
	      </li>
	      <li>
	        <a href="javascript:void(0)">投诉及意见</a>
	      </li>
	      <li>
	        <a href="javascript:void(0)">用户操作</a>
	      </li>-->          
	    </ul>
	  </div>
	</div>
	<div class="container_bg">
	  <div id="container" style="padding:24px 0px 24px 0px">
	    <div style="width:640px; height:360px; margin:0px auto">
	      <h2>员工登录</h2>
	      <div style="position:relative; width:600px; height:240px; border:1px solid #DDDDDD;  margin:12px auto">
	        <div style="position:absolute; top:60px; left:100px">
	        <form id="loginform" name="loginform"  method="post" onkeydown="if(event.keyCode==13){login();}">
	          <span>用户名：</span><input id="username" type="text" /> <span id="erruname" style="color:red"></span><br /><br />
	          <span>密　码：</span><input id="password" type="password" /> <span id="errpwd" style="color:red"></span>
	        </form>
	        </div>
	        <div style="position:absolute; bottom:40px; right:60px">
            <input id="btnLogin" type="button" style="width:80px" value="登录" />
          </div>
	      </div>
	    </div>
	    <div style="clear:both;"></div>
    </div>
  </div>

  <div class="footer_bg">
    <div id="footer">
      <div style="width:960px">
        <div id="f_police">
          <img alt="police" src="<%=request.getContextPath()%>/images/book.jpg"></img>
        </div>
        <div id="f_copyright_cn">
          <span>&nbsp;&nbsp;&nbsp;&nbsp;联系电话：13608817451</span>　<br/><br/>　
          <span>电子邮件：zk.yang1012@gmail.com</span><br />
        </div>
        <div id="f_contentus">
          <span>&ensp;通讯地址：昆明市五华区翠湖北路2号云南大学东二院1幢512室</span><br /><br />
          <span>&ensp;<a href="<%=request.getContextPath()%>/pages/studentPages/studentPage.jsp"><font color="white">前台入口</font></a>&nbsp;|&nbsp;
     <a href="<%=request.getContextPath()%>/pages/adminPages/login.jsp">管理员入口</a></span>
        </div>
        <div style="clear:both"></div>
      </div>
      <div id="f_copyright_en">
        <span>Copyright © 2012 - 2013 Zongkun Yang All Rights Reserved.</span><br /><span>云南大学 杨宗昆 版权所有</span>     
      </div>
    </div>    
  </div>	
</body>
</html>