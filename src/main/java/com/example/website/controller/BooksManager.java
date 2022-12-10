package com.example.website.controller;

import com.example.website.Database;
import com.example.website.model.Book;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.ArrayList;

@Controller
public class BooksManager {

    @GetMapping("/doBooks")
    public String listOfBooks(HttpServletRequest req) {
        String usr = req.getSession().getAttribute("username").toString();
        if(req.getSession().getAttribute("username") != null) {
            ArrayList<Book> bs = Database.getInstance().getUserDao().getByKey(usr).getBooks();
            req.setAttribute("books", bs);
            return "booksPage";
        } else {
            return "notAuthorized";
        }
    }
}
