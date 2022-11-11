<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%
    //치환 변수 선언
    pageContext.setAttribute("cr", "\r");
    pageContext.setAttribute("cn", "\n");
    pageContext.setAttribute("cron", "\r\n");
    pageContext.setAttribute("sp", "&nbsp;");
    pageContext.setAttribute("br", "<br/>");
%>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="preconnect" href="https://fonts.gstatic.com" />
<link
        href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap"
        rel="stylesheet"
/>
<script src="${pageContext.request.contextPath}/resources/common/jquery/jquery-3.5.1.js"></script>
<script src="${pageContext.request.contextPath}/resources/common/js/common.js"></script>
<!-- date picker -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/common/jquery/jquery-ui.css" />
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/favicon.ico" />
<script type="text/javascript" charset="UTF-8" src="${pageContext.request.contextPath}/resources/common/jquery/jquery-ui.min.js"></script>
<script type="text/javascript" charset="UTF-8" src="${pageContext.request.contextPath}/resources/common/jquery/jquery-ui.datepicker.js"></script>
<!-- -->
