package com.example.website.controller;

import com.example.website.database.Database;
import com.example.website.utility.ReviewRating;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class ItemPageManager {
    @GetMapping("/itemPage")
    public String itemPage(HttpServletRequest req, @RequestParam String item_type, @RequestParam String item_id) {

        if(req.getSession().getAttribute("username") != null) {
            String usr = req.getSession().getAttribute("username").toString();

            switch(item_type) {
                case "book":
                    List<ReviewRating> items = Database.getInstance().getBookDao().getReviewsAndRatings(item_id);
                    req.setAttribute("items", items);
                    req.setAttribute("book_id", item_id);
                    req.setAttribute("type", "book");
                    return "itemPage";

                case "movie":
                    // code
                    break;

                case "TvShow":
                    //code
                    break;
            }

        }
        return "notAuthorized";
    }
}
