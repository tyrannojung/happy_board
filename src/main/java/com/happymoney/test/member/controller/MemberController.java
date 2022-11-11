package com.happymoney.test.member.controller;

import com.happymoney.test.common.mail.service.MailService;
import com.happymoney.test.common.util.PBKDF2;
import com.happymoney.test.member.dto.MemberDTO;
import com.happymoney.test.member.service.MemberService;
import lombok.extern.log4j.Log4j2;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Locale;

/**
 * 메인 회원 콘트롤러
 * 작성자 : 정다운
 * 작성일 : 2022-11-03
 */
@RestController
@Log4j2
public class MemberController {

    private final MemberService memberservie;

    private final MailService mailService;

    public MemberController(MemberService memberservie, MailService mailService) {
        this.memberservie = memberservie;
        this.mailService = mailService;
    }



    @GetMapping("/login")
    public ModelAndView signin(
        Locale locale
        , ModelAndView mav
    ) {
        mav.setViewName("/member/signIn");
        return mav;
    }

    @GetMapping("/member-join")
    public ModelAndView memberJoin(
            Locale locale
            , ModelAndView mav
    ) {
        mav.setViewName("/member/signUp");
        return mav;
    }

    @GetMapping("/member-find")
    public ModelAndView memberFind(
            Locale locale
            , ModelAndView mav
    ) {
        mav.setViewName("/member/find");
        return mav;
    }

    //EMAIL 주석
//    @GetMapping("/member-email/{type}/{email}")
//    public ModelAndView memberEmail(
//            Locale locale
//            , ModelAndView mav
//            , @PathVariable(name= "type") String type
//            , @PathVariable(name= "email") String email
//    ) {
//        StringBuffer strResult = new StringBuffer();
//        switch(type){
//            case "signup":
//                strResult.append("이메일 주소 ");
//                strResult.append(email);
//                strResult.append(" 으로 회원가입 요청이 성공적으로 완료되었습니다.");
//                break;
//            case "reid":
//                strResult.append("");
//                break;
//            case "repass":
//                strResult.append("");
//                break;
//        }
//        mav.addObject("content", strResult.toString());
//        mav.setViewName("/member/email");
//        return mav;
//    }

    @GetMapping("/member-repass")
    public ModelAndView memberRepass(
            Locale locale
            , ModelAndView mav
    ) {
        mav.setViewName("/member/repass");
        return mav;
    }

    @GetMapping("/member-signout")
    public ModelAndView memberSignOut(
            Locale locale
            , ModelAndView mav
            , HttpSession session
    ) {
        session.invalidate();
        mav.setViewName("redirect:/login");
        return mav;
    }

    // Rest=====================================================================================================
    @PostMapping("/member")
    public String MemberJoinAction(
            MemberDTO memberDTO
            , HttpServletRequest request){
        String strResult = "{\"result\":\"fail\"}";
        System.out.println(memberDTO.toString());
        try{
            memberDTO.setMember_password(PBKDF2.createHash(memberDTO.getMember_password()));

            //email 회원가입key 생성
            //memberDTO.setMember_key(UUID.randomUUID().toString());

            if(memberservie.memberJoinAction(memberDTO) == 1){
                strResult = "{\"result\":\"ok\"}";

                //EAMIL주석
//                String token = memberDTO.getMember_key();
//                String domain = request.getScheme()+"://"+request.getServerPort(); // localhost
//                //String domain = request.getScheme()+"://"+request.getServerName(); // domain
//                String response = domain+"/member-auth/" + token;
//                emailDTO.setFrom("tyrannojung@happymoney.co.kr");
//                emailDTO.setTo(memberDTO.getMember_email());
//                emailDTO.setSubject("happymoney 회원가입을 인증해주세요.");
//                emailDTO.setContent("안녕하세요 해피머니입니다. <br/><br/>아래 링크를 클릭하시면 회원가입이 완료됩니다! <br /><br />" + response);

            }
        } catch (Exception e) {
            //e.printStackTrace();
            log.debug(e.getMessage().toString());
        }
        return strResult;
    }

    @PostMapping("/member-sign-in")
    public String MemberSignAction(
            MemberDTO memberDTO
            , HttpSession session
    ){
        String strResult = "{\"result\":\"fail\"}";
        try {
            MemberDTO memberInfo = memberservie.memberInfo(memberDTO);
            if(memberInfo != null){
                String pass = "";
                String hash = "";
                pass = memberDTO.getMember_password();
                hash = memberInfo.getMember_password();

                if(hash != null && !hash.trim().equals("") && PBKDF2.validatePassword(pass, hash)){
                    session.setAttribute("isLogin", "true");
                    session.setAttribute("member_idx", memberInfo.getMember_idx());
                    session.setAttribute("member_id", memberInfo.getMember_id());
                    session.setAttribute("member_email", memberInfo.getMember_email());
                    session.setAttribute("member_name", memberInfo.getMember_name());
                    strResult = "{\"result\":\"ok\"}";

                }

            }

        } catch(Exception e) {
            //e.printStackTrace();
            log.debug(e.getMessage().toString());

        }

        return strResult;

    }

    @GetMapping("/member/find")
    public String MemberFindCheck(
            MemberDTO memberDTO){

        log.debug(memberDTO.toString());
        StringBuffer strResult = new StringBuffer();
        MemberDTO memberDetail = memberservie.memberFindCheck(memberDTO);
        log.debug(memberDetail);
        if(memberDetail != null){
            strResult.append("{\"id\":" + "\""+ memberDetail.getMember_id() +"\"" + ", \"result\":\"ok\"}");

        }
        else {
            strResult.append("{\"result\":\"fail\"}");

        }
        return strResult.toString();

    }

    @GetMapping("/member/{id}")
    public String MemberExistCompare(
            MemberDTO memberDTO
            , @PathVariable(name= "id") String id
    ){
        //String strResult = "{\"result\":\"FAIL\"}";
        StringBuffer strResult = new StringBuffer();
        strResult.append("{\"type\":");
        //log.debug(id);
        if(id.contains("@")) {
            memberDTO.setMember_email(id);
            strResult.append("\"email\"");
        }
        else {
            memberDTO.setMember_id(id);
            strResult.append("\"id\"");
        }
        strResult.append(", \"result\":");
        if(memberservie.memberExistCompare(memberDTO) > 0){
            //중복확인
            strResult.append("\"fail\"");
        } else {
            // 중복x
            strResult.append("\"ok\"");
        }
        strResult.append("}");
        //log.debug(strResult);
        return strResult.toString();

    }

    @PostMapping("/member-repass")
    public String memberRepass(
            Locale locale
            , MemberDTO memberDTO
            , ModelAndView mav
    ) {
        String strResult = "{\"result\":\"fail\"}";
        log.debug(memberDTO.toString());
        try{
            memberDTO.setMember_password(PBKDF2.createHash(memberDTO.getMember_password()));
            if(memberservie.memberPasswordChangeUpdate(memberDTO) == 1){
                strResult = "{\"result\":\"ok\"}";

            }
        } catch (Exception e) {
            //e.printStackTrace();
            log.debug(e.getMessage().toString());
        }

        return strResult;

    }


}
