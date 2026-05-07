package com.aegis.controller;

import java.sql.Connection;

import com.aegis.dao.MessageDAO;
import com.aegis.model.Message;
import com.aegis.util.AESUtil;


public class MessageController {
	public void viewMessages(Connection conn, String receiver) {

	    try {
	        MessageDAO dao = new MessageDAO();

	        // Get messages from DB
	        java.util.List<Message> list = dao.getMessages(conn, receiver);

	        for (Message msg : list) {

	            // 🔓 Decrypt message
	            String decrypted = AESUtil.decrypt(msg.getMessage());

	            System.out.println("From: " + msg.getSender());
	            System.out.println("Message: " + decrypted);
	            System.out.println("Time: " + msg.getTimestamp());
	            System.out.println("-------------------------");
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}
    public void sendMessage(Connection conn, String sender, String receiver, String messageText) {

        try {
            // 🔐 Encrypt message
            String encryptedMessage = AESUtil.encrypt(messageText);

            // Create message object
            Message msg = new Message();
            msg.setSender(sender);
            msg.setReceiver(receiver);
            msg.setMessage(encryptedMessage);

            // Save to DB
            MessageDAO dao = new MessageDAO();
            dao.saveMessage(conn, msg);

            System.out.println("Message Sent Securely ✅");

        } catch (Exception e) {
            e.printStackTrace();
        }
        
    }
}