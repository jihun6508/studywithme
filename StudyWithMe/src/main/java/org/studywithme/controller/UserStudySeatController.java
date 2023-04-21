package org.studywithme.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.studywithme.domain.UserVO;
import org.studywithme.exception.SeatNotAvailableException;
import org.studywithme.service.StudyseatService;
import org.studywithme.util.UserUtil;
import org.studywithme.util.changetime;

import lombok.extern.log4j.Log4j;

@Controller
public class UserStudySeatController {
	@Autowired
	private StudyseatService service;

	@Autowired
	private UserUtil util;
	
	@Autowired
	HttpSession session;
	
	@GetMapping("/userstudyseat")
	public String UserStudyseat(Model model) {

		UserVO vo = new UserUtil().getUserDetails();
		changetime changer = new changetime();
		String remainingSeatTime = changer.time_longtoString(vo.getRemainingSeatTime());
		
		int cafeno = (int) session.getAttribute("cafeNum");
		model.addAttribute("map", service.myuseseat(vo.getUserId()));
		model.addAttribute("cafeno", cafeno);
		model.addAttribute("lists", service.useseat(cafeno));
		model.addAttribute("name", vo.getUserName());
		model.addAttribute("id", vo.getUserId());
		model.addAttribute("time", remainingSeatTime);
		model.addAttribute("long_time", vo.getRemainingSeatTime());
		
		//branch부분을 메인에서 넘어온 카페이름으로 바꿔야함. 당연히 view 폴더 이름도 같음.
		String cafe_name = "studycafe/";
		String branch = "chosim_Gangnam_Dogok/";
		String category = "userstudyseat";
		return cafe_name+branch+category;
	}

	@PostMapping("/userstudyseat/reservation")
	public ResponseEntity<String> reservation(@RequestParam("num_using") int num_using, @RequestParam("cafe_no") int cafe_no) {
		UserVO vo = new UserUtil().getUserDetails();
		
		try {
			try {
				service.insertseat(cafe_no, num_using, vo.getUserId());
				return ResponseEntity.ok("Reservation Successful");
			}catch (SeatNotAvailableException e) {
				return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Reservation Failed");
			
			}
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Reservation Failed");
		}
	}
	
	@PostMapping("/userstudyseat/return")
	public ResponseEntity<String> returnseat(@RequestParam("user_id") String user_id) {
		try {
			service.returnseat(user_id);
			return ResponseEntity.ok("Returnseat Successful");
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Returnseat Failed");
		}finally {
			util.refreshUserDetails(user_id);
		}
	}
}
