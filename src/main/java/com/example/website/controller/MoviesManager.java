package com.example.website.controller;

import com.example.website.database.Database;
import com.example.website.model.Movie;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class MoviesManager {

    @GetMapping("/getMovies")
    public String listOfMovies(HttpServletRequest req) {
        if(req.getSession().getAttribute("username") != null) {
            String usr = req.getSession().getAttribute("username").toString();
            List<Movie> movies = Database.getInstance().getUserDao().getMoviesByKey(usr);
            req.setAttribute("movies", movies);
            return "moviesPage";
        } else {
            // TODO - Redirect to Login Page
            return "notAuthorized";
        }
    }

    @GetMapping("/searchMovies")
    public String searchMovies(HttpServletRequest req) {
        if(req.getSession().getAttribute("username") != null) {
            return "searchMovies";
        } else {
            // TODO - Redirect to Login Page
            return "notAuthorized";
        }
    }
}
