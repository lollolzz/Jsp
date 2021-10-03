package kr.co.farmstory3.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import kr.co.farmstory3.db.DBConfig;
import kr.co.farmstory3.db.Sql;
import kr.co.farmstory3.vo.ArticleVo;
import kr.co.farmstory3.vo.FileVo;

public class ArticleDao {
	
	private static ArticleDao instance = new ArticleDao();
	public static ArticleDao getInstance() {
		return instance;
	}
	
	private ArticleDao() {}
	
	
	
	public void insertFile(int seq, String oriName, String newName) {
		
		try {
			Connection conn = DBConfig.getInstance().getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.INSERT_FILE);
			psmt.setInt(1, seq);
			psmt.setString(2, oriName);
			psmt.setString(3, newName);
			
			psmt.executeUpdate();
			psmt.close();
			conn.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void insertComment(ArticleVo vo) {
		
		try {
			Connection conn = DBConfig.getInstance().getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.INSERT_COMMENT);
			psmt.setInt(1, vo.getParent());
			psmt.setString(2, vo.getContent());
			psmt.setString(3, vo.getUid());
			psmt.setString(4, vo.getRegip());
			psmt.executeUpdate();
			
			psmt.close();
			conn.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public int insertArticle(ArticleVo vo) {



		try {
			Connection conn = DBConfig.getInstance().getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.INSERT_ARTICLE);
			psmt.setString(1, vo.getCate());
			psmt.setString(2, vo.getTitle());
			psmt.setString(3, vo.getContent());
			psmt.setInt(4, vo.getFile());
			psmt.setString(5, vo.getUid());
			psmt.setString(6, vo.getRegip());
			
			// executeUpdate의 리턴값은 뭘까요?
			// return값은 1이다 글 작성시 insert되는것이 하나이기때문이다(글을 한번에 한개씩만 작성)
			// return = 1; 을 적어도 되지만 굳이 안쓰고 의미만 알고 있도록 하자 
			// int result = psmt.executeUpdate();
			psmt.executeUpdate();
			
			psmt.close();
			conn.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return selectMaxSeq();
		// insert한 글 번호가 retrun 되는 것이다 
	}
	
	// insertArticle과 selectMaxSeq의 관계
	// 글을 작성하면 artilce_table에 작성한 글이 업로드 되고 
	// 작성한 글은 최신글이라 db 제일마지막에 들어간 글이 된다
	// db에 업로드된 최신 글의 번호를 불러온다 why?
	// file_table에도 그 글과 같과 마찬가지로 저장을 했기 때문에
	// 글 번호가 필요하다
	// selectMaxSeq를 insertArticle에서 return 하는 이유는 
	// file_table에 저장된 parent를 artilce_table대입시켜 주어야 하기 때문이다.
	public int selectMaxSeq() {
		int seq = 0;
		
		try {
			Connection conn = DBConfig.getInstance().getConnection();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(Sql.SELECT_MAX_SEQ);
			
			if(rs.next()) {
				seq = rs.getInt(1);
			}
							
		}catch(Exception e) {
			e.printStackTrace();
		}
		return seq;
	}
	
	public FileVo selectFile(String fseq) {
		
		FileVo fvo = null;
		
		try {
			
			Connection conn = DBConfig.getInstance().getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.SELECT_FILE);
			// 파일번호를 조회해야한 fseq
			psmt.setString(1, fseq);
			
			ResultSet rs = psmt.executeQuery();
			
			if(rs.next()) {
				fvo = new FileVo();
				
				fvo.setFseq(rs.getInt(1));
				fvo.setParent(rs.getInt(2));
				fvo.setOriName(rs.getString(3));
				fvo.setNewName(rs.getString(4));
				fvo.setDownload(rs.getInt(5));
				fvo.setRdate(rs.getString(6));
			}
	
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return fvo;
	}
	
	
	
	public ArticleVo selectArticle(String seq) {
			
			ArticleVo vo = null;
			try {
				Connection conn = DBConfig.getInstance().getConnection();
				PreparedStatement psmt = conn.prepareStatement(Sql.SELECT_ARTICLE);
				psmt.setString(1, seq);
				
				ResultSet rs = psmt.executeQuery();
				
				if(rs.next()) {
					vo = new ArticleVo();
					vo.setSeq(rs.getInt(1));
					vo.setParent(rs.getInt(2));
					vo.setComment(rs.getInt(3));
					vo.setCate(rs.getString(4));
					vo.setTitle(rs.getString(5));
					vo.setContent(rs.getString(6));
					vo.setFile(rs.getInt(7));
					vo.setHit(rs.getInt(8));
					vo.setUid(rs.getString(9));
					vo.setRegip(rs.getString(10));
					vo.setRdate(rs.getString(11));
					
					// 파일정보
					// ArticleVo 안에 FileVo를 저장 시켜 두엇기 때문에
					// 그안에 저장된것을 불러와야한다 그래서 아래와 같이 적음
					FileVo fvo = new FileVo();
					fvo.setFseq(rs.getInt(12));
					fvo.setParent(rs.getInt(13));
					fvo.setOriName(rs.getString(14));
					fvo.setNewName(rs.getString(15));
					fvo.setDownload(rs.getInt(16));
					fvo.setRdate(rs.getString(17));
									
					vo.setFb(fvo);
				}
			}catch (Exception e) {
				e.printStackTrace();
			}
			
			return vo;
		}
	
public List<ArticleVo> selectArticles(String cate, int start) {
		
		List<ArticleVo> articles = new ArrayList<>();
		
		try {
			Connection conn = DBConfig.getInstance().getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.SELECT_ARTICLES);
            psmt.setString(1, cate);
            psmt.setInt(2, start);
			// start는 변수이름 
			ResultSet rs = psmt.executeQuery();
			
			while(rs.next()) {
				// 사실 list.jsp페이지에서 작성되어진 목록만 불러오면 되지만 
				// 그냥 다 가져온것.
				ArticleVo vo = new ArticleVo();
				vo.setSeq(rs.getInt(1));
				vo.setParent(rs.getInt(2));
				vo.setComment(rs.getInt(3));
				vo.setCate(rs.getString(4));
				vo.setTitle(rs.getString(5));
				vo.setContent(rs.getString(6));
				vo.setFile(rs.getInt(7));
				vo.setHit(rs.getInt(8));
				vo.setUid(rs.getString(9));
				vo.setRegip(rs.getString(10));
				vo.setRdate(rs.getString(11).substring(2, 10));
				vo.setNick(rs.getString(12));
				
				articles.add(vo);
			}
			
			rs.close();
			psmt.close();
			conn.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return articles;
	}
	
	public List<ArticleVo> selectComments(String parent) {
		
		
		List<ArticleVo> comments = new ArrayList<>();
		
		try {
			
			Connection conn = DBConfig.getInstance().getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.SELECT_COMMENTS);
			psmt.setString(1, parent);
			
			ResultSet rs = psmt.executeQuery();
			
			while(rs.next()) {
				
				ArticleVo vo = new ArticleVo();
				vo.setSeq(rs.getInt(1));
				vo.setParent(rs.getInt(2));
				vo.setComment(rs.getInt(3));
				vo.setCate(rs.getString(4));
				vo.setTitle(rs.getString(5));
				vo.setContent(rs.getString(6));
				vo.setFile(rs.getInt(7));
				vo.setHit(rs.getInt(8));
				vo.setUid(rs.getString(9));
				vo.setRegip(rs.getString(10));
				vo.setRdate(rs.getString(11).substring(2, 10));
				vo.setNick(rs.getString(12));
				
				comments.add(vo);
				
				rs.close();
				psmt.close();
				conn.close();
				
			}

		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return comments;
	}

	public void updateArticle() {}
	public void deleteArticle() {}

	

	public int selectCountTotal() {

		int total = 0;
		
		try {
			
			Connection conn =DBConfig.getInstance().getConnection();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(Sql.SELECT_COUNT_TOTAL);
			
			if(rs.next()) {
				total = rs.getInt(1);
			}
	
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return total;
		
	}
	
	

}
