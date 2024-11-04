<%@page import="shop.dao.UserRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="userDAO" class="shop.dao.UserRepository" />

<%
//ID 파라미터 받기
String idValue = request.getParameter("id");
        int id = Integer.parseInt(idValue);

        // 회원 탈퇴 처리
        UserRepository userRepository = new UserRepository();
        int result = userRepository.delete(id);

    	if( result > 0) {
    		response.sendRedirect(root + "/shop/delete_pro.jsp");
    	}
    	else {
    		response.sendRedirect(root + "/shop/delete_pro.jsp?error");
    	}
%>
