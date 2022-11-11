<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Header -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/signIn.css">
    <%@include file="../include/header.jsp"%>
</head>
<body>
<div class="wrap">
    <div class="main">
        <div class="main_login" action="#">
            <div class="logo"></div>
            <form name="signInForm" id="signInForm" method="post" onsubmit="return false;">
                <div class="login_txt" name="email">아이디</div>
                <input type="text" class="login_input" name="member_id" id="member_id" />
                <div class="login_txt" name="pw">비밀번호</div>
                <input type="password" class="login_input" name="member_password" id="member_password" />
                <span class="input_warning" id="warning_member">아이디 또는 비밀번호를 확인해주세요.</span>
                <button
                        type="button"
                        class="login_submit"
                        onclick="chkSignInForm()"
                >
                    로그인
                </button>
            </form>
            <div class="line"></div>
            <div class="find">
                <div><a href="/member-find">아이디/비밀번호 찾기</a></div>
                <div></div>
                <div><a href="/member-join">회원가입</a></div>
            </div>
        </div>
    </div>
</div>
<script>
    function chkSignInForm(){
      $(".input_warning").css("display", "none");
      var objForm = document.signInForm;
      if (!REG_member_id.test(objForm.member_id.value)
      || checkNull(objForm.member_password.value)){
        $("#warning_member").show();
      } else {
        $.ajax({
          url: '/member-sign-in',
          type: "POST",
          data: new FormData(document.getElementById('signInForm')),
          dataType: 'text',
          async: true,
          processData: false,
          contentType: false,
          success: function (res) {
            var joFunc = JSON.parse(res);
            if(joFunc['result']== "ok")
              location.href="/board-list"
            else
              $("#warning_member").show();

          },
          error: function (XMLHttpRequest, textStatus, errorThrown) {
            console.log("통신 실패.")

          }
        });
      }

    }

</script>
</body>
</html>