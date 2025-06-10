package com.library.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.library.model.PageInfo;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/etc")
@AllArgsConstructor
public class EtcController {
	private PageInfo pageInfo;

	public void setPageInfo(Model model) {
		model.addAttribute("pageTitleCode", pageInfo.getPageTitleCode());
		model.addAttribute("pagePath", pageInfo.getPagePath());
	}

	@GetMapping("/{number}")
	public String showEtcPage(@PathVariable("number") String number, Model model) {
		System.out.println("✅ EtcController - /etc/" + number + " - GET 요청 정상 처리!");

		pageInfo = PageInfo.builder()
				.pageTitleCode(number)
				.pagePath("page/etc-" + number + ".jsp")
				.build();

		setPageInfo(model);

		return "layout";
	}
}
