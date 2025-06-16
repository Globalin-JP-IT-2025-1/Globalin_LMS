package com.library.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.library.model.PageInfo;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/public/etc")
@AllArgsConstructor
public class EtcController {
	private PageInfo pageInfo;

	public void setPageInfo(Model model) {
		model.addAttribute("pageTitleCode", pageInfo.getPageTitleCode());
		model.addAttribute("pagePath", pageInfo.getPagePath());
	}

	@GetMapping("/{number}")
	public String showEtcPage(@PathVariable("number") String number, HttpServletRequest request, Model model) {
    	log.info("### {} - {} - {} 요청 매핑 정상 처리!", 
				this.getClass().getSimpleName(), 
				request.getRequestURI(),
				request.getMethod());

		pageInfo = PageInfo.builder()
				.pageTitleCode(number)
				.pagePath("page/8-etc/etc-" + number + ".jsp")
				.build();

		setPageInfo(model);

		return "layout";
	}
}
