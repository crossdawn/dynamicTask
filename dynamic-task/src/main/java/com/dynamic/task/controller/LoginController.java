package com.dynamic.task.controller;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
/**
 * Created by zhangrui on 2017-09-22.
 */
@Controller
public class LoginController {

    @RequestMapping("/login")
    public String login(String username, String password, RedirectAttributes model, HttpSession session) {

        if (StringUtils.isEmpty(username)) {
            model.addFlashAttribute("resMess", "账号不能为空.");
            model.addFlashAttribute("resType", "1");
            return "redirect:login.jsp";
        }
        if (StringUtils.isEmpty(password)) {
            model.addFlashAttribute("resMess", "密码不能为空.");
            model.addFlashAttribute("resType", "2");
            return "redirect:login.jsp";
        }

        if ("admin".equals(username) && "123456".equals(password)) {
            session.setAttribute("user", "admin");
            return "redirect:job/index";
        } else {
            model.addAttribute("resType", "3");
            model.addAttribute("resMess", "请填写正确的用户名和密码.");
            return "redirect:login.jsp";
        }
    }

}
