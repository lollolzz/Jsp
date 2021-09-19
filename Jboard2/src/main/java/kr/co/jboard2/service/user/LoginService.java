package kr.co.jboard2.service.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.jboard2.service.CommonService;
import kr.co.jboard2.vo.MemberVo;
import kr.co.jboard2.dao.MemberDao;

public class LoginService implements CommonService {

	@Override
	public String requestProc(HttpServletRequest req, HttpServletResponse resp) {
		
		if(req.getMethod().equals("GET")) {
			
			String success = req.getParameter("success");
			req.setAttribute("success", success);
			
			return "/user/login.jsp";	
		}else {
			
			String uid  = req.getParameter("uid");
			String pass = req.getParameter("pass");
			
			// 받아온 uid,pass가 db에 있는지 확인해야 한다 
			MemberVo vo = MemberDao.getInstance().selectMember(uid, pass);
			// 해당되는 사용자가 있다면 제대로 return되지만 null값이올 경우도 있다.
			if(vo != null) {
				// 회원 맞을 경우 -> 사용자 정보객체 세션저장 후 리스트 리다이렉트 
				HttpSession sess = req.getSession();
				// session을 request를 통해 얻어오기 
				sess.setAttribute("sessMember", vo);
				// setAttribute를 사용해 session에 정보를 저장한다.
				
				return "redirect:/list.do";
			}else {
				// 회원 아닐 경우 -> 다시 로그인페이지 리다이렉트
				return "redirect:/user/login.do?success=100";
				// success10x 이게 로그인으로 리다이렉트 됐다가 다시 로그인 서비스 페이지로
				// 와서 req에 담긴다 그래서 윗 부분에 success를 parmeter해준다
				// parameter한 sucess를 login.jsp에서 사용할거기 때문에
				// req.setAttribute("success", success);이것을 사용함
				
				// 위의 루틴을 각 success마다 실행한다
			}
		}
	}
}

