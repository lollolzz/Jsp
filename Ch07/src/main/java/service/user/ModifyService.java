package service.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserDao;
import model.CommonService;
import vo.UserVo;

public class ModifyService  implements CommonService{

	// 사용자가 요청한 작업을 해줄 java파일 
		@Override
		public String requestProc(HttpServletRequest req, HttpServletResponse resp) {
			
			//selectUser로 계정을 불러오고 그다음에 updateUser로 수정한ㄷ
			if(req.getMethod().equals("GET")) {
				String uid = req.getParameter("uid");
				UserVo vo = UserDao.getInstance().selectUser(uid);
				req.setAttribute("user", vo);
				
				return "/user/modify.jsp";	
			}else { // post 방식은 form양식을 불러와 실제로 수정 하는 행위를 하게 해준다
				String uid  = req.getParameter("uid");
				String name = req.getParameter("name");
				String hp   = req.getParameter("hp");
				String age  = req.getParameter("age");
				
				UserVo vo = new UserVo();
				vo.setUid(uid);
				vo.setName(name);
				vo.setHp(hp);
				vo.setAge(age);
				
				// Dao 사용
				
				UserDao.getInstance().updateUser(vo);
				
				return "redirect:/user/list.do";
			}
			
			
			
		}

	}