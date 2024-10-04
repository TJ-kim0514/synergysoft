package com.synergysoft.bonvoyage.guide.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.synergysoft.bonvoyage.common.Paging;
import com.synergysoft.bonvoyage.guide.model.dto.Guide;

@Repository("guideDao")
public class GuideDao {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	
	public ArrayList<Guide> selectAllGuide(Paging paging){
		List<Guide> list = sqlSessionTemplate.selectList("guideMapper.selectAllGuide", paging);
		return (ArrayList<Guide>)list;
		
	}


	public int insertGuide(Guide guide) {
		return sqlSessionTemplate.insert("guideMapper.insertGuide", guide);
	}


	public Guide selectGuide(String guidepostId) {
		return sqlSessionTemplate.selectOne("guideMapper.selectGuide", guidepostId);
	}


	public int likeCount(String guidepostId) {
		return sqlSessionTemplate.update("guideMapper.likeCount", guidepostId);
	}


	public int updateGuide(Guide guide) {
		return sqlSessionTemplate.update("guideMapper.updateGuide", guide);
	}


	public int deleteGuide(String guidepostId) {
		return sqlSessionTemplate.delete("guideMapper.deleteGuide", guidepostId);
	}


	public int selectListCount() {
		return sqlSessionTemplate.selectOne("guideMapper.selectListCount");
	}






	
	



}//EndGuidDao
