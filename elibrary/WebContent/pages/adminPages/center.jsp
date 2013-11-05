<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.akun.elibrary.bean.Libuser"%><html>
<head>
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css" />
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <title>AKUN后台管理系统</title>
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/jquery.ui.css" />
  <script type="text/javascript" src="<%=request.getContextPath()%>/jquery/jquery.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/jquery/jquery.ui.js"></script>
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/ext/resources/css/ext-all.css" />
  <link rel="stylesheet" type="text/css" href="" />
  <script type="text/javascript" src="<%=request.getContextPath()%>/ext/adapter/ext/ext-base.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/ext/ext-all.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/ext/src/locale/ext-lang-zh_CN.js"></script>
  <script type="text/javascript">
	<%--   <% if (session.getAttribute("userInfo") == null) { %>
	     alert("此页面只针对平台用户开放，请登录后重试！");
	     window.location = "<%=request.getContextPath()%>/pages/adminPages/login.jsp";
	  <% } %> --%>
	  function loadpage(href) {
		  $("#content_page").load(href, function(response, status, xhr) {
	        if (status == "error") {
	          $("#content_page").load("<%=request.getContextPath()%>/pages/404.jsp");
	        }
	      });
		} 
	  //Jquery完成侧边栏 及导航栏
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
    });
    Ext.ux.ThemeChange = Ext.extend(Ext.form.ComboBox,{
        editable : false,
        displayField : 'theme',
        valueField : 'css',
        typeAhead : true,
        mode : 'local',
        value : '默认',
        readonly : true,
        width:50,
        triggerAction : 'all',
        selectOnFocus : true,
        initComponent : function(){
                var themes = [
                                ['默认', 'xtheme-gray.css'],
                                ['黑色', 'xtheme-black.css'],
                                ['深灰', 'xtheme-darkgray.css'],
                                ['蓝色', 'ext-all.css'],
                                ['绿色', 'xtheme-green.css'],
                                ['橄榄', 'xtheme-olive.css'],
                                ['粉色', 'xtheme-pink.css'],
                                ['紫色', 'xtheme-purple.css'],
                                ['暗蓝', 'xtheme-slate.css'],
                                ['靛青', 'xtheme-indigo.css'],
                                ['Slic', 'xtheme-slickness.css'],
                                ['深夜', 'xtheme-midnight.css']
                ];
                this.store = new Ext.data.SimpleStore({
                        fields : ['theme', 'css'],
                        data : themes
                });
        },
        initEvents : function(){
                this.on('collapse', function(){
                        var name = this.getValue();
                        var date = new Date();
                        date.setTime(date.getTime() + 30*24*3066*1000);
                        document.cookie = "css=" + name + ";expires=" + date.toGMTString();
 
                        //实际改变风格样式的处理
                        Ext.util.CSS.swapStyleSheet('theme', '../../ext/resources/css/'+ name);
                });
        }
});
Ext.reg('xthemeChange', Ext.ux.ThemeChange);
 
Ext.onReady(function(){
        var cookiesArr = document.cookie.split(";");
        var cssName = "";
 
        for(var i=0; i<cookiesArr.length; i++){
                var arr = cookiesArr[i].split("=");
                if(arr[0] == "css"){
                        cssName = arr[1];
                        break;
                }
        };
 
        var themeList = new Ext.ux.ThemeChange();
 
        if(cssName != ""){
                Ext.util.CSS.swapStyleSheet('theme', "../../ext/resources/css/" + cssName);
                themeList.setValue(cssName);
        }
 
        //实例化一个可以改变风格样式的组件
        var pan = new Ext.Panel({
                title:'更换主题',
                items: themeList,
                headerAsText:false,
                header:false
                //height:20,
               // width:50
        });
        pan.render("navi");
});
  </script>
</head>
<body>
  <div class="header_bg">
    <div id="header">
      <div id="hd_logo"><span></span></div>
      <div id="hd_banner"><span>AKUN图书馆借阅服务平台</span></div>
      <div style="position:absolute; bottom:2px; right:8px">
        <% Libuser userInfo = new Libuser(); if(null != session.getAttribute("userInfo")) { userInfo = (Libuser) session.getAttribute("userInfo"); } %>
        <span style="color:white">欢迎，系统管理员：<%=userInfo.getUsername()%>！</span><a style="color:lightblue" href="<%=request.getContextPath()%>/logout.action">注销</a>
      </div>
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
         <li>
          <a href="javascript:void(0)">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;更换主题</a>
        </li>
      </ul>
    </div>
  </div>
  <div class="container_bg">
    <div id="container">
      <div id="sidebar">
        <ul>
          
          <li>
            <a href="javascript:void(0)">图书管理</a>
            <ul>
              <li><a href="<%=request.getContextPath()%>/pages/adminPages/literatureCategoryList.jsp">类别管理</a></li>
              <li><a href="<%=request.getContextPath()%>/pages/adminPages/literatureList.jsp">图书列表</a></li>
            </ul>
          </li>
           <li>
            <a href="javascript:void(0)">借阅管理</a>
            <ul>
              <li><a href="<%=request.getContextPath()%>/pages/adminPages/borrowList.jsp">借阅信息列表</a></li>
              <li><a href="<%=request.getContextPath()%>/pages/adminPages/borrowLiteratureList.jsp">书目信息查询</a></li>
            </ul>
          </li>
          <li><a href="javascript:void(0)">员工管理</a>
            <ul>
              <li><a href="<%=request.getContextPath()%>/pages/adminPages/libuserList.jsp">员工列表</a></li>
              <li><a href="<%=request.getContextPath()%>/pages/adminPages/libuserChangePwd.jsp">修改密码</a></li>
            </ul>
          </li>
          <li>
            <a href="javascript:void(0)">学生管理</a>
            <ul>
              <li><a href="<%=request.getContextPath()%>/pages/adminPages/studentList.jsp">学生列表</a></li>
            </ul>
          </li>
        </ul>
      </div>
      <div id="content_page"><span></span></div>
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
          <span>电子邮件：zk.yang1012@gmail.com</span><br/>
        </div>
        <div id="f_contentus">
          <span>&ensp;通讯地址：昆明市五华区翠湖北路2号云南大学东二院1幢512室</span><br /><br />
          <span>&ensp;<a href="<%=request.getContextPath()%>/pages/studentPages/studentPage.jsp"><font color="white">前台入口</font></a>&nbsp;|&nbsp;
     <a href="<%=request.getContextPath()%>/pages/userPages/userPage.jsp">员工入口</a></span>
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