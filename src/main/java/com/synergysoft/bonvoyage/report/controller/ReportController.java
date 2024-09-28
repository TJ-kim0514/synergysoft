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

	// �� ������ �̵� ó�� �޼ҵ�

	// �� �Ű� ��� ������ �̵� ó��
	@RequestMapping("rwrite.do")
	public String moveWritePage() {
		return "member/report/reportWriteForm";
	}

	// ��û ó��
	
	/*
	// �Ű�� �� ���� ���� ��û ó��
	@RequestMapping("rdetail.do")
	public ModelAndView reportDetailMethod(@RequestParam("no") String reportId, ModelAndView mv, HttpSession session) {
		// �����ڿ� �󼼺��� �������� �Ϲ�ȸ�� �󼼺��� �������� �����ؼ� ���� ó��

		logger.info("ndetail.do : " + reportId); // ���۹��� �� Ȯ��

		Report report = reportService.selectReportDetail(reportId);

		if (report != null) {
			mv.addObject("report", report);

			Member loginUser = (Member) session.getAttribute("loginUser");

			if (loginUser != null && loginUser.getMemType().equals("ADMIN")) {
				mv.setViewName("admin/report/reportAdminDetailView");
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
	*/
	
	/*
	// �Ű�� ��ü ��� ����
	@RequestMapping("reportList.do")
	public ModelAndView reportListMethod(ModelAndView mv, Member member) {

		// ���񽺷� ��� ��ȸ ��û�ϰ� ��� �ޱ�
		ArrayList<Report> report = reportService.selectReport();

		if (report != null && report.size() > 0 && member != null && member.getMemType().equals("ADMIN")) {
			mv.addObject("report", report);
			mv.setViewName("admin/report/reportListView");
		} else {
			mv.addObject("message", "��� ��ȸ ����!");
			mv.setViewName("common/error");
		}

		return mv;

	} // �Ű�� ��ü ��� ����
	*/
}
