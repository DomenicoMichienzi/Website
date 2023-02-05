package com.example.website.utility;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URL;
import java.nio.channels.Channels;
import java.nio.channels.ReadableByteChannel;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

public class Image {

    public static void deleteBookCover(String book_id) {
        String path = "src/main/webapp/assets/books/covers/" + book_id + ".png";
        File img = new File(path);
        img.delete();
    }

    public static void deleteMoviePoster(String movie_id) {
        String path = "src/main/webapp/assets/movies/posters/" + movie_id + ".jpg";
        File img = new File(path);
        img.delete();
    }
    public static void saveBookCover(String url_cover, String book_id) {
        String u = "https://books.google.com/books/publisher/content/images/frontcover/" + book_id;
        try {
            String textPath =  "src/main/webapp/assets/books/covers/";
            // create folder if it not exists
            Path path = Paths.get(textPath);
            Files.createDirectories(path);

            downloadUsingNIO(u, textPath + book_id + ".png");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void saveMoviePoster(String poster_path, String movie_id) {
        String url = "https://image.tmdb.org/t/p/w500" + poster_path;

        try {
            String textPath = "src/main/webapp/assets/movies/posters/";
            // create folder if it not exists
            Path path = Paths.get(textPath);
            Files.createDirectories(path);

            downloadUsingNIO(url, textPath + movie_id + ".jpg");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static void downloadUsingNIO(String urlStr, String file) throws IOException {
        URL url = new URL(urlStr);
        ReadableByteChannel rbc = Channels.newChannel(url.openStream());
        FileOutputStream fos = new FileOutputStream(file);
        fos.getChannel().transferFrom(rbc, 0, Long.MAX_VALUE);
        fos.close();
        rbc.close();
    }

    private static void downloadUsingStream(String urlStr, String file) throws IOException{
        URL url = new URL(urlStr);
        BufferedInputStream bis = new BufferedInputStream(url.openStream());
        FileOutputStream fis = new FileOutputStream(file);
        byte[] buffer = new byte[1024];
        int count=0;
        while((count = bis.read(buffer,0,1024)) != -1)
        {
            fis.write(buffer, 0, count);
        }
        fis.close();
        bis.close();
    }
}
