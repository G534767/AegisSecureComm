import com.aegis.util.PasswordUtil;

public class TestPassword {
    public static void main(String[] args) {

        String password = "12345";

        String hashed = PasswordUtil.hashPassword(password);

        System.out.println("Original: " + password);
        System.out.println("Hashed: " + hashed);
    }
}