package org.studywithme.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.studywithme.domain.UserVO;
import org.studywithme.service.AuthMailSendService;
import org.studywithme.service.UserService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class UserController {
	
	@Autowired
	private UserService service;
	@Autowired
	private AuthMailSendService mailService;

	
	//회원가입 폼으로 이동
	@GetMapping("/join")
	public String join() {
		return "user/joinForm";			
	}
	

    @GetMapping("/checkIdDuplicate")
    @ResponseBody
    public boolean checkIdDuplicate(@RequestParam("userId") String userId) {
		log.info("아이디 중복 확인 버튼 클릭");
		boolean isDuplicate = service.isUserIdDuplicate(userId);
		if(isDuplicate) {
			log.info("아이디 중복 조회 결과: 중복 아이디 있음");
		} else {
			log.info("아이디 중복 조회 결과: 중복 아이디 없음");
		}

        return isDuplicate;
    }
	
	
	//이메일 인증 버튼 확인
	@GetMapping("/mailCheck")
	@ResponseBody
	public String mailCheck(String email) {
		log.info("이메일 인증 요청이 들어옴!");
		log.info("이메일 인증 이메일 : " + email);
		return mailService.sendJoinMail(email);
	}
	
    @PostMapping("/join")
    public String join(UserVO userVO) {
    	//검증이 필요한 경우 아래에 구현
    	
    	//성공
    	try {
			service.registerWithPwEncoding(userVO);
			log.info("회원가입 성공!!");
			return "redirect:/sample/all";
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/sample/all";
		}
    }
    
   
	

}
