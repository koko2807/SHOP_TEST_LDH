<%@page import="shop.dao.OrderRepository"%>
<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// root 경로 설정
	String root = request.getContextPath();
	
	// 폼에서 전달된 파라미터 가져오기
	String phone = request.getParameter("phone");
	String orderPw = request.getParameter("orderPw");

	// 유효성 검사를 통해 입력값 확인
	if (phone == null || phone.isEmpty() || orderPw == null || orderPw.isEmpty()) {
		// 값이 비어 있으면 에러 메시지와 함께 주문 페이지로 이동
		request.getSession().setAttribute("orderError", "전화번호와 주문 비밀번호를 모두 입력해주세요.");
		response.sendRedirect(root + "/user/order.jsp");
		return;
	}

	// 주문 정보 조회
	OrderRepository orderRepo = new OrderRepository();
	List<Product> orderList = new ArrayList<>(); // 빈 리스트로 초기화

	try {
		// 주문 내역 가져오기
		orderList = orderRepo.getOrdersByPhoneAndPw(phone, orderPw);
		if (orderList == null) {
			orderList = new ArrayList<>(); // null 방지
		}
	} catch (Exception e) {
		e.printStackTrace();
		request.getSession().setAttribute("orderError", "주문 조회 중 오류가 발생했습니다.");
		response.sendRedirect(root + "/user/order.jsp");
		return;
	}

	// 주문 내역이 있는지 확인
	if (orderList.isEmpty()) {
		// 주문 내역이 없으면 에러 메시지와 함께 다시 주문 페이지로 이동
		request.getSession().setAttribute("orderError", "입력하신 정보와 일치하는 주문 내역이 없습니다.");
		response.sendRedirect(root + "/user/order.jsp");
		return;
	}

	// 조회된 주문 내역을 세션에 저장
	request.getSession().setAttribute("orderList", orderList);
	request.getSession().setAttribute("orderPhone", phone);

	// 주문 페이지로 리다이렉트
	response.sendRedirect(root + "/user/order.jsp");
%>
