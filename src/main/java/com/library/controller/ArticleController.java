package com.library.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.library.model.Article;
import com.library.service.ArticleService;

@Controller
@RequestMapping("/Articles")
public class ArticleController {

    private final ArticleService articleService;

    public ArticleController(ArticleService articleService) {
        this.articleService = articleService;
    }

    @GetMapping
    public String getAllArticles(Model model) {
    	List<Article> articleList = articleService.findAllArticles();
        
    	model.addAttribute("articleList", articleList);
    	model.addAttribute("pageTitle", "글 목록 조회");
    	model.addAttribute("pagePath", "page/articleList.jsp");
    	
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
