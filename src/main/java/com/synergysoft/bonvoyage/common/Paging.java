package com.synergysoft.bonvoyage.common;

public class Paging implements java.io.Serializable{

	private static final long serialVersionUID = -152292818359704529L;
	
	private int startRow;		// �ش� �������� ����� ������ (�������� ����)
	private int endRow;			// �ش� �������� ����� ���� (�������� ����)
	private int listCount;		// �� ��� ���� (������������ ���)
	private int limit;			// �� �������� ����� ����(������������ ���)
	private int currentPage;	// ����� ���� ������(������������ ���)
	private int maxPage;		// �� ������ �� (������ ������) (������������ ���)
	private int startPage;		// ���� �������� ���� ������ �׷��� ���۰� (������������ ���)
	private int endPage;		// ���� �������� ���� ������ ������ ���� (������������ ���)
	private String urlMapping;	// ������ ���� Ŭ���� ��û�� url �����(�˻���� ���� ��û�� url �� �޶� �ʿ���) (������������ ���)
	private int groupLimit;		// ����¡ �׷� ���� ( ������������ ��� )

	
	// �⺻������ ���ʿ�
	
	// �Ű����� 4�� �ִ� ������
	
	public Paging(int listCount, int limit, int currentPage, String urlMapping, int groupLimit) {
		super();
		this.listCount = listCount;
		this.limit = limit;
		this.currentPage = currentPage;
		this.urlMapping = urlMapping;
		this.groupLimit = groupLimit;
	}
	
	// ������ ��� �޼ҵ�
	public void calculate() {
		// �� ������ �� ��� : 
		this.maxPage = (int)((double)listCount / limit + 0.9); 
		
		// �� ������ ��¿� ����� ������ �׸��� ���۰� ����
		// �� ����������
		this.startPage = (int)(((double)currentPage / groupLimit + 0.9)-1 ) * groupLimit + 1;
		// �� ����������
		this.endPage = startPage + groupLimit - 1;
		
		// ������ �׷��� ������ ������ �������� ����
		if(maxPage < endPage) {
			endPage = maxPage;
		}
		
		// ��û�� ���� �������� ��µ� ����� �� ��ȣ�� ���
		// ���� �Խù�
		this.startRow = (currentPage-1) * limit + 1;
		// ���� �Խù�
		this.endRow = startRow + limit - 1;		
	}
	



	// setters and getters
	public int getStartRow() {
		return startRow;
	}


	public void setStartRow(int startRow) {
		this.startRow = startRow;
	}


	public int getEndRow() {
		return endRow;
	}


	public void setEndRow(int endRow) {
		this.endRow = endRow;
	}


	public int getListCount() {
		return listCount;
	}


	public void setListCount(int listCount) {
		this.listCount = listCount;
	}


	public int getLimit() {
		return limit;
	}


	public void setLimit(int limit) {
		this.limit = limit;
	}


	public int getCurrentPage() {
		return currentPage;
	}


	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}


	public int getMaxPage() {
		return maxPage;
	}


	public void setMaxPage(int maxPage) {
		this.maxPage = maxPage;
	}


	public int getStartPage() {
		return startPage;
	}


	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}


	public int getEndPage() {
		return endPage;
	}


	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}


	public String getUrlMapping() {
		return urlMapping;
	}


	public void setUrlMapping(String urlMapping) {
		this.urlMapping = urlMapping;
	}


	public int getGroupLimit() {
		return groupLimit;
	}


	public void setGroupLimit(int groupLimit) {
		this.groupLimit = groupLimit;
	}


	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	// toString

	@Override
	public String toString() {
		return "Paging [startRow=" + startRow + ", endRow=" + endRow + ", listCount=" + listCount + ", limit=" + limit
				+ ", currentPage=" + currentPage + ", maxPage=" + maxPage + ", startPage=" + startPage + ", endPage="
				+ endPage + ", urlMapping=" + urlMapping + ", groupLimit=" + groupLimit + "]";
	}
}
