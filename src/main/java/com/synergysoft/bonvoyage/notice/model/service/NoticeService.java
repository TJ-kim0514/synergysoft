package com.synergysoft.bonvoyage.notice.model.service;

import java.util.ArrayList;

import com.synergysoft.bonvoyage.notice.model.dto.Notice;

public interface NoticeService {
	
	ArrayList<Notice> selectAllNotice();
	int insertNotice(Notice notice);
	Notice selectDetailNotice(String noticeId);

}
