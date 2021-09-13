package kr.co.jboard2.db;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConfig {

	// 싱글톤 객체
	// - 메모리에 한 번 만 올라간다 
	// - 객체생성은 내부에서만 클래스 이름으로만 접근 
	// -> 클래스 설계 패턴 
		private static DBConfig instance = new DBConfig();
		
		private DBConfig() {}
		
		public static DBConfig getInstance() {
			return instance;
		}
		
		// DB정보
		private final String HOST = "jdbc:mysql://54.180.160.240:3306/lollolzz1018";
		private final String USER = "lollolzz1018";
		private final String PASS = "1234";
		
		public Connection getConnection() throws Exception {
			// 1단계
			Class.forName("com.mysql.jdbc.Driver");
			// 2단계
			Connection conn = DriverManager.getConnection(HOST, USER, PASS);
			
			return conn;
		}
}
