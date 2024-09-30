package com.synergysoft.bonvoyage.notice.model.service;

import java.util.ArrayList;

import com.synergysoft.bonvoyage.common.Paging;
import com.synergysoft.bonvoyage.notice.model.dto.Notice;


public interface NoticeService {
	
	ArrayList<Notice> selectAllNotice(Paging paging);
	int insertNotice(Notice notice);
	Notice selectDetailNotice(String noticeId);
	int selectListCount();

}
