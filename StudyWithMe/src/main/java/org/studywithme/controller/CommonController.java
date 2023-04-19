package org.studywithme.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class CommonController {

	@GetMapping("/accessError")
	public String accessDenied(Authentication auth, Model model) {

		log.info("access Denied : " + auth);

		model.addAttribute("msg", "Access Denied");
		return "user/accessError";

	}

	@GetMapping("/login")
	public String loginInput(String error, String logout, Model model) {

		log.info("error: " + error);
		log.info("logout: " + logout);

		if (error != null) {
			model.addAttribute("error", "Login Error Check Your Account");
		}

		if (logout != null) {
			model.addAttribute("logout", "Logout!!");
		}
		return "user/login";
	}

	@GetMapping("/logout")
	public String logoutGET() {

		log.info("custom logout");
		return "redirect:/login";

	}

	@PostMapping("/logout")
	public String logoutPost() {

		log.info("post custom logout");
		return "redirect:/login";
	}

}
