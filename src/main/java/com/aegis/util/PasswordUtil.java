package com.aegis.util;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtil {

    // 🔐 HASH PASSWORD
    public static String hashPassword(String plainPassword) {
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt(10));
    }

    // 🔐 CHECK PASSWORD
    public static boolean checkPassword(String plainPassword, String hashedPassword) {
        return BCrypt.checkpw(plainPassword, hashedPassword);
    }
}