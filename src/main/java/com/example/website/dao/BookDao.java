package com.example.website.dao;

import com.example.website.model.Book;

import java.util.List;

public interface BookDao {
    List<Book> getAll();
    Book getByKey(String volume_id);

    // TODO - split method for better usage
    boolean saveOrUpdate(Book book);
    boolean delete(String bookID);
}
