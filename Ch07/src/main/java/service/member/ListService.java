package service.member;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MemberDao;
import dao.UserDao;
import model.CommonService;
import vo.MemberVo;
import vo.UserVo;

public class ListService implements CommonService {
		
		@Override
		public String requestProc(HttpServletRequest req, HttpServletResponse resp) {
			
			List<MemberVo> members = MemberDao.getInstance().selectMembers();
			
			req.setAttribute("members", members);
			
			return "/member/list.jsp";
		}
	}