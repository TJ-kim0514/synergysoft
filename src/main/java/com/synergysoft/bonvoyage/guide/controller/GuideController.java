package com.synergysoft.bonvoyage.guide.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.synergysoft.bonvoyage.common.FileNameChange;
import com.synergysoft.bonvoyage.common.Paging;
import com.synergysoft.bonvoyage.common.Search;
import com.synergysoft.bonvoyage.guide.model.dto.Guide;
import com.synergysoft.bonvoyage.guide.model.service.GuideService;
import com.synergysoft.bonvoyage.member.model.dto.Member;


@Controller
public class GuideController {
	private static final Logger logger = LoggerFactory.getLogger(GuideController.class);
	
	@Autowired
	private GuideService guideService;
	
	// 조회수 많은 인기 게시글 top-3 요청 처리용
	@RequestMapping(value = "gtop3.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardTop3Method(HttpServletResponse response) throws UnsupportedEncodingException {
	    // ajax 요청시 리턴방법은 여러가지가 있음 (문자열, json 객체 등)
	    // 방법1 : 출력스트림을 따로 생성해서 응답하는 방법 -> public void 로 지정
	    // 방법2 : 뷰리졸버로 리턴해서 등록된 JSONView 가 내보내는 방법 (servlet-context.xml 에 등록)
	    // public String 으로 지정

	    // 조회수 많은 게시글 3개 조회 요청함
	    ArrayList<Guide> list = guideService.selectTop3();

	    // 내보낼 값에 대해 response 에 mimiType 설정
	    response.setContentType("application/json; charset=utf-8");

	    // 리턴된 list 를 json 배열에 옮겨 기록하기
	    JSONArray jarr = new JSONArray();

	    for (Guide guide : list) {
	        // 각 게시글 정보를 JSON 객체로 변환
	        JSONObject job = new JSONObject(); // org.json.simple.JSONObject 임포트

	        job.put("guidepostId", guide.getGuidepostId());
	        // 문자열값에 한글이 포함되어 있다면, 반드시 인코딩해서 저장해야 함
	        job.put("gtitle", URLEncoder.encode(guide.getGuideTitle(), "utf-8"));
	        // 조회수 또는 좋아요 수
	        job.put("lcount", guide.getLikeCount());
	        
	        job.put("glocation", guide.getGuideLocation());

	        // 추가적인 이미지 파일 정보 (carousel에 사용할 이미지 경로)
	        if (guide.getrFile1() != null && !guide.getrFile1().isEmpty()) {
	            job.put("rFile1", guide.getrFile1());
	        } else {
	            job.put("rFile1", "");  // 이미지가 없는 경우 빈 문자열
	        }

	        jarr.add(job); // 배열에 JSON 객체 추가
	    }

	    // 전송용 JSON 객체 생성
	    JSONObject sendJson = new JSONObject();
	    sendJson.put("glist", jarr); // glist 라는 키에 배열 추가

	    // 최종적으로 JSON 문자열로 변환하여 반환
	    return sendJson.toJSONString();
	}

	
	//가이드 게시판 페이징 처리
	@RequestMapping("sagBlog.do")
	public String guideListMethod(Model model,
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
		int listCount = guideService.selectListCount();
		logger.info("블로그 총 갯수 : " +listCount);
		
		// 페이징 처리 값생성
		Paging paging = new Paging(listCount, limit, currentPage, "sagBlog.do", groupLimit);
		paging.calculate();
		//paging 세팅---------------------------------------------------------------------------
	    // 서비스를 목록 조회 요청하고 결과 받기(페이징 처리)
		ArrayList<Guide> list = guideService.selectAllGuide(paging);  // 전체 목록 받기

	    logger.info("list : " + list);
	    if(list != null && list.size() > 0) {
	        model.addAttribute("list", list);
			model.addAttribute("paging",paging);
			model.addAttribute("currentPage",currentPage);
			return "guide/guideListView";  // 뷰의 이름을 반환
	    } else {
	        model.addAttribute("message", "목록 조회 실패!");
	        return "common/error";  // 에러 페이지 뷰의 이름 반환
	    }
	}
	
	
	

