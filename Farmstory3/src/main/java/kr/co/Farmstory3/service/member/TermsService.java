package kr.co.farmstory3.service.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.farmstory3.dao.MemberDao;
import kr.co.farmstory3.service.CommonService;
import kr.co.farmstory3.vo.TermsVo;

public class TermsService implements CommonService {

	@Override
	public String requestProc(HttpServletRequest req, HttpServletResponse resp) {
		
		TermsVo vo = MemberDao.getInstance().selectTerms();
		
		req.setAttribute("vo", vo);
		// terms페이지에 표현식으로 vo를 사용하엿기 때문에 req로 불러와준다

		return "/member/terms.jsp";
	}

}
