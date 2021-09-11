package service.user;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserDao;
import model.CommonService;
import vo.UserVo;

public class ListService  implements CommonService{

	// 사용자가 요청한 작업을 해줄 java파일 
		@Override
		public String requestProc(HttpServletRequest req, HttpServletResponse resp) {
			
			List<UserVo> users = UserDao.getInstance().selectUsers();
			// view에서 users를 참조해서 출력해야한다
			
			// 컴포넌트간의 데이터 공유(view에서 해당 list를 참조해서 출력해야하기 때문에)
			// req를 이용해서 List<UserVo> users이것을 참조해서 출력하자
			// -> request는 하나다 
			req.setAttribute("users", users);
					
			return "/user/list.jsp";
		}
}