	//새 블로그 등록 페이지로 이동 처리
	@RequestMapping("gmoveWrite.do")
	public String moveWritePage() {
	    return "guide/guideWriteForm";  // guideWriteForm.jsp로 이동
	}
	
	
	// 새 공지글 등록 요청 처리용 (파일 업로드 기능 추가)
		@RequestMapping(value="ginsert.do", method=RequestMethod.POST)
		public String guideInsertMethod(Guide guide, Model model, HttpServletRequest request,
		    @RequestParam(name="gmfiles", required = false) MultipartFile[] gmfiles) {
		    logger.info("ginsert.do : " + guide);
		    
		    // 세션에서 로그인된 사용자 정보 가져오기
		    HttpSession session = request.getSession();
		    Member loginUser = (Member) session.getAttribute("loginUser");
		    
		    // loginUser가 null이 아닌 경우에 guideUserId를 설정
		    if (loginUser != null) {
		        guide.setGuideUserId(loginUser.getMemId());  // guideUserId에 로그인한 사용자 ID 설정
		    } else {
		        model.addAttribute("message", "로그인 정보가 없습니다.");
		        return "common/error";
		    }
		    
		    
		    // 파일 개수가 5개를 넘는지 확인
		    if (gmfiles != null && gmfiles.length > 5) {
		        model.addAttribute("message", "파일 개수는 최대 5개까지 가능합니다.");
		        return "common/error"; // 오류 발생 시 해당 JSP로 이동
		    }
		    
		    // 파일 저장 경로 설정
		    String savePath = "D:/ProjectWork/bonvoyage/src/main/webapp/resources/guide_upfiles";
		    

		    
		    // 5개의 컬럼에 맞게 파일명을 저장하기 위한 변수 선언
		    String[] ofiles = new String[5];
		    String[] rfiles = new String[5];

		    int fileIndex = 0;
		    
		    // 파일 배열에서 각 파일 처리
		    if (gmfiles != null) {
		        for (MultipartFile file : gmfiles) {
		            if (!file.isEmpty() && fileIndex < 5) {
		                // 파일의 원본 이름을 가져옴
		                String fileName = file.getOriginalFilename();
		                String renameFileName = null;
		                
		                // 파일 이름 바꾸기 : 년월일시분초.확장자
		                if (fileName != null && fileName.length() > 0) {
		                    renameFileName = FileNameChange.change(fileName, "yyyyMMddHHmmssSSS");

		                    try {
		                        // 실제 파일을 저장할 경로 지정
		                    	file.transferTo( new File(savePath + "\\" + renameFileName));// 파일 저장
		                    } catch (Exception e) {
		                        e.printStackTrace();
		                        model.addAttribute("message", "첨부파일 저장 실패!");
		                        return "common/error";
		                    }

		                    // 배열에 원본 파일명과 변경된 파일명을 저장
		                    ofiles[fileIndex] = fileName;
		                    rfiles[fileIndex] = renameFileName;

		                    // 다음 파일을 위한 인덱스 증가
		                    fileIndex++;
		                }
		            }
		        }
		    }

		    // guide 객체에 각각의 파일명을 저장 (OFILE1 ~ OFILE5, RFILE1 ~ RFILE5)
		    guide.setoFile1(ofiles[0]);
		    guide.setoFile2(ofiles[1]);
		    guide.setoFile3(ofiles[2]);
		    guide.setoFile4(ofiles[3]);
		    guide.setoFile5(ofiles[4]);

		    guide.setrFile1(rfiles[0]);
		    guide.setrFile2(rfiles[1]);
		    guide.setrFile3(rfiles[2]);
		    guide.setrFile4(rfiles[3]);
		    guide.setrFile5(rfiles[4]);
		    
		

		    // 데이터베이스에 저장
		   
		    if (guideService.insertGuide(guide) > 0) {
		        return "redirect:sagBlog.do"; // 성공 후 이동할 페이지
		    } else {
		        model.addAttribute("message", "블로그 등록 실패!");
		        return "common/error"; // 실패 시 에러 페이지
		    }
		    
		    
		}
	
	
	
	//블로그 상세내용 보기 요청 처리 메소드(뷰와 모델 함께 가져오는 방법)
	@RequestMapping("gdetail.do")
	public ModelAndView guideDetailMethod(
	        @RequestParam("guidepostId") String guidepostId,
	        ModelAndView mv, HttpSession session) {
		
		
		//회원인지 확인하기 위해 session 매개변수 추가함
		logger.info("gdetail.do : " + guidepostId);
		
		//조회수 1증가처리용 
		guideService.likeCount(guidepostId);

	    // 블로그 데이터를 guidepostId를 이용해 가져옴
	    Guide guide = guideService.selectGuide(guidepostId);

	    if (guide != null) {
	    	//세션에서 로그인한 사람정보 가져오기
	    	Member loginUser = (Member)session.getAttribute("loginUser");
			if(loginUser != null && loginUser.getUserId().equals(guide.getGuideUserId())) {
				mv.setViewName("guide/guideDetail");
	        // 블로그 데이터가 있을 경우 상세보기 페이지로 이동
	        mv.addObject("guide", guide);  // guide 객체를 뷰에 전달
	        mv.setViewName("guide/guideDetail");  // guideDetailView로 이동
	    } else {
	    	// 작성자가 아니면 수정할 수 없는 페이지로 이동
	    	 mv.addObject("guide", guide);
            mv.setViewName("guide/guideDetailView"); 
	    }}
			else {
	        // 블로그 데이터가 없을 경우 에러 페이지로 이동
	        mv.addObject("message", guidepostId + "번 블로그 상세보기 요청 실패!");
	        mv.setViewName("common/error");  // 에러 페이지로 이동
	    }

	    return mv;  // ModelAndView 반환
	}
		
		



//공지글 수정 페이지로 이동 처리용
	@RequestMapping("gmoveup.do")
	public ModelAndView moveUpdatePage(
			@RequestParam("guidepostId") String guidepostId, ModelAndView mv) {
		//수정페이지에 출력할 공지글 조회해 봄
		Guide guide = guideService.selectGuide(guidepostId);
		
		if(guide != null) {
			mv.addObject("guide", guide);
			mv.setViewName("guide/guideUpdateView");
		}else {
			mv.addObject("message", guidepostId + "번 공지글 수정페이지로 이동 실패!");
			mv.setViewName("common/error");
		}
		
		return mv;
	}//gmoveUpdatePage() end


