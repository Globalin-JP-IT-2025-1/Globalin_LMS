package com.library.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.library.dto.PageInfo;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/etc")
@AllArgsConstructor
public class EtcController {
	private PageInfo pageInfo;

	public void setPageInfo(Model model) {
		model.addAttribute("pageTitle", pageInfo.getPageTitle());
		model.addAttribute("pagePath", pageInfo.getPagePath());
	}

	@GetMapping("/{number}")
	public String showEtcPage(@RequestParam(name = "number", required = false) String number, Model model) {
		System.out.println("✅ EtcController - /etc/{number} - GET 요청 정상 처리!");

		pageInfo = PageInfo.builder()
				.pageTitle(getPageTitle(number))
				.pagePath("page/etc-" + number + ".jsp")
				.build();

		setPageInfo(model);

		return "layout";
	}

	private String[] getPageTitle(String number) {
		switch (number) {
		case "11":
			return new String[] { "도서관 소개", "도서관 정보" };
		case "12":
			return new String[] { "도서관 소개", "연혁" };
		case "13":
			return new String[] { "도서관 소개", "도서 현황" };
		case "21":
			return new String[] { "이용안내", "이용시간/휴관일" };
		case "22":
			return new String[] { "이용안내", "회원가입 안내" };
		case "23":
			return new String[] { "이용안내", "도서 대출/반납/예약" };
		case "91":
			return new String[] { "홈페이지 이용안내", "사이트맵" };
		case "92":
			return new String[] { "홈페이지 이용안내", "이용약관" };
		case "93":
			return new String[] { "홈페이지 이용안내", "개인정보처리방침" };
		default:
			return new String[] { "", "" };
		}
	}
	
}
