package com.synergysoft.bonvoyage.report.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.synergysoft.bonvoyage.member.model.dto.Member;
import com.synergysoft.bonvoyage.member.model.service.MemberService;
import com.synergysoft.bonvoyage.report.model.dto.Report;
import com.synergysoft.bonvoyage.report.model.service.ReportService;

@Controller
public class ReportController {

	private static final Logger logger = LoggerFactory.getLogger(ReportController.class);

	@Autowired
	private ReportService reportService;

	@Autowired
	private MemberService memberService;

	// 뷰 페이지 이동 처리 메소드

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
				if(loginUser != null && loginUser.getMemType().equals("USER")) {
					report.setReportUserId(loginUser.getMemId());
					report.setReportId(reportId);
					report = reportService.selectMyReportDetail(report);
					if(report != null) {
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

	// 신고글 전체 목록 보기
	@RequestMapping("reportList.do")
	public ModelAndView reportListMethod(ModelAndView mv, HttpSession session) {

		// 서비스롤 목록 조회 요청하고 결과 받기
		ArrayList<Report> reportList = reportService.selectReport();
		Member loginUser = (Member) session.getAttribute("loginUser");

		if (reportList != null && reportList.size() > 0 && loginUser != null
				&& loginUser.getMemType().equals("ADMIN")) {
			mv.addObject("report", reportList);
			mv.setViewName("admin/report/reportListView");

		} else if (reportList != null && reportList.size() > 0 && loginUser != null
				&& loginUser.getMemType().equals("USER")) {
			mv.addObject("report", reportList);
			mv.setViewName("admin/report/reportListView");
		}else {
			mv.addObject("message", "목록 조회 실패!");
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
