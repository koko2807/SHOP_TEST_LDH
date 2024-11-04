<!-- 로그인 처리 -->
<%@page import="java.util.UUID"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="shop.dto.User"%>
<%@page import="shop.dao.UserRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
	
	UserRepository userDAO = new  UserRepository();
	User loginUser = userDAO.login(id, pw);
	
	// 로그인 실패
	if( loginUser == null ) {
		// 리다이렉트 -> 로그인 화면으로 다시 이동
		response.sendRedirect("login.jsp?error=0");
		return;
	}
	
	// 로그인 성공
	if(loginUser != null ) {
	// - 세션에 아이디 등록
	session.setAttribute("loginId", loginUser.getName());
	session.setAttribute("loginUser", loginUser);
	response.sendRedirect("index.jsp");
	}
	
	// 아이디 저장
	String rememberId = request.getParameter("remember-id");
	Cookie cookieRememberId = new Cookie("rememberId", "");
	Cookie cookieUsername = new Cookie("username", "");
	
	// 자동 로그인
	String rememberMe = request.getParameter("remember-me");
	Cookie cookieRememberMe = new Cookie("rememberMe", "");
	Cookie cookieToken = new Cookie("token", "");
	// 쿠키 전달
	
	
	// 로그인 성공 페이지로 이동
	response.sendRedirect("complete.jsp?msg=0");		

%>





