package model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class HelloService implements CommonService {
	// 사용자가 요청한 작업을 해줄 java파일
	
	@Override
	public String requestProc(HttpServletRequest req, HttpServletResponse resp) {
		// TODO Auto-generated method stub
		return "/hello.jsp";
	}

}
