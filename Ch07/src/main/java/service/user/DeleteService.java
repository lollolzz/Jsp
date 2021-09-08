package service.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserDao;
import model.CommonService;

public class DeleteService implements CommonService {
	
	@Override
	public String requestProc(HttpServletRequest req, HttpServletResponse resp) {
		
		String uid = req.getParameter("uid");
		// list에서 삭제 누르면 여기 파라미터가 받아준다
		UserDao.getInstance().deleteUser(uid);
		
		
		
		return "redirect:/user/list.do";
	}
}
