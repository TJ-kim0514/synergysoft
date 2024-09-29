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
	
	// ������ : �Ű� ��� ��ȸ
	public ArrayList<Report> selectReport(){
		List<Report> list = sqlSessionTemplate.selectList("reportMapper.selectReport");
		return (ArrayList<Report>)list;
	}
	
	// ������ : �Ű� �� ��ȸ
	public Report selectReportDetail(String reportId) {
		return sqlSessionTemplate.selectOne("reportMapper.selectReportDetail", reportId);
	}
	
	// ����&������ : �Ű� ���
	public int insertReport(Report report) {
		return sqlSessionTemplate.insert("reportMapper.insertReport", report);
	}
	
	// ������ : �Ű� ó��
	public int updateReport(Report report) {
		return sqlSessionTemplate.update("reportMapper.updateReport", report);  
	}
	
	// ������ : �Ű� ����
	public int deleteReport(String reportId) {
		return sqlSessionTemplate.delete("reportMapper.deleteReport", reportId);
	}
	
}