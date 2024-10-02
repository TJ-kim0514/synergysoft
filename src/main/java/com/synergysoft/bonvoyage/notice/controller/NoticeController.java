package com.synergysoft.bonvoyage.notice.controller;


import java.util.ArrayList;


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
import com.synergysoft.bonvoyage.member.model.dto.Member;
import com.synergysoft.bonvoyage.notice.model.dto.Notice;
import com.synergysoft.bonvoyage.notice.model.service.NoticeService;

@Controller
public class NoticeController {
	// 로그 생성객체 생성 
	private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);
	
	@Autowired
	private NoticeService noticeService;
	
	@RequestMapping("sanotice.do")
	public String noticeListMethod(Model model,
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
		int listCount = noticeService.selectListCount();
		logger.info("공지사항 총 갯수 : " +listCount);
		
		// 페이징 처리 값생성
		Paging paging = new Paging(listCount, limit, currentPage, "sanotice.do", groupLimit);
		paging.calculate();
		//paging 세팅---------------------------------------------------------------------------
	    // 서비스를 목록 조회 요청하고 결과 받기(페이징 처리)
	    ArrayList<Notice> list = noticeService.selectAllNotice(paging);  // 전체목록 받아오기

	    logger.info("list : " + list);
	    if(list != null && list.size() > 0) {
	        model.addAttribute("list", list);
			model.addAttribute("paging",paging);
			model.addAttribute("currentPage",currentPage);
	        return "notice/noticeListView";  // 뷰의 이름을 반환
	    } else {
	        model.addAttribute("message", "목록 조회 실패!");
	        return "common/error";  // 에러 페이지 뷰의 이름 반환
	    }
	}
	
	// 공지사항 작성페이지 이동
	@RequestMapping("minotice.do")
	public String moveInsertNotice(
			) {
		return "notice/insertNoticeView";
	}
	
	// 공지사항 등록
	@RequestMapping(value="inotice.do", method=RequestMethod.POST)
	public String insertNotice(Notice notice, Model model
			
			) {
		logger.info("ninsert.do : " + notice);

		if(noticeService.insertNotice(notice)>0) {
			// 새 공지글 등록 성공시 목록 페이지 내보내기 요청
			return "redirect:sanotice.do";  // 현재 있는 클래스의 메소드 실행 : redirect:url명
		} else {
			model.addAttribute("message","새 공지글 등록 실패");
			return "common/error";
		}
	}
	
	// 공지사항 상세보기
	@RequestMapping("msnotice.do")
	public ModelAndView selectDetailNotice(ModelAndView mv,  	// view 데이터 전송객체
			@RequestParam("noticeId") String noticeId,			// 검색할 공지글 id불러오기
			HttpSession session									// 관리자 여부 확인용 객체
			) {
		logger.info("상세보기 noticeId : " + noticeId);
		Notice notice = noticeService.selectDetailNotice(noticeId);
		logger.info("상세보기 notice : "+notice);
		if(notice != null) {
			mv.addObject("notice", notice);
			Member loginUser = (Member)session.getAttribute("loginUser");
			if(loginUser != null && loginUser.getMemType().equals("ADMIN")) {
				mv.setViewName("notice/noticeAdminDetailView");
			} else {
				mv.setViewName("notice/noticeUserDetailView");
			}
			
		} else {
			mv.addObject("message", noticeId +"번 공지글 상세보기 요청 실패");
			mv.setViewName("common/error");
		}
		return mv;
	}
	
	// 공지사항 수정페이지 이동
	@RequestMapping("munotice.do")
	public ModelAndView noticeMoveUpdate(
			@RequestParam("noticeId") String noticeId,
			ModelAndView mv
			) {
		Notice notice = noticeService.selectDetailNotice(noticeId);
		
		if(notice!=null) {
			mv.addObject("notice",notice);
			mv.setViewName("notice/noticeUpdateView");
		} else {
			mv.addObject("message",noticeId+ "번 공지글 수정페이지 이동 실패");
			mv.setViewName("common/error");
		}
				
		return mv;
	}
	
	// 공지사항 수정 처리
	@RequestMapping(value="unotice.do", method=RequestMethod.POST)
	public String noticeUpdate(
			Notice notice,
			Model model
			) {
		logger.info("notice : " + notice);
		if(noticeService.updateNotice(notice)>0) {
			return "redirect:sanotice.do";
		}else {
			model.addAttribute("message",notice.getNoticeId()+ "번 공지글 수정에 실패하였습니다.");
			return "common/error";
		}
		
		
		
	}
	
	
	// 공지사항 삭제 처리(수정)
	@RequestMapping("dnotice.do")
	public String noticeDelete(
			Notice notice,
			Model model) {
		logger.info("noticedelete id: "+notice.getNoticeId());
		if(noticeService.deleteNotice(notice)>0) {
			return "redirect:sanotice.do";
		} else {
			model.addAttribute("message",notice.getNoticeId()+"번 공지글 삭제 실패");
			return "common/error";
		}
	}
	
}	
