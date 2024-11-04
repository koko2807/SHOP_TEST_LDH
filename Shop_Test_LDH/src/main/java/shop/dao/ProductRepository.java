package shop.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import shop.dto.Product;

public class ProductRepository extends JDBConnection {
	
	/**
	 * 상품 목록
	 * @return
	 */
	public List<Product> list() {
		List<Product> productList= new ArrayList<Product>();
		String sql = " SELECT o.order_no, p.name, p.unit_price, io.amount FROM `order` o JOIN product_io io ON o.order_no = io.order_no "
				+ 	 "               JOIN product p ON io.product_id = p.product_id "
				+ 	 " WHERE o.user_id = ? ";
		try {
			psmt = con.prepareStatement(sql);
			rs = psmt.executeQuery();
			while( rs.next() ) {
				Product product = new Product();
				product.setFile(rs.getString("File"));
				product.setName(rs.getString("Name"));
				product.setDescription(rs.getString("Description"));
				product.setUnitPrice(rs.getInt("UnitPrice"));
				productList.add(product);
				
			}
		} catch (Exception e) {
			System.err.println("게시글 목록 조회 시, 예외 발생");
			e.printStackTrace();
		}
		return productList;
	}
	
	
	/**
	 * 상품 목록 검색
	 * @param keyword
	 * @return
	 */
	public List<Product> list(String keyword) {
		List<Product> productList= new ArrayList<Product>();
		String sql = " SELECT * "
				+ 	 " FROM product "
				+	 " WHERE name LIKE CONCAT('%', '상품명', '%') ";
		try {
			psmt = con.prepareStatement(sql);
			rs = psmt.executeQuery();
			while( rs.next() ) {
				Product product = new Product();
				product.setFile(rs.getString("File"));
				product.setName(rs.getString("Name"));
				product.setDescription(rs.getString("Description"));
				product.setUnitPrice(rs.getInt("UnitPrice"));
				productList.add(product);
				
			}
		} catch (Exception e) {
			System.err.println("게시글 목록 조회 시, 예외 발생");
			e.printStackTrace();
		}
		return productList;
	}
		
		
	/**
	 * 상품 조회
	 * @param productId
	 * @return
	 */
		public List<Product> getProductById(String productId) {
		    List<Product> productList = new ArrayList<Product>();
		    String sql = "SELECT o.order_no, p.name, p.unit_price, io.amount FROM `order` o "
		               + "JOIN product_io io ON o.order_no = io.order_no "
		               + "JOIN product p ON io.product_id = p.product_id "
		               + "WHERE o.user_id = ?";

		    try {
		        psmt = con.prepareStatement(sql);
		        psmt.setString(1, productId);
		        rs = psmt.executeQuery();
		        while (rs.next()) {
		            Product product = new Product();
		            product.setName(rs.getString("name")); // Column names should match exactly
		            product.setUnitPrice(rs.getInt("unit_price"));
		            product.setUnitsInStock(rs.getInt("amount")); // Assuming 'amount' matches 'UnitsInStock'
		            product.setOrderNo(rs.getInt("order_no"));
		            productList.add(product);
		        }
		    } catch (Exception e) {
		        System.err.println("상품 조회 시, 예외 발생");
		        e.printStackTrace();
		    }
		    return productList;
		}

	
	
	/**
	 * 상품 등록
	 * @param product
	 * @return
	 */
	public int insert(Product product) {
		String sql = " INSERT INTO order (product_id, name, unitPrice, description, manufacturer, category, unitsInStock, condition) VALUES (?, ?, ?, ?, ?, ?, ?, ?) ";
		int result = 0;
        try { psmt = con.prepareStatement(sql);
            
            psmt.setString(1, product.getProductId());
            psmt.setString(2, product.getName());
            psmt.setInt(3, product.getUnitPrice());
            psmt.setString(4, product.getDescription());
            psmt.setString(5, product.getManufacturer());
            psmt.setString(6, product.getCategory());
            psmt.setLong(7, product.getUnitsInStock());
            psmt.setString(8, product.getCondition());
            
            result = psmt.executeUpdate();
            System.out.println("Order added successfully.");

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
	}
	
	
	/**
	 * 상품 수정
	 * @param product
	 * @return
	 */
	public int update(Product product) {
		String sql = " UPDATE product SET id = ?, name = ?, unitPrice = ?, description = ?, manufacturer = ?, category = ?, unitsInStock = ?, condition = ?) VALUES (?, ?, ?, ?, ?, ?, ?, ?) ";
		int result = 0;
		try {
			psmt = con.prepareStatement(sql);

			psmt.setString(1, product.getProductId());
			psmt.setString(3, product.getName());
			psmt.setInt(4, product.getUnitPrice());
			psmt.setString(5, product.getDescription());
			psmt.setString(6, product.getManufacturer());
			psmt.setString(7, product.getCategory());
			psmt.setLong(8, product.getUnitsInStock());
			psmt.setString(8, product.getCondition());

			result = psmt.executeUpdate();
			System.out.println("Order added successfully.");

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	
	
	/**
	 * 상품 삭제
	 * @param product
	 * @return
	 */
	public int delete(String productId) {
		int result = 0;
	    String sql = " DELETE FROM product WHERE product_id = ? ";
	    
	    try {
	        psmt = con.prepareStatement(sql);
	        psmt.setString(1, productId);
	        Product product = new Product();
	        product.setFile(rs.getString("File"));
			product.setName(rs.getString("Name"));
			product.setDescription(rs.getString("Description"));
			product.setUnitPrice(rs.getInt("UnitPrice"));
	        
	        result = psmt.executeUpdate(); // 특정 사용자의 상품 정보 삭제 요청
	    } catch (SQLException e) {
	        System.err.println("상품 삭제 중, 에러 발생!");
	        e.printStackTrace();
	    }
	    System.out.println("상품 정보 " + result + "개의 데이터가 삭제되었습니다.");
	    return result;
	}
}







