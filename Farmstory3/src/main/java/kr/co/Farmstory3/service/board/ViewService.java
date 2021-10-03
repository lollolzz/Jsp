package kr.co.farmstory3.service.board;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.farmstory3.dao.ArticleDao;
import kr.co.farmstory3.service.CommonService;
import kr.co.farmstory3.vo.ArticleVo;

public class ViewService implements CommonService {

	@Override
	public String requestProc(HttpServletRequest req, HttpServletResponse resp) {
		
		String group = req.getParameter("group");
		String cate  = req.getParameter("cate");
		
		String seq = req.getParameter("seq");
		 
		 // 싱글톤으로 불러오기 위해서 인가 ?
		 ArticleDao dao = ArticleDao.getInstance();	 
		 
		 ArticleVo vo = ArticleDao.getInstance().selectArticle(seq);
		 List<ArticleVo> comments = dao.selectComments(seq);
		 
		 req.setAttribute("vo", vo);
		 req.setAttribute("comments", comments);
		 
		 req.setAttribute("group", group);
		 req.setAttribute("cate", cate);
		
		return "/board/view.jsp";
	}

}
