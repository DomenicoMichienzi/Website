package com.example.website.controller;

import com.example.website.database.Database;
import com.example.website.model.Movie;
import com.example.website.utility.Image;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class UserMoviesREST {
    @PostMapping("/addMovie")
    public String addMovie(@RequestBody Movie m, @RequestParam String poster,
                           HttpServletRequest req) {
        String usr = req.getSession().getAttribute("username").toString();
        if(usr != null) {
            m.setUsername_id(usr);
            if(Database.getInstance().getMovieDao().save(m)) {
                // Save poster image
                Image.saveMoviePoster(poster, m.getMovie_id(), usr);
                return "Success";
            }
        }
        return "Failed";
    }

    @PostMapping("/removeMovie")
    public String removeMovie(@RequestBody String movie_id, HttpServletRequest req) {
        String usr = req.getSession().getAttribute("username").toString();

        if(usr != null) {
            if(Database.getInstance().getMovieDao().delete(movie_id, usr)) {
                // Delete poster image
                Image.deleteMoviePoster(movie_id, usr);
                return "Successfully Removed";
            }
        }
        return "Failed";
    }
}
