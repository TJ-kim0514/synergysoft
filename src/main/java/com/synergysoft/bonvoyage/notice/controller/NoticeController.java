package com.synergysoft.bonvoyage.notice.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.synergysoft.bonvoyage.notice.model.dto.Notice;
import com.synergysoft.bonvoyage.notice.model.service.NoticeService;

@Controller
public class NoticeController {
	// 로그 생성객체 생성
	private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);
	
	@Autowired
	private NoticeService noticeService;
	
	@RequestMapping("sanotice.do")
	public String noticeListMethod(Model model) {
		
	    // 서비스를 목록 조회 요청하고 결과 받기
	    ArrayList<Notice> list = noticeService.selectAllNotice();  // 전체목록 받아오기

	    logger.info("list : " + list);
	    if(list != null && list.size() > 0) {
	        model.addAttribute("list", list);
	        return "notice/noticeListView";  // 뷰의 이름을 반환
	    } else {
	        model.addAttribute("message", "목록 조회 실패!");
	        return "common/error";  // 에러 페이지 뷰의 이름 반환
	    }
	}
	
	// 공지사항 작성페이지 이동
	@RequestMapping("minotice.do")
	public String moveInsertNotice() {	
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
	public String selectDetailNotice(Model model,
			@RequestParam("noticeId") String noticeId 
			) {
		logger.info("noticeId : " + noticeId);
		Notice notice = noticeService.selectDetailNotice(noticeId);
		logger.info("notice : "+notice);
		model.addAttribute("notice",notice);
		return "notice/noticeDetail";
		
	}
}	
