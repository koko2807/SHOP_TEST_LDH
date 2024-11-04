<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
<%@page import="shop.dao.OrderRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// root 경로 설정
	String root = request.getContextPath();
	
	// 폼에서 전달된 파라미터 가져오기
	String phone = request.getParameter("phone");
	String orderPw = request.getParameter("orderPw");

	// 주문 정보 조회
	 OrderRepository orderRepository = new OrderRepository();
    List<Product> orderList = orderRepository.list(phone, orderPw); // 빈 리스트로 초기화
    
	// 유효성 검사를 통해 입력값 확인
	if (orderList != null && !orderList.isEmpty()) {
        session.setAttribute("orderList", orderList);
        response.sendRedirect(root + "/user/order.jsp");
    } else {
        // 조회 실패 시 에러 메시지를 전달하고 다시 조회 페이지로 이동
        session.setAttribute("errorMessage", "일치하는 주문 내역이 없습니다.");
        response.sendRedirect(root + "/user/order.jsp");

    }
%>
