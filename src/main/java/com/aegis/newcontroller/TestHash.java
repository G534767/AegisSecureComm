package com.aegis.newcontroller;

import com.aegis.security.PasswordUtil;

public class TestHash {

    public static void main(String[] args) {

        String adminHash = PasswordUtil.hashPassword("admin123");
        String soldierHash = PasswordUtil.hashPassword("123");

        System.out.println("ADMIN HASH:");
        System.out.println(adminHash);

        System.out.println("\nSOLDIER HASH:");
        System.out.println(soldierHash);
    }
}