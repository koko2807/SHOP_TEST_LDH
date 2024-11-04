<%@page import="java.util.regex.Pattern"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="shop.dao.UserRepository"%>
<%@page import="shop.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="userDAO" class="shop.dao.UserRepository" />
<%	
	//클라이언트로부터 전달받은 파라미터
	String id = request.getParameter("id");
	String name = request.getParameter("name");
	String gender = request.getParameter("gender");
	String year = request.getParameter("year");
	String month = request.getParameter("month");
	String day = request.getParameter("day");
	String email1 = request.getParameter("email1");
	String email2 = request.getParameter("email2");
	String phone = request.getParameter("phone");
	String address = request.getParameter("address");
	
	if (!Pattern.matches("^[가-힣]+$", name)) {
        response.sendRedirect("join.jsp?error=name_invalid");
        return; // 이름 형식이 유효하지 않음
    }

    // 생일 포맷팅
    String birth = year + "-" + month + "-" + day;

    // 이메일 조합
    String email = email1 + "@" + email2;
	
	User user = new User();
	user.setId(id);
	user.setName(name);
	user.setGender(gender);
	user.setBirth(birth);
	user.setMail(email);
	user.setPhone(phone);
	user.setAddress(address);
	user.setRegistDay(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));

	// 회원 정보 수정 처리
	UserRepository userRepository = new UserRepository();
    int result = userRepository.update(user);
    if (result >0 ){
        response.sendRedirect("complete.jsp?msg=2");
    } else {
        response.sendRedirect("update.jsp");
    }

%>