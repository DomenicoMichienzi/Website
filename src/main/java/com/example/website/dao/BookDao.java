package com.example.website.dao;

import com.example.website.model.Book;

import java.util.List;

public interface BookDao {
    List<Book> getAll();
    Book getByKey(String volume_id);
    //boolean saveOrUpdate(Book book);
    boolean save(Book book);
    boolean update(Book book);
    boolean delete(String bookID);
}
