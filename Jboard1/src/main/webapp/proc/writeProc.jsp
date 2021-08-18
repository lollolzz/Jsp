<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="Kr.co.jboard1.db.Sql"%>
<%@page import="java.io.File"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="Kr.co.jboard1.db.DBConfig"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%

		/*
		파일첨부시 주의사항 
		id를 제외하고는 시간형식으로 저장하는 것이 좋다.
		다운로드 : 시간으로 저장한 것을 원레이름을 바꿔야한다
		- 근데 원레 이름은 이미 지워진 상태 
		- 그래서 DB에 원레이름을 저장해놓아야한다(file tag에 저장해두어야한다)
		: DB에 INSERT를 해주어야한다 (그니까 file tag에 파일을 미리 insert 해두어야 한다는 의미)
		- 파일업로드 후 이름 수정 -> insert
		*/
		
		// 전송 데이터 수신 
		request.setCharacterEncoding("utf-8");

		// Multipart 전송 데이터 수신(파일 업로드와 동시에 처리)
		String path = request.getServletContext().getRealPath("/file");
		int maxSize = 1024 * 1024 * 10; // 최대 파일 허용량 10MB
		
		MultipartRequest mRequest = new MultipartRequest(request, path, maxSize, "UTF-8", new DefaultFileRenamePolicy());
		String uid 		= mRequest.getParameter("uid");
		String title 	= mRequest.getParameter("title");
		String content 	= mRequest.getParameter("content");
		String fname 	= mRequest.getFilesystemName("fname"); // 첨부파일 이름
		String regip 	= request.getRemoteAddr();
		
		int seq = 0;
		
		try{
			
			// 1,2단계
			Connection conn = DBConfig.getInstance().getConnection();
			// 3단계
			Statement stmt = conn.createStatement();
			PreparedStatement psmt = conn.prepareStatement(Sql.INSERT_ARTICLE);
			psmt.setString(1, title);
			psmt.setString(2, content);
			psmt.setInt(3, fname == null ? 0:1);
			psmt.setString(4, uid);
			psmt.setString(5, regip);
			// 4단계
			psmt.executeUpdate();
			ResultSet rs = stmt.executeQuery(Sql.SELECT_MAX_SEQ);
			// 단계 
			if(rs.next()){
				seq = rs.getInt(1);
			}
			
			// 6단계
			rs. close();
			stmt.close();
			psmt.close();
			conn.close();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		// 파일첨부 했으면 파일 처리작업 
		// fname == null -파일 첨부하지 않은 
		if(fname != null){
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
			oriFile.renameTo(newFile);
			
			// 파일 테이블 INSERT
			try{
				// 1,2단계 
				Connection conn = DBConfig.getInstance().getConnection();
				// 3단계
				PreparedStatement psmt = conn.prepareStatement(Sql.INSERT_FILE);
				psmt.setInt(1, seq);
				psmt.setString(2, fname);
				psmt.setString(3, newName);
				// 4단계
				psmt.executeUpdate();
				// 5단계
				// 6단계
				psmt.close();
				conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
			
		}
		// 리다이렉트
		response.sendRedirect("/Jboard1/list.jsp?pg=1");



%>