package kr.co.jboard2.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import kr.co.jboard2.db.DBConfig;
import kr.co.jboard2.db.Sql;
import kr.co.jboard2.vo.ArticleVo;

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
	
	public int insertArticle(ArticleVo vo) {

		try {
			Connection conn = DBConfig.getInstance().getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.INSERT_ARTICLE);
			psmt.setString(1, vo.getTitle());
			psmt.setString(2, vo.getContent());
			psmt.setInt(3, vo.getFile());
			psmt.setString(4, vo.getUid());
			psmt.setString(5, vo.getRegip());
			
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
	public void selectArticle() {}
	public void selectArticles() {}
	public void updateArticle() {}
	public void deleteArticle() {}

	public void selectComments() {}
	public void selectCountTotal() {}
	
	

}
