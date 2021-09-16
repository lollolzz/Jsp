package kr.co.jboard2.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jboard2.dao.ArticleDao;
import kr.co.jboard2.vo.FileVo;

public class FileDownloadService implements CommonService {
	
	@Override
	public String requestProc(HttpServletRequest req, HttpServletResponse resp) {
		
		String fseq = req.getParameter("fseq");
		//  <a href="/Jboard2/fileDownload.do?fseq=${vo.fb.fseq}"> 
		// view.jsp에서 쏘아준것응 받아오는 것
		
		// 파일 다운로드 카운트 +1
		
		// 파일 정보 가져오기 
		
		FileVo fvo = ArticleDao.getInstance().selectFile(fseq);
		
		
		// Controller에서 파일 다운로드 기능 실행을 위한 문자열 
		req.setAttribute("fvo", fvo);
		
		return "file";
		// file로 리턴해야 컨트롤러에서 받을 수 있다.
		// else if(resutl.startWith("file:"))-> 이부분에서 받는다. 
		
		
	}

}
