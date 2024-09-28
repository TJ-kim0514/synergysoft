package com.synergysoft.bonvoyage.report.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.synergysoft.bonvoyage.report.model.dto.Report;

@Repository("ReportDao")
public class ReportDao {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	// 관리자 : 신고 목록 조회
	public ArrayList<Report> selectReport(){
		List<Report> list = sqlSessionTemplate.selectList("reportMapper.selectReport");
		return (ArrayList<Report>)list;
	}
	
	// 관리자 : 신고 상세 조회
	public Report selectReportDetail(String reportId) {
		return sqlSessionTemplate.selectOne("reportMapper.selectReportDetail", reportId);
	}
	
	// 유저&관리자 : 신고 등록
	public int insertReport(Report report) {
		return sqlSessionTemplate.insert("reportMapper.insertReport", report);
	}
	
	// 관리자 : 신고 처리
	public int updateReport(Report report) {
		return sqlSessionTemplate.update("reportMapper.updateReport", report);  
	}
	
	// 관리자 : 신고 삭제
	public int deleteReport(String reportId) {
		return sqlSessionTemplate.delete("reportMapper.deleteReport", reportId);
	}
	
}