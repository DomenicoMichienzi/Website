package com.example.website.controller;

import com.example.website.database.Database;
import com.example.website.model.Book;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.web.bind.annotation.*;

@RestController
public class UserBooksREST {
    @PostMapping("/addBook")
    public String addBook(@RequestBody Book b,
                           HttpServletRequest req) {
        String usr = req.getSession().getAttribute("username").toString();
        if(usr != null) {
            b.setUsername_id(usr);
            if(Database.getInstance().getBookDao().saveOrUpdate(b)) {
                return "Success";
            }
        }
        return "Failed";
    }

    @PostMapping("/removeBook")
    public String removeBook(@RequestBody String bookID, HttpServletRequest req) {
        String usr = req.getSession().getAttribute("username").toString();
        //System.out.println("bookID: " + bookID);
        if(usr != null) {
            if(Database.getInstance().getBookDao().delete(bookID)) {
                return "Successfully Removed";
            }
        }
        return "Failed";
    }
}
