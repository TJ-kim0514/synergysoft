package com.synergysoft.bonvoyage.report.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.synergysoft.bonvoyage.common.Paging;
import com.synergysoft.bonvoyage.common.Search;
import com.synergysoft.bonvoyage.report.model.dto.Report;

@Repository("ReportDao")
public class ReportDao {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	// 신고 상세 조회
	public Report selectReportDetail(String reportId) {
		return sqlSessionTemplate.selectOne("reportMapper.selectReportDetail", reportId);
	}
	
	// 유저&관리자 : 신고 등록
	public int insertReport(Report report) {
		return sqlSessionTemplate.insert("reportMapper.insertReport", report);
	}

	// 관리자 : 신고 처리
	public int updateReportProcess(Report report) {
		return sqlSessionTemplate.update("reportMapper.updateReportProcess", report);
	}

	// 관리자 : 신고 반려
	public int updateReportReject(Report report) {
		return sqlSessionTemplate.update("reportMapper.updateReportReject", report);
	}

	// 관리자 : 신고 삭제
	public int deleteReport(String reportId) {
		return sqlSessionTemplate.delete("reportMapper.deleteReport", reportId);
	}
	
	public int selectReportAllListCount() {
		return sqlSessionTemplate.selectOne("reportMapper.selectReportListCount");
	}
	//회원이 신고한 글 갯수 조회
	public int selectReportUserListCount(String reportId) {
		return sqlSessionTemplate.selectOne("reportMapper.selectAllReportMe", reportId);
	}
	
	//관리자 목록조회
	public ArrayList<Report> selectList(Paging paging) {
		List<Report> list = sqlSessionTemplate.selectList("reportMapper.selectReport",paging);
		return (ArrayList<Report>)list;
	}
	
	//회원이 신고한 목록 조회
	public ArrayList<Report> selectList(Search search) {
		List<Report> list = sqlSessionTemplate.selectList("reportMapper.selectReportMe",search);
		return (ArrayList<Report>)list;
	}
	
}