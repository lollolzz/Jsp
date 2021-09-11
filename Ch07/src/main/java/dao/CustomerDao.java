package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import vo.CustomerVo;

public class CustomerDao {
	
	private static CustomerDao instance = new CustomerDao();
	public static CustomerDao getInstance() {
		return instance;
	}
	
	private CustomerDao() {}
	
	private final String HOST = "jdbc:mysql://3.34.49.17:3306/lollolzz1018";
	private final String USER = "lollolzz1018";
	private final String PASS = "tkfka1704!";
	

	public void insertCustomer(CustomerVo vo) {
		
		try {
			
			Class.forName("com.mysql.jdbc.Driver");
			
			Connection conn = DriverManager.getConnection(HOST, USER, PASS);
			
			String sql = "INSERT INTO `Customer` (`name`, `address`, `phone`) VALUES (?,?,?)";
			PreparedStatement psmt = conn.prepareStatement(sql);
			psmt.setString(1, vo.getName());
			psmt.setString(2, vo.getAddress());
			psmt.setString(3, vo.getPhone());
			
			psmt.executeUpdate();
			
			psmt.close();
			conn.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	
	public CustomerVo selectCustomer(String custid) {
		CustomerVo vo = null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection(HOST, USER, PASS);
			
			PreparedStatement psmt = conn.prepareStatement("SELECT * FROM `Customer` WHERE `custid`=?");
			psmt.setString(1, custid);
			
			ResultSet rs = psmt.executeQuery();
			
			if(rs.next()) {
				vo = new CustomerVo();
				vo.setCustid(rs.getInt(1));
				vo.setName(rs.getString(2));
				vo.setAddress(rs.getString(3));
				vo.setPhone(rs.getString(4));
			}
			
			rs.close();
			psmt.close();
			conn.close();
			
		}catch (Exception e) {
			e.printStackTrace();
		}		
		
		return vo;
		
	}
	public List<CustomerVo> selectCustomers() {
		
		List<CustomerVo> customers = new ArrayList<>();
		
		try {
			
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection(HOST, USER, PASS);
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM `Customer`");
			
			while(rs.next()) {
				CustomerVo vo = new CustomerVo();
				vo.setCustid(rs.getInt(1));
				vo.setName(rs.getString(2));
				vo.setAddress(rs.getString(3));
				vo.setPhone(rs.getString(4));
				
				customers.add(vo);
				
			}
			
			rs.close();
			stmt.close();
			conn.close();
		
		
		}catch(Exception e) {
			e.printStackTrace();
		}
		return customers;
		
	}
	public void udpdateCustomer() {}
	public void deleteCustomer() {}
	
}
