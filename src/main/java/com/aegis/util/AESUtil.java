package com.aegis.util;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import javax.crypto.spec.IvParameterSpec;
import java.util.Base64;
import java.security.SecureRandom;

public class AESUtil {

    private static final String SECRET_KEY = "1234567890123456"; // 16 chars

    // 🔐 ENCRYPT
    public static String encrypt(String data) throws Exception {

        byte[] keyBytes = SECRET_KEY.getBytes("UTF-8");
        SecretKeySpec key = new SecretKeySpec(keyBytes, "AES");

        // 🔥 RANDOM IV
        byte[] iv = new byte[16];
        SecureRandom random = new SecureRandom();
        random.nextBytes(iv);

        IvParameterSpec ivSpec = new IvParameterSpec(iv);

        Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
        cipher.init(Cipher.ENCRYPT_MODE, key, ivSpec);

        byte[] encrypted = cipher.doFinal(data.getBytes("UTF-8"));

        // 🔥 COMBINE IV + DATA
        byte[] combined = new byte[iv.length + encrypted.length];
        System.arraycopy(iv, 0, combined, 0, iv.length);
        System.arraycopy(encrypted, 0, combined, iv.length, encrypted.length);

        return Base64.getEncoder().encodeToString(combined);
    }

    // 🔐 DECRYPT
    public static String decrypt(String encryptedData) throws Exception {

        byte[] combined = Base64.getDecoder().decode(encryptedData);

        // 🔥 EXTRACT IV
        byte[] iv = new byte[16];
        byte[] encrypted = new byte[combined.length - 16];

        System.arraycopy(combined, 0, iv, 0, 16);
        System.arraycopy(combined, 16, encrypted, 0, encrypted.length);

        SecretKeySpec key = new SecretKeySpec(SECRET_KEY.getBytes("UTF-8"), "AES");
        IvParameterSpec ivSpec = new IvParameterSpec(iv);

        Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
        cipher.init(Cipher.DECRYPT_MODE, key, ivSpec);

        return new String(cipher.doFinal(encrypted), "UTF-8");
    }
}