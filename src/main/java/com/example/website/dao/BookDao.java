package com.example.website.dao;

import com.example.website.model.Book;

import java.util.List;

public interface BookDao {
    List<Book> getAll();
    boolean check(Book book);  // check if the book is already in the library
    boolean save(Book book);
    boolean update(Book book);
    //boolean update(Book book);
    boolean delete(String book_id, String username_id);
}
