package com.example.website.controller;

import com.example.website.database.Database;
import com.example.website.model.Movie;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class MoviesManager {

    @GetMapping("/doMovies")
    public String listOfMovies(HttpServletRequest req) {
        String usr = req.getSession().getAttribute("username").toString();
        if(req.getSession().getAttribute("username") != null) {
            List<Movie> movies = Database.getInstance().getUserDao().getAllMovies(usr);
            req.setAttribute("movies", movies);
            return "moviesPage";
        } else {
            return "notAuthorized";
        }
    }

    @GetMapping("/searchMovies")
    public String searchMovies(HttpServletRequest req) {
        String usr = req.getSession().getAttribute("username").toString();
        if(req.getSession().getAttribute("username") != null) {
            return "movieSearch";
        } else {
            return "notAuthorized";
        }
    }
}
