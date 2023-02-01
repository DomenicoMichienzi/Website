package com.example.website.controller;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class SearchManager {
    @GetMapping("/searchPage")
    public String searchPage(HttpServletRequest req) {
        if(req.getSession().getAttribute("username") != null) {
            return "searchPage";
        } else {
            // TODO - Redirect to Login Page
            return "notAuthorized";
        }
    }
}
