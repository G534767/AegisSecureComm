import java.sql.Connection;

import com.aegis.controller.MessageController;
import com.aegis.util.DBConnection;

public class TestApp {

    public static void main(String[] args) {

        // DB connect
        Connection conn = DBConnection.getConnection();

        MessageController controller = new MessageController();

        // SEND MESSAGE
        controller.sendMessage(conn, "Commander", "Soldier", "Attack at 5AM");

        // VIEW MESSAGE
        controller.viewMessages(conn, "Soldier");
    }
}