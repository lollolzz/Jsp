package service.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserDao;
import model.CommonService;
import vo.UserVo;

public class RegisterService implements CommonService{
	
	// 사용자가 요청한 작업을 해줄 java파일
	@Override
	public String requestProc(HttpServletRequest req, HttpServletResponse resp) {
		
		if(req.getMethod().equals("GET")) {
			return "/user/register.jsp";
		}else {
			String uid 	= req.getParameter("uid");
			String name = req.getParameter("name");
			String hp 	= req.getParameter("hp");
			String age	= req.getParameter("age");
			
			UserVo vo = new UserVo();
			vo.setUid(uid);
			vo.setName(name);
			vo.setHp(hp);
			vo.setAge(age);
			// 파라미터로 받은 age는 문자열이고 UserVo에 설정해둔 age는 int
			// UserVo에 추가 설명 기입 되어 있음 
			
			// Dao 실행
			UserDao.getInstance().inserUser(vo);
			
			return "redirect:/user/list.do";
			// redirect도 maincontrller에서 수행한다 
			// redirect형식을 그냥 저런식으로 써놓은 것 뿐 의미는 없다. 
			// redirect를 maincontroller의 String view쪽으로 이동 
			
			
			
			
			
		}
	}

}
