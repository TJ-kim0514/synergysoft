package com.synergysoft.bonvoyage.guide.model.service;

import java.util.ArrayList;

import com.synergysoft.bonvoyage.common.Paging;
import com.synergysoft.bonvoyage.guide.model.dto.Guide;


public interface GuideService {
	ArrayList<Guide> selectAllGuide(Paging paging);

	int insertGuide(Guide guide);

	Guide selectGuide(String guidepostId);

	int likeCount(String guidepostId);

	int updateGuide(Guide guide);

	int deleteGuide(String guidepostId);

	int selectListCount();




	

}
