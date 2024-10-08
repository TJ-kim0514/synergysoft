package com.synergysoft.bonvoyage.report.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.synergysoft.bonvoyage.common.Paging;
import com.synergysoft.bonvoyage.common.Search;
import com.synergysoft.bonvoyage.member.model.dto.Member;
import com.synergysoft.bonvoyage.notice.model.dto.Notice;
import com.synergysoft.bonvoyage.report.model.dto.Report;
import com.synergysoft.bonvoyage.report.model.service.ReportService;

@Controller
public class ReportController {

	private static final Logger logger = LoggerFactory.getLogger(ReportController.class);

	@Autowired
	private ReportService reportService;
	// 뷰 페이지 이동 처리 메소드

	// 페이징 처리하기
	@RequestMapping("reP.do")
	public String reportListMethod(Model model, @RequestParam(name = "page", required = false) String page,
			@RequestParam(name = "limit", required = false) String slimit,
			@RequestParam(name = "groupLimit", required = false) String glimit) {

		// paging
		// 기본세팅-----------------------------------------------------------------------
		// 출력할 페이지(기본값 1페이지)
		int currentPage = 1;
		if (page != null) {
			currentPage = Integer.parseInt(page);
		}
		// 한페이지에 출력할 공지글 갯수 (기본값 10개 세팅)
		int limit = 10;
		if (slimit != null) {
			limit = Integer.parseInt(slimit);
		}
		// 페이징 그룹 갯수 (기본값 5개 세팅)
		int groupLimit = 5;
		if (glimit != null) {
			groupLimit = Integer.parseInt(glimit);
		}
		// 총 목록 갯수 조회
		int listCount = reportService.selectReportListCount();
		logger.info("신고글 총 갯수 : " + listCount);

		// 페이징 처리 값생성
		Paging paging = new Paging(listCount, limit, currentPage, "reP.do", groupLimit);
		paging.calculate();
		// paging
		// 세팅---------------------------------------------------------------------------
		// 서비스를 목록 조회 요청하고 결과 받기(페이징 처리)
		ArrayList<Report> list = reportService.selectAllReport(paging); // 전체목록 받아오기

		logger.info("list : " + list);
		if (list != null && list.size() > 0) {
			model.addAttribute("list", list);
			model.addAttribute("paging", paging);
			model.addAttribute("currentPage", currentPage);
			return "admin/report/reportListView"; // 뷰의 이름을 반환
		} else {
			model.addAttribute("message", "목록 조회 실패!");
			return "common/error"; // 에러 페이지 뷰의 이름 반환
		}
	}

	// 새 신고 등록 페이지 이동 처리
	@RequestMapping("reportWrite.do")
	public ModelAndView moveWritePage(ModelAndView mv, HttpSession session) {

		Member loginUser = (Member) session.getAttribute("loginUser");

		if (loginUser != null) {
			mv.setViewName("member/report/reportWriteView");
		} else {
			mv.addObject("message", "세션이 없습니다. 로그인 후 다시 이용해주시기 바랍니다.");
			mv.setViewName("common/error");
		}
		return mv;
	}

	// 요청 처리

	// 신고글 상세 내용 보기 요청 처리
	@RequestMapping("reportDetail.do")
	public ModelAndView reportDetailMethod(@RequestParam("no") String reportId, ModelAndView mv, HttpSession session) {
		// 관리자용 상세보기 페이지와 일반회원 상세보기 페이지를 구분해서 응답 처리

		logger.info("rdetail.do : " + reportId); // 전송받은 값 확인

		Report report = reportService.selectReportDetail(reportId);

		if (report != null) {
			mv.addObject("report", report);

			Member loginUser = (Member) session.getAttribute("loginUser");

			if (loginUser != null && loginUser.getMemType().equals("ADMIN")) {
				mv.setViewName("admin/report/reportDetailView");
			} else {
				if (loginUser != null && loginUser.getMemType().equals("USER")) {
					report.setReportUserId(loginUser.getMemId());
					report.setReportId(reportId);
					report = reportService.selectMyReportDetail(report);
					if (report != null) {
						mv.setViewName("admin/report/reportDetailView");
					} else {
						mv.addObject("message", "잘못된 접근입니다.");
						mv.setViewName("common/error");
					}
				} else {
					mv.addObject("message", "잘못된 접근입니다.");
					mv.setViewName("common/error");
				}
			}
		} else {
			mv.addObject("message", reportId + "번 신고글 상세보기 요청 실패");
			mv.setViewName("common/error");
		}
		return mv;
	} // 신고글 상세정보 보기

