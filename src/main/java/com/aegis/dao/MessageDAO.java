package com.aegis.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.aegis.model.Message;

public class MessageDAO {

    // SAVE MESSAGE
    public void saveMessage(Connection conn, Message msg) {
        try {
            String sql = "INSERT INTO messages (sender, receiver, message, timestamp) VALUES (?, ?, ?, NOW())";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, msg.getSender());
            ps.setString(2, msg.getReceiver());
            ps.setString(3, msg.getMessage());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // GET MESSAGES FOR USER
    public List<Message> getMessages(Connection conn, String receiver) {

        List<Message> list = new ArrayList<>();

        try {
            String sql = "SELECT * FROM messages WHERE receiver=?";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, receiver);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Message msg = new Message();

                msg.setId(rs.getInt("id"));
                msg.setSender(rs.getString("sender"));
                msg.setReceiver(rs.getString("receiver"));
                msg.setMessage(rs.getString("message"));
                msg.setTimestamp(rs.getString("timestamp"));

                list.add(msg);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}