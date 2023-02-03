package com.example.website.controller;

import com.example.website.database.Database;
import com.example.website.model.Book;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class HomePage {

    @GetMapping("/test")
    public String testingPage(HttpServletRequest req) {
        if(req.getSession().getAttribute("username") != null) {
            return "Test";
        }
        return "Bad";
    }
    @GetMapping("/")
    public String homePage(HttpServletRequest req) {
        if(req.getSession().getAttribute("username") != null) {
            String usr = req.getSession().getAttribute("username").toString();

            // Most Rated Books
            List<Book> books = Database.getInstance().getUserDao().getAllBooks();
            req.setAttribute("books", books);
            return "index";
        }

        return "index";
    }
}
