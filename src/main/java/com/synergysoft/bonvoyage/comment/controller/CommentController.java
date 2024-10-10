package com.synergysoft.bonvoyage.comment.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.synergysoft.bonvoyage.comment.model.dto.Comment;
import com.synergysoft.bonvoyage.comment.model.service.CommentService;
import com.synergysoft.bonvoyage.route.controller.RouteController;

@Controller
public class CommentController {
	private static final Logger logger = LoggerFactory.getLogger(RouteController.class);
	
	@Autowired
	private CommentService commentService;
	
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
	
//	@RequestMapping("commentShow.do")
//	public String routeCommentShowMethod(HttpServletResponse response,
//																@RequestParam("postId") String postId) throws UnsupportedEncodingException {
//		ArrayList<Comment> clist = commentService.selectComment(postId);
//		
//		response.setContentType("application/json; charset=utf-8");
//		
//		JSONArray jarr = new JSONArray();
//		
//		for(Comment comment : clist) {
//			JSONObject job = new JSONObject();
//			
//			job.put("userId", comment.getUserId());
//			job.put("content", URLEncoder.encode(comment.getContent(), "utf-8"));
//			job.put("createdAt", comment.getCreatedAt());
//			
//			jarr.add(job);
//		}
//		
//		JSONObject sendJson = new JSONObject();
//		sendJson.put("clist", jarr);
//		
//		return sendJson.toJSONString();
//	}
	
	
	
	
	
	
	
	
	
	
}
