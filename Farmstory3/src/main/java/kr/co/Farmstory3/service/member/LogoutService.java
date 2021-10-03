package kr.co.farmstory3.service.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.farmstory3.service.CommonService;



public class LogoutService implements CommonService {

	@Override
	public String requestProc(HttpServletRequest req, HttpServletResponse resp) {
		
		// 세션에서 사용자 정보객체 제거
		HttpSession sess = req.getSession();
		//requset를 통해 session을 얻어온다
		sess.invalidate();
		// invalidate -> 서버에서 정보 삭제하는 것
		// 다시말해 session을 종료하는 것
		
		// 리퀘스트는 클라이언트에대한 정보가 만들어지고 리퀘스트를 통해서 세션을 구한다
		// 즉 세션이 브라우저(클라이언트)다. -> 각 개별 클라이언트라고 생각하면된다.
	
		
		return "redirect:/member/login.do?success=101";
	}
}

