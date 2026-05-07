package com.aegis.security;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtil {

    // 🔐 HASH PASSWORD
    public static String hashPassword(String plainPassword) {

        if (plainPassword == null || plainPassword.isEmpty()) {
            throw new IllegalArgumentException("Password cannot be empty");
        }

        // 🔥 12 rounds (secure)
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt(12));
    }

    // 🔐 VERIFY PASSWORD
    public static boolean checkPassword(String plainPassword, String hashedPassword) {

        if (plainPassword == null || hashedPassword == null) {
            return false;
        }

        try {
            return BCrypt.checkpw(plainPassword, hashedPassword);
        } catch (Exception e) {
            return false; // 🔥 prevent crash
        }
    }
}