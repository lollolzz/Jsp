package Kr.co.Farmstory1.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import Kr.co.Farmstory1.bean.MemberBean;
import Kr.co.Farmstory1.bean.TermsBean;
import Kr.co.Farmstory1.db.DBConfig;
import Kr.co.Farmstory1.db.Sql;

public class MemberDao {
	
	private static MemberDao instance = new MemberDao();
	
	public static MemberDao getInstance() {
		return instance;
	}
	
	private MemberDao() {}
	
	public void insertMember() {}
	
	public TermsBean selectTerms() {
		
		return null;
	}
	
	public int selectCountUserInfo(int type) {
		// 회원가입시 중복체크 관련 선
		return 0;
	}
	
	public MemberBean selectMember(String uid, String pass) {
		
		MemberBean mb = null;
		// 메서드 상단은 지역변수선언하는 자리 
		
		try {
			Connection conn = DBConfig.getInstance().getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.SELECT_MEMBER);
			psmt.setString(1, uid);
			psmt.setString(2, pass);
			ResultSet rs = psmt.executeQuery();
			
			if(rs.next()) {
				mb= new MemberBean();
				mb.setUid(rs.getString(1));
				mb.setPass(rs.getString(2));
				mb.setName(rs.getString(3));
				mb.setNick(rs.getString(4));
				mb.setEmail(rs.getString(5));
				mb.setHp(rs.getString(6));
				mb.setGrade(rs.getInt(7));
				mb.setZip(rs.getString(8));
				mb.setAddr1(rs.getString(9));
				mb.setAddr2(rs.getString(10));
				mb.setRegip(rs.getString(11));
				mb.setRdate(rs.getString(12));
			}
			
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return mb; // if문에서 선언되면 mb가 선언되지 않음,, try문 밖에서 선언해야함
		// try문 밖에서 초기화 해주고
		// if문 안에서 선언을 해주자 
	}
	public void seletMember() {}
	public void updateMember() {}
	public void deleteMember() {}
	
	

}
