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

	// �� ������ �̵� ó�� �޼ҵ�

	// �� �Ű� ��� ������ �̵� ó��
	@RequestMapping("reportWrite.do")
	public ModelAndView moveWritePage(ModelAndView mv, HttpSession session) {
		
		Member loginUser = (Member) session.getAttribute("loginUser");
		
		if(loginUser != null) {
			mv.setViewName("member/report/reportWriteForm");
		} else {
			mv.addObject("message", "������ �����ϴ�. �α��� �� �ٽ� �̿����ֽñ� �ٶ��ϴ�.");
			mv.setViewName("common/error");
		}
		return mv;
	}

	// ��û ó��

	// �Ű�� �� ���� ���� ��û ó��
	@RequestMapping("reportDetail.do")
	public ModelAndView reportDetailMethod(@RequestParam("no") String reportId, ModelAndView mv, HttpSession session) {
		// �����ڿ� �󼼺��� �������� �Ϲ�ȸ�� �󼼺��� �������� �����ؼ� ���� ó��

		logger.info("rdetail.do : " + reportId); // ���۹��� �� Ȯ��

		Report report = reportService.selectReportDetail(reportId);

		if (report != null) {
			mv.addObject("report", report);

			Member loginUser = (Member) session.getAttribute("loginUser");

			if (loginUser != null && loginUser.getMemType().equals("ADMIN")) {
				mv.setViewName("admin/report/reportDetailView");
			} else {
				mv.addObject("message", "�߸��� �����Դϴ�.");
				mv.setViewName("common/error");
			}
		} else {
			mv.addObject("message", reportId + "�� �Ű�� �󼼺��� ��û ����");
			mv.setViewName("common/error");
		}

		return mv;
	} // �Ű�� ������ ����

	// �Ű�� ��ü ��� ����
	@RequestMapping("reportList.do")
	public ModelAndView reportListMethod(ModelAndView mv, HttpSession session) {

		// ���񽺷� ��� ��ȸ ��û�ϰ� ��� �ޱ�
		ArrayList<Report> reportList = reportService.selectReport();
		Member loginUser = (Member) session.getAttribute("loginUser");

		if (reportList != null && reportList.size() > 0 && loginUser != null
				&& loginUser.getMemType().equals("ADMIN")) {
			mv.addObject("report", reportList);
			mv.setViewName("admin/report/reportListView");
		} else {
			mv.addObject("message", "��� ��ȸ ����!");
			mv.setViewName("common/error");
		}

		return mv;

	} // �Ű�� ��ü ��� ����

	// �Ű�� ��� ���
	@RequestMapping("reportInsert.do")
	public ModelAndView reportInsertMethod(Report report, ModelAndView mv, HttpSession session) {
		if (reportService.insertReport(report) > 0) {
			mv.addObject("report", report);
			mv.setViewName("common/main");
		} else {
			mv.addObject("message", "�Ű� ��� ����");
			mv.setViewName("common/error");
		}
		return mv;
	} // �Ű�� ��� ���

	// �Ű�� ó�� ���
	@RequestMapping("reportUpdateProcess.do")
	public ModelAndView reportUpdateProcessMethod(Report report, ModelAndView mv, HttpSession session) {
		
		Member loginUser = (Member) session.getAttribute("loginUser");
		
		if(loginUser != null && loginUser.getMemType().equals("ADMIN")) {
			if (reportService.updateReportProcess(report) > 0) {
				mv.addObject("report", report);
				mv.setViewName("redirect:reportList.do");
			} else {
				mv.addObject("message", "�Ű� ó�� ����");
				mv.setViewName("common/error");
			}
		} else {
			mv.addObject("message", "������ �����ϴ�.");
		}
		
		return mv;
	}

	// �Ű�� ó�� �ݷ� ���
	@RequestMapping("reportUpdateReject.do")
	public ModelAndView reportUpdateRejectMethod(Report report, ModelAndView mv, HttpSession session) {
		
		Member loginUser = (Member) session.getAttribute("loginUser");
		
		if(loginUser != null && loginUser.getMemType().equals("ADMIN")) {
			if (reportService.updateReportReject(report) > 0) {
				mv.addObject("report", report);
				mv.setViewName("redirect:reportList.do");
			} else {
				mv.addObject("message", "�Ű� ó�� ����");
				mv.setViewName("common/error");
			}
		} else {
			mv.addObject("message", "������ �����ϴ�.");
		}
		return mv;
	} // �Ű�� ó�� �ݷ� ���

	// �Ű�� ���� ���
	@RequestMapping("reportDelete.do")
	public ModelAndView reportDeleteMethod(String reportId, ModelAndView mv, HttpSession session) {
		Member loginUser = (Member) session.getAttribute("loginUser");
		
		if(reportService.deleteReport(reportId) > 0) {
			mv.addObject(loginUser);
			mv.setViewName("redirect:reportList.do");
		} else {
			mv.addObject("message", "�Ű� ���� ����");
			mv.setViewName("common/error");
		}
		return mv;
	} // �Ű�� ���� ���
}
