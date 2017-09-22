package com.dynamic.task.util;

import org.apache.commons.lang.StringUtils;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Created by zhangrui on 2017-09-22.
 */
public class LoginFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession();

        String path = req.getServletPath();
        if(StringUtils.isNotEmpty(path) &&("/login.jsp".equals(path) || "/login".equals(path) || path.contains("/static")|| "/job/calls".equals(path))){
            chain.doFilter(request,response);
        } else {
            if (null==session.getAttribute("user")){
                res.sendRedirect(req.getContextPath() + "/login.jsp");
            }else {
                chain.doFilter(request,response);
            }
        }

    }

    @Override
    public void destroy() {

    }
}