	// 공지글 수정 요청 처리용 (파일 업로드 기능 추가)
	@RequestMapping(value = "gupdate.do", method = RequestMethod.POST)
	public String guideUpdate(Guide guide, Model model, HttpServletRequest request, 
	        @RequestParam(name = "deleteFlag1", required = false) String delFlag1,
	        @RequestParam(name = "deleteFlag2", required = false) String delFlag2,
	        @RequestParam(name = "deleteFlag3", required = false) String delFlag3,
	        @RequestParam(name = "deleteFlag4", required = false) String delFlag4,
	        @RequestParam(name = "deleteFlag5", required = false) String delFlag5,
	        @RequestParam(name = "gmfiles", required = false) MultipartFile[] gmfiles) {

	    logger.info("gupdate.do : " + guide); // 전송된 값 확인
	    
	    logger.info("deleteFlag1 : " +  delFlag1);
	    logger.info("gmfiles : " +  gmfiles.length);
	    
	    
	    // 파일 저장 경로 설정
	    String savePath = "D:/ProjectWork/bonvoyage/src/main/webapp/resources/guide_upfiles";

	    // 파일 처리 변수 선언
	    String[] ofiles = new String[5];
	    String[] rfiles = new String[5];
	    int fileIndex = 0;

	    // 1. 개별 파일 삭제 처리 (논리 연산자의 우선순위를 명확히 하기 위해 괄호 사용)
	    if (guide.getoFile1() != null && ((delFlag1 != null && delFlag1.equals("yes")) || (gmfiles != null && gmfiles.length > 0))) {
	        new File(savePath + "\\" + guide.getrFile1()).delete();
	        guide.setoFile1(null);
	        guide.setrFile1(null);
	    }
	    
	    if (guide.getoFile2() != null && ((delFlag2 != null && delFlag2.equals("yes")) || (gmfiles != null && gmfiles.length > 0))) {
	        new File(savePath + "\\" + guide.getrFile2()).delete();
	        guide.setoFile2(null);
	        guide.setrFile2(null);
	    }
	    
	    if (guide.getoFile3() != null && ((delFlag3 != null && delFlag3.equals("yes")) || (gmfiles != null && gmfiles.length > 0))) {
	        new File(savePath + "\\" + guide.getrFile3()).delete();
	        guide.setoFile3(null);
	        guide.setrFile3(null);
	    }
	    
	    if (guide.getoFile4() != null && ((delFlag4 != null && delFlag4.equals("yes")) || (gmfiles != null && gmfiles.length > 0))) {
	        new File(savePath + "\\" + guide.getrFile4()).delete();
	        guide.setoFile4(null);
	        guide.setrFile4(null);
	    }

	    if (guide.getoFile5() != null && ((delFlag5 != null && delFlag5.equals("yes")) || (gmfiles != null && gmfiles.length > 0))) {
	        new File(savePath + "\\" + guide.getrFile5()).delete();
	        guide.setoFile5(null);
	        guide.setrFile5(null);
	    }

	    // 2. 새로운 첨부파일이 있을 때 처리
	    if (gmfiles != null && gmfiles.length > 0) {
	        for (MultipartFile file : gmfiles) {
	            logger.info("업로드된 파일 이름: " + file.getOriginalFilename());
	            if (!file.isEmpty() && fileIndex < 5) {
	                // 파일 원본 이름 및 변경된 파일명 생성
	                String fileName = file.getOriginalFilename();
	                String renameFileName = FileNameChange.change(fileName, "yyyyMMddHHmmssSSS");

	                // 파일 저장
	                try {
	                    file.transferTo(new File(savePath + "\\" + renameFileName)); // 파일을 실제 경로에 저장
	                } catch (Exception e) {
	                    e.printStackTrace();
	                    model.addAttribute("message", "파일 저장 실패!");
	                    return "common/error";
	                }

	                // 파일명 배열에 저장
	                ofiles[fileIndex] = fileName;
	                rfiles[fileIndex] = renameFileName;
	                fileIndex++;
	            }
	        }

	        // 가이드 객체에 파일 정보 저장
	        guide.setoFile1(ofiles[0]);
	        guide.setoFile2(ofiles[1]);
	        guide.setoFile3(ofiles[2]);
	        guide.setoFile4(ofiles[3]);
	        guide.setoFile5(ofiles[4]);

	        guide.setrFile1(rfiles[0]);
	        guide.setrFile2(rfiles[1]);
	        guide.setrFile3(rfiles[2]);
	        guide.setrFile4(rfiles[3]);
	        guide.setrFile5(rfiles[4]);
	    }

	    // 데이터베이스 업데이트 수행
	    if (guideService.updateGuide(guide) > 0) { // 공지글 수정 성공시
	        return "redirect:gdetail.do?guidepostId=" + guide.getGuidepostId();
	    } else {
	        model.addAttribute("message", guide.getGuidepostId() + "번 공지글 수정 실패!");
	        return "common/error";
	    }
	}

	
	//삭제하기

