package kr.co.Farmstory2.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import java.sql.Statement;

import kr.co.Farmstory2.bean.ArticleBean;
import kr.co.Farmstory2.bean.FileBean;
import kr.co.Farmstory2.db.DBConfig;
import kr.co.Farmstory2.db.Sql;


// 싱글톤 사용 
// DAO(Data Access Object) 
public class ArticleDao {

	
	private static ArticleDao instance = new ArticleDao();
	
	public static ArticleDao getInstance() {
		return instance;
	}
	
	private ArticleDao() {}
	
	public int selectCountTotal(String cate) {
		int total = 0;
		
		try{
			// 1,2단계
			Connection conn = DBConfig.getInstance().getConnection();
			// 3단계
			PreparedStatement psmt = conn.prepareStatement(Sql.SELECT_COUNT_TOTAL);
			/* Statement 클래스
			  - SQL 구문을 실행하는 역할
			  - 스스로 SQL구문 이해 못함(구문해석 X )-> 전달역할
			  - SQL관리 o + 연결 정보 x
			  
			  PreparedStatemnet 클래스
			  - Statement 클래스의 기능 향상
			  - 인자와 관련된 작업이 특화(매개 변수)
			  - 코드 안전성 높음. 가독성 높음
			  - 코드량이 증가 -> 매개변수를 set해줘야하기 때문에 ...
			  - 텍스트 SQL 호출 
			  ++ SQL문을 표현 즉, statment객체는 실행시 sql명령어를 지정하여 여러
			  sql구문을 하나의 statement객체로 수행이 가능(재사용 가능)
			  하지만 , preparedStatement는 객체 생성시 지정된 sql명령어만을 실행 할 수 잇다.
			  (다른 sql은 사용x -> 재사용 x)
			 
			*/
			psmt.setString(1, cate);
			// 4단계
			ResultSet rs = psmt.executeQuery();
			// 5단계
			if(rs.next()) {
				total = rs.getInt(1);
			}
			// 6단계
			rs.close();
			psmt.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return total;
	}
		
	public List<ArticleBean> selectLatest(String cate) {
		
		List<ArticleBean> latests = new ArrayList<>();
		
		try {
			Connection conn = DBConfig.getInstance().getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.SELECT_LATEST);
			psmt.setString(1, cate);
			ResultSet rs = psmt.executeQuery();
			
			while(rs.next()) {
				ArticleBean article = new ArticleBean();
				article.setSeq(rs.getInt(1));
				article.setTitle(rs.getString(2));
				article.setRdate(rs.getString(3));
				
				latests.add(article);
			}
			rs.close();
			psmt.close();
			conn.close();
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return latests;
	}
	
	public ArticleBean selectArticle(String seq) { // return type을 ArticleBean 주자
		
		ArticleBean ab = null;
		// 선언	-- 선언시 값을 초기화 시켜주어야한다 
		FileBean fb = null;
		
		try{
			// 1,2 단계
			Connection conn = DBConfig.getInstance().getConnection();
			// 3단계
			PreparedStatement psmt = conn.prepareStatement(Sql.SELECT_ARTICLE);
			psmt.setString(1, seq);
			// 4단계
			ResultSet rs = psmt.executeQuery();
			// 5단계
			if(rs.next()) {
				ab = new ArticleBean(); // 위에서 한 선언의 생성을 여기서 하자 
				ab.setSeq(rs.getInt(1));
				ab.setParent(rs.getInt(2));
				ab.setComment(rs.getInt(3));
				ab.setCate(rs.getString(4));
				ab.setTitle(rs.getString(5));
				ab.setContent(rs.getString(6));
				ab.setFile(rs.getInt(7));
				ab.setHit(rs.getInt(8));
				ab.setUid(rs.getString(9));
				ab.setRegip(rs.getString(10));
				ab.setRdate(rs.getString(11));
				
				fb = new FileBean();
				fb.setFseq(rs.getInt(12));
				fb.setParent(rs.getInt(13));
				fb.setOriName(rs.getString(14));
				fb.setNewName(rs.getString(15));
				fb.setDownload(rs.getInt(16));
				fb.setRdate(rs.getString(17));
				
				ab.setFb(fb);
			}
			// 6단계
				rs.close();
				psmt.close();
				conn.close();
				
			} catch(Exception e){
				e.printStackTrace();
			}
		return ab;

	}
	
	public List<ArticleBean> selectArticles(String cate, int start) {
		
		List<ArticleBean> articles = new ArrayList<>();
		
		try{
			
			Connection conn = DBConfig.getInstance().getConnection();
			
			PreparedStatement psmt = conn.prepareStatement(Sql.SELECT_ARTICLES);
			psmt.setString(1, cate);
			psmt.setInt(2, start);
			
			ResultSet rs = psmt.executeQuery();
			
			while(rs.next()){
				ArticleBean ab = new ArticleBean();
				ab.setSeq(rs.getInt(1));
				ab.setParent(rs.getInt(2));
				ab.setComment(rs.getInt(3));
				ab.setCate(rs.getString(4));
				ab.setTitle(rs.getString(5));
				ab.setContent(rs.getString(6));
				ab.setFile(rs.getInt(7));
				ab.setHit(rs.getInt(8));
				ab.setUid(rs.getString(9));
				ab.setRegip(rs.getString(10));
				ab.setRdate(rs.getString(11));
				ab.setNick(rs.getString(12));
				
				articles.add(ab);
			}
			
			rs.close();
			psmt.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return articles;
	}
	
public FileBean selectFile(String fseq) {
		
		FileBean fb = null;
		// 생성하고 동시에 선언하는것보다 초기화를 먼저해서하는것이 좋다 
		
		try {
			
			Connection conn = DBConfig.getInstance().getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.SELECT_FILE);
			psmt.setString(1, fseq);
			ResultSet rs = psmt.executeQuery();
			
			if(rs.next()) {
				fb = new FileBean();
				fb.setFseq(rs.getInt(1));
				fb.setParent(rs.getInt(2));
				fb.setOriName(rs.getString(3));
				fb.setNewName(rs.getString(4));
				fb.setDownload(rs.getInt(5));
				fb.setRdate(rs.getString(6));
			}
			rs.close();
			conn.close();
			psmt.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return fb;
	}
	
	public List<ArticleBean> selectComments(String seq){
		
		List<ArticleBean> comments = new ArrayList<>();
		
		try{
			// 1,2단계
			Connection conn = DBConfig.getInstance().getConnection();
			// 3단계
			PreparedStatement psmt = conn.prepareStatement(Sql.SELECT_COMMENTS);
			psmt.setString(1, seq);
			// 4단계
			ResultSet rs = psmt.executeQuery();
			// 5단계
			while(rs.next()){
				ArticleBean ab = new ArticleBean();
				ab.setSeq(rs.getInt(1));
				ab.setParent(rs.getInt(2));
				ab.setComment(rs.getInt(3));
				ab.setCate(rs.getString(4));
				ab.setTitle(rs.getString(5));
				ab.setContent(rs.getString(6));
				ab.setFile(rs.getInt(7));
				ab.setHit(rs.getInt(8));
				ab.setUid(rs.getString(9));
				ab.setRegip(rs.getString(10));
				ab.setRdate(rs.getString(11));
				ab.setNick(rs.getString(12));
				
				comments.add(ab);
			}
			// 6´Ü°è
			rs.close();
			psmt.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return comments;
		
	}
	
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
	
	public int insertArticle(ArticleBean article) {
		
		try {
			Connection conn = DBConfig.getInstance().getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.INSERT_ARTICLE);
			// db의 cate에 어떤게시판 부분에 사용될 글인지 정하는 sql이다 
			psmt.setString(1, article.getCate());
			psmt.setString(2, article.getTitle());
			psmt.setString(3, article.getContent());
			psmt.setInt(4, article.getFile());
			psmt.setString(5, article.getUid());
			psmt.setString(6, article.getRegip());
			
			psmt.executeUpdate();
			psmt.close();
			conn.close();

		}catch(Exception e) {
			e.printStackTrace();
		}
		// 글 등록 후 바로 해당 글번호 리턴
		return selectMaxSeq();
		
	} // wirtproc에 잇는 자료 옮기기 
	
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
	
	
	
	// Comment insert와 update를 같이 써도 되지만 묶어서 사용 하는 것이 좋다 
	public void insertComment(ArticleBean ab) {
		try {
			//  1,2 단계
			Connection conn = DBConfig.getInstance().getConnection();
			// 3단계
			PreparedStatement psmt = conn.prepareStatement(Sql.INSERT_COMMENT);
			psmt.setInt(1, ab.getParent());
			psmt.setString(2, ab.getContent());
			psmt.setString(3, ab.getUid());
			psmt.setString(4, ab.getRegip());
			// 4단계
			psmt.executeUpdate(); // insert 했기때문에 update로 해주어야 한다 
			// 5단계
			// 6단계
			psmt.close();
			conn.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void updateArticle(String title, String content, String seq) {
			
			try {
				Connection conn = DBConfig.getInstance().getConnection();
				PreparedStatement psmt = conn.prepareStatement(Sql.UPDATE_ARTICLE);
				psmt.setString(1, title);
				psmt.setString(2, content);
				psmt.setString(3, seq);
				
				psmt.executeUpdate();
				conn.close();
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
	
	public void updateArticleHit(String seq) {
		// 조회수 업데이트
		try{
		// 1,2 단계
			Connection conn = DBConfig.getInstance().getConnection();
		// 3단계
			PreparedStatement psmt = conn.prepareStatement(Sql.UPDATE_ARTICLE_HIT);
			psmt.setString(1, seq);
		// 4단계
			psmt.executeUpdate(); // insert 및 update는 executeUpdate 사용 
		// 5단계
		// 6단계
			psmt.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public void updateCommentCount(String parent, int type) {
		try {
				Connection conn = DBConfig.getInstance().getConnection();
				PreparedStatement psmt = null;
				
				if(type > 0) {
					psmt = conn.prepareStatement(Sql.UPDATE_COMMENT_COUNT_PLUS);
				}else {
					psmt = conn.prepareStatement(Sql.UPDATE_COMMENT_COUNT_MINUS);
				}
				
				
				psmt.setString(1, parent);
				psmt.executeUpdate();
				psmt.close();
				conn.close();
				
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

	public int updateComment(String content, String seq) {
		
		int result = 0;
		
		try {
			
			Connection conn = DBConfig.getInstance().getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.UPDATE_COMMENT);
			psmt.setString(1, content);
			psmt.setString(2, seq);
		    result = psmt.executeUpdate();
			psmt.close();
			conn.close();
			// 원레 return 값 안주는데 
			// view 페이지에 
//			if(data.result == 1){
//				alert('댓글 수정이 성공 했습니ㅏㄷ.');
//			}else{
//				alert('댓글 수정이 실패했습니다.');
//			}
//			위의 식을 써서 데이터를 return 받기 때문에 사용 할 수 있는 것이다. 
			// 그리고 updateCommnet에 json을 생성하여 주어야 한다
			// 좀 더 리뷰 해보기 

		}catch(Exception e) {
			e.printStackTrace();
		}
			return result;
	}

	public void updateFileDownload(String fseq) {
		try {
			Connection conn = DBConfig.getInstance().getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.UPDATE_FILE_DOWNLOAD);
			psmt.setString(1,  fseq);
			psmt.executeUpdate();
			
		}catch(Exception e) {
			
			e.printStackTrace();
		}
	}
	
	public void deleteArticle(String seq) {
		
		try {
			Connection conn = DBConfig.getInstance().getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.DELETE_ARTICLE);
			psmt.setString(1, seq);
			psmt.executeUpdate();
			conn.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		
	}
	
	public void deleteComment(String seq) {
		
		try{
			// 1,2 단계
			Connection conn = DBConfig.getInstance().getConnection();
			// 3단계
			PreparedStatement psmt = conn.prepareStatement(Sql.DELETE_COMMENT);
			psmt.setString(1, seq);
			// 4단계
			psmt.executeUpdate();
			// 5단계
			// 6단계
			psmt.close();
			conn.close();
			
			}catch(Exception e){
				e.printStackTrace();
			}
			

	}
	
}