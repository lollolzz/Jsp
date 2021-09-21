package kr.co.jboard2.service.user;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jboard2.dao.MemberDao;
import kr.co.jboard2.service.CommonService;
import kr.co.jboard2.vo.TermsVo;
import kr.co.jboard2.vo.MemberVo;


public class TermsService implements CommonService {

	@Override
	public String requestProc(HttpServletRequest req, HttpServletResponse resp) {
		
		TermsVo vo = MemberDao.getInstance().selectTerms();
		// deleteService 페이지 만드는 것과 매우 흡사하다
		// UserDao에 selectTerms에 무엇을 넣어야 하는지만 잘생각 해보면 만들 수가 있다.
		req.setAttribute("vo", vo);
		
		return "/user/terms.jsp";
	}

}