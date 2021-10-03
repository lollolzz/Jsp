package kr.co.farmstory3.service.board;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.farmstory3.dao.ArticleDao;
import kr.co.farmstory3.service.CommonService;
import kr.co.farmstory3.vo.FileVo;


public class FileDownloadService implements CommonService {

	@Override
	public String requestProc(HttpServletRequest req, HttpServletResponse resp) {
		
		
		String fseq = req.getParameter("fseq");
		//  <a href="/Jboard2/fileDownload.do?fseq=${vo.fb.fseq}"> 
		// view.jsp에서 쏘아준것응 받아오는 것
		
		// 파일 다운로드 카운트 +1
		
		
		// 파일 정보 가져오기
		
		FileVo fvo = ArticleDao.getInstance().selectFile(fseq);
		
		
		
		// Controller에서 파일객체 참조하기 위해 여기서 저장
		req.setAttribute("fvo", fvo);
		
		
		// Controller에서 파일 다운로드 기능 실행을 위하여 문자열 
		return "file";
		// file로 리턴해야 컨트롤러에서 받을 수 있다 .
		// else if(result.startsWith("file:")) -> 이부분에서 받는다
		
		
		// requsetScop에 저장되어져 있는 
	}
	
}
