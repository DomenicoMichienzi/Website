package com.example.website.jdbc;

import com.example.website.dao.UserDao;
import com.example.website.model.Book;
import com.example.website.model.Movie;
import com.example.website.model.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDaoJDBC implements UserDao {
    private Connection conn;

    public UserDaoJDBC(Connection conn) {
        this.conn = conn;
    }

    @Override
    public User getByKey(String username_id) {
        User usr = null;
        String query = "select * from books inner join users u " +
                "on u.username = books.username_id where u.username = '" + username_id + "'";

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
                b.setLink(rs.getString("link"));
                b.setDescription(rs.getString("description"));
                b.setReview(rs.getString("review"));
                b.setRating(rs.getFloat("rating"));
                b.setComment(rs.getString("comment"));
                // add created book to the list of books in the User class
                // TODO Fix
                usr.getBooks().add(b);
            }
        } catch (SQLException e) {
            e.printStackTrace();
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
    public List<Book> getAllBooks() {
        ArrayList<Book> books = new ArrayList<Book>();

        // ordered by rating desc
        String query = "select * from books order by rating desc";

        try {
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(query);

            while(rs.next()) {
                // create Book
                Book b = new Book();

                if(rs.getFloat("rating") == 0.0)
                    break;

                b.setVolume_id(rs.getString("volume_id"));
                b.setUsername_id(rs.getString("username_id"));
                b.setComment(rs.getString("comment"));
                b.setLink(rs.getString("link"));
                b.setDescription(rs.getString("description"));
                b.setTitle(rs.getString("title"));
                b.setReview(rs.getString("review"));
                b.setRating(rs.getFloat("rating"));
                b.setComment(rs.getString("comment"));

                // Add Book
                books.add(b);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return books;
    }

    @Override
    public List<Movie> getAllMovies() {
        return null;
    }

    @Override
    // Get Books by username
    public List<Book> getBooksByUserID(String username) {
        ArrayList<Book> books = new ArrayList<Book>();

        // ordered by title
        String query = "select * from books inner join users u " +
                "on u.username = books.username_id where u.username = '" + username + "' order by books.title";

        try {
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(query);
            while (rs.next()) {
                // Create book
                Book b = new Book();

                b.setVolume_id(rs.getString("volume_id"));
                b.setUsername_id(rs.getString("username_id"));
                b.setComment(rs.getString("comment"));
                b.setLink(rs.getString("link"));
                b.setDescription(rs.getString("description"));
                b.setTitle(rs.getString("title"));
                b.setReview(rs.getString("review"));
                b.setRating(rs.getFloat("rating"));
                b.setComment(rs.getString("comment"));

                // Add Book
                books.add(b);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return books;
    }

    @Override
    public List<Movie> getMoviesByKey(String username) {
        List<Movie> movies = new ArrayList<Movie>();

        // ordered by title
        String query = "select * from movies inner join users u " +
                "on u.username = movies.username_id where u.username = '" + username + "' order by movies.title";

        try {
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(query);
            while (rs.next()) {
                // Create Movie
                Movie m = new Movie();

                m.setMovie_id(rs.getString("movie_id"));
                m.setUsername_id(rs.getString("username_id"));
                m.setTitle(rs.getString("title"));
                m.setDescription(rs.getString("description"));
                m.setReview(rs.getString("review"));
                m.setRating(rs.getFloat("rating"));
                m.setComment(rs.getString("comment"));

                // Add Movie
                movies.add(m);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return movies;
    }


}
