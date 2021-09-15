package kr.co.jboard2.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.jboard2.dao.ArticleDao;
import kr.co.jboard2.vo.ArticleVo;
import kr.co.jboard2.vo.MemberVo;

public class ListService implements CommonService {
	
	@Override
	public String requestProc(HttpServletRequest req, HttpServletResponse resp) {
		
		// listservice페이지 작성시 List<>이런식으로 작성해야 하는데 
		// login기능이 구현되어서 이와 같은 방식으로 작성된것
		
		HttpSession sess = req.getSession();
		MemberVo sessMember = (MemberVo)sess.getAttribute("sessMember");
		// 세션을 이용해서 로그인한 사용자 정보에 대한것을 MemberVo를 이용해서 가져온다 
		// 로그인을 안하면 list가 보이지 않도록 설정을 해서 위와 같이 적용해준다.
		
		if(sessMember == null) {
			// 로그인 실패했을 때 
			return "redirect:/user/login.do?success=102";
		}else {
			
			String pg = req.getParameter("pg");

			// 페이지 처리
			int currentPage  = getCurrentPageNum(pg);
			int total        = ArticleDao.getInstance().selectCountTotal();
			int lastPageNum  = getLastPageNum(total);			
			int start        = getLimitStart(currentPage);
			int pageStartNum = getPageStartNum(total, start); 
			int[] groups     = getPageGroup(currentPage, lastPageNum);

			// 로그인 성공 했을때 list불러오는거 
			List<ArticleVo> articles = ArticleDao.getInstance().selectArticles(start);
			// dao페이지에서 () -> 메개변수로 int start를 잡아주엇기 때문에 위에 start를 사용한다
			req.setAttribute("articles", articles);
			req.setAttribute("lastPageNum", lastPageNum);
			req.setAttribute("currentPage", currentPage);
			req.setAttribute("pageStartNum", pageStartNum);
			req.setAttribute("groups", groups);
				
			
			return "/list.jsp";
		}
		
	}// requestPrco end...
	
public int getCurrentPageNum(String pg) {
		
		if(pg == null) {
			pg = "1";
		}
		return Integer.parseInt(pg);
	}
	
	public int getLastPageNum(int total) {
		
		int lastPageNum = 0;
				
		if(total % 10 == 0){
			lastPageNum = total / 10;
		}else{
			lastPageNum = total / 10 + 1;
		}
		
		return lastPageNum;

	}

	public int getLimitStart(int currentPage) {
		return (currentPage - 1) * 10;
	}
	
	public int getPageStartNum(int total, int start) {
		return (total - start)+1;
	}
	
	public int[] getPageGroup(int currentPage, int lastPageNum) {
		int groupCurrent = (int)Math.ceil(currentPage / 10.0);
		int groupStart = (groupCurrent - 1) * 10 + 1;
		int groupEnd = groupCurrent * 10;
		
		if(groupEnd > lastPageNum){
			groupEnd = lastPageNum;
		}
		
		int[] groups = {groupStart, groupEnd};
		
		return groups;
	}
	
	

}