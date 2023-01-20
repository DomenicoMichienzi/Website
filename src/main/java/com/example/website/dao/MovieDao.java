package com.example.website.dao;

import com.example.website.model.Movie;

import java.util.List;

public interface MovieDao {
    List<Movie> getAll();
    Movie getByKey(String movie_id);
    boolean save(Movie movie);
    boolean update(Movie movie);
    boolean delete(String movie_id, String username_id);
}
