package com.aegis;

import java.io.BufferedReader;
import java.io.FileReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

public class DatabaseSetup {
    
    public static void main(String[] args) {
        try {
            // Load MySQL driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // Connect to MySQL (without specifying database initially)
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/",
                "root",
                "root"
            );
            
            Statement stmt = con.createStatement();
            
            // Read and execute SQL script
            BufferedReader reader = new BufferedReader(new FileReader("database_setup.sql"));
            StringBuilder sqlScript = new StringBuilder();
            String line;
            
            while ((line = reader.readLine()) != null) {
                sqlScript.append(line).append("\n");
            }
            reader.close();
            
            // Split script by semicolons and execute each statement
            String[] sqlStatements = sqlScript.toString().split(";");
            
            for (String sql : sqlStatements) {
                sql = sql.trim();
                if (!sql.isEmpty() && !sql.startsWith("--")) {
                    try {
                        stmt.execute(sql);
                        System.out.println("Executed: " + sql.substring(0, Math.min(50, sql.length())) + "...");
                    } catch (Exception e) {
                        // Some statements might fail if they already exist
                        System.out.println("Skipped/Failed: " + sql.substring(0, Math.min(50, sql.length())) + "...");
                    }
                }
            }
            
            con.close();
            System.out.println("Database setup completed successfully!");
            
        } catch (Exception e) {
            System.out.println("Database setup failed: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
