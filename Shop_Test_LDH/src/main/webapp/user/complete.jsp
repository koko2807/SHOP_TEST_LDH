<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="shop.dto.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Shop</title>
    <jsp:include page="/layout/meta.jsp" />
    <jsp:include page="/layout/link.jsp" />
    <style>
        .message {
            text-align: center; /* 가운데 정렬 */
            margin-top: 20px; /* 상단 여백 추가 */
        }
    </style>
</head>
<body>   
    <% String root = request.getContextPath(); %>
    
    <jsp:include page="/layout/header.jsp" />
    <div class="px-4 py-5 my-5 text-center">
        <h1 class="display-5 fw-bold text-body-emphasis">회원 정보</h1>
    </div>
    <!-- 회원 가입/수정/탈퇴 완료 메시지 -->
    <div class="container mb-5">
        <%
            String msg = request.getParameter("msg");
            if (msg != null) {
        %>
                <div class="message">
                    <%
                        switch (msg) {
                            case "0":
                                String userName = ((User)session.getAttribute("loginUser")).getName();
                                out.println("<p>" + userName + "님 환영합니다.</p>");
                                break;
                            case "1":
                                out.println("<p>회원 가입이 완료되었습니다.</p>");
                                break;
                            case "2":
                                out.println("<p>회원 정보가 수정되었습니다.</p>");
                                break;
                            case "3":
                                out.println("<p>회원 탈퇴가 완료되었습니다.</p>");
                                break;
                            default:
                                break;
                        }
                    %>
                </div>
        <%
            }
        %>
    </div>
    
    <div class="container mb-5 text-center">
        <a href="<%= root %>/index.jsp" class="btn btn-primary">메인 화면으로 돌아가기</a>
    </div>
    
    <jsp:include page="/layout/footer.jsp" />
    <jsp:include page="/layout/script.jsp" />
</body>
</html>