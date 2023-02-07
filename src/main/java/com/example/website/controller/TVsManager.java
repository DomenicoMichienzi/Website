package com.example.website.controller;

import com.example.website.database.Database;
import com.example.website.model.Tv;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class TVsManager {
    @GetMapping("/getTVs")
    public String listOfTVs(HttpServletRequest req) {
        if(req.getSession().getAttribute("username") != null) {
            String usr = req.getSession().getAttribute("username").toString();

            List<Tv> tvs = Database.getInstance().getUserDao().getTvsByUser(usr);
            req.setAttribute("tvs", tvs);
            return "tvs";
        }
        return "notAuthorized";
    }
}
