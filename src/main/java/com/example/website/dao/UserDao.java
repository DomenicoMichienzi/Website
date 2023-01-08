package com.example.website.dao;

import com.example.website.model.Book;
import com.example.website.model.Movie;
import com.example.website.model.User;

import java.util.List;

public interface UserDao {
    List<User> getAll( );
    User getByKey(String username);
    void saveOrUpdate(User user);
    void delete(User user);
    List<Book> getAllBooks(String username);
    List<Movie> getAllMovies(String username);
}
