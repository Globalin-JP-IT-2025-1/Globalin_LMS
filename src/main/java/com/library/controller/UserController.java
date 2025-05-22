package com.library.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.library.model.User;
import com.library.service.UserService;

// 회원 관리
@Controller
@RequestMapping("/user")
public class UserController {
	private final UserService userService;

	public UserController(UserService userService) {
		this.userService = userService;
	}

	// 회원 목록 조회
	@GetMapping("/list")
	public String getUserList(Model model) {
		List<User> userList = userService.getUserList();
		System.out.println("✅ UserController - /userList - GET 요청 정상 처리!");

		model.addAttribute("pageTitle", "User List");
		model.addAttribute("pagePath", "page/userList.jsp");
		model.addAttribute("userList", userList);

		return "layout";
	}

	// 회원 정보 조회
	@GetMapping("/{id}")
	public String getUserInfo(@PathVariable("id") int id, Model model) {
		User user = userService.getUser(id);
		System.out.println("✅ UserController - /user/{id} - GET 요청 정상 처리!");

		model.addAttribute("pageTitle", "User Info");
		model.addAttribute("pagePath", "page/mypage.jsp");
		model.addAttribute("userList", user);

		return "layout";
	}

	// 회원가입 폼으로 연결
	@GetMapping("/regForm")
	public String goRegForm(Model model) {
		System.out.println("✅ UserController - /user/regForm - GET 요청 정상 처리!");

		model.addAttribute("pageTitle", "User Form");
		model.addAttribute("pagePath", "page/regForm.jsp");

		return "layout";
	}

	// 회원가입 폼으로부터
	@PostMapping("/register")
	public String registerUser(@ModelAttribute User user, Model model) {
		System.out.println("@ModelAttribute : " + user.getName()); // 한글깨짐 확인용1
		
		userService.registerUser(user);
		System.out.println("✅ UserController - /user/register - POST 요청 정상 처리!");

		model.addAttribute("pageTitle", "Login");
		model.addAttribute("pagePath", "page/loginForm.jsp");

		return "layout";

	}

	// 로그인 폼으로 연결
	@GetMapping("/loginForm/{status}")
	public String goLoginForm(@PathVariable("status") int status, Model model) {
		System.out.println("✅ UserController - /user/loginForm - GET 요청 정상 처리!");

		if (status == -1) {
			model.addAttribute("errorMessage", "❌ 로그인 실패! 다시 시도하세요.");
		}

		model.addAttribute("pageTitle", "Login Form");
		model.addAttribute("pagePath", "page/loginForm.jsp");

		return "layout";
	}

	// 로그인 폼으로부터
	@PostMapping("/loginCheck")
	public String checkUser(@RequestParam("userid") String userid, @RequestParam("password") String password,
			Model model) { // jwt 적용시 @RequestBody 사용 예정
		boolean result = userService.checkUserInfo(userid, password);
		System.out.println("✅ UserController - /user/loginCheck - ? 요청 정상 처리!");

		if (!result) {
			return "redirect:/user/loginForm/-1"; // 로그인 실패: 로그인 폼 그대로
		}

		return "redirect:/home?userid=" + userid; // 로그인 성공: 아이디 갖고 홈으로

	}

}
