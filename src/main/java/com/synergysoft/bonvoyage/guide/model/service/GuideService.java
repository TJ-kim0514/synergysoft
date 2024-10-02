package com.synergysoft.bonvoyage.guide.model.service;

import java.util.ArrayList;

import com.synergysoft.bonvoyage.guide.model.dto.Guide;


public interface GuideService {
	ArrayList<Guide> selectAllGuide();

	int insertGuide(Guide guide);

	Guide selectGuide(String guidepostId);


	

}
