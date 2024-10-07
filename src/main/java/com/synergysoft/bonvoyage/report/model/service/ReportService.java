package com.synergysoft.bonvoyage.report.model.service;

import java.util.ArrayList;

import com.synergysoft.bonvoyage.common.Paging;
import com.synergysoft.bonvoyage.report.model.dto.Report;

public interface ReportService {
	
	ArrayList<Report> selectReport(Paging paging);
	ArrayList<Report> selectReportMe(String reportId);
	ArrayList<Report> selectAllReport(Paging paging);
	Report selectReportDetail(String reportId);
	Report selectMyReportDetail(Report report);
	int selectReportListCount();
	int selectAllReportMe(String memId);
	
	int insertReport(Report report);
	
	int updateReportProcess(Report report);
	int updateReportReject(Report report);
	
	int deleteReport(String reportId);

}
