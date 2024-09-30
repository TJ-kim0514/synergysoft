package com.synergysoft.bonvoyage.report.model.service;

import java.util.ArrayList;

import com.synergysoft.bonvoyage.report.model.dto.Report;

public interface ReportService {
	
	ArrayList<Report> selectReport();
	Report selectReportDetail(String reportId);
	int insertReport(Report report);
	int updateReportProcess(Report report);
	int updateReportReject(Report report);
	int deleteReport(String reportId);

}
