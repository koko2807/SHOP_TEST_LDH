package shop.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import shop.dto.Product;

public class ProductIORepository extends JDBConnection {

	/**
	 * 상품 입출고 등록
	 * @param product
	 * @param type
	 * @return
	 */
	public int insert(Product product, String type) {
		    String sql = " INSERT INTO `order` (order_no, product_id, amount, type, io_date, user_id) VALUES (?, ?, ?, ?, ?,NOW(),?) ";
		    int result = 0;
		    try {
		        psmt = con.prepareStatement(sql);

		        psmt.setInt(1, product.getOrderNo());
		        psmt.setString(2, product.getProductId());
		        psmt.setInt(3, product.getAmount());
		        psmt.setString(4, type);
		        psmt.setString(5, product.getIoDate());
		        psmt.setString(6, product.getUserId());

		        result = psmt.executeUpdate();
		        System.out.println("Order added successfully.");

		    } catch (SQLException e) {
		        e.printStackTrace();
		    }
		    return result;
		}
}
