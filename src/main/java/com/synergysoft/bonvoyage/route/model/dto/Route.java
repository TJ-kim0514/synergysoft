package com.synergysoft.bonvoyage.route.model.dto;

import java.sql.Date;

public class Route implements java.io.Serializable {
	private static final long serialVersionUID = -1477524178816632376L;
	
	private String routeBoardId;		// 게시글 식별코드
	private String userId;			// 작성자 ID
	private String title;				// 제목
	private String content;			// 내용
	private String transport;			// 교통수단 식별코드
	private java.sql.Date createdAt;	// 작성일자
	private java.sql.Date updatedAt;	// 수정일자
	private int likeCount;			// 좋아요 수
	private int totalDuration;		// 총 소요시간
	private String routeName;		// 추천 경로 이름
	
	public Route() {
		super();
	}

	public Route(String userId, String title, String content, String transport, Date createdAt) {
		super();
		this.userId = userId;
		this.title = title;
		this.content = content;
		this.transport = transport;
		this.createdAt = createdAt;
	}

	public Route(String routeBoardId, String userId, String title, String content, String transport, Date createdAt,
			Date updatedAt, int likeCount, int totalDuration, String routeName) {
		super();
		this.routeBoardId = routeBoardId;
		this.userId = userId;
		this.title = title;
		this.content = content;
		this.transport = transport;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
		this.likeCount = likeCount;
		this.totalDuration = totalDuration;
		this.routeName = routeName;
	}

	public String getRouteBoardId() {
		return routeBoardId;
	}

	public void setRouteBoardId(String routeBoardId) {
		this.routeBoardId = routeBoardId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
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

	public String getTransport() {
		return transport;
	}

	public void setTransport(String transport) {
		this.transport = transport;
	}

	public java.sql.Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(java.sql.Date createdAt) {
		this.createdAt = createdAt;
	}

	public java.sql.Date getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(java.sql.Date updatedAt) {
		this.updatedAt = updatedAt;
	}

	public int getLikeCount() {
		return likeCount;
	}

	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}

	public int getTotalDuration() {
		return totalDuration;
	}

	public void setTotalDuration(int totalDuration) {
		this.totalDuration = totalDuration;
	}

	public String getRouteName() {
		return routeName;
	}

	public void setRouteName(String routeName) {
		this.routeName = routeName;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "Route [routeBoardId=" + routeBoardId + ", userId=" + userId + ", title=" + title + ", content="
				+ content + ", transport=" + transport + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt
				+ ", likeCount=" + likeCount + ", totalDuration=" + totalDuration + ", routeName=" + routeName + "]";
	}
	
	
}
