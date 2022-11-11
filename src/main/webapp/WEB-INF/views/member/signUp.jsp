<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Header -->
    <link rel="stylesheet" href="/css/signUp.css">
    <%@include file="../include/header.jsp" %>
    <script src="/common/js/ethers-v5.min.js"></script>
</head>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Document</title>
    <link rel="stylesheet" href="./css/signup.css"/>
</head>
<body>
<div class="wrap">
    <div class="main">
        <div id="signup_view">
            <div class="logo" onclick="location.href='/login'"></div>
            <div class="join_box">
                <!--  -->
                <div class="box_top">
                    <p>회원가입</p>
                    해피머니 게시판을 이용하기 위해서는 회원가입이 필요합니다.
                </div>
                <!--  -->
                <div class="box_bot">
                    <form name="signUpForm" id="signUpForm" method="post" onsubmit="return false;">
                        <input type="hidden" name="member_key" id="member_key" />
                        <div class="join_txt">아이디</div>
                        <input type="text" name="member_id" id="member_id" placeholder="아이디"/>
                        <span class="input_warning"
                              id="warning_member_id">아이디를 확인해주세요. (아이디는 5~20자 영문소문자, 숫자로만 사용 가능합니다.)</span>
                        <span class="input_warning"
                              id="warning_member_id_compare">아이디가 중복되었습니다.</span>
                        <div class="join_txt">Password</div>
                        <div class="wid_50pec">
                            <input type="password" name="member_password" id="member_password" placeholder="비밀번호"/>
                            <input type="password" name="member_repassword" id="member_repassword" placeholder="비밀번호 확인"/>
                        </div>
                        <span class="input_warning" id="warning_member_password">비밀번호를 확인해주세요. </br> ※ 8~12자 영문(대+소),숫자,특수문자혼용 3개 이상 연속x)</span>

                        <div class="join_txt">이메일</div>
                        <input type="text" name="member_email" id="member_email" placeholder="xx@happy.com"/>
                        <span class="input_warning" id="warning_member_email">이메일 형식을 확인해주세요.</span>
                        <span class="input_warning"
                              id="warning_member_email_compare">이메일이 중복되었습니다.</span>
                        <div class="join_txt">이름</div>
                        <input type="text" name="member_name" id="member_name" placeholder="홍길동"/>
                        <span class="input_warning" id="warning_member_name">이름을 확인해주세요.</span>
                        <div class="fin">
                            <button
                                    type="submit"
                                    class="submit_bt color_blue"
                                    onclick="chkSignUpForm()"
                            >
                                회원가입
                            </button>
                            <button class="submit_bt" onclick="location.href='/login'">
                                취소
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <div id="signup_complete_view" style="display: none">
            <div class="find_main" action="#">
                <div class="logo"></div>
                <div class="csignup_box">
                    <span class="csignup_title">Please Save Your Happymoney private key <br/></span>
                    <div class="csignup_subtitle">
                        아래의 해피머니 개인키를 복사하여 안전하게 보관해주세요.
                        </br>해당키를 절대 잃어버리시면 안되며, 잃어버리시면 계정을 복원할 수 없습니다.
                        </br>※해당키는 아이디 비밀번호를 찾을때 사용됩니다.
                    </div>
                    <div class="pass_input">
                        <input type="password" id="member_private_key"/>
                        <div class="eye_icon"></div>
                    </div>
                </div>
                <div class="line"></div>
                <button type="submit" class="submit_find_bt color_blue" onclick="location.href='/login'">
                    홈으로
                </button>
            </div>
        </div>
    </div>
</div>
</body>
<script>
  //회원가입
  async function chkSignUpForm () {
    $(".input_warning").css("display", "none");
    var objForm = document.signUpForm;
    var hostUrl = "/member/"
    var checkCount = 0;
    //## ID 체크
    if (!REG_member_id.test(objForm.member_id.value))
      $("#warning_member_id").css("display", "inline");
    else{
      var id_check = "fail";
      //중복체크
      await $.ajax({
        type: "GET",            // HTTP method type(GET, POST) 형식이다.
        //contentType: 'application/json',
        async: true,
        url: hostUrl + objForm.member_id.value,      // 컨트롤러에서 대기중인 URL 주소이다.
        //data: JSON.stringify(params),            // Json 형식의 데이터이다.
        success: function (res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
          var joFunc = JSON.parse(res);
          id_check = joFunc['result'];
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
          console.log("통신 실패.")
        }
      });
      //중복아닐때 + 해준다.
      if(id_check == "ok"){
        checkCount++;
      } else {
        $("#warning_member_id_compare").css("display", "inline");
      }

    }

    //## 비밀번호 체크
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
      || objForm.member_password.value != objForm.member_repassword.value)
      $("#warning_member_password").show();
    else
      checkCount++;

    if(!CheckEmail(objForm.member_email.value))
      $("#warning_member_email").show();
    else{
      var email_check = "fail";
      //중복체크
      await $.ajax({
        type: "GET",            // HTTP method type(GET, POST) 형식이다.
        //contentType: 'application/json',
        async: true,
        url: hostUrl + objForm.member_email.value,      // 컨트롤러에서 대기중인 URL 주소이다.
        //data: JSON.stringify(params),            // Json 형식의 데이터이다.
        success: function (res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
          var joFunc = JSON.parse(res);
          email_check = joFunc['result'];
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
          console.log("통신 실패.")
        }
      });

      //중복아닐때 + 해준다.
      if(email_check == "ok"){
        checkCount++;
      } else {
        $("#warning_member_email_compare").css("display", "inline");
      }

    }

    if(!REG_name.test(objForm.member_name.value))
      $("#warning_member_name").show();
    else
      checkCount++;

    if(checkCount == 4){
      console.log('회원가입진행');
      //public key 저장
      var randomSeed = ethers.Wallet.createRandom();
      var privateKey = randomSeed.privateKey;

      var address = randomSeed.address;
      $('#member_key').val(address);

      $.ajax({
        url: hostUrl,
        type: "POST",
        data: new FormData(document.getElementById('signUpForm')),
        dataType: 'text',
        async: true,
        processData: false,
        contentType: false,
        success: function (res) {
          var joFunc = JSON.parse(res);
          if(joFunc['result']== "ok"){
            // 개인키 확인
            $("#signup_view").css("display", "none");
            $("#signup_complete_view").css("display", "block");
            $('#member_private_key').val(privateKey);
          }
          else {
            alert("실패하셨습니다.");

          }

        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
          console.log("통신 실패.")

        }
      });

    }

  }


  $('.eye_icon').on('click', function(){
    $(this).toggleClass('eye_on');
    if($('.eye_icon').hasClass('eye_on') == true) {
      $(this).prev('input').attr('type', 'text');
    }
    else {
      $(this).prev('input').attr('type', 'password');
    }
  })
</script>
</html>