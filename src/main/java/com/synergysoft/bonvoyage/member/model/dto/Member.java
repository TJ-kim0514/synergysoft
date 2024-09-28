package com.synergysoft.bonvoyage.member.model.dto;

import java.sql.Date;

public class Member {
	
	private String memId;
	private String memName;
	private String memType;
	private String memPw;
	private String memNickNm;
	private Date memJoinDate;
	private String memPhone;
	private Date memBirth;
	private String memSocial;
	private String memStatus;
	private Date memLoginLog;
	private Date memLogoutLog;
	private Date memStatusDate;
	private Date memPwUpdate;
	
	public Member() {
		super();
	}

	public Member(String memId, String memName, String memType, String memPw, String memNickNm, Date memJoinDate,
			String memPhone, Date memBirth, String memSocial, String memStatus, Date memLoginLog, Date memLogoutLog,
			Date memStatusDate, Date memPwUpdate) {
		super();
		this.memId = memId;
		this.memName = memName;
		this.memType = memType;
		this.memPw = memPw;
		this.memNickNm = memNickNm;
		this.memJoinDate = memJoinDate;
		this.memPhone = memPhone;
		this.memBirth = memBirth;
		this.memSocial = memSocial;
		this.memStatus = memStatus;
		this.memLoginLog = memLoginLog;
		this.memLogoutLog = memLogoutLog;
		this.memStatusDate = memStatusDate;
		this.memPwUpdate = memPwUpdate;
	}

	public String getMemId() {
		return memId;
	}

	public void setMemId(String memId) {
		this.memId = memId;
	}

	public String getMemName() {
		return memName;
	}

	public void setMemName(String memName) {
		this.memName = memName;
	}

	public String getMemType() {
		return memType;
	}

	public void setMemType(String memType) {
		this.memType = memType;
	}

	public String getMemPw() {
		return memPw;
	}

	public void setMemPw(String memPw) {
		this.memPw = memPw;
	}

	public String getMemNickNm() {
		return memNickNm;
	}

	public void setMemNickNm(String memNickNm) {
		this.memNickNm = memNickNm;
	}

	public Date getMemJoinDate() {
		return memJoinDate;
	}

	public void setMemJoinDate(Date memJoinDate) {
		this.memJoinDate = memJoinDate;
	}

	public String getMemPhone() {
		return memPhone;
	}

	public void setMemPhone(String memPhone) {
		this.memPhone = memPhone;
	}

	public Date getMemBirth() {
		return memBirth;
	}

	public void setMemBirth(Date memBirth) {
		this.memBirth = memBirth;
	}

	public String getMemSocial() {
		return memSocial;
	}

	public void setMemSocial(String memSocial) {
		this.memSocial = memSocial;
	}

	public String getMemStatus() {
		return memStatus;
	}

	public void setMemStatus(String memStatus) {
		this.memStatus = memStatus;
	}

	public Date getMemLoginLog() {
		return memLoginLog;
	}

	public void setMemLoginLog(Date memLoginLog) {
		this.memLoginLog = memLoginLog;
	}

	public Date getMemLogoutLog() {
		return memLogoutLog;
	}

	public void setMemLogoutLog(Date memLogoutLog) {
		this.memLogoutLog = memLogoutLog;
	}

	public Date getMemStatusDate() {
		return memStatusDate;
	}

	public void setMemStatusDate(Date memStatusDate) {
		this.memStatusDate = memStatusDate;
	}

	public Date getMemPwUpdate() {
		return memPwUpdate;
	}

	public void setMemPwUpdate(Date memPwUpdate) {
		this.memPwUpdate = memPwUpdate;
	}

	@Override
	public String toString() {
		return "Member [memId=" + memId + ", memName=" + memName + ", memType=" + memType + ", memPw=" + memPw
				+ ", memNickNm=" + memNickNm + ", memJoinDate=" + memJoinDate + ", memPhone=" + memPhone + ", memBirth="
				+ memBirth + ", memSocial=" + memSocial + ", memStatus=" + memStatus + ", memLoginLog=" + memLoginLog
				+ ", memLogoutLog=" + memLogoutLog + ", memStatusDate=" + memStatusDate + ", memPwUpdate=" + memPwUpdate
				+ "]";
	}
	
}
