package com.synergysoft.bonvoyage.report.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.synergysoft.bonvoyage.report.model.dao.ReportDao;
import com.synergysoft.bonvoyage.report.model.dto.Report;

@Service("ReportService")
public class ReportServiceImpl implements ReportService {
	@Autowired
	private ReportDao reportDao;

	@Override
	// 관리자 : 신고 목록 조회
	public ArrayList<Report> selectReport() {
		return reportDao.selectReport();
	}

	@Override
	// 관리자 : 신고 상세 조회
	public Report selectReportDetail(String reportId) {
		return reportDao.selectReportDetail(reportId);
	}

	@Override
	// 유저&관리자 : 신고 등록
	public int insertReport(Report report) {
		return reportDao.insertReport(report);
	}
	
	@Override
	// 관리자 : 신고 처리
	public int updateReportProcess(Report report) {
		return reportDao.updateReportProcess(report);
	}
	
	@Override
	// 관리자 : 신고 반려
	public int updateReportReject(Report report) {
		return reportDao.updateReportReject(report);
	}

	@Override
	// 관리자 : 신고 삭제
	public int deleteReport(String reportId) {
		return reportDao.deleteReport(reportId);
	}
}
