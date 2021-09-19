package kr.co.jboard3.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jboard3.dao.ArticleDao;
import kr.co.jboard3.vo.ArticleVo;

public class ViewService implements CommonService {
	
	@Override
	public String requestProc(HttpServletRequest req, HttpServletResponse resp) {
		
		String seq = req.getParameter("seq");
		
		ArticleDao dao = ArticleDao.getInstance();
		
		ArticleVo vo = dao.selectArticle(seq);
		List<ArticleVo> comments = dao.selectComments(seq);
		
		req.setAttribute("vo", vo);
		req.setAttribute("comments", comments);
		
		
		return null;
	}

}
