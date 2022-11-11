<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Header -->
    <link rel="stylesheet" href="/css/find.css">
    <%@include file="../include/header.jsp"%>
    <script src="/common/js/ethers-v5.min.js"></script>
</head>
<body>
<form class="find_user_tb" name="findForm" id="findForm" method="get" onsubmit="return false;">
    <div class="wrap">
        <div class="main">
            <div class="main_login" action="#">
                <div class="logo" onclick="location.href='/login'"></div>
                <div class="tb_title">
                    <div class="tb_title_line">
                        <div class="b_active" id="fid">아이디 찾기</div>
                        <div id="fpw">비밀번호 찾기</div>
                    </div>
                </div>
                <div class="find_user_tb">
                    <input type="hidden" id="type_value" value="id" />
                    <div class="tb_line" id="fpw_id" style="display: none">
                        <div>아이디</div>
                        <div><input type="text" name="member_id" id="member_id" /></div>
                    </div>
                    <div class="tb_line">
                        <div>이름</div>
                        <div><input type="text" name="member_name" id="member_name" /></div>
                    </div>
                    <div class="tb_line">
                        <div>Private-key</div>
                        <div><input type="password" name="member_key_input" id="member_key_input" /></div>
                    </div>
                </div>
                <button type="submit" class="submit_bt color_blue" id="find_action" onclick="chkFindAction()">
                    아이디 찾기
                </button>
                <div class="line"></div>
                <span class="input_warning" id="warning_find_value">입력값들을 확인해주세요.</span>
                <span class="input_warning" id="warning_chek_value">가입된 내역이 확인되지 않습니다.</span>
            </div>


            <div class="find_success_id" style="display: none">
                <div class="logo" onclick="location.href='/login'"></div>
                <div class="repass_title">
                    고객님의 아이디는 "<span id="find_success_id_value"></span>" 입니다.
                </div>
                <div class="line"></div>
                <button type="submit" class="submit_bt color_blue" onclick="location.href='/login'">
                    홈으로
                </button>
            </div>
            <div class="find_success_repass" style="display: none">
                <div class="logo" onclick="location.href='/login'"></div>
                <div class="repass_title">
                    안전한 이용을 위해 해피머니만의 비밀번호를 만들어 주세요.
                </div>
                <div class="find_user_tb">
                    <div class="tb_line">
                        <div>새 비밀번호</div>
                        <div><input type="password" name="member_password" id="member_password" placeholder="비밀번호" /></div>
                    </div>
                    <div class="tb_line">
                        <div>새 비밀번호 확인</div>
                        <div><input type="password" name="member_repassword" id="member_repassword" placeholder="비밀번호 확인" /></div>
                    </div>
                </div>
                <button type="submit" class="submit_bt color_blue" onclick="checkResetPassword()">
                    비밀번호 변경
                </button>
                <div class="line"></div>
                <span class="input_warning" id="warning_member_password">비밀번호를 확인해주세요. </br> ※ 8~12자 영문(대+소),숫자,특수문자혼용 3개 이상 연속x)</span>
                <span class="input_warning" id="warning_member_password_value">입력값들을 확인해주세요.</span>
            </div>
        </div>
    </div>
