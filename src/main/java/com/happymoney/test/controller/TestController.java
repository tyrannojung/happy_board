package com.happymoney.test.controller;

import com.happymoney.test.common.mail.dto.EmailDTO;
import com.happymoney.test.common.mail.service.MailService;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

/**
 * 메인 테스트 콘트롤러
 * 작성자 : 정다운
 * 작성일 : 2022-11-02
 */
@Controller
@Log4j2
public class TestController {

    private final MailService mailService;

    public TestController( MailService mailService) {
        this.mailService = mailService;
    }

    @GetMapping("/test")
    public ModelAndView index(
            ModelAndView mav
            , EmailDTO emailDTO
            , HttpServletRequest request) {

        mav.setViewName("/index");
//        try {
//            String domain = request.getScheme() + "://" + request.getServerPort(); // localhost
//            //String domain = request.getScheme()+"://"+request.getServerName(); // domain
//            String response = domain + "/member-auth/" + "12345";
//            emailDTO.setFrom("tyrannojung@happymoney.co.kr");
//            emailDTO.setTo("tyrannojung@naver.com");
//            emailDTO.setSubject("happymoney 회원가입을 인증해주세요.");
//            emailDTO.setContent("안녕하세요 해피머니입니다. <br/><br/>아래 링크를 클릭하시면 회원가입이 완료됩니다! <br /><br />" + response);
//
//            if(!mailService.sendTestMail(emailDTO)){
//                log.debug("등록된 이메일이 없거나 패스워드 재발급요청");
//            }
//            log.debug("잘타나?");
//
//        } catch (Exception e) {
//            //e.printStackTrace();
//            log.debug(e.getMessage().toString());
//        }
        return mav;
    }
}
