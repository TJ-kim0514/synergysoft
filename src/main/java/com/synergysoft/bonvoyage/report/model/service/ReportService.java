package com.synergysoft.bonvoyage.report.model.service;

import java.util.ArrayList;

import com.synergysoft.bonvoyage.common.Paging;
import com.synergysoft.bonvoyage.common.Search;
import com.synergysoft.bonvoyage.report.model.dto.Report;

public interface ReportService {	
	Report selectReportDetail(String reportId);	
	
	int selectReportUserListCount(String reportId); //일반 회원일 때 회원이 등록한 신고 갯수 조회
	int selectReportAllListCount();  //관리자일 때 전체목록 갯수 조회용
	ArrayList<Report> selectList(Paging paging);//관리자일 때 전체목록조회용
	ArrayList<Report> selectList(Search search); //회원이 등록한 신고글 목록조회
	
	int insertReport(Report report);	
	int updateReportProcess(Report report);
	int updateReportReject(Report report);	
	int deleteReport(String reportId);
	
}