	// 공지글 삭제 요청 처리용
	@RequestMapping("gdelete.do")
	public String guideDelete(
	        @RequestParam("guidepostId") String guidepostId,
	        HttpServletRequest request, Model model) {
	    
	    if (guideService.deleteGuide(guidepostId) > 0) { // 공지글 삭제 성공 시
	        return "redirect:sagBlog.do";  // 목록 페이지로 리다이렉트
	    } else {
	        model.addAttribute("message", guidepostId + "번 공지글 삭제 실패!");
	        return "common/error";  // 에러 페이지로 이동
	    }
	}
	
	// 통합 검색 처리용 (제목, 내용, 지역을 하나의 메소드에서 처리)
	@RequestMapping("gsearch.do")
	public ModelAndView guideSearchMethod(ModelAndView mv, 
	        @RequestParam("action") String action, // 검색 기준 (title, content, location)
	        @RequestParam("keyword") String keyword, 
	        @RequestParam(name = "page", required = false) String page,
	        @RequestParam(name = "limit", required = false) String slimit,
	        @RequestParam(name = "groupLimit", required = false) String glimit) {

	    // 페이징 처리
	    int currentPage = 1;
	    if (page != null) {
	        currentPage = Integer.parseInt(page);
	    }

	    int limit = 10;
	    if (slimit != null) {
	        limit = Integer.parseInt(slimit);
	    }

	    int groupLimit = 5;
	    if (glimit != null) {
	        groupLimit = Integer.parseInt(glimit);
	    }

	    // 검색 결과 목록 총 갯수 조회 및 페이징 처리
	    int listCount = 0;
	    ArrayList<Guide> list = null;
	    Paging paging = null;
	    
	    // 검색 기준에 따라 다른 쿼리 호출
	    if (action.equals("title")) {
	        listCount = guideService.selectSearchTitleCount(keyword);
	        paging = new Paging(listCount, limit, currentPage, "gsearch.do", groupLimit);
	        paging.calculate();
	        Search search = new Search();
	        search.setKeyword(keyword);
	        search.setStartRow(paging.getStartRow());
	        search.setEndRow(paging.getEndRow());
	        list = guideService.selectSearchTitle(search);
	    } else if (action.equals("content")) {
	        listCount = guideService.selectSearchContentCount(keyword);
	        paging = new Paging(listCount, limit, currentPage, "gsearch.do", groupLimit);
	        paging.calculate();
	        Search search = new Search();
	        search.setKeyword(keyword);
	        search.setStartRow(paging.getStartRow());
	        search.setEndRow(paging.getEndRow());
	        list = guideService.selectSearchContent(search);
	    } else if (action.equals("location")) {
	        listCount = guideService.selectSearchLocationCount(keyword);
	        paging = new Paging(listCount, limit, currentPage, "gsearch.do", groupLimit);
	        paging.calculate();
	        Search search = new Search();
	        search.setKeyword(keyword);
	        search.setStartRow(paging.getStartRow());
	        search.setEndRow(paging.getEndRow());
	        list = guideService.selectSearchLocation(search);
	    }

	    // 검색 결과 리스트 확인 후 뷰 설정
	    if (list != null && list.size() > 0) {
	        mv.addObject("list", list);
	        mv.addObject("paging", paging);
	        mv.addObject("currentPage", currentPage);
	        mv.addObject("action", action);
	        mv.addObject("keyword", keyword);
	        mv.setViewName("guide/guideListView");
	    } else {
	        mv.addObject("message", action + "에 대한 " + keyword + " 검색 결과가 존재하지 않습니다.");
	        mv.setViewName("common/error");
	    }

	    return mv;
	}






	
		

	
	
}// end
	


