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
import com.synergysoft.bonvoyage.report.model.dto.Report;
import com.synergysoft.bonvoyage.report.model.service.ReportService;

@Controller
public class ReportController {

	private static final Logger logger = LoggerFactory.getLogger(ReportController.class);

	@Autowired
	private ReportService reportService;

	// 뷰 페이지 이동 처리 메소드

	// 새 신고 등록 페이지 이동 처리
	@RequestMapping("rwrite.do")
	public String moveWritePage() {
		return "member/report/reportWriteForm";
	}

	// 요청 처리
	
	/*
	// 신고글 상세 내용 보기 요청 처리
	@RequestMapping("rdetail.do")
	public ModelAndView reportDetailMethod(@RequestParam("no") String reportId, ModelAndView mv, HttpSession session) {
		// 관리자용 상세보기 페이지와 일반회원 상세보기 페이지를 구분해서 응답 처리

		logger.info("ndetail.do : " + reportId); // 전송받은 값 확인

		Report report = reportService.selectReportDetail(reportId);

		if (report != null) {
			mv.addObject("report", report);

			Member loginUser = (Member) session.getAttribute("loginUser");

			if (loginUser != null && loginUser.getMemType().equals("ADMIN")) {
				mv.setViewName("admin/report/reportAdminDetailView");
			} else {
				mv.addObject("message", "잘못된 접근입니다.");
				mv.setViewName("common/error");
			}
		} else {
			mv.addObject("message", reportId + "번 신고글 상세보기 요청 실패");
			mv.setViewName("common/error");
		}

		return mv;
	} // 신고글 상세정보 보기
	*/
	
	/*
	// 신고글 전체 목록 보기
	@RequestMapping("reportList.do")
	public ModelAndView reportListMethod(ModelAndView mv, Member member) {

		// 서비스롤 목록 조회 요청하고 결과 받기
		ArrayList<Report> report = reportService.selectReport();

		if (report != null && report.size() > 0 && member != null && member.getMemType().equals("ADMIN")) {
			mv.addObject("report", report);
			mv.setViewName("admin/report/reportListView");
		} else {
			mv.addObject("message", "목록 조회 실패!");
			mv.setViewName("common/error");
		}

		return mv;

	} // 신고글 전체 목록 보기
	*/
}
