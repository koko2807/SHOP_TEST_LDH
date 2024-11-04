<!-- 
	회원 가입 처리
 -->
<%@page import="shop.dao.UserRepository"%>
<%@page import="shop.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    User user = new User();

    	String id = request.getParameter("id");
    	String password = request.getParameter("pw");
    	String pw_confirm = request.getParameter("pw_confirm");
    	String name = request.getParameter("name");
    	String gender = request.getParameter("gender");
    	String birth = request.getParameter("birth");
    	String mail = request.getParameter("mail");
    	String phone = request.getParameter("phone");
    	String address = request.getParameter("address");
    	
    	user.setId(id);
    	user.setPassword(password);
    	user.setName(name);
    	user.setGender(gender);
    	user.setBirth(birth);
    	user.setMail(mail);
    	user.setPhone(phone);
    	user.setAddress(address);
    	
    	// 비밀번호 확인
    	if (user != null && password.equals(pw_confirm)) {

    		// 회원 가입 요청
    		UserRepository userRepository = new UserRepository();
    		int result = userRepository.insert(user);

    		// 회원가입 성공
    		if (result > 0) {
    	response.sendRedirect(request.getContextPath()+"/index.jsp"); // 메인화면으로 이동
    		}
    		// 회원가입 실패
    		else {
    	response.sendRedirect("join.jsp?error=0"); // 다시 회원가입페이지로 (에러포함)
    		}
    		
    		
    	} else {
    		out.println("<script>alert('로그인 실패. 아이디와 비밀번호를 확인하세요.'); history.back();</script>");
    	}

    	// 비밀번호 유효성 검사
    	// 	String passwordPattern = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$";

    	// 이름 유효성 검사
    	// 	String regExpName = "/^[가-힣]*$/";

    	// 전화번호 패턴
    	// 	String regExpPhone = "^\\d{3}-\\d{3,4}-\\d{4}$";

    	// 생일 포맷팅

    	// 이메일 유효성 검사
    	// 	String regExpMail = "^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\\.[a-zA-Z]{2,3}$";

    	// 이메일 조합

    	// User객체 생성 및 필드 설정

    	// UserRepository를 통해 데이터베이스에 사용자 정보 저장
    %>


    
    

    
    
    
    
    
    