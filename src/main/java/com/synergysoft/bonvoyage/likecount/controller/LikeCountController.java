package com.synergysoft.bonvoyage.likecount.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.synergysoft.bonvoyage.likecount.model.dto.LikeCount;
import com.synergysoft.bonvoyage.likecount.model.service.LikeCountService;
import com.synergysoft.bonvoyage.route.controller.RouteController;
import com.synergysoft.bonvoyage.route.model.service.RouteService;

@Controller
public class LikeCountController {
	private static final Logger logger = LoggerFactory.getLogger(RouteController.class);

	@Autowired
	private LikeCountService likeCountService;
	
	@Autowired
	private RouteService routeService; 
	
	// 경로추천게시판 추천수 증가 메소드
	@RequestMapping("rlikecount.do")
	public String routeLikeCount(Model model,
												@RequestParam("postId") String postId,
												@RequestParam("userId") String userId) {
		
		
		
		LikeCount likeCount = new LikeCount();
		likeCount.setPostId(postId);
		likeCount.setUserId(userId);
		
		logger.info("likeCount" + likeCount);
		
		LikeCount chkLikeCount = likeCountService.selectLikeCount(likeCount);
		
		
		if(chkLikeCount == null) {
			likeCountService.insertLikeCount(likeCount);
			routeService.updateRouteLikeCount(postId);
			return "redirect:routedetail.do?no=" + postId;
		}else {
			model.addAttribute("message", "이미 추천한 게시글입니다.");
			return "common/error";
		}
		
		
		
		
	}
}
