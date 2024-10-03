package com.synergysoft.bonvoyage.guide.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.synergysoft.bonvoyage.guide.model.dto.Guide;
import com.synergysoft.bonvoyage.guide.model.service.GuideService;
import com.synergysoft.bonvoyage.member.model.dto.Member;


@Controller
public class GuideController {
	private static final Logger logger = LoggerFactory.getLogger(GuideController.class);
	
	@Autowired
	private GuideService guideService;
	
	@RequestMapping("sagBlog.do")
	public String guideListMethod(Model model) {
	    ArrayList<Guide> list = guideService.selectAllGuide();  // 전체 목록 받기

	    logger.info("guide list : " + list);
	    if (list != null && list.size() > 0) {
	        model.addAttribute("guideList", list);  // "guideList"로 이름 변경
	        return "guide/guideListView";  // 뷰의 이름을 반환
	    } else {
	        model.addAttribute("message", "목록 조회 실패!");
	        return "common/error";  // 에러 페이지 뷰의 이름 반환
	    }
	}
	

	//새 블로그 등록 페이지로 이동 처리
	@RequestMapping("gmoveWrite.do")
	public String moveWritePage() {
	    return "guide/guideWriteForm";  // guideWriteForm.jsp로 이동
	}
	
	// 새 공지글 등록 요청 처리용 
	@RequestMapping(value="ginsert.do", method=RequestMethod.POST)
	public String guideInsertMethod(Guide guide, Model model, HttpServletRequest request) {
	    // 세션에서 로그인된 사용자 정보 가져오기
	    HttpSession session = request.getSession();
	    Member loginUser = (Member) session.getAttribute("loginUser");
	    
	    // loginUser가 null이 아닌 경우에 guideUserId를 설정
	    if (loginUser != null) {
	        guide.setGuideUserId(loginUser.getMemId());  // guideUserId에 로그인한 사용자 ID 설정
	    } else {
	        model.addAttribute("message", "로그인 정보가 없습니다.");
	        return "common/error";
	    }
	    
	    logger.info("ginsert.do : " + guide);
	    
	    if (guideService.insertGuide(guide) > 0) {
	        // 블로그 등록 성공시 목록 페이지로 리다이렉트
	        return "redirect:sagBlog.do";
	    } else {
	        model.addAttribute("message", "새 공지글 등록 실패!");
	        return "common/error";
	    }
	}
	
	//블로그 상세내용 보기 요청 처리 메소드(뷰와 모델 함께 가져오는 방법)
	@RequestMapping("gdetail.do")
	public ModelAndView guideDetailMethod(
	        @RequestParam("guidepostId") String guidepostId,
	        ModelAndView mv, HttpSession session) {
		
		
		//회원인지 확인하기 위해 session 매개변수 추가함
		logger.info("gdetail.do : " + guidepostId);

	    // 블로그 데이터를 guidepostId를 이용해 가져옴
	    Guide guide = guideService.selectGuide(guidepostId);

	    if (guide != null) {
	    	//세션에서 로그인한 사람정보 가져오기
	    	Member loginUser = (Member)session.getAttribute("loginUser");
			if(loginUser != null && loginUser.getUserId().equals(guide.getGuideUserId())) {
				mv.setViewName("guide/guideDetail");
	        // 블로그 데이터가 있을 경우 상세보기 페이지로 이동
	        mv.addObject("guide", guide);  // guide 객체를 뷰에 전달
	        mv.setViewName("guide/guideDetail");  // guideDetailView로 이동
	    } else {
	    	// 작성자가 아니면 수정할 수 없는 페이지로 이동
	    	 mv.addObject("guide", guide);
            mv.setViewName("guide/guideDetailView"); 
	    }}
			else {
	        // 블로그 데이터가 없을 경우 에러 페이지로 이동
	        mv.addObject("message", guidepostId + "번 블로그 상세보기 요청 실패!");
	        mv.setViewName("common/error");  // 에러 페이지로 이동
	    }

	    return mv;  // ModelAndView 반환
	}
		
		
		



//공지글 수정 페이지로 이동 처리용
	@RequestMapping("gmoveup.do")
	public ModelAndView moveUpdatePage(
			@RequestParam("guidepostId") String guidepostId, ModelAndView mv) {
		//수정페이지에 출력할 공지글 조회해 봄
		Guide guide = guideService.selectGuide(guidepostId);
		
		if(guide != null) {
			mv.addObject("guide", guide);
			mv.setViewName("guide/guideUpdateView");
		}else {
			mv.addObject("message", guidepostId + "번 공지글 수정페이지로 이동 실패!");
			mv.setViewName("common/error");
		}
		
		return mv;
	}//gmoveUpdatePage() end



	
	//삭제하기
	


	
		

	
	
}
	


