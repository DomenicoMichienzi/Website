package com.example.website.controller;

import com.example.website.database.Database;
import com.example.website.model.Book;
import com.example.website.model.Movie;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class ItemPageManager {
    @GetMapping("/item")
    public String itemPage(HttpServletRequest req, @RequestParam String item_type, @RequestParam String item_id) {
        System.out.println("type: " + item_type);
        if(req.getSession().getAttribute("username") != null) {
            String usr = req.getSession().getAttribute("username").toString();

            switch(item_type) {
                case "book":
                    List<Book> books = Database.getInstance().getBookDao().getReviewsAndRatings(item_id);
                    req.setAttribute("items", books);
                    req.setAttribute("book_id", item_id);
                    req.setAttribute("type", "book");
                    return "item";

                case "movie":
                    List<Movie> movies = Database.getInstance().getMovieDao().getReviewsAndRatings(item_id);
                    req.setAttribute("items", movies);
                    req.setAttribute("movie_id", item_id);
                    req.setAttribute("type", "movie");
                    return "item";

                case "tv":
                    //code
                    break;
            }

        }
        return "notAuthorized";
    }
}
