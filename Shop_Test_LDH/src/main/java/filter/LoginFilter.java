package filter;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import shop.dao.UserRepository;
import shop.dto.PersistentLogin;
import shop.dto.User;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebFilter("/*")
public class LoginFilter implements Filter {

    UserRepository userRepository;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    	userRepository = new UserRepository();
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
    	// 로그인 여부 확인
 		HttpSession session = httpRequest.getSession();
 		String loginId = (String) session.getAttribute("loginId");
 		User loginUser = (User) session.getAttribute("loginUser");
 		
 		// 이미 로그인 됨
 		if( loginId != null && loginUser != null ) {
 			chain.doFilter(request, response);
 			System.out.println("로그인된 사용자 : " + loginId);
 			return;
 		}
 		

        // 세션에 loginId가 없다면 쿠키를 확인
        if (session.getAttribute("loginId") == null) {
            Cookie[] cookies = httpRequest.getCookies();
            String rememberMe = null;
            String token = null;

            // rememberMe와 token 쿠키를 가져옴
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if ("rememberMe".equals(cookie.getName())) {
                        rememberMe = cookie.getValue();
                    }
                    if ("token".equals(cookie.getName())) {
                        token = cookie.getValue();
                    }
                }
            }

            // 쿠키가 모두 존재하고 자동 로그인 설정된 경우
            if (rememberMe != null && token != null) {
            	PersistentLogin persistentLogin = userRepository.selectTokenByToken(token);
            	if( persistentLogin != null) {
            		loginId = persistentLogin.getUserId();
    				loginUser = userRepository.getUserById(loginId);
    				// 로그인 처리
    				session.setAttribute("loginId", loginId);
    				session.setAttribute("loginUser", loginUser);
    				System.out.println("자동 로그인 성공 : " + loginUser);
            	}
            }
        }

        // 다음 필터나 서블릿으로 요청 전달
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
       
    }
}
