package com.library.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.library.dto.PageInfo;
import com.library.service.ArticleService;
import com.library.vo.Article;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/Articles")
@AllArgsConstructor
public class ArticleController {
    private final ArticleService articleService;
    private PageInfo pageInfo;
    
    public void setPageInfo(Model model) {
    	model.addAttribute("pageTitleCode", pageInfo.getPageTitleCode());
    	model.addAttribute("pagePath", pageInfo.getPagePath());
    }

    @GetMapping
    public String getAllArticles(Model model) {
    	List<Article> articleList = articleService.findAllArticles();
        
    	model.addAttribute("articleList", articleList);
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("21")
    			.pagePath("page/articleList.jsp")
    			.build();
        	
        setPageInfo(model);
    	
        return "layout";
    }

	/*
	 * @GetMapping("/{id}") public String getArticle(@PathVariable("id") int id,
	 * Model model) { Article article = articleService.findById(id);
	 * 
	 * model.addAttribute("article", article); model.addAttribute("pageTitle",
	 * "글 조회"); model.addAttribute("pagePath", "page/articleDetail.jsp");
	 * 
	 * return "layout"; }
	 * 
	 * @PostMapping public String createArticle(Article article, Model model) {
	 * boolean result = articleService.save(article);
	 * 
	 * if (!result) { return "redirect:/"; }
	 * 
	 * return "layout"; }
	 * 
	 * @PutMapping("/{id}") public String updateArticle(@PathVariable("id") int id,
	 * Article article, Model model) { boolean result =
	 * articleService.save(article);
	 * 
	 * if (!result) { return "redirect:/"; }
	 * 
	 * return "layout";
	 * 
	 * }
	 * 
	 * @DeleteMapping("/{id}") public String deleteArticle(@PathVariable("id") int
	 * id, Model model) { boolean result = articleService.deleteById(id);
	 * 
	 * if (!result) { return "redirect:/"; }
	 * 
	 * return "layout"; }
	 */
    
}