package com.example.website.database;

import com.example.website.dao.BookDao;
import com.example.website.dao.MovieDao;
import com.example.website.dao.UserDao;
import com.example.website.jdbc.BookDaoJDBC;
import com.example.website.jdbc.MovieDaoJDBC;
import com.example.website.jdbc.UserDaoJDBC;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Database {
    private static Database instance = null;
    private Connection conn;
    public static Database getInstance() {
        if(instance == null) {
            instance = new Database();
        }
        return instance;
    }
    private Database() {
        try {
            // Hard coded user and password
            conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres",
                                                "postgres","postgres");
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public UserDao getUserDao() {
        return new UserDaoJDBC(conn);
    }
    public BookDao getBookDao() {
        return new BookDaoJDBC(conn);
    }
    public MovieDao getMovieDao() { return new MovieDaoJDBC(conn); }
}
