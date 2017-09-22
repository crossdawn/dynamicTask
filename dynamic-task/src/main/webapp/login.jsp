<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/basic/base.jsp"%>
<!DOCTYPE html>
<html>
<head><title>quartz</title>
    <meta charset="utf-8">

    <meta name="keywords" content="DB">
    <meta name="description"
          content="">
    <meta name="author" content="">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1">
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <link rel="shortcut icon" href="/img/favicon.ico">
    <script type="text/javascript">(function () {
        if (navigator.userAgent.indexOf("MSIE 7.") > 0) {
            location.href = '/Prompt/Obsolete';
        }
    })();</script>

    <link rel="stylesheet" type="text/css" href="${ctx}/static/adminlte/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/adminlte/bootstrap/css/bootstrap-theme.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/index.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/layout.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/login.css">
    <style type="text/css">
        .error{
            height: 30px;
            line-height: 30px;
            text-align: center;
        }
    </style>

    <!--[if gte IE 7]>
    <script src="http://apps.bdimg.com/libs/html5shiv/3.7/html5shiv.min.js"></script>
    <script src="http://apps.bdimg.com/libs/respond.js/1.4.2/respond.min.js"></script><![endif]-->
    <script src="${ctx}/static/jquery-1.9.1.js" type="text/javascript"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body>
<div id="jm-body">
    <%
        request.setAttribute("rm",request.getParameter("resMess"));
        request.setAttribute("rt",request.getParameter("resType"));
    %>
    <input type="hidden" value="${rm}" id="resMess" />
    <input type="hidden" value="${rt}" id="resType" />

    <div class="bg">
        <div id="jm-login">
            <form action="${ctx}/login" method="post" id='validate' name="myform">
                <p class="head">登录</p>

                <input type="text" value="${username}" class="input" placeholder="用户名" name="username" id="username"/>
                <label id="username-error" class="error" style="display: none;"></label>

                <input type="password" class="input" placeholder="密码" name="password" id="password"/>
                <label id="password-error" class="error" style="display: none;"></label>

                <a href="javascript:void(0);" id="submitlogin" onclick="submitlogin()" class="register">登录</a>

            </form>
        </div>
    </div>
</div>

<!--
<script data-main="/js/gulp/main.min" src="/js/gulp/require.min.js"></script>
-->
<script type="text/javascript">
    $(document).ready(function(){
        var resType=$("#resType").val();
        if(resType != undefined){
            if(resType=='1'){
                $("#username-error").html($("#resMess").val()).attr("style","display: block;");
            }else if (resType=='2'){
                $("#password-error").html($("#resMess").val()).attr("style","display: block;");
            }else if (resType=='3'){
                $("#username-error").html($("#resMess").val()).attr("style","display: block;");
            }
        }
    });
    function submitlogin(){
        var username = $.trim($("#username").val());
        var password = $.trim($("#password").val());
        if(username==''){
            $("#username-error").html("用户名不能为空").attr("style","display: block;");
            return false;
        }else{$("#username-error").attr("style","display: none;");}
        if(password==''){
            $("#password-error").html("密码不能为空").attr("style","display: block;");
            return false;
        }else{$("#password-error").attr("style","display: none;");}
        document.forms.myform.method = "post";
        document.forms.myform.submit();
    }
    document.onkeydown=function(event){
        var e = event || window.event || arguments.callee.caller.arguments[0];
        if(e && e.keyCode==13){
            $("#submitlogin").click();
        }
    };
</script>

</body>
</html>