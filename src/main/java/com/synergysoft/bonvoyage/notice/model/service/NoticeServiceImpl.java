package com.synergysoft.bonvoyage.notice.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.synergysoft.bonvoyage.common.Paging;
import com.synergysoft.bonvoyage.notice.model.dao.NoticeDao;
import com.synergysoft.bonvoyage.notice.model.dto.Notice;

@Service("noticeService")
public class NoticeServiceImpl implements NoticeService{
	// dao ���� 
	@Autowired
	private NoticeDao noticeDao;
	
	// �������� ����ȭ�� ��üȭ�� ��¿� ����
	@Override
	public ArrayList<Notice> selectAllNotice(Paging paging) {
		return noticeDao.selectAllNotice(paging);
	}
	
	// �������� ���
	@Override
	public int insertNotice(Notice notice) {
		return noticeDao.insertNotice(notice);
	}
	
	// �������� �󼼺���
	@Override
	public Notice selectDetailNotice(String noticeId) {
		return noticeDao.selectDetailNotice(noticeId);
	}
	
	// ����¡�� �������� ����Ȯ��
	@Override
	public int selectListCount() {
		return noticeDao.selectListCount();
	}

}
