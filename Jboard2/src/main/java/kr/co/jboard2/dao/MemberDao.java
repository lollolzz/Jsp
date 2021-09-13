package kr.co.jboard2.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import kr.co.jboard2.db.DBConfig;
import kr.co.jboard2.db.Sql;
import kr.co.jboard2.vo.MemberVo;
import kr.co.jboard2.vo.TermsVo;



public class MemberDao {
	
	private static MemberDao instance = new MemberDao();
	public static MemberDao getInstance() {
		return instance;
	}
	
	private MemberDao() {}
	
	public void insertMember(MemberVo vo) {
		
		try {
			
			Connection conn = DBConfig.getInstance().getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.INSERT_MEMBER);
			psmt.setString(1, vo.getUid());
			psmt.setString(2, vo.getPass());
			psmt.setString(3, vo.getName());
			psmt.setString(4, vo.getNick());
			psmt.setString(5, vo.getEmail());
			psmt.setString(6, vo.getHp());
			psmt.setString(7, vo.getZip());
			psmt.setString(8, vo.getAddr1());
			psmt.setString(9, vo.getAddr2());
			psmt.setString(10, vo.getRegip());
			psmt.executeUpdate();
			
			
			psmt.close();
			conn.close();
			
			
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public TermsVo selectTerms() {
		// 회원가입시 약관 동의 하는 부분에 관한 
		
		TermsVo vo = null;
		
		try {
			// db에 연결해서 sql문을 불러와야 한다
			Connection conn = DBConfig.getInstance().getConnection();
			Statement stmt = conn.createStatement();
			// 1.PreS~ 사용 해도 되지만 2.Sta를 씀 
			// 1은 정해진 sql문만 사용 하는데 2는 다양한 가능성이 열려 있다.
			ResultSet rs = stmt.executeQuery(Sql.SELECT_TERMS);
						
			if(rs.next()) {
				
				vo = new TermsVo();
				vo.setTerms(rs.getString(1));
				vo.setPrivacy(rs.getString(2));
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		// 실행되어져있는 것들을 종료를 하지 않는 이유는 페이지에 접속 할때 마다 계속 해서
		// 출력되어야 하기 때문인거 같다.
		return vo;		
	}
	public void selectMember() {}
	public void selectMembers() {}
	
public int selectCountUserInfo(int type, String checkData) {
	// 각종 중복 체크 를 할때 사용할 부분 
		
		int result = 0;
		
		try {
			// 1,2단계
			Connection conn = DBConfig.getInstance().getConnection();
			// 3단계
			PreparedStatement psmt = null;
			
			if(type == 1) {
				psmt = conn.prepareStatement(Sql.SELECT_COUNT_UID);
			}else if(type == 2) {
				psmt = conn.prepareStatement(Sql.SELECT_COUNT_NICK);
			}else if(type == 3) {
				psmt = conn.prepareStatement(Sql.SELECT_COUNT_EMAIL);
			}else if(type == 4) {
				psmt = conn.prepareStatement(Sql.SELECT_COUNT_HP);
			}
			psmt.setString(1, checkData);
			
			// 4단계
			ResultSet rs = psmt.executeQuery();
			// 5단계
			if(rs.next()) {
				result = rs.getInt(1);
			}
			//6단계
			rs.close();
			psmt.close();
			conn.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
		
		
	}
	
	
	public void updateMember() {}
	public void deleteMember() {}
	

}
