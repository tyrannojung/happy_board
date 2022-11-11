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
            <div class="logo"></div>
            <div class="repass_title">
                안전한 이용을 위해 해피머니만의 비밀번호를 만들어 주세요.
            </div>
            <div class="find_user_tb">
                <div class="tb_line" id="fpw_id">
                    <div>새 비밀번호</div>
                    <div><input type="text" /></div>
                </div>
                <div class="tb_line">
                    <div>새 비밀번호 확인</div>
                    <div><input type="text" /></div>
                </div>
            </div>
            <button type="submit" class="submit_bt color_blue" id="find_action">
                비밀번호 변경
            </button>
            <div class="line"></div>
        </div>
    </div>
</div>
</body>
</html>