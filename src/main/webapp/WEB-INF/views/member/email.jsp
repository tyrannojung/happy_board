<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Header -->
    <link rel="stylesheet" href="/css/find.css">
    <%@include file="../include/header.jsp"%>
</head>
<body>
<div class="wrap">
    <div class="main">
        <div class="main_login" action="#">
            <div class="logo" onclick="location.href='/login'"></div>
            <div class="repass_title">
                ${content}
            </div>
            <div class="line"></div>
            <button type="submit" class="submit_bt color_blue" onclick="location.href='/login'">
                홈으로
            </button>
        </div>
    </div>
</div>
</body>
</html>