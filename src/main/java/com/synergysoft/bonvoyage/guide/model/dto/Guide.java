package com.synergysoft.bonvoyage.guide.model.dto;

import java.sql.Date;

public class Guide implements java.io.Serializable {

	private static final long serialVersionUID = -3148970657314738393L;

	private String guidepostId; // POST_ID VARCHAR2(255),
	private String guideTitle; // TITLE VARCHAR2(500) NOT NULL,
	private String guideContent; // CONTENT CLOB NOT NULL,
	private String guideLocation; // LOCATION VARCHAR2(500) NOT NULL,
	private String guideCreatedAt;// CREATED_AT DATE DEFAULT SYSDATE,
	private java.sql.Date guideUpdatedAt;// UPDATED_AT DATE,
	private String guideUserId; // USER_ID VARCHAR2(255) NOT NULL,
	private int likeCount; // LIKE_COUNT NUMBER DEFAULT 0,
	private String File1; // FILE1 VARCHAR2(500),
	private String File2;// FILE2 VARCHAR2(500),
	private String File3;// FILE3 VARCHAR2(500),
	private String File4;// FILE4 VARCHAR2(500),
	private String File5;// FILE5 VARCHAR2(500),
	private String File6;// FILE6 VARCHAR2(500),
	private String File7;// FILE7 VARCHAR2(500),
	private String File8;// FILE8 VARCHAR2(500),
	private String File9;// FILE9 VARCHAR2(500),
	private String File10;// FILE10 VARCHAR2(500),
	private String File11;// FILE10 VARCHAR2(500),
	private String File12;// FILE10 VARCHAR2(500),
	private String File13;// FILE10 VARCHAR2(500),
	
	public Guide() {
		super();
		
	}
	

	public Guide(String guidepostId, String guideTitle, String guideContent, String guideCreatedAt,
			String guideUserId) {
		super();
		this.guidepostId = guidepostId;
		this.guideTitle = guideTitle;
		this.guideContent = guideContent;
		this.guideCreatedAt = guideCreatedAt;
		this.guideUserId = guideUserId;
	}


	public Guide(String guidepostId, String guideTitle, String guideContent, String guideLocation,
			String guideCreatedAt, Date guideUpdatedAt, String guideUserId, int likeCount, String file1, String file2,
			String file3, String file4, String file5, String file6, String file7, String file8, String file9,
			String file10) {
		super();
		this.guidepostId = guidepostId;
		this.guideTitle = guideTitle;
		this.guideContent = guideContent;
		this.guideLocation = guideLocation;
		this.guideCreatedAt = guideCreatedAt;
		this.guideUpdatedAt = guideUpdatedAt;
		this.guideUserId = guideUserId;
		this.likeCount = likeCount;
		File1 = file1;
		File2 = file2;
		File3 = file3;
		File4 = file4;
		File5 = file5;
		File6 = file6;
		File7 = file7;
		File8 = file8;
		File9 = file9;
		File10 = file10;
	}

	public String getGuidepostId() {
		return guidepostId;
	}

	public void setGuidepostId(String guidepostId) {
		this.guidepostId = guidepostId;
	}

	public String getGuideTitle() {
		return guideTitle;
	}

	public void setGuideTitle(String guideTitle) {
		this.guideTitle = guideTitle;
	}

	public String getGuideContent() {
		return guideContent;
	}

	public void setGuideContent(String guideContent) {
		this.guideContent = guideContent;
	}

	public String getGuideLocation() {
		return guideLocation;
	}

	public void setGuideLocation(String guideLocation) {
		this.guideLocation = guideLocation;
	}

	public String getGuideCreatedAt() {
		return guideCreatedAt;
	}

	public void setGuideCreatedAt(String guideCreatedAt) {
		this.guideCreatedAt = guideCreatedAt;
	}

	public java.sql.Date getGuideUpdatedAt() {
		return guideUpdatedAt;
	}

	public void setGuideUpdatedAt(java.sql.Date guideUpdatedAt) {
		this.guideUpdatedAt = guideUpdatedAt;
	}

	public String getGuideUserId() {
		return guideUserId;
	}

	public void setGuideUserId(String guideUserId) {
		this.guideUserId = guideUserId;
	}

	public int getLikeCount() {
		return likeCount;
	}

	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}

	public String getFile1() {
		return File1;
	}

	public void setFile1(String file1) {
		File1 = file1;
	}

	public String getFile2() {
		return File2;
	}

	public void setFile2(String file2) {
		File2 = file2;
	}

	public String getFile3() {
		return File3;
	}

	public void setFile3(String file3) {
		File3 = file3;
	}

	public String getFile4() {
		return File4;
	}

	public void setFile4(String file4) {
		File4 = file4;
	}

	public String getFile5() {
		return File5;
	}

	public void setFile5(String file5) {
		File5 = file5;
	}

	public String getFile6() {
		return File6;
	}

	public void setFile6(String file6) {
		File6 = file6;
	}

	public String getFile7() {
		return File7;
	}

	public void setFile7(String file7) {
		File7 = file7;
	}

	public String getFile8() {
		return File8;
	}

	public void setFile8(String file8) {
		File8 = file8;
	}

	public String getFile9() {
		return File9;
	}

	public void setFile9(String file9) {
		File9 = file9;
	}

	public String getFile10() {
		return File10;
	}

	public void setFile10(String file10) {
		File10 = file10;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "Guide [guidepostId=" + guidepostId + ", guideTitle=" + guideTitle + ", guideContent=" + guideContent
				+ ", guideLocation=" + guideLocation + ", guideCreatedAt=" + guideCreatedAt + ", guideUpdatedAt="
				+ guideUpdatedAt + ", guideUserId=" + guideUserId + ", likeCount=" + likeCount + ", File1=" + File1
				+ ", File2=" + File2 + ", File3=" + File3 + ", File4=" + File4 + ", File5=" + File5 + ", File6=" + File6
				+ ", File7=" + File7 + ", File8=" + File8 + ", File9=" + File9 + ", File10=" + File10 + "]";
	}
	
	
	
	

}
