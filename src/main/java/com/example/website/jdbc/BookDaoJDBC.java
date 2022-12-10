package com.example.website.jdbc;

import com.example.website.dao.BookDao;
import com.example.website.model.Book;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

public class BookDaoJDBC implements BookDao{

    private Connection conn;

    public BookDaoJDBC(Connection conn) {
        this.conn = conn;
    }

    @Override
    public List<Book> getAll() {
        return null;
    }

    @Override
    public Book getByKey(String volume_id) {
        return null;
    }

    @Override
    public boolean saveOrUpdate(Book book) {
    System.out.println("Save or Update");
        try {

            String query = "insert into book (volume_id, isbn, comment, link, description, done, stars, username_id)\n" +
                    "values (?, ?, ?, ?, ?, ?, ?, ?) " +
                    "on conflict (volume_id) do update set comment =  excluded.comment, " +
                    "stars = excluded.stars, done = excluded.done";
            PreparedStatement pst = conn.prepareStatement(query);
            pst.setString(1, book.getVolume_id());
            pst.setString(2, book.getIsbn());
            pst.setString(3, book.getComment());
            pst.setString(4, book.getLink());
            pst.setString(5, book.getDescription());
            pst.setBoolean(6, book.isDone());
            pst.setShort(7, book.getStars());
            pst.setString(8, book.getUsername_id());

            pst.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }

        return true;
    }

    @Override
    public boolean delete(String bookID) {

        try {
            String query = "delete from book " +
                    "where volume_id = ?";

            PreparedStatement pst = conn.prepareStatement(query);
            pst.setString(1, bookID);

            pst.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }

        return true;
    }
}
