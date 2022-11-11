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
        <div class="user_manager">
            <div class="main_pan user_set">
                <div class="user_set_txt">해피머니 게시판</div>
                <div class="user_table">
                    <div class="user_w50_over">
                        <div class="tb_option tb_option_w50">
                            <div class="tb_txt">조회기간</div>
                            <div class="tb_day">
                                <input type="text" class="Date tb_dayck start_date" name="search_start_date" id="1" readonly/>
                                <img src="../img/calendar.png" alt="달력" class="calendar pointer" onclick="clickCal('start')" />
                                <span>~</span>
                                <input type="text" class="Date tb_dayck2 end_date"  name="search_end_date" id="2" readonly/>
                                <img src="../img/calendar.png" alt="달력" class="calendar pointer" onclick="clickCal('end')" />
                            </div>
                        </div>
                        <div class="tb_option tb_option_w50">
                            <div class="tb_txt">
                                <div class="tb_input">
                                    <select
                                            name="회원구분"
                                            id = "search_subject"
                                            style="
                          width: 170px;
                          background-color: #f0f0f0;
                          font-size: 14px;
                          font-weight: 600;
                        "
                                    >
                                        <option value="subject">제목</option>
                                        <option value="content">내용</option>
                                        <option value="id">아이디</option>
                                        <option value="name">이름</option>
                                    </select>
                                </div>
                            </div>
                            <div class="tb_input">
                                <input
                                        type="text"
                                        name="name"
                                        id="search_content"
                                        placeholder="검색할 내용을 입력하세요."
                                />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="search_bt">
                    <input type="hidden" id="search_data" />
                    <div class="search_txt s_bt_search" onclick="board_search()">검색</div>
                    <div class="search_txt s_bt_reset" onclick="board_search_reset()">초기화</div>
                </div>
            </div>

            <div class="main_pan user_info" style=" height: 624px;">
                <table cellspacing="0">
                    <thead>
                    <tr>
                        <th width="10%">No</th>
                        <th width="50%">제목</th>
                        <th width="20%">등록자</th>
                        <th width="20%">등록일시</th>
                    </tr>
                    </thead>
                    <tbody id="board_list">

                    </tbody>
                </table>
                <div class="line"></div>
                <div class="button_box">
                    <span class="page_button">
                        <a href="/board-register">등록</a>
                    </span>
                </div>
                <%@include file="../include/paging.jsp"%>
                <div class="hide_bot_100"></div>
            </div>
        </div>
    </div>
</div>
<script>
  $(function () {
    $(".Date").datepicker({});
    //처음시작
    getBoardList(1,"");

  });

  //페이지 이동 함수
  function pageMove(num){
    var search_data = "";
    if($('#search_data').val())
      search_data = JSON.parse(unescape($('#search_data').val()));

    getBoardList(num, search_data);

  }

  function getBoardList(page, search){
    $('#board_list').empty();
    $('#paging_inner').empty();


    var url = '/board';
    var params = {};
    params.page = page;

    if(search){
      console.log(search);
      Object.assign(params, search);
      console.log(params)
    }

    $.ajax({
      url: url,
      type: "GET",
      async: true,
      data: params,
      contentType: false,
      success: function (res) {
        var joFunc = JSON.parse(res);
        if(joFunc['result']== "ok"){
          $.each(joFunc.boardList, function(key, value){
            // 게시물
            $('#board_list').append(
              '<tr style="cursor: pointer" onclick="location.href=\'board-detail/'+ value.board_idx +'\'">'
              +'<td>'
              + value.board_idx
              + '</td>'
              + '<td>'
              + value.board_title
              + '</td>'
              + '<td>'
              + value.memberDTO.member_id + '(' + value.memberDTO.member_name + ')'
              + '</td>'
              + '<td>'
              + value.board_rdate
              + '</td>'
              + '</tr>'
            )
          });
          //==========Paging start==============
            var page_ui = "";
            if(joFunc.page.prev){
              page_ui += '<div class="page_box pointer" onclick="pageMove('+ (joFunc.page.startPage-1) +')">&lt;</div>';
            }
            for(var i = joFunc.page.startPage; i < joFunc.page.endPage + 1; i++){
              if(joFunc.page.page == i)
                page_ui += '<div class="page_box page_box_ck">'+ i +'</div>';
              else
                page_ui += '<div class="page_box pointer" onclick="pageMove('+ i +')">'+ i +'</div>';
            }
            if(joFunc.page.next && joFunc.page.endPage > 0){
              page_ui += '<div class="page_box pointer" onclick="pageMove('+ (joFunc.page.endPage+1) +')">&gt;</div>';
            }
            $('#paging_inner').append(page_ui);
          //==========Paging end==============

          // // 게시물이 없을때.
          // 없을때 검증하면서 추가한다.
          // $("#board_list_none").show();
          // if(joFunc.boardList.length == 0){
          //   console.log('게시물없음')
          //   $('#board_list').append(
          //     '<tr><td>게시물이0</td></tr>'
          //   )
          // }

        }
      },
      error: function (XMLHttpRequest, textStatus, errorThrown) {
        console.log("통신 실패.")

      }
    });
  }

  function board_search() {
    console.log('서치');
    var start_date = $('.start_date').val();
    var end_date = $('.end_date').val();
    var search_subject = $('#search_subject').val();
    var search_content = $('#search_content').val();
    console.log(start_date + ", " + end_date + "," + search_subject + "," + search_content);
    if(!(start_date && end_date) && !search_content){
      alert('날짜 또는 검색어를 입력해주세요.');
      return;

    }
    var sdate = start_date;
    var edate = end_date;
    var sdt = new Date(sdate);
    var edt = new Date(edate);
    var dateDiff = Math.ceil((edt.getTime()-sdt.getTime())/(1000*3600*24));

    if(dateDiff < 0) {
      alert('날짜를 재설정해주세요.');
      return;

    }
    var params = {};

    if(search_subject)
      params["boardSearchDTO.search_subject"] = search_subject;
    if(search_content)
      params["boardSearchDTO.search_content"] = search_content;
    if(start_date)
        params["boardSearchDTO.search_start_date"] = start_date;
    if(end_date)
        params["boardSearchDTO.search_end_date"] = end_date;


    //param을 추가한다.
    $('#search_data').val(escape(JSON.stringify(params)));
    getBoardList(1, params);
  }

  function board_search_reset() {
    console.log('reset');
    $('.start_date').val("");
    $('.end_date').val("");
    $('#search_subject').val("subject").prop("selected", true);
    $('#search_content').val("");
    //기본초기화
    getBoardList(1,"");

  }

  function clickCal(type){
    if(type == "start")
      $('.start_date').focus();
    else
      $('.end_date').focus();

  }

</script>
</body>
</html>