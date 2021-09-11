package service.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MemberDao;
import dao.UserDao;
import model.CommonService;
import vo.MemberVo;
import vo.UserVo;

public class RegisterService implements CommonService {

	@Override
	public String requestProc(HttpServletRequest req, HttpServletResponse resp) {
		
		if(req.getMethod().equals("GET")) {
			return "/user/register.jsp";	
		}else {
			String uid  = req.getParameter("uid");
			String name = req.getParameter("name");
			String hp   = req.getParameter("hp");
			String age  = req.getParameter("age");
			
			UserVo vo = new UserVo();
			vo.setUid(uid);
			vo.setName(name);
			vo.setHp(hp);
			vo.setAge(age);
			
		
			UserDao.getInstance().insertUser(vo);
			
			return "redirect:/user/list.do";
			// 컨트롤러가 받아서 리다이렉트를 수행하도록 값을 반환한다 => 문자열 정보이다.
		
		}		
		
	}

}