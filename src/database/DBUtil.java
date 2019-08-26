package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {
    private String dbClassName = "com.mysql.cj.jdbc.Driver";
    private Connection ct=null;
    private String url="jdbc:mysql://47.101.198.71:3306/testdatabase?useUnicode=true&characterEncoding=utf-8&useSSL=false&serverTimezone=GMT%2B8";
    private String username="root";
    private String password="1234";
    public Connection getCon() {

        try {
            Class.forName(dbClassName);
            try {
                ct=DriverManager.getConnection(url,username,password);
            } catch (SQLException e) {

                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        } catch (ClassNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return ct;

    }
    public void close() {
        if(ct!=null) {
            try {
                ct.close();
            } catch (SQLException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
    }
    public static void main(String []args) {
        if(new DBUtil().getCon()!=null)
            System.out.println("success");
        else
            System.out.println("false");
    }

}