	// 신고글 전체 목록 보기 (페이징/검색)
	@RequestMapping("reportList.do")
	public ModelAndView reportListMethod(
//			@RequestParam("action") String action,  // 검색 유형 (제목,내용)
//			@RequestParam("keyword") String keyword,  // 검색키워드값		
			@RequestParam(name = "page", required = false) String page,
			@RequestParam(name = "limit", required = false) String slimit,
			@RequestParam(name = "groupLimit", required = false) String glimit,
			ModelAndView mv, HttpSession session, Model model) {

		// paging
		// 기본세팅-----------------------------------------------------------------------
		// 출력할 페이지(기본값 1페이지)
		int currentPage = 1;
		if (page != null) {
			currentPage = Integer.parseInt(page);
		}

		// 한페이지에 출력할 공지글 갯수 (기본값 10개 세팅)
		int limit = 10;
		if (slimit != null) {
			limit = Integer.parseInt(slimit);
		}
		// 페이징 그룹 갯수 (기본값 5개 세팅)
		int groupLimit = 5;
		if (glimit != null) {
			groupLimit = Integer.parseInt(glimit);
		}
		
		int resultAllCount = reportService.selectReportListCount();
		
		// 총 목록 갯수 조회
//	    if(action.equals("title")) {
//	    	listCount = reportService.selectSearchTitleListCount(keyword);
//	    } else if(action.equals("content")) {
//	    	listCount = reportService.selectSearchContentListCount(keyword);
//	    }
	    
//	    logger.info("신고글 총 갯수 : " +listCount);
	    
	 // 페이징 처리 값생성
 		
 		//paging 세팅---------------------------------------------------------------------------
 	    
 	    // 검색시 사용할 값 전송 객체생성 및 값 입력
 	    
 	    
 	    // 서비스를 목록 조회 요청하고 결과 받기(페이징 처리)
// 	    if(action.equals("title")) {
// 	    	list = reportService.selectSearchTitleReport(search);
// 	    } else if(action.equals("content")) {
// 	    	list = reportService.selectSearchContentReport(search);
// 	    }
	    
		// 서비스롤 목록 조회 요청하고 결과 받기
		Member loginUser = (Member) session.getAttribute("loginUser");

		if (resultAllCount > 0 && loginUser != null
				&& loginUser.getMemType().equals("ADMIN")) {
			int listCount = reportService.selectReportListCount();
			Paging paging = new Paging(listCount, limit, currentPage, "reportList.do", groupLimit);
	 		paging.calculate();
			
	 		Search search = new Search();
//	 	    search.setKeyword(keyword);
	 	    search.setStartRow(paging.getStartRow());
	 	    search.setEndRow(paging.getEndRow());
	 	    ArrayList<Report> list =null;
	 		
	 	   ArrayList<Report> reportList = reportService.selectReport(paging);
	 	    
	 		mv.addObject("list", list);
			mv.addObject("paging",paging);
			mv.addObject("currentPage",currentPage);
//			mv.addObject("action",action);
//			mv.addObject("keyword",keyword);
			mv.addObject("report", reportList);
			mv.setViewName("admin/report/reportListView");

		} else if (resultAllCount > 0 && loginUser != null
				&& loginUser.getMemType().equals("USER")) {
			int listCount = reportService.selectReportListCount();
			Paging paging = new Paging(listCount, limit, currentPage, "reportList.do", groupLimit);
	 		paging.calculate();
			
	 		Search search = new Search();
//	 	    search.setKeyword(keyword);
	 	    search.setStartRow(paging.getStartRow());
	 	    search.setEndRow(paging.getEndRow());
	 	    ArrayList<Report> list =null;
	 		
	 	   ArrayList<Report> reportList = reportService.selectReport(paging);
	 	    
			mv.addObject("list", list);
			mv.addObject("paging",paging);
			mv.addObject("currentPage",currentPage);
//			mv.addObject("action",action);
//			mv.addObject("keyword",keyword);
			mv.addObject("report", reportList);
			mv.setViewName("admin/report/reportListView");
		} else {
//			mv.addObject("message", action + "에 대한 " + keyword + "검색결과가 존재하지 않습니다.");
			mv.setViewName("common/error");
		}

		return mv;

	} // 신고글 전체 목록 보기

	// 신고글 등록 기능
	@RequestMapping("reportInsert.do")
	public ModelAndView reportInsertMethod(Report report, ModelAndView mv, HttpSession session) {
		if (reportService.insertReport(report) > 0) {
			mv.addObject("report", report);
			mv.setViewName("common/main");
		} else {
			mv.addObject("message", "신고 등록 실패");
			mv.setViewName("common/error");
		}
		return mv;
	} // 신고글 등록 기능

	// 신고글 처리 기능
	@RequestMapping("reportUpdateProcess.do")
	public ModelAndView reportUpdateProcessMethod(Report report, ModelAndView mv, HttpSession session) {

		Member loginUser = (Member) session.getAttribute("loginUser");

		if (loginUser != null && loginUser.getMemType().equals("ADMIN")) {
			if (reportService.updateReportProcess(report) > 0) {
				mv.addObject("report", report);
				mv.setViewName("redirect:reportList.do");
			} else {
				mv.addObject("message", "신고 처리 실패");
				mv.setViewName("common/error");
			}
		} else {
			mv.addObject("message", "권한이 없습니다.");
		}

		return mv;
	}

	// 신고글 처리 반려 기능
	@RequestMapping("reportUpdateReject.do")
	public ModelAndView reportUpdateRejectMethod(Report report, ModelAndView mv, HttpSession session) {

		Member loginUser = (Member) session.getAttribute("loginUser");

		if (loginUser != null && loginUser.getMemType().equals("ADMIN")) {
			if (reportService.updateReportReject(report) > 0) {
				mv.addObject("report", report);
				mv.setViewName("redirect:reportList.do");
			} else {
				mv.addObject("message", "신고 처리 실패");
				mv.setViewName("common/error");
			}
		} else {
			mv.addObject("message", "권한이 없습니다.");
		}
		return mv;
	} // 신고글 처리 반려 기능

	// 신고글 삭제 기능
	@RequestMapping("reportDelete.do")
	public ModelAndView reportDeleteMethod(String reportId, ModelAndView mv, HttpSession session) {
		Member loginUser = (Member) session.getAttribute("loginUser");

		if (reportService.deleteReport(reportId) > 0) {
			mv.addObject(loginUser);
			mv.setViewName("redirect:reportList.do");
		} else {
			mv.addObject("message", "신고 삭제 실패");
			mv.setViewName("common/error");
		}
		return mv;
	} // 신고글 삭제 기능
}
