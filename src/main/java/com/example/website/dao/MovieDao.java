package com.example.website.dao;

import com.example.website.model.Book;
import com.example.website.model.LazyMovie;
import com.example.website.model.Movie;

import java.util.List;

public interface MovieDao {
    List<Movie> getAll();
    boolean check(Movie movie); // check if the movie (including username_id) is already in the library
    boolean check(String movie_id); // check if a movie is in the library
    boolean save(Movie movie);
    boolean update(Movie movie);
    boolean delete(String movie_id, String username_id);
    float avgRating(String movie_id);
    List<LazyMovie> sortedByAvg();
    List<Movie> getReviewsAndRatings(String movie_id);
}
