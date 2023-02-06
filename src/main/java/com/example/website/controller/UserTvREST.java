package com.example.website.controller;

import com.example.website.database.Database;
import com.example.website.model.Tv;
import com.example.website.utility.Image;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.xml.crypto.Data;

@RestController
public class UserTvREST {
    @PostMapping("/updateTv")
    public String updateTv(@RequestBody Tv tv, HttpServletRequest req) {
        String usr = req.getSession().getAttribute("username").toString();

        if(usr != null) {
            // add username_id to Tv object
            tv.setUsername_id(usr);

            if(Database.getInstance().getTvDao().update(tv)) {
                return "Success";
            }
        }
        return "Failed";
    }

    @PostMapping("/addTv")
    public String addTv(@RequestBody Tv tv, @RequestParam String poster,
                        HttpServletRequest req) {
        String usr = req.getSession().getAttribute("username").toString();

        if(usr != null) {
            // add username_id to Tv object
            tv.setUsername_id(usr);

            // check if the tv already exists in the library
            if(Database.getInstance().getTvDao().check(tv)) {
                return "exists";
            }

            if(Database.getInstance().getTvDao().save(tv)) {
                // save poster image
                Image.saveTvPoster(poster, tv.getTv_id());
                return "Success";
            }
        }
        return "Failed";
    }

    @PostMapping("/removeTv")
    public String removeTv(@RequestBody String tv_id, HttpServletRequest req) {
        String usr = req.getSession().getAttribute("username").toString();

        if(usr != null) {
            if(Database.getInstance().getTvDao().delete(tv_id, usr) &&
                !Database.getInstance().getTvDao().check(tv_id)) {
                // delete poster image
                Image.deleteTvPoster(tv_id);
                return "Successfully Removed";
            }
        }
        return "Failed";
    }
}