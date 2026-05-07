package com.aegis.newcontroller;

import java.io.*;
import java.net.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/trackIP")
public class IpTrackerServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String ip = request.getParameter("ip");

        String apiUrl = "http://ip-api.com/json/" + ip;

        URL url = new URL(apiUrl);
        HttpURLConnection con = (HttpURLConnection) url.openConnection();
        con.setRequestMethod("GET");

        BufferedReader reader = new BufferedReader(
                new InputStreamReader(con.getInputStream())
        );

        String line;
        StringBuilder result = new StringBuilder();

        while ((line = reader.readLine()) != null) {
            result.append(line);
        }

        reader.close();

        response.setContentType("application/json");
        response.getWriter().write(result.toString());
    }
}