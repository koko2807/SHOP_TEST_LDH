<%@page import="org.apache.commons.fileupload.DiskFileUpload"%>
<%@ page import="java.io.File"%>
<%@ page import="org.apache.commons.fileupload.FileItem"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="shop.dao.ProductRepository"%>
<%@ page import="shop.dto.Product"%>
<%
    request.setCharacterEncoding("UTF-8");

    String path = "C:\\UPLOAD"; // 파일 업로드 경로 설정

    DiskFileUpload upload = new DiskFileUpload();
    upload.setSizeMax(10 * 1000 * 1000);        // 최대 파일 크기 10MB
    upload.setSizeThreshold(4 * 1024);          // 메모리에서의 최대 크기 4MB

    List<FileItem> items = upload.parseRequest(request);
    Iterator<FileItem> params = items.iterator();

    String productId = "";
    String name = "";
    int unitPrice = 0;
    Long unitsInStock = 0L;
    String description = "";
    String manufacturer = "";
    String category = "";
    String condition = "";
    String fileName = ""; // 전역 변수로 선언된 fileName
    Product product = new Product();

    // 폼 데이터와 파일 데이터 분리 처리
    while (params.hasNext()) {
        FileItem item = params.next();
        if (item.isFormField()) {
            // 일반 데이터 처리
            String fieldName = item.getFieldName();
            String value = item.getString("utf-8"); // UTF-8 인코딩으로 읽기
            
            switch (fieldName) {
                case "productId":
                    productId = value;
                    break;
                case "name":
                    name = value;
                    break;
                case "unitPrice":
                    unitPrice = Integer.parseInt(value);
                    break;
                case "unitsInStock":
                    unitsInStock = Long.parseLong(value);
                    break;
                case "description":
                    description = value;
                    break;
                case "manufacturer":
                    manufacturer = value;
                    break;
                case "category":
                    category = value;
                    break;
                case "condition":
                    condition = value;
                    break;
            }
        } else {
            // 파일 데이터 처리
            String fileFieldName = item.getFieldName();
            if (fileFieldName.equals("file")) { // 파일 필드인 경우에만 처리
                fileName = item.getName(); // 파일 이름 가져오기
                fileName = fileName.substring(fileName.lastIndexOf("\\") + 1); // 파일 이름에서 경로 제거
                File file = new File(path + "\\" + fileName); // 파일 객체 생성
                item.write(file); // 파일 저장
                
                // 파일 경로를 Product 객체에 설정
                product.setFile(file.getAbsolutePath()); // 절대 경로로 설정
            }
        }
    }

    // Product 객체 생성 및 필드 설정
    product.setProductId(productId);
    product.setName(name);
    product.setUnitPrice(unitPrice);
    product.setDescription(description);
    product.setManufacturer(manufacturer);
    product.setCategory(category);
    product.setUnitsInStock(unitsInStock);
    product.setCondition(condition);
    // product.setFile(file); // 제거, 위에서 이미 설정됨

    // ProductRepository 인스턴스 생성 및 insert 호출
    ProductRepository productRepository = new ProductRepository();
    int result = productRepository.insert(product);

    // 결과 처리
    if (result > 0) {
        out.println("<script>alert('상품이 성공적으로 등록되었습니다.'); location.href='products.jsp';</script>");
    } else {
        out.println("<script>alert('상품 등록에 실패하였습니다. 다시 시도해 주세요.'); history.back();</script>");
    }
%>