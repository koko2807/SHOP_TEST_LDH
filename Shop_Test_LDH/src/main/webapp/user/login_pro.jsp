<!-- 로그인 처리 -->
<%@page import="shop.dto.PersistentLogin"%>
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
	if(loginUser == null){
		response.sendRedirect("login.jsp?error=0");
		return;
	}
	// 로그인 성공
	// - 세션에 아이디 등록
	if(loginUser != null){
		session.setAttribute("loginId", loginUser.getId());
		session.setAttribute("loginUser", loginUser);
		
		response.sendRedirect("complete.jsp?msg=0");
	}
	// 아이디 저장
	String rememberId = request.getParameter("remember-id");
	Cookie cookieRememberId = new Cookie("rememberId","");
	Cookie cookieId = new Cookie("id","");
	
	if(rememberId != null && rememberId.equals("on")){
		cookieRememberId.setValue(URLEncoder.encode(rememberId, "UTF-8" ));
		cookieId.setValue(URLEncoder.encode(id, "UTF-8"));
	}
	else{
		cookieRememberId.setMaxAge(0);
		cookieId.setMaxAge(0);
	}
	// 자동 로그인
	String rememberMe = request.getParameter("remember-me");
	Cookie cookieRememberMe = new Cookie("rememberMe","");
	Cookie cookieToken = new Cookie("token","");
	
	cookieRememberMe.setPath("/");
	cookieToken.setPath("/");
	
	if(rememberMe != null && rememberMe.equals("on")){
		 UserRepository userRepository = new UserRepository();
		 String token  = userRepository.refreshToken(id);
		 
		cookieRememberMe.setValue(URLEncoder.encode(rememberMe, "UTF-8"));
		cookieToken.setValue(URLEncoder.encode(token, "UTF-8"));
	}
	else{
		cookieRememberMe.setMaxAge(0);
		cookieToken.setMaxAge(0);
	}
			
	// 쿠키 전달
	response.addCookie(cookieRememberId);
	response.addCookie(cookieId);
	response.addCookie(cookieRememberMe);
	response.addCookie(cookieToken);
	

%>