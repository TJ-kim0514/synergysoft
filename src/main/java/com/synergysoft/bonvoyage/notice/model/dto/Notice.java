package com.synergysoft.bonvoyage.notice.model.dto;

import java.sql.Date;

public class Notice implements java.io.Serializable{

	private static final long serialVersionUID = 7300351471653170316L;
	private String noticeId;					// NOTICE_ID	VARCHAR2(255 BYTE)
	private String title;						// TITLE	VARCHAR2(500 BYTE)
	private String content;					// CONTENT	CLOB
	private String adminId;					// ADMIN_ID	VARCHAR2(255 BYTE)
	private Date createdAt;					// CREATED_AT	DATE
	private Date updatedAt;					// UPDATED_AT	DATE
	private String updateCheck;				// UPDATE_CHECK	CHAR(1 BYTE)
	private Date deletedAt;					// DELETED_AT	DATE
	private String deleteCheck;				// DELETE_CHECK	CHAR(1 BYTE)
	private String file1;						// FILE1	VARCHAR2(500 BYTE)
	private String file2;						// FILE2	VARCHAR2(500 BYTE)
	private String file3;						// FILE3	VARCHAR2(500 BYTE)
	
	public Notice() {}

	public Notice(String noticeId, String title, String content, String adminId, Date createdAt, Date updatedAt,
			String updateCheck, Date deletedAt, String deleteCheck, String file1, String file2, String file3) {
		super();
		this.noticeId = noticeId;
		this.title = title;
		this.content = content;
		this.adminId = adminId;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
		this.updateCheck = updateCheck;
		this.deletedAt = deletedAt;
		this.deleteCheck = deleteCheck;
		this.file1 = file1;
		this.file2 = file2;
		this.file3 = file3;
	}

	public String getNoticeId() {
		return noticeId;
	}

	public void setNoticeId(String noticeId) {
		this.noticeId = noticeId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getAdminId() {
		return adminId;
	}

	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public Date getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}

	public String getUpdateCheck() {
		return updateCheck;
	}

	public void setUpdateCheck(String updateCheck) {
		this.updateCheck = updateCheck;
	}

	public Date getDeletedAt() {
		return deletedAt;
	}

	public void setDeletedAt(Date deletedAt) {
		this.deletedAt = deletedAt;
	}

	public String getDeleteCheck() {
		return deleteCheck;
	}

	public void setDeleteCheck(String deleteCheck) {
		this.deleteCheck = deleteCheck;
	}

	public String getFile1() {
		return file1;
	}

	public void setFile1(String file1) {
		this.file1 = file1;
	}

	public String getFile2() {
		return file2;
	}

	public void setFile2(String file2) {
		this.file2 = file2;
	}

	public String getFile3() {
		return file3;
	}

	public void setFile3(String file3) {
		this.file3 = file3;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "Notice [noticeId=" + noticeId + ", title=" + title + ", content=" + content + ", adminId=" + adminId
				+ ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + ", updateCheck=" + updateCheck
				+ ", deletedAt=" + deletedAt + ", deleteCheck=" + deleteCheck + ", file1=" + file1 + ", file2=" + file2
				+ ", file3=" + file3 + ", getNoticeId()=" + getNoticeId() + ", getTitle()=" + getTitle()
				+ ", getContent()=" + getContent() + ", getAdminId()=" + getAdminId() + ", getCreatedAt()="
				+ getCreatedAt() + ", getUpdatedAt()=" + getUpdatedAt() + ", getUpdateCheck()=" + getUpdateCheck()
				+ ", getDeletedAt()=" + getDeletedAt() + ", getDeleteCheck()=" + getDeleteCheck() + ", getFile1()="
				+ getFile1() + ", getFile2()=" + getFile2() + ", getFile3()=" + getFile3() + ", getClass()="
				+ getClass() + ", hashCode()=" + hashCode() + ", toString()=" + super.toString() + "]";
	}

	

}
