package com.example.website.jdbc;

import com.example.website.dao.UserDao;
import com.example.website.model.Book;
import com.example.website.model.User;

import java.sql.*;
import java.util.List;

public class UserDaoJDBC implements UserDao {
    private Connection conn;

    public UserDaoJDBC(Connection conn) {
        this.conn = conn;
    }

    // TODO implement function
    @Override
    public List<User> getAll() {
        return null;
    }

    @Override
    public User getByKey(String username_id) {
        User usr = null;
        String query = "select * from book inner join users u " +
                "on u.username = book.username_id where u.username = '" + username_id + "'";

        try {
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(query);
            while (rs.next()) {
                if (usr == null) {
                    usr = new User();
                    usr.setUsername(rs.getString("username"));
                    usr.setEmail(rs.getString("email"));
                }
                Book b = new Book();
                b.setUsername_id(usr.getUsername());
                b.setVolume_id(rs.getString("volume_id"));
                b.setIsbn(rs.getString("isbn"));
                b.setComment(rs.getString("comment"));
                b.setLink(rs.getString("link"));
                b.setDescription(rs.getString("description"));
                b.setDone(rs.getBoolean("done"));
                b.setStars(rs.getShort("stars"));
                // add created book to the list of books in the User class
                // TODO Fix
                usr.getBooks().add(b);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return usr;
    }
    public User getByKeyLazy(String user_id) {
        User usr = null;
        String query = "select * from users where username = ?";
        try {
            PreparedStatement pst = conn.prepareStatement(query);
            pst.setString(1, user_id);
            ResultSet rs = pst.executeQuery(query);
            if(rs.next()) {
                usr = new User();
                usr.setUsername(rs.getString("username"));
                usr.setEmail(rs.getString("email"));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return usr;
    }

    @Override
    public void saveOrUpdate(User user) {

    }

    @Override
    public void delete(User user) {

    }

    @Override
    public List<Book> getAllBooks(String user_id) {
        return null;
    }


}
