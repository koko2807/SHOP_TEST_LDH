<%@page import="shop.dao.UserRepository"%>
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
	

	// 쿠키 전달
// 	String rememberId ="";
// 	String name="";
// 	Cookie cookieId = new Cookie("name", name);
//     Cookie cookieRememberId = new Cookie("rememberId", rememberId);
    response.sendRedirect(request.getContextPath() + "/");
    
 // 경로와 유효시간 설정 후 쿠키 추가
//  	cookieId.setPath("/");
//  	cookieRememberId.setPath("/");
//  	cookieId.setMaxAge(0);
//  	cookieRememberId.setMaxAge(0);
//  	response.addCookie(cookieId);
//  	response.addCookie(cookieRememberId);

	UserRepository userRepository = new UserRepository();
	String loginId = (String) session.getAttribute("loginId");
	if (loginId != null) {
	    int result = userRepository.deleteToken(loginId); 
	    if (result > 0) { // 삭제 성공
	        out.println("인증 토큰 데이터 삭제 성공!");
	    } else { // 삭제 실패
	        out.println("인증 토큰 데이터 삭제 실패!");
	    }
	} else {
	    out.println("사용자 ID가 존재하지 않습니다.");
	}
	
	// 세션 무효화
	session.invalidate();
%>