<%@page import="java.util.regex.Pattern"%>
<%@page import="shop.dao.UserRepository"%>
<%@page import="shop.dto.User"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

<%
    // 클라이언트로부터 전달받은 파라미터
    String id = request.getParameter("id");
    String password = request.getParameter("pw"); // 비밀번호
    String passwordConfirm = request.getParameter("pw_confirm"); // 비밀번호 확인
    String name = request.getParameter("name");
    String gender = request.getParameter("gender");
    String year = request.getParameter("year");
    String month = request.getParameter("month");
    String day = request.getParameter("day");
    String email1 = request.getParameter("email1");
    String email2 = request.getParameter("email2");
    String phone = request.getParameter("phone");
    String address = request.getParameter("address");

    // 비밀번호 확인
    if (password == null || password.trim().isEmpty()) {
        response.sendRedirect("join.jsp?error=password_required");
        return;
    }
    
    // 비밀번호 유효성 검사
    String passwordPattern = "^(?=.*[a-zA-Z])(?=.*\\d)(?=.*[!@#$%^&*()_+<>?])[A-Za-z\\d!@#$%^&*()_+<>?]{6,}$";
    if (!Pattern.matches(passwordPattern, password)) {
        response.sendRedirect("join.jsp?error=password_invalid");
        return; // 비밀번호 형식이 유효하지 않음
    }
    
    // 비밀번호 확인
    if (!password.equals(passwordConfirm)) {
        response.sendRedirect("join.jsp?error=password_mismatch");
        return;
    }

    // 이름 유효성 검사 (한글만)
    if (!Pattern.matches("^[가-힣]+$", name)) {
        response.sendRedirect("join.jsp?error=name_invalid");
        return; // 이름 형식이 유효하지 않음
    }

    // 생일 포맷팅
    String birth = year + "-" + month + "-" + day;

    // 이메일 유효성 검사
    if (email1 == null || email1.trim().isEmpty() || email2 == null || email2.trim().isEmpty()) {
        response.sendRedirect("join.jsp?error=email_required");
        return; // 이메일이 필요함
    }

    // 이메일 조합
    String email = email1 + "@" + email2;

    // User 객체 생성 및 필드 설정
    User user = new User();
    user.setId(id);
    user.setPassword(password);
    user.setName(name);
    user.setGender(gender);
    user.setBirth(birth);
    user.setMail(email);
    user.setPhone(phone);
    user.setAddress(address);
    user.setRegistDay(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));

    // UserRepository를 통해 데이터베이스에 사용자 정보 저장
    UserRepository userRepository = new UserRepository();
    try {
        int result = userRepository.insert(user);

        // 결과에 따라 리다이렉션 처리
        if (result > 0) {
            response.sendRedirect("complete.jsp?msg=1");
        } else {
            response.sendRedirect("join.jsp?error=registration_failed");
        }
    } catch (Exception e) {
        e.printStackTrace(); // 예외를 출력
        response.sendRedirect("join.jsp?error=database_error");
    }
%>