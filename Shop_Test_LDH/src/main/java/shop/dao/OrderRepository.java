package shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import shop.dto.Order;
import shop.dto.Product;
import shop.dto.User;

public class OrderRepository extends JDBConnection {
	
	/**
	 * 주문 등록
	 * @param user
	 * @return
	 */
	public void addOrder(User user) {
        String sql = " INSERT INTO order (id, password, name, gender, birth, mail, phone, address, regist_day) VALUES (?, ?, ?) ";
        try { psmt = con.prepareStatement(sql);
            
            psmt.setString(1, user.getId());
            psmt.setString(2, user.getPassword());
            psmt.setString(3, user.getName());
            psmt.setString(4, user.getGender());
            psmt.setString(5, user.getBirth());
            psmt.setString(6, user.getAddress());
            psmt.setString(7, user.getMail());
            psmt.setString(8, user.getPhone());
            psmt.setString(9, user.getAddress());
            psmt.setString(10, user.getRegistDay());
            
            psmt.executeUpdate();
            System.out.println("Order added successfully.");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

	/**
	 * 최근 등록한 orderNo 
	 * @return
	 */
	public int lastOrderNo() {
		int lastOrderNo = 0;
		
		String sql = " SELECT MAX(order_no) FROM order ";
		
        try { psmt = con.prepareStatement(sql);
            ResultSet rs = psmt.executeQuery();
            if (rs.next()) {
            	lastOrderNo = rs.getInt(1);
            }
        } catch (SQLException e) {
        	e.printStackTrace();
        }
        
        return lastOrderNo;
    }

	
	/**
	 * 주문 내역 조회 - 회원
	 * @param userId
	 * @return
	 */
	public List<Product> list(String userId) {
		List<Product> productList= new ArrayList<Product>();
		String sql = " SELECT o.order_no, p.name, p.unit_price, io.amount FROM `order` o JOIN product_io io ON o.order_no = io.order_no "
				+ 	 "               JOIN product p ON io.product_id = p.product_id "
				+ 	 " WHERE o.user_id = ? ";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, userId);
			rs = psmt.executeQuery();
			while( rs.next() ) {
				Product product = new Product();
				product.setName(rs.getString("Name"));
				product.setUnitPrice(rs.getInt("UnitPrice"));
				product.setUnitsInStock(rs.getLong("UnitsInStock"));
				product.setOrderNo(rs.getInt("OrderNo"));
				productList.add(product);
				
			}
		} catch (Exception e) {
			System.err.println("주문 내역 조회 시, 예외 발생");
			e.printStackTrace();
		}
		return productList;		
	}
	
	/**
	 * 주문 내역 조회 - 비회원
	 * @param phone
	 * @param orderPw
	 * @return
	 */
	public List<Product> list(String phone, String orderPw) {
		List<Product> productList= new ArrayList<Product>();
		String sql = " SELECT o.order_no, p.name, p.unit_price, io.amount FROM `order` o JOIN product_io io ON o.order_no = io.order_no "
				+ 	 "               JOIN product p ON io.product_id = p.product_id "
				+ 	 " WHERE o.user_id = ? ";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, phone);
			psmt.setString(2, orderPw);
			rs = psmt.executeQuery();
			while( rs.next() ) {
				Product product = new Product();
				product.setName(rs.getString("Name"));
				product.setUnitPrice(rs.getInt("UnitPrice"));
				product.setUnitsInStock(rs.getInt("UnitsInStock"));
				product.setOrderNo(rs.getInt("OrderNo"));
				productList.add(product);
				
			}
		} catch (Exception e) {
			System.err.println("주문 내역 조회 시, 예외 발생");
			e.printStackTrace();
		}
		return productList;	
		
	}
	
}


