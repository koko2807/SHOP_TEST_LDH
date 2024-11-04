<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
	// 자동 로그인, 토큰 쿠키 삭제
	Cookie cookieRememberMe = new Cookie("rememberMe", "");
	Cookie cookieToken = new Cookie("token", "");
	cookieRememberMe.setPath("/");
	cookieToken.setPath("/");
	cookieRememberMe.setMaxAge(0);
	cookieToken.setMaxAge(0);
	response.addCookie(cookieRememberMe);
	response.addCookie(cookieToken);
	
	// 세션 무효화
	session.invalidate();

	// 쿠키 전달
	String rememberId ="";
	String name="";
	Cookie cookieId = new Cookie("name", name);
    Cookie cookieRememberId = new Cookie("rememberId", rememberId);
    
 // 경로와 유효시간 설정 후 쿠키 추가
 	cookieId.setPath("/");
 	cookieRememberId.setPath("/");
 	cookieId.setMaxAge(0);
 	cookieRememberId.setMaxAge(0);
 	response.addCookie(cookieId);
 	response.addCookie(cookieRememberId);
%>