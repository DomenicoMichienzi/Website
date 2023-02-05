package com.example.website.controller;

import com.example.website.database.Database;
import com.example.website.model.Book;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class BooksManager {

    @GetMapping("/getBooks")
    public String listOfBooks(HttpServletRequest req) {
        if(req.getSession().getAttribute("username") != null) {
            String usr = req.getSession().getAttribute("username").toString();
            List<Book> bs = Database.getInstance().getUserDao().getBooksByUser(usr);
            req.setAttribute("books", bs);
            return "booksPage";
        } else {
            // TODO - Redirect to Login Page
            return "notAuthorized";
        }
    }
}
