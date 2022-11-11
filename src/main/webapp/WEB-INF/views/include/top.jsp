<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="header">
    <div class="logo">
        <a  href="/board-list"></a>
    </div>
    <div class="right_menu">
        <div class="menu_login_ck" onclick="location.href='/member-signout'">
            <div class="user_img"></div>
            <div class="menu_txt">Sign out</div>
        </div>
    </div>
</div>