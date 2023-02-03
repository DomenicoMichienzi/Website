package com.example.website.controller;

import com.example.website.database.Database;
import com.example.website.model.Book;
import com.example.website.utility.Image;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.web.bind.annotation.*;

import javax.xml.crypto.Data;

@RestController
public class UserBooksREST {

    @PostMapping("/updateBook")
    public String updateBook(@RequestBody Book b, HttpServletRequest req) {
        String usr = req.getSession().getAttribute("username").toString();

        if(usr != null) {
            // add username_id to Book object
            b.setUsername_id(usr);

            if(Database.getInstance().getBookDao().update(b)) {
                return "Success";
            }
        }
        return "Failed";
    }
    @PostMapping("/addBook")
    public String addBook(@RequestBody Book b, @RequestParam String coverURL,
                           HttpServletRequest req) {
        String usr = req.getSession().getAttribute("username").toString();
        if(usr != null) {
            // add username_id to Book object
            b.setUsername_id(usr);

            // remove html tags in the description of some books (Google APIs bug)
            String html = b.getDescription();
            if(html != null) {
                String result = html.replaceAll("<[^>]*>", "");
                b.setDescription(result);
            }

            // check if the book already exists in the library
            if(Database.getInstance().getBookDao().check(b)) {
                return "exists";
            }

            if(Database.getInstance().getBookDao().save(b)) {
                // Save cover image
                Image.saveBookCover(coverURL, b.getVolume_id());
                return "Success";
            }
        }
        return "Failed";
    }

    @PostMapping("/removeBook")
    public String removeBook(@RequestBody String book_id, HttpServletRequest req) {
        String usr = req.getSession().getAttribute("username").toString();

        if(usr != null) {
            if(Database.getInstance().getBookDao().delete(book_id, usr) &&
                !Database.getInstance().getBookDao().check(book_id)) {
                // Delete cover image
                Image.deleteBookCover(book_id);
                return "Successfully Removed";
            }
        }
        return "Failed";
    }
}
