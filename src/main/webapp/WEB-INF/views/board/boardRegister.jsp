<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Header -->
    <link rel="stylesheet" href="/css/board.css">
    <%@include file="../include/header.jsp"%>
</head>
<body>
<div class="wrap">
    <%@include file="../include/top.jsp"%>
    <div class="main_right">
        <div class="main_pan pro_register">
            <form name="boardRegisterForm" id="boardRegisterForm" method="post" onsubmit="return false;">
                <div class="pro_register_txt">게시판 등록</div>
                <div class="register_content">
                    <input type="text" name="board_title" id="board_title" placeholder="title" maxlength="26" />
                </div>
                <span class="input_warning" id="warning_board_title">제목을 입력해주세요.</span>
                <div class="reg_line"></div>
                <textarea class="reg_box" name="board_content" id="board_content" placeholder="===content"></textarea>
                <span id="board_cnt" style="font-size: 12px; float: right">(0 / 300000)</span>
                <span class="input_warning" id="warning_board_content">내용을 입력해주세요.</span>
                <div class="reg_confirm">
                    <div class="confirm_bt" onclick="javascript:history.back()">취소</div>
                    <div class="confirm_bt color_blue" onclick="chkBoardRegisterForm()">등록하기</div>
                </div>
            </form>
        </div>
    </div>
</div>
<script>
      $(function () {
        $('#board_content').on('keyup', function() {
          console.log($(this).val().length);
          $('#board_cnt').html("("+$(this).val().length+" / 300000)");

          if($(this).val().length > 300000) {
            $(this).val($(this).val().substring(0, 300000));
            $('#board_cnt').html("(300000 / 300000)");
          }
        });
      });

    function chkBoardRegisterForm(){
      $(".input_warning").css("display", "none");
      var objForm = document.boardRegisterForm;
      var checkCount = 0;

      if(checkNull(objForm.board_title.value) || !(checkLen(objForm.board_title.value) <= 26))
        $("#warning_board_title").css("display", "inline");
      else
        checkCount++;
      if(checkNull(objForm.board_content.value))
        $("#warning_board_content").css("display", "inline");
      else
        checkCount++;

      if(checkCount == 2){
        console.log('통과');
        $.ajax({
          url: '/board',
          type: "POST",
          data: new FormData(document.getElementById('boardRegisterForm')),
          dataType: 'text',
          async: true,
          processData: false,
          contentType: false,
          success: function (res) {
            var joFunc = JSON.parse(res);
            console.log(joFunc);
            if(joFunc['result']== "ok"){
                alert("게시글등록이 완료되었습니다.");
                location.href="/board-list"
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
</script>
</body>
</html>