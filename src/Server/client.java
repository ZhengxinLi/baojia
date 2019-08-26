package Server;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.net.Socket;

public class client extends JFrame implements Runnable{
    private Socket socket;
    private PrintWriter writer;
    private ScrollPane scrollPane;
    private JTextArea jta;
    private JTextField jt;
    public client(){
        connect();
        Thread thred=new Thread(this);
        thred.start();
        this.setBounds(0,0,200,300);
        jta=new JTextArea();
        jt=new JTextField();
        scrollPane=new ScrollPane();
        scrollPane.add(jta);
        jt.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                writer.println(jt.getText());
                jt.setText("");
            }
        });

        this.add(scrollPane, BorderLayout.CENTER);
        this.add(jt,BorderLayout.SOUTH);
        this.setVisible(true);
        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    }
    public void connect() {   //连接服务器

        try {
            socket = new Socket("127.0.0.1", 1997);
            writer = new PrintWriter(socket.getOutputStream(), true);
            //  jTextArea.append("连接成功\n");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    public void writemessage(String message){
        writer.println(message);
    }
    public static void main(String [] args){
        client client=new client();

    }

    @Override
    public void run() {
        try {
            // 读Sock里面的数据
            InputStream s = socket.getInputStream();
            byte[] buf = new byte[1024];
            int len = 0;
            while ((len = s.read(buf)) != -1) {
                //收到消息，现存放到消息队列里面，等打开相应的聊天界面才输出
              jta.append(new String(buf, 0, len));

            }

        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