</form>
<script>
    $("#fid").click(function () {
        $(".input_warning").css("display", "none");
        $("#fpw").removeClass("b_active");
        $("#fid").addClass("b_active");
        $("#find_action").text("아이디 찾기");
        $("#fpw_id").css("display", "none");
        $('#type_value').val('id');
    });

    $("#fpw").click(function () {
        $(".input_warning").css("display", "none");
        $("#fid").removeClass("b_active");
        $("#fpw ").addClass("b_active");
        $("#find_action").text("비밀번호 찾기");
        $("#fpw_id").css("display", "table-row")
        $('#type_value').val('pass');
    });

    async function chkFindAction(){
      $(".input_warning").css("display", "none");

      var type = $('#type_value').val();
      var objForm = document.findForm;
      var checkCount = 0;

      //이름 유효성검사
      if(REG_name.test(objForm.member_name.value))
        checkCount++;
      //private key null check
      if(!checkNull(objForm.member_key_input.value))
        checkCount++;
      if(type == "pass") {
        if (REG_member_id.test(objForm.member_id.value))
          checkCount++;
      }
      if(type == "pass" && checkCount == 3){
        var result = await checkFindValue(objForm);
        console.log("=============" + result);
        if(result == $('#member_id').val()){
          $(".main_login").css("display", "none");
          $(".find_success_repass").css("display", "block");
        }
      }
      else if(type == "id" && checkCount == 2){
        var result = await checkFindValue(objForm);
        console.log(result);
        if(result){
         $(".main_login").css("display", "none");
         $(".find_success_id").css("display", "block");
         $('#find_success_id_value').text(result);
        }

        console.log("=============" + result);


      }
      else
        $("#warning_find_value").css("display", "inline");
    }


    async function checkFindValue(objForm){
      try{
        var restore = new ethers.Wallet(objForm.member_key_input.value);
        var type = $('#type_value').val();
        var result = "";
        if(restore){
          var params = {};
          params.member_key = restore.address;
          params.member_name = objForm.member_name.value;
          if(type == "pass") {
            params.member_id = objForm.member_id.value;
          }
          await $.ajax({
            url: '/member/find',
            type: "GET",
            data: params,
            async: true,
            contentType: false,
            success: function (res) {
              var joFunc = JSON.parse(res);
              if(joFunc['result']== "ok"){
                result = joFunc['id'];
              }
              else {
                $("#warning_chek_value").css("display", "inline");
              }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
              console.log("통신 실패.")

            }
          });

        }
        return result;

      }catch (error){
        console.log(error);
        $("#warning_find_value").css("display", "inline");
        return;

      }
    }


    function checkResetPassword(){

      $(".input_warning").css("display", "none");
      //## 비밀번호 체크
      var objForm = document.findForm;
      var pw = objForm.member_password.value;
      var pw_passed = true;
      var pattern1 = /[0-9]/; // 숫자
      var pattern2 = /[a-z]/; // 영문 소문자
      var pattern3 = /[A-Z]/; // 영문 대문자
      var pattern4 = /[~!@#$%^*]/; // 원하는 특수문자 추가 제거
      // Begin 동일문자 연속 3회 체크
      var SamePass_0 = 0; //동일문자 카운트
      var SamePass_1 = 0; //연속성(+) 카운드
      var SamePass_2 = 0; //연속성(-) 카운드
      var pw_passed = true; //동일연속성

      // End 동일문자 연속 3회 체크
      // End 영문 소문자, 대문자, 숫자, 특수문자(~!@#$%^*)를 포함하여 8자리 이상 20자리
      for (var i = 0; i < pw.length; i++) {
        var chr_pass_0;
        var chr_pass_1;
        var chr_pass_2;
        if (i >= 2) {
          chr_pass_0 = pw.charCodeAt(i - 2);
          chr_pass_1 = pw.charCodeAt(i - 1);
          chr_pass_2 = pw.charCodeAt(i);
          //동일문자 카운트
          if ((chr_pass_0 == chr_pass_1) && (chr_pass_1 == chr_pass_2)) {
            SamePass_0++;
          } else {
            SamePass_0 = 0;
          }
          //연속성(+) 카운트
          if (chr_pass_0 - chr_pass_1 == 1 && chr_pass_1 - chr_pass_2 == 1) {
            SamePass_1++;
          } else {
            SamePass_1 = 0;
          }
          //연속성(-) 카운트
          if (chr_pass_0 - chr_pass_1 == -1 && chr_pass_1 - chr_pass_2 == -1) {
            SamePass_2++;
          } else {
            SamePass_2 = 0;
          }
        }
        if (SamePass_0 > 0)
          pw_passed = false;

        if (SamePass_1 > 0 || SamePass_2 > 0)
          pw_passed = false;

      }

      if (checkNull(objForm.member_password.value)
        || !pattern1.test(pw)
        || !pattern2.test(pw)
        || !pattern3.test(pw)
        || !pattern4.test(pw)
        || (pw.length < 8 || pw.length > 20)
        || !pw_passed
        || checkNull(objForm.member_repassword.value)
        || objForm.member_password.value != objForm.member_repassword.value){
        $("#warning_member_password").show();
        return;
      }
      else{
        //여기서부터진행한다.
        //private-key 잘 변환해서 form에 넣어 보내준다.
        try{
          var restore = new ethers.Wallet(objForm.member_key_input.value);
          var requestForm = new FormData(document.getElementById('findForm'));
          requestForm.append('member_key', restore.address);

          $.ajax({
            url: '/member-repass',
            type: "POST",
            data: requestForm,
            dataType: 'text',
            async: true,
            processData: false,
            contentType: false,
            success: function (res) {
              var joFunc = JSON.parse(res);
              if(joFunc['result']== "ok"){
                alert("비밀번호 변경이 완료되었습니다.");
                location.href="/login"

              }
              else {
                alert("실패하셨습니다.");

              }

            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
              console.log("통신 실패.")

            }
          });


        }catch (error){
          console.log(error);
          return;

        }
      }
    }
</script>
</body>
</html>