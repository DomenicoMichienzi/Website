package com.example.website.controller;

import com.example.website.database.Database;
import com.example.website.model.Book;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.ArrayList;
import java.util.List;

@Controller
public class BooksManager {

    @GetMapping("/getBooks")
    public String listOfBooks(HttpServletRequest req) {
        String usr = req.getSession().getAttribute("username").toString();
        if(req.getSession().getAttribute("username") != null) {
            List<Book> bs = Database.getInstance().getUserDao().getAllBooks(usr);
            req.setAttribute("books", bs);
            return "booksPage";
        } else {
            return "notAuthorized";
        }
    }

    @GetMapping("/searchBooks")
    public String searchBooks(HttpServletRequest req) {
        String usr = req.getSession().getAttribute("username").toString();
        if(req.getSession().getAttribute("username") != null) {
            return "searchBooks";
        } else {
            return "notAuthorized";
        }
    }
}
