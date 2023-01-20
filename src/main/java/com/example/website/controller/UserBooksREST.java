package com.example.website.controller;

import com.example.website.database.Database;
import com.example.website.model.Book;
import com.example.website.utility.Image;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.web.bind.annotation.*;

@RestController
public class UserBooksREST {
    @PostMapping("/addBook")
    public String addBook(@RequestBody Book b, @RequestParam String coverURL,
                           HttpServletRequest req) {
        String usr = req.getSession().getAttribute("username").toString();
        if(usr != null) {
            b.setUsername_id(usr);
            if(Database.getInstance().getBookDao().save(b)) {
                // Save cover image
                Image.saveBookCover(coverURL, b.getVolume_id());
                return "Success";
            }
        }
        return "Failed";
    }

    @PostMapping("/removeBook")
    public String removeBook(@RequestBody String bookID, HttpServletRequest req) {
        String usr = req.getSession().getAttribute("username").toString();
        if(usr != null) {
            if(Database.getInstance().getBookDao().delete(bookID)) {
                // Delete cover image
                Image.deleteBookCover(bookID);
                return "Successfully Removed";
            }
        }
        return "Failed";
    }
}
