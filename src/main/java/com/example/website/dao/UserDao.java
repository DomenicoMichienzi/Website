package com.example.website.dao;

import com.example.website.model.Book;
import com.example.website.model.Movie;
import com.example.website.model.Tv;
import com.example.website.model.User;

import java.util.List;

public interface UserDao {
    User getByKey(String username);
    void saveOrUpdate(User user);
    void delete(User user);

    List<Book> getAllBooks();
    List<Movie> getAllMovies();
    List<Book> getBooksByUser(String username);
    List<Movie> getMoviesByUser(String username);
    List<Tv> getTvsByUser(String username);
}
