<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="org.apache.coyote.http11.filters.BufferedInputFilter"%>
<%@page import="java.io.File"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="Kr.co.jboard1.bean.FileBean"%>
<%@page import="Kr.co.jboard1.dao.ArticleDao"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%

	// 전송 파라미터 수신
	request.setCharacterEncoding("utf-8");
	String fseq = request.getParameter("fseq");
	
	// 파일 정보 Select
	ArticleDao dao = ArticleDao.getInstance();
	FileBean fb = dao.selectFile(fseq);
	// fseq는 view페이지에서 parameter로 받아 와야한다 
	
	// 파일 다운로드 카운트 update
	dao.updateFileDownload(fseq);
	
	// response 헤더 수정
	response.setContentType("application/octet-stream");
	response.setHeader("Content-Disposition", "attachment; filename="+URLEncoder.encode(fb.getOriName(), "utf-8"));
	// URLEncoder.encode("파일명.txt", "utf-8"));-> 1번 ""의 이름으로  2번"" 형식으로 파일이 다운받아 진다 
	response.setHeader("Content-Transfer-Encoding", "binary");
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Cache-Control", "private");
	
	// response 객체 파일 스트림 작업
	String path = request.getServletContext().getRealPath("/file");
	File file = new File(path+"/"+fb.getNewName());
	
	BufferedInputStream bis = new BufferedInputStream(new FileInputStream(file)); 
	BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());
	
	while(true){
		int data = bis.read();
		
		if(data == -1){ // data가 없을경우
			break;
		}
		bos.write(data);
	}
	bos.close();
	bis.close();
	




%>