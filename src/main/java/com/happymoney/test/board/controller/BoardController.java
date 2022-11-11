package com.happymoney.test.board.controller;


import com.happymoney.test.board.dto.BoardDTO;
import com.happymoney.test.board.service.BoardService;
import com.happymoney.test.common.util.PageMaker;
import com.happymoney.test.common.util.StringUtil;
import lombok.extern.log4j.Log4j2;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Locale;

/**
 * 메인 게시판 콘트롤러
 * 작성자 : 정다운
 * 작성일 : 2022-11-07
 */
@RestController
@Log4j2
public class BoardController {

    private final BoardService boardService;

    public BoardController(BoardService boardService) {
        this.boardService = boardService;
    }

    //list
    @GetMapping("/board-list")
    public ModelAndView boardList(
            Locale locale
            , ModelAndView mav
            , PageMaker pageMaker
            , HttpSession session
    ) {
        mav.setViewName("/board/boardList");

        // 로그인체크 추후 aop로변경
        String isLogin = StringUtil.nvl(session.getAttribute("isLogin"),"false");
        if(!isLogin.equals("true")) {
            mav.setViewName("redirect:/login");
        }
        // end login check


        return mav;
    }

    //register
    @GetMapping("/board-register")
    public ModelAndView boardRegister(
            Locale locale
            , ModelAndView mav
            , HttpSession session
    ) {
        mav.setViewName("/board/boardRegister");

        // 로그인체크 추후 aop로변경
        String isLogin = StringUtil.nvl(session.getAttribute("isLogin"),"false");
        if(!isLogin.equals("true")) {
            mav.setViewName("redirect:/login");
        }
        // end login check

        return mav;
    }

    //detail
    @GetMapping("/board-detail/{board_idx}")
    public ModelAndView boardDetail(
            Locale locale
            , ModelAndView mav
            , HttpSession session
            , BoardDTO boardDTO
    ) {
        mav.setViewName("/board/boardDetail");

        // 로그인체크 추후 aop로변경
        String isLogin = StringUtil.nvl(session.getAttribute("isLogin"),"false");
        if(!isLogin.equals("true")) {
            mav.setViewName("redirect:/login");
        }
        // end login check
        BoardDTO boardDetail = boardService.boardDetail(boardDTO);
        if(boardDetail != null) {
            //result check
            //log.debug("========boardDetail : " + boardDetail);
            mav.addObject("boardDetail", boardDetail);
        }

        return mav;

    }

    //edit
    @GetMapping("/board-edit/{board_idx}")
    public ModelAndView boardEdit(
            Locale locale
            , ModelAndView mav
            , HttpSession session
            , BoardDTO boardDTO
    ) {
        mav.setViewName("/board/boardEdit");

        // 로그인체크 추후 aop로변경
        String isLogin = StringUtil.nvl(session.getAttribute("isLogin"),"false");
        if(!isLogin.equals("true")) {
            mav.setViewName("redirect:/login");
        }
        // end login check
        BoardDTO boardDetail = boardService.boardDetail(boardDTO);
        if(boardDetail != null) {
            //result check
            //log.debug("========boardDetail : " + boardDetail);
            mav.addObject("boardDetail", boardDetail);
        }

        return mav;
    }

    //REST
    //list
    @GetMapping("/board")
    public String getBoardList(
            Locale locale
            , ModelAndView mav
            , HttpSession session
            , BoardDTO boardDTO
            , PageMaker pageMaker
    ) {
        StringBuffer strResult = new StringBuffer();
        ObjectMapper mapper = new ObjectMapper();
        //log.debug("========param : " + boardDTO.toString());

        try {
            strResult.append("{\"boardList\":");
            // paging
            boardDTO.setPageStartNum(pageMaker.getPageStart());
            boardDTO.setPageNemPer(pageMaker.getPerPageNum());

            List<BoardDTO> boardList = boardService.boardList(boardDTO);
            // dto to json
            strResult.append(mapper.writeValueAsString(boardList));

            pageMaker.setTotalCount(boardService.boardListCount(boardDTO));
            strResult.append(",\"page\":");
            strResult.append(mapper.writeValueAsString(pageMaker));

            //log.debug("========boardList : " + boardList);
            //log.debug("========boardPage : " + pageMaker);
            //log.debug("=========pageDto : " + pageDTO);

            strResult.append(",\"result\":\"ok\"");
            strResult.append("}");

        } catch(Exception e) {
            //e.printStackTrace();
            log.debug(e.getMessage().toString());

        }

        return strResult.toString();
    }

    //detail
    @GetMapping("/board/{board_idx}")
    public String getBoard(
            Locale locale
            , ModelAndView mav
            , HttpSession session
            , BoardDTO boardDTO
    ) {
        String strResult = "{\"result\":\"fail\"}";

        //PATH variable dto set check
        //log.debug("====== board_idx : " + boardDTO.getBoard_idx());
        BoardDTO boardDetail = boardService.boardDetail(boardDTO);

        if(boardDetail != null) {
            //result check
            //log.debug("========boardDetail : " + boardDetail);
            strResult = "{\"result\":\"ok\"}";
        }

        return strResult;
    }

    //insert
    @PostMapping("/board")
    public String postBoard(
            Locale locale
            , ModelAndView mav
            , HttpSession session
            , BoardDTO boardDTO
    ) {
        String strResult = "{\"result\":\"fail\"}";
        String isLogin = StringUtil.nvl(session.getAttribute("isLogin"),"false");
        if(isLogin.equals("true")) {
            boardDTO.setMember_idx((int)session.getAttribute("member_idx"));
            if(boardService.boardCreateAction(boardDTO) == 1){
                strResult = "{\"result\":\"ok\"}";

            }
        }

        return strResult;
    }


    //update
    @PatchMapping("/board/{board_idx}")
    public String patchBoard(
            Locale locale
            , ModelAndView mav
            , HttpSession session
            , BoardDTO boardDTO
    ) {
        String strResult = "{\"result\":\"fail\"}";
        String isLogin = StringUtil.nvl(session.getAttribute("isLogin"),"false");
        if(isLogin.equals("true")) {
            //본인이 작성한 글이 맞는지 sever-side에서 한번더 체크
            boardDTO.setMember_idx((int)session.getAttribute("member_idx"));
            if(boardService.boardUpdateAction(boardDTO) == 1){
                strResult = "{\"result\":\"ok\"}";

            }
        }

        return strResult;
    }

    //delete
    @DeleteMapping("/board/{board_idx}")
    public String deleteBoard(
            Locale locale
            , ModelAndView mav
            , HttpSession session
            , BoardDTO boardDTO
    ) {
        String strResult = "{\"result\":\"fail\"}";
        String isLogin = StringUtil.nvl(session.getAttribute("isLogin"),"false");
        if(isLogin.equals("true")) {
            //본인이 작성한 글이 맞는지 sever-side에서 한번더 체크
            boardDTO.setMember_idx((int)session.getAttribute("member_idx"));
            if(boardService.boardDeleteAction(boardDTO) == 1){
                strResult = "{\"result\":\"ok\"}";

            }
        }

        return strResult;
    }

}
