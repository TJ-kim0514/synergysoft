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

import com.synergysoft.bonvoyage.common.Paging;
import com.synergysoft.bonvoyage.guide.model.dto.Guide;
import com.synergysoft.bonvoyage.guide.model.service.GuideService;
import com.synergysoft.bonvoyage.member.model.dto.Member;
import com.synergysoft.bonvoyage.notice.model.dto.Notice;


@Controller
public class GuideController {
	private static final Logger logger = LoggerFactory.getLogger(GuideController.class);
	
	@Autowired
	private GuideService guideService;
	
	
	
	//가이드 게시판 페이징 처리
	@RequestMapping("sagBlog.do")
	public String guideListMethod(Model model,
			@RequestParam(name="page", required=false) String page,
			@RequestParam(name="limit", required=false) String slimit,
			@RequestParam(name="groupLimit", required=false) String glimit
			) {
		
		//paging 기본세팅-----------------------------------------------------------------------
		// 출력할 페이지(기본값 1페이지)
		int currentPage=1;
		if(page!=null) {
			currentPage = Integer.parseInt(page);
		}
		// 한페이지에 출력할 공지글 갯수 (기본값 10개 세팅)
		int limit =10;
		if(slimit !=null) {
			limit= Integer.parseInt(slimit);
		}
		// 페이징 그룹 갯수 (기본값 5개 세팅)
		int groupLimit =5;
		if(glimit!=null) {
			groupLimit=Integer.parseInt(glimit);
		}
		// 총 목록 갯수 조회
		int listCount = guideService.selectListCount();
		logger.info("블로그 총 갯수 : " +listCount);
		
		// 페이징 처리 값생성
		Paging paging = new Paging(listCount, limit, currentPage, "sagBlog.do", groupLimit);
		paging.calculate();
		//paging 세팅---------------------------------------------------------------------------
	    // 서비스를 목록 조회 요청하고 결과 받기(페이징 처리)
		ArrayList<Guide> list = guideService.selectAllGuide(paging);  // 전체 목록 받기

	    logger.info("list : " + list);
	    if(list != null && list.size() > 0) {
	        model.addAttribute("list", list);
			model.addAttribute("paging",paging);
			model.addAttribute("currentPage",currentPage);
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
		
		//조회수 1증가처리용 
		guideService.likeCount(guidepostId);

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


	// 공지글 수정 요청 처리용 (파일 업로드 기능 제거)
	@RequestMapping(value = "gupdate.do", method = RequestMethod.POST)
	public String guideUpdate(Guide guide, Model model, HttpServletRequest request, 
	        @RequestParam(name = "deleteFlag", required = false) String delFlag) {
	    
	    logger.info("gupdate.do : " + guide); // 전송된 값 확인
	    
	  

	    if (guideService.updateGuide(guide) > 0) { // 공지글 수정 성공 시
	        return "redirect:gdetail.do?guidepostId=" + guide.getGuidepostId();
	    } else {
	        model.addAttribute("message", guide.getGuidepostId() + "번 공지글 수정 실패!");
	        return "common/error";
	    }
	}


	
	//삭제하기

	// 공지글 삭제 요청 처리용
	@RequestMapping("gdelete.do")
	public String guideDelete(
	        @RequestParam("guidepostId") String guidepostId,
	        HttpServletRequest request, Model model) {
	    
	    if (guideService.deleteGuide(guidepostId) > 0) { // 공지글 삭제 성공 시
	        return "redirect:sagBlog.do";  // 목록 페이지로 리다이렉트
	    } else {
	        model.addAttribute("message", guidepostId + "번 공지글 삭제 실패!");
	        return "common/error";  // 에러 페이지로 이동
	    }
	}



	
		

	
	
}
	


