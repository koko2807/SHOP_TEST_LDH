package filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebFilter("/LoginFilter")
public class LoginFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession();

        // 세션에 로그인 정보가 없는 경우에만 자동 로그인 로직을 실행
        if (session.getAttribute("loginId") == null) {
            Cookie[] cookies = httpRequest.getCookies();
            String rememberMe = null;
            String token = null;

            // 쿠키에서 rememberMe와 token 값을 가져오기
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if ("rememberMe".equals(cookie.getName())) {
                        rememberMe = cookie.getValue();
                    } else if ("token".equals(cookie.getName())) {
                        token = cookie.getValue();
                    }
                }
            }

            // rememberMe와 token 쿠키가 모두 존재하는 경우에만 자동 로그인 시도
            if ("true".equals(rememberMe) && token != null) {
                try {
                    // DB 연결 설정
                    String jdbcUrl = "jdbc:mysql://localhost:3306/joeun"; // 데이터베이스 주소
                    String dbUser = "joeun"; // DB 사용자명
                    String dbPassword = "123456"; // DB 비밀번호
                    Connection conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

                    // token을 사용해 user_id 조회
                    String query = "SELECT user_id FROM persistent_logins WHERE token = ?";
                    PreparedStatement pstmt = conn.prepareStatement(query);
                    pstmt.setString(1, token);
                    ResultSet rs = pstmt.executeQuery();

                    if (rs.next()) {
                        String loginId = rs.getString("user_id");
                        session.setAttribute("loginId", loginId); // 세션에 로그인 ID 저장
                    }

                    // 리소스 해제
                    rs.close();
                    pstmt.close();
                    conn.close();

                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        // 다음 필터나 서블릿 호출
        chain.doFilter(request, response);
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // 초기화 코드가 필요한 경우 작성
    }

    @Override
    public void destroy() {
        // 종료 시 자원 해제가 필요한 경우 작성
    }
}