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
	// ������ : �Ű� ��� ��ȸ
	public ArrayList<Report> selectReport() {
		return reportDao.selectReport();
	}

	@Override
	// ������ : �Ű� �� ��ȸ
	public Report selectReportDetail(String reportId) {
		return reportDao.selectReportDetail(reportId);
	}

	@Override
	// ����&������ : �Ű� ���
	public int insertReport(Report report) {
		return reportDao.insertReport(report);
	}
	
	@Override
	// ������ : �Ű� ó��
	public int updateReportProcess(Report report) {
		return reportDao.updateReportProcess(report);
	}
	
	@Override
	// ������ : �Ű� �ݷ�
	public int updateReportReject(Report report) {
		return reportDao.updateReportReject(report);
	}

	@Override
	// ������ : �Ű� ����
	public int deleteReport(String reportId) {
		return reportDao.deleteReport(reportId);
	}
}
