package com.synergysoft.bonvoyage.qna.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;

import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.synergysoft.bonvoyage.common.Paging;
import com.synergysoft.bonvoyage.common.Search;
import com.synergysoft.bonvoyage.notice.model.dto.Notice;
import com.synergysoft.bonvoyage.qna.model.dto.Qna;
import com.synergysoft.bonvoyage.qna.model.service.QnaService;

@Controller
public class QnaController {

	//로그 객체 생성
	private static final Logger logger = LoggerFactory.getLogger(QnaController.class);
	
	@Autowired
	private QnaService qnaService;
	
	/*
	 * //최근 등록글 10 출력
	 * 
	 * @ResponseBody
	 * 
	 * @RequestMapping(value="stqna.do", method=RequestMethod.POST) public String
	 * selectTopQna( HttpServletResponse response ) throws
	 * UnsupportedEncodingException { // 최근 등록된 공지글 10개 조회 ArrayList<Qna> list =
	 * qnaService.selectTopQna(); logger.info("list : " + list);
	 * response.setContentType("application/json; charset=utf-8");
	 * 
	 * JSONArray jarr=new JSONArray(); logger.info("list : " + list); for(Qna qna :
	 * list) { JSONObject job = new JSONObject(); job.put("qnaId",qna.getQnaId());
	 * job.put("title", URLEncoder.encode(qna.getTitle(),"utf-8"));
	 * job.put("qCreatedAt",qna.getqCreatedAt().toString());
	 * 
	 * jarr.add(job); } JSONObject sendJson = new JSONObject();
	 * sendJson.put("qlist", jarr); logger.info("QNA sendJson : " +
	 * sendJson.toJSONString()); return sendJson.toJSONString(); }
	 */
	
	// 전체리스트 출력
	@RequestMapping("saqna.do")
	public String selectAllQna(
			Model model,
			@RequestParam(name="page", required=false) String page,
			@RequestParam(name="limit", required=false) String slimit,
			@RequestParam(name="groupLimit", required=false) String glimit
			) {
		//paging 기본세팅-----------------------------------------------------------------------
		// 출력할 페이지(기본값 1페이지)
		int currentPage=1;
		if(page!=null) {
			currentPage = Integer.parseInt(page);
		}
		// 한페이지에 출력할 공지글 갯수 (기본값 10개 세팅)
		int limit =10;
		if(slimit !=null) {
			limit= Integer.parseInt(slimit);
		}
		// 페이징 그룹 갯수 (기본값 5개 세팅)
		int groupLimit =5;
		if(glimit!=null) {
			groupLimit=Integer.parseInt(glimit);
		}
		// 총 목록 갯수 조회
		int listCount = qnaService.selectListCount();
		logger.info("QnA 총 갯수 : " +listCount);			
		
		// 페이징 처리 값생성
		Paging paging = new Paging(listCount, limit, currentPage, "saqna.do", groupLimit);
		paging.calculate();
		//paging 세팅---------------------------------------------------------------------------
	    // 서비스를 목록 조회 요청하고 결과 받기(페이징 처리)
	    ArrayList<Qna> list = qnaService.selectAllQna(paging);  // 전체목록 받아오기
	    
	    logger.info("list : " + list);
	    if(list != null && list.size() > 0) {
	        model.addAttribute("list", list);
			model.addAttribute("paging",paging);
			model.addAttribute("currentPage",currentPage);
	        return "qna/qnaListView";  // 뷰의 이름을 반환
	    } else {
	        model.addAttribute("message", "목록 조회 실패!");
	        return "common/error";  // 에러 페이지 뷰의 이름 반환
	    }	    
	} // "saqna.do"
	
	// 검색 출력
	@RequestMapping("ssqna.do")
	public String selectSearchQna(
			Model model,
			@RequestParam("action") String action,
			@RequestParam("keyword") String keyword,
			@RequestParam(name="page", required=false) String page,
			@RequestParam(name="limit", required=false) String slimit,
			@RequestParam(name="groupLimit", required=false) String glimit
			) {
		//paging 기본세팅-----------------------------------------------------------------------
		// 출력할 페이지(기본값 1페이지)
		int currentPage=1;
		if(page!=null) {
			currentPage = Integer.parseInt(page);
		}
		// 한페이지에 출력할 공지글 갯수 (기본값 10개 세팅)
		int limit =10;
		if(slimit !=null) {
			limit= Integer.parseInt(slimit);
		}
		// 페이징 그룹 갯수 (기본값 5개 세팅)
		int groupLimit =5;
		if(glimit!=null) {
			groupLimit=Integer.parseInt(glimit);
		}
		// 총 목록 갯수 조회
		int listCount = 0;
	    if(action.equals("title")) {
	    	listCount = qnaService.selectSearchTitleListCount(keyword);
	    } else if(action.equals("userContent")) {
	    	listCount = qnaService.selectSearchUserContentListCount(keyword);
	    } else if(action.equals("userId")) {
	    	listCount = qnaService.selectSearchUserIdListCount(keyword);
	    }
		
		
		// 페이징 처리 값생성
		Paging paging = new Paging(listCount, limit, currentPage, "saqna.do", groupLimit);
		paging.calculate();
		//paging 세팅---------------------------------------------------------------------------
	    // 서비스를 목록 조회 요청하고 결과 받기(페이징 처리)
	    Search search = new Search();
	    search.setKeyword(keyword);
	    search.setStartRow(paging.getStartRow());
	    search.setEndRow(paging.getEndRow());		
	    ArrayList<Qna> list = null;
	    
	    qnaService.selectAllQna(paging);  // 전체목록 받아오기
	    // 서비스를 목록 조회 요청하고 결과 받기(페이징 처리)
	    if(action.equals("title")) {
	    	list = qnaService.selectSearchTitleQna(search);
	    } else if(action.equals("userContent")) {
	    	list = qnaService.selectSearchUserContentQna(search);
	    } else if(action.equals("userId")) {
	    	list = qnaService.selectSearchUserIdQna(search);
	    }
	    
	    logger.info("list : " + list);
	    if(list != null && list.size() > 0) {
	        model.addAttribute("list", list);
			model.addAttribute("paging",paging);
			model.addAttribute("currentPage",currentPage);
			model.addAttribute("action",action);
			model.addAttribute("keyword",keyword);			
			
	        return "qna/qnaListView";  // 뷰의 이름을 반환
	    } else {
	        model.addAttribute("message", action + "에 대한 " + keyword + "검색결과가 존재하지 않습니다.");
	        return "common/error";  // 에러 페이지 뷰의 이름 반환
	    }	    
	} // "saqna.do"
}


