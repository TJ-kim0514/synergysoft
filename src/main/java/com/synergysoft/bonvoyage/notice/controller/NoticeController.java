package com.synergysoft.bonvoyage.notice.controller;


import java.io.File;
import java.io.IOException;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.synergysoft.bonvoyage.common.FileNameChange;
import com.synergysoft.bonvoyage.common.Paging;
import com.synergysoft.bonvoyage.common.Search;
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
	public String selectAllNotice(Model model,
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
	public String insertNotice(Notice notice, Model model,
			HttpServletRequest request,
			@RequestParam(name="insertFile1", required=false) MultipartFile ifile1,
			@RequestParam(name="insertFile2", required=false) MultipartFile ifile2,
			@RequestParam(name="insertFile3", required=false) MultipartFile ifile3
			) {
		logger.info("ninsert.do : " + notice);
		
		// 파일 저장 경로 생성
		String savePath = request.getSession().getServletContext().getRealPath("resources/notice_upfiles");

		//첨부파일 저장
		//파일1
		if(!ifile1.isEmpty()) {
			
			String fileName = ifile1.getOriginalFilename();
			String renameFileName = null;
			
			if(fileName != null && fileName.length() >0) {
				renameFileName = FileNameChange.change(fileName, "yyyyMMddHHmmssSSS");
				logger.info("변경될 첨부파일명 확인 : " + renameFileName);
				
				try {
					ifile1.transferTo(new File(savePath + "\\" + renameFileName));
				} catch (Exception e) {
					e.printStackTrace();
					model.addAttribute("message",fileName +" 첨부파일 저장 실패 ");
					return "common/error";
				} 
			}
			// db저장용 파일명 set
			notice.setoFile1(fileName);
			notice.setrFile1(renameFileName);
		}
		
		//파일2
		if(!ifile2.isEmpty()) {
			
			String fileName = ifile2.getOriginalFilename();
			String renameFileName = null;
			
			if(fileName != null && fileName.length() >0) {
				renameFileName = FileNameChange.change(fileName, "yyyyMMddHHmmssSSS");
				logger.info("변경될 첨부파일명 확인 : " + renameFileName);
				
				try {
					ifile2.transferTo(new File(savePath + "\\" + renameFileName));
				} catch (Exception e) {
					e.printStackTrace();
					model.addAttribute("message",fileName +" 첨부파일 저장 실패 ");
					return "common/error";
				} 
			}
			// db저장용 파일명 set
			notice.setoFile2(fileName);
			notice.setrFile2(renameFileName);
		}	
		
		//파일3
		if(!ifile3.isEmpty()) {
			
			String fileName = ifile3.getOriginalFilename();
			String renameFileName = null;
			
			if(fileName != null && fileName.length() >0) {
				renameFileName = FileNameChange.change(fileName, "yyyyMMddHHmmssSSS");
				logger.info("변경될 첨부파일명 확인 : " + renameFileName);
				
				try {
					ifile3.transferTo(new File(savePath + "\\" + renameFileName));
				} catch (Exception e) {
					e.printStackTrace();
					model.addAttribute("message",fileName +" 첨부파일 저장 실패 ");
					return "common/error";
				} 
			}
			// db저장용 파일명 set
			notice.setoFile3(fileName);
			notice.setrFile3(renameFileName);
		}		
		
		
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
	
	// 공지사항 검색 처리(제목/내용)
	@RequestMapping("ssnotice.do")
	public String selectSearchTitleNotice(Model model,
			@RequestParam("action") String action,  // 검색 유형 (제목,내용)
			@RequestParam("keyword") String keyword,  // 검색키워드값			
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
		
		int listCount = 0;
		// 총 목록 갯수 조회
	    if(action.equals("title")) {
	    	listCount = noticeService.selectSearchTitleListCount(keyword);
	    } else if(action.equals("content")) {
	    	listCount = noticeService.selectSearchContentListCount(keyword);
	    }
		
		logger.info("공지사항 총 갯수 : " +listCount);
		
		// 페이징 처리 값생성
		Paging paging = new Paging(listCount, limit, currentPage, "ssnotice.do", groupLimit);
		paging.calculate();
		//paging 세팅---------------------------------------------------------------------------
	    
	    // 검색시 사용할 값 전송 객체생성 및 값 입력
	    Search search = new Search();
	    search.setKeyword(keyword);
	    search.setStartRow(paging.getStartRow());
	    search.setEndRow(paging.getEndRow());
	    ArrayList<Notice> list =null;
	    
	    // 서비스를 목록 조회 요청하고 결과 받기(페이징 처리)
	    if(action.equals("title")) {
	    	list = noticeService.selectSearchTitleNotice(search);
	    } else if(action.equals("content")) {
	    	list = noticeService.selectSearchContentNotice(search);
	    }
	    
	    
	    logger.info("list : " + list);
	    if(list != null && list.size() > 0) {
	        model.addAttribute("list", list);
			model.addAttribute("paging",paging);
			model.addAttribute("currentPage",currentPage);
			model.addAttribute("action",action);
			model.addAttribute("keyword",keyword);
			
	        return "notice/noticeListView";  // 뷰의 이름을 반환
	    } else {
	        model.addAttribute("message", action + "에 대한 " + keyword + "검색결과가 존재하지 않습니다.");
	        return "common/error";  // 에러 페이지 뷰의 이름 반환
	    }
	}
	
	
}	
