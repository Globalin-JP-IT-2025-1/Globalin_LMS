package com.library.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.stereotype.Repository;

import com.library.model.User;

@Repository
public class UserRepository {

	private final DataSource dataSource;

	public UserRepository(DataSource dataSource) {
		this.dataSource = dataSource;
	}
	
	// DB에서 id 기반으로 회원 정보 가져오기
	public User getUser(long id) {
		String sql = "SELECT id, name, email, userid, password FROM test_users WHERE id = ?";
		User user = new User();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = dataSource.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setLong(1, id);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				user.setId(id);
				user.setName(rs.getString("name"));
				user.setEmail(rs.getString("email"));
				user.setUserid(rs.getString("userid"));
				user.setPassword(rs.getString("password"));
			}

		} catch (Exception e) {
			e.printStackTrace();

		} finally {

			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace();
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace();
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException se) {
					se.printStackTrace();
				}
			}

		}
		
		return user;
		
	}
	
	// DB에서 회원 목록 가져오기
	public List<User> getUserList() {
		String sql = "SELECT id, name, email, userid, password FROM test_users";
		List<User> userList = new ArrayList<>();

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = dataSource.getConnection();
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				User user = new User();
				user.setId(rs.getInt("id"));
				user.setName(rs.getString("name"));
				user.setEmail(rs.getString("email"));
				user.setUserid(rs.getString("userid"));
				user.setPassword(rs.getString("password"));

				userList.add(user);
			}

		} catch (Exception e) {
			e.printStackTrace();

		} finally {

			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace();
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace();
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException se) {
					se.printStackTrace();
				}
			}

		}

		return userList;
	}
	
	// 회원을 DB에 등록하기
	public void registerUser(User user) {
		String sql = "INSERT INTO test_users (id, name, email, userid, password) VALUES (test_users_seq.NEXTVAL, ?, ?, ?, ?)";
		
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = dataSource.getConnection();
			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, user.getName());
			pstmt.setString(2, user.getEmail());
			pstmt.setString(3, user.getUserid());
			pstmt.setString(4, user.getPassword());
			
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();

		} finally {

			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace();
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException se) {
					se.printStackTrace();
				}
			}

		}
		
	}

	// DB에서 userid 기반으로 회원의 password 정보 가져와서 비교하기
	public boolean checkUserInfo(String userid, String password) {
		String sql = "SELECT password FROM test_users WHERE userid = ?";
		boolean result = false;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = dataSource.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				if (rs.getString("password").equals(password)) {
					result = true;
				}
			}

		} catch (Exception e) {
			e.printStackTrace();

		} finally {

			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace();
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace();
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException se) {
					se.printStackTrace();
				}
			}

		}
		
		return result;
		
		
	}

}
