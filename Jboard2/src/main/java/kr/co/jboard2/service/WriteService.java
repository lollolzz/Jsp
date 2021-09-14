package kr.co.jboard2.service;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.co.jboard2.dao.ArticleDao;
import kr.co.jboard2.vo.ArticleVo;

public class WriteService implements CommonService {
	
	// MultipartRequest의 path를 함께 전역변수로 선언하엿다
	private String path = null;
	
	@Override
	public String requestProc(HttpServletRequest req, HttpServletResponse resp) {
		
		// post전송시 사용
		if(req.getMethod().equals("GET")) {
			return "/write.jsp";
			
		}else {
			// write.jsp에서 "multipart/form-data적용시켜 주엇기 때문에  바로 밑의 문구를 넣어줘야한다
			MultipartRequest mReq = getMultipartRequset(req);
			String title   = mReq.getParameter("title");
			String content = mReq.getParameter("content");
			String uid     = mReq.getParameter("uid");
			String fname   = mReq.getFilesystemName("fname");
			// regip받아오는 방법 알아 두기 
			String regip   = req.getRemoteAddr();
			
			ArticleVo vo = new ArticleVo();
			vo.setTitle(title);
			vo.setContent(content);
			vo.setFile(fname == null ? 0 : 1);
			// fname이 null값이면 0,, 아니라면 +1값이 db에 적용된다.
			vo.setUid(uid);
			// session을 사용해서 받아와도 되지만 parameter 써도 상관없다
			vo.setRegip(regip);

			// 글번호를 리턴 받아야한다 
			// 받아야지 파일 정보를 insert할때 파일 정보를 insert할수 있다(parent값을)
			// 추가 설명은 ArticleDao insertArticle밑에 적어둠 
			int seq = ArticleDao.getInstance().insertArticle(vo);
			
			if(fname != null) {
				// 파일 첨부 했으면 이름 수정하고 INSERT
				String newName = renameFile(fname, uid);
				ArticleDao.getInstance().insertFile(seq, fname, newName);
			}
			
			
			return "redirect:/list.do";
			
			
		}

	}// requestProc end
	
	// 따로 메서드를만든이유는 multipartrequest를 예외 처리를 해야하기때문에 구조를 간단하게
	// 하기위하여 따로 만들어 주엇다
	public MultipartRequest getMultipartRequset(HttpServletRequest req) {
		
		MultipartRequest mReq = null;
		
		try {
			
			path = req.getServletContext().getRealPath("/file");
			// 전역 변수로 선언하여 주자 
			// 바로 밑의 메서드에서도 path를 사용해야 하는데 
			// 지역변수면 참조 할 수 가 없기때문
			int maxSize = 1024 * 1024 * 10; // 최대 파일 허용크기 10MB
			
			mReq = new MultipartRequest(req, path, maxSize ,"UTF-8", new DefaultFileRenamePolicy());

		}catch(IOException e) {
			e.printStackTrace();
		}
		
		return mReq;

	}

	public String renameFile(String fname, String uid) {
		
		
			// 파일 수정
			int i = fname.lastIndexOf(".");
			String ext = fname.substring(i); //substring - 문자열 짜르기 
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss_");
			String now = sdf.format(new Date());
			String newName = now+uid+ext;
			
			File oriFile = new File(path+"/"+fname);
			File newFile = new File(path+"/"+newName);
			// 가상의 파일을 생성 // 이름 : 2021/08/16.....
			
			// newName의 파일 이름을 수정해주는 작업
			// requestProc 제일 하단에 이름 수정하고 insert하는 부분이 잇다.
			oriFile.renameTo(newFile);
			
			return newName;
		
	}
	
		
		
	
	
}