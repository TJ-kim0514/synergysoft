package com.synergysoft.bonvoyage.report.model.dto;

import java.util.Date;

public class Report implements java.io.Serializable {
	private static final long serialVersionUID = 4468055390785996667L;
	
	private String reportId;
	private String boardDivCd;
	private String postId;
	private String reportUserId;
	private String reportingReason;
	private String detail;
	private Date reportDate;
	private String checkedAdmin;
	private String checkedAdminId;
	private String checkedAssigned;
	private String assignedAdminId;
	
	public Report() {
		super();
	}

	public Report(String reportId, String boardDivCd, String postId, String reportUserId, String reportingReason,
			String detail, Date reportDate, String checkedAdmin, String checkedAdminId, String checkedAssigned,
			String assignedAdminId) {
		super();
		this.reportId = reportId;
		this.boardDivCd = boardDivCd;
		this.postId = postId;
		this.reportUserId = reportUserId;
		this.reportingReason = reportingReason;
		this.detail = detail;
		this.reportDate = reportDate;
		this.checkedAdmin = checkedAdmin;
		this.checkedAdminId = checkedAdminId;
		this.checkedAssigned = checkedAssigned;
		this.assignedAdminId = assignedAdminId;
	}

	public String getReportId() {
		return reportId;
	}

	public void setReportId(String reportId) {
		this.reportId = reportId;
	}

	public String getBoardDivCd() {
		return boardDivCd;
	}

	public void setBoardDivCd(String boardDivCd) {
		this.boardDivCd = boardDivCd;
	}

	public String getPostId() {
		return postId;
	}

	public void setPostId(String postId) {
		this.postId = postId;
	}

	public String getReportUserId() {
		return reportUserId;
	}

	public void setReportUserId(String reportUserId) {
		this.reportUserId = reportUserId;
	}

	public String getReportingReason() {
		return reportingReason;
	}

	public void setReportingReason(String reportingReason) {
		this.reportingReason = reportingReason;
	}

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	public Date getReportDate() {
		return reportDate;
	}

	public void setReportDate(Date reportDate) {
		this.reportDate = reportDate;
	}

	public String getCheckedAdmin() {
		return checkedAdmin;
	}

	public void setCheckedAdmin(String checkedAdmin) {
		this.checkedAdmin = checkedAdmin;
	}

	public String getCheckedAdminId() {
		return checkedAdminId;
	}

	public void setCheckedAdminId(String checkedAdminId) {
		this.checkedAdminId = checkedAdminId;
	}

	public String getCheckedAssigned() {
		return checkedAssigned;
	}

	public void setCheckedAssigned(String checkedAssigned) {
		this.checkedAssigned = checkedAssigned;
	}

	public String getAssignedAdminId() {
		return assignedAdminId;
	}

	public void setAssignedAdminId(String assignedAdminId) {
		this.assignedAdminId = assignedAdminId;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "Report [reportId=" + reportId + ", boardDivCd=" + boardDivCd + ", postId=" + postId + ", reportUserId="
				+ reportUserId + ", reportingReason=" + reportingReason + ", detail=" + detail + ", reportDate="
				+ reportDate + ", checkedAdmin=" + checkedAdmin + ", checkedAdminId=" + checkedAdminId
				+ ", checkedAssigned=" + checkedAssigned + ", assignedAdminId=" + assignedAdminId + "]";
	}
	
}
