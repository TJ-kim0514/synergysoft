package com.synergysoft.bonvoyage.comment.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.synergysoft.bonvoyage.comment.model.dto.Comment;
import com.synergysoft.bonvoyage.comment.model.service.CommentService;
import com.synergysoft.bonvoyage.route.controller.RouteController;

@Controller
public class CommentController {
	private static final Logger logger = LoggerFactory.getLogger(RouteController.class);
	
	@Autowired
	private CommentService commentService;
	
	// 경로추천게시판 댓글 등록 메소드
	@RequestMapping("routecomment.do")
	public String insertRouteCommentMethod(Comment comment, Model model,
																	@RequestParam("postId") String postId,
																	@RequestParam("userId") String userId,
																	HttpServletRequest request) {
		logger.info("routecomment.do : " + postId);
		
		if(commentService.insertRouteComment(comment) > 0) {
			
			comment.setUserId(userId);
			comment.setPostId(postId);
			
			// 댓글작성 성공시 상세페이지로 이동
			return "redirect:routedetail.do?no=" + postId;
		}else {
			model.addAttribute("message", "댓글 등록실패");
			return "common/error";
		}
		
	}
	
	// 경로추천게시판 댓글 삭제 메소드
	@RequestMapping("rcommentdelete.do")
	public String deleteRouteCommentMethod(Model model,
																	@RequestParam("postId") String routeBoardId,
																	@RequestParam("commentId") String commentId) {
		
		logger.info("commentId : " + commentId);
		logger.info("postId : " + routeBoardId);
		
		
		if(commentService.deleteRouteComment(commentId) > 0) {
			return "redirect:routedetail.do?no=" + routeBoardId;
		}else {
			model.addAttribute("message", "댓글 삭제 실패");
			return "common/error";
		}
	}
	
	@RequestMapping(value="routeCommentEdit.do", method=RequestMethod.POST)
	@ResponseBody
	public String routeCommentUpdateMethod(HttpServletResponse response,
																	@RequestParam("commentId") String commentId,
																	@RequestParam("content") String content) {
		
		try {
			Comment comment = new Comment();
			comment.setCommentId(commentId);
			comment.setContent(content);
			
			commentService.updateRouteComment(comment);
			return "Success";
		} catch (Exception e) {
			return "Error: " + e.getMessage();
		}

	}

	
	
	
	
	
	
	
	
	
	
}
