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
            <form name="boardEditForm" id="boardEditForm" method="post" onsubmit="return false;">
                <div class="pro_register_txt">게시판 수정</div>
                <div class="register_content">
                    <input type="text" name="board_title" id="board_title" placeholder="title" value="${boardDetail.board_title}" maxlength="26" />
                </div>
                <span class="input_warning" id="warning_board_title">제목을 입력해주세요.</span>
                <div class="reg_line"></div>
                <textarea class="reg_box" name="board_content" id="board_content" placeholder="===content">${boardDetail.board_content}</textarea>
                <span id="board_cnt" style="font-size: 12px; float: right"></span>
                <span class="input_warning" id="warning_board_content">내용을 입력해주세요.</span>
                <div class="reg_confirm">
                    <div class="confirm_bt" onclick="javascript:history.back()">취소</div>
                    <div class="confirm_bt color_blue" onclick="chkBoardEditForm('${boardDetail.board_idx}')">수정하기</div>
                </div>
            </form>
        </div>
    </div>
</div>
<script>
  $(function () {
    $('#board_cnt').text("("+ $("#board_content").val().length +" / 300000)")

    $('#board_content').on('keyup', function() {
      console.log($(this).val().length);
      $('#board_cnt').html("("+$(this).val().length+" / 300000)");

      if($(this).val().length > 300000) {
        $(this).val($(this).val().substring(0, 300000));
        $('#board_cnt').html("(300000 / 300000)");
      }
    });
  });


  function chkBoardEditForm(board_idx){
    $(".input_warning").css("display", "none");
    var objForm = document.boardEditForm;
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
        url: '/board/' + board_idx,
        type: "PATCH",
        data: new FormData(document.getElementById('boardEditForm')),
        dataType: 'text',
        async: true,
        processData: false,
        contentType: false,
        success: function (res) {
          var joFunc = JSON.parse(res);
          console.log(joFunc);
          if(joFunc['result']== "ok"){
            alert("게시글수정이 완료되었습니다.");
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