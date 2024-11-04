<%@page import="shop.dao.UserRepository"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 탈퇴</title>
    <jsp:include page="/layout/meta.jsp" />
    <jsp:include page="/layout/link.jsp" />
</head>
<body>
    <%
        String root = request.getContextPath();

        String loginId = (String) session.getAttribute("loginId");

        if (loginId == null || loginId.isEmpty()) {
            response.sendRedirect(root);
            return;
        }

        UserRepository userDAO = new UserRepository();

        int result = userDAO.delete(loginId);

        if (result > 0) {
            session.invalidate(); 
            response.sendRedirect("complete.jsp?msg=3");
            return;
        } else {
            out.println("<script>alert('회원 탈퇴에 실패했습니다.'); history.back();</script>");
        }
    %>
    
    <jsp:include page="/layout/footer.jsp" />
</body>
</html>