package Kr.co.jboard1.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import Kr.co.jboard1.bean.ArticleBean;
import Kr.co.jboard1.bean.FileBean;
import Kr.co.jboard1.db.DBConfig;
import Kr.co.jboard1.db.Sql;

//싱글톤 사용 
//DAO(Data Access Object) 
public class ArticleDao {
	
	
	private static ArticleDao instance = new ArticleDao();
	
	public static ArticleDao getInstance() {
		return instance;
	}
	
	private ArticleDao() {}
	
	public int selectCountTotal() {
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
			// 4단계
			ResultSet rs = psmt.executeQuery();
			// query
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
	
	public List<ArticleBean> selectArticles(int start) {
		
		List<ArticleBean> articles = new ArrayList<>();
		
		try{
			
			Connection conn = DBConfig.getInstance().getConnection();
			
			PreparedStatement psmt = conn.prepareStatement(Sql.SELECT_ARTICLES);
			psmt.setInt(1, start);
			
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
	
	public List<ArticleBean> selectComments(String seq){
		
		List<ArticleBean> comments = new ArrayList<>();
		// ArrayList 크기가 가변적 - 선형 리스트 , 일반 배열과는 달리 객체들이 추가되어 저장 용량을 초과한다면 자동으로 부족한 만큼 저장 용량이 늘어 남 
		// List를 공통되는 메소드를 추출해놓은 클래스 인터페이스라고 생각하면 된다 .
		// ArticleBean은 list에 담겨질 객체의 타입을 정해준 것이라 생각하면 된다 ,, 
		// 그래서 정해진 타입이 아니면 add를 할 수 없기 때문에 오류를 예방 할 수 있다 
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
			// 6 단계
			rs.close();
			psmt.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return comments;
		
	}
	
	public void insertArticle() {} // wirtproc에 잇는 자료 옮기기 
	
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
	
	public void updateArticle() {}
	
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
	
	public void updateCommentCount(String parent) {
		try {
			Connection conn = DBConfig.getInstance().getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.UPDATE_COMMENT_COUNT);
			psmt.setString(1, parent);
			psmt.executeUpdate();
			psmt.close();
			conn.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void deleteArticle() {}
	
}