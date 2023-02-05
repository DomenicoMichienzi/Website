package com.example.website.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import java.io.IOException;
import java.sql.*;
import java.util.Objects;

@Controller
public class Login {

    @GetMapping("/loginPage")
    public String loginPage() {
        return "login";
    }

    @GetMapping("/doLogout")
    public void logout(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        session.invalidate();
        resp.sendRedirect("/");
    }

    @PostMapping("/doSignUp")
    public String signUp(HttpServletRequest req, HttpServletResponse resp,
                         String username, String email, String passwd) throws IOException {

        try {
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres",
                    "postgres","postgres");

            String query = "insert into users (email, username, password)" +
                    " values (?, ?, ?)";

            PreparedStatement pst = con.prepareStatement(query);

            pst.setString(1, email);
            pst.setString(2, username);
            pst.setString(3, passwd);

            int rs = pst.executeUpdate();

            if(rs == 1) {
                HttpSession session = req.getSession(true);
                session.setAttribute("username", username);
                resp.sendRedirect("/");
            }

        } catch (SQLException | IOException e) {
            e.printStackTrace();
            resp.sendRedirect("/");
            return null;
        }
        return null;
    }

    @PostMapping("/doLogin")
    public String doLogin(HttpServletRequest req, HttpServletResponse resp, String username, String passwd) throws IOException {
        String query = "select * from users where username = '" + username + "'";
        HttpSession session = req.getSession(true);

        try {
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres",
                                                        "postgres","postgres");

            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(query);

            if(rs.next()) {
                // password check
                if(Objects.equals(rs.getString("password"), passwd)) {
                    session.setAttribute("username", rs.getString("username"));
                    resp.sendRedirect("/");
                    return null;
                }
            }
            // TODO bad username and/or password
            resp.sendRedirect("/");

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
