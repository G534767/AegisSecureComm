import com.aegis.util.AESUtil;

public class TestAES {
    public static void main(String[] args) {

        String message = "Hello Commander";

        String encrypted = AESUtil.encrypt(message);
        System.out.println("Encrypted: " + encrypted);

        String decrypted = AESUtil.decrypt(encrypted);
        System.out.println("Decrypted: " + decrypted);
    }
}