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
            <div class="pro_register_txt">게시판 상세</div>
            <span class="reg_price_text">Title</span>
            <div class="register_content">
                <input type="text" placeholder="title" value="${boardDetail.board_title}" disabled/>
            </div>
            <div class="reg_line"></div>
            <span class="reg_price_text">content</span>
            <textarea class="reg_box" placeholder="===content" disabled>${boardDetail.board_content}</textarea>
            <div class="reg_confirm">
                <div class="confirm_bt" onclick="javascript:history.back()">뒤로가기</div>
                <c:if test="${member_idx eq boardDetail.member_idx}">
                    <div class="confirm_bt color_blue" onclick="location.href='/board-edit/${boardDetail.board_idx}'">수정하기</div>
                    <div class="confirm_bt color_blue" onclick="board_delete('${boardDetail.board_idx}')">삭제하기</div>
                </c:if>
            </div>
        </div>
    </div>
</div>
<script>
    function board_delete(board_idx){
      let del_confirm = confirm("정말로 삭제하시겠습니까?");
      if(del_confirm){
        $.ajax({
          url: '/board/' + board_idx,
          type: "DELETE",
          dataType: 'text',
          async: true,
          processData: false,
          contentType: false,
          success: function (res) {
            var joFunc = JSON.parse(res);
            console.log(joFunc);
            if(joFunc['result']== "ok"){
              alert("게시글삭제가 완료되었습니다.");
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