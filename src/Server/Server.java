package Server;

import java.io.*;
import java.net.ServerSocket;
import java.net.Socket;


public class Server {
    private ServerSocket server = null;
    private Socket socket = null;            //服务器段需要创建多个套接字，和多个客户端通信

    public Server(int port) {
        try {

            server = new ServerSocket(port);
            while (true) {
                start();
            }

        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    public void start() {

        System.out.println("wait client connect...");
        //if(socket==null)
        try {
            socket = server.accept();
//            new DealMessage(socket).start();
            dealmessage2(socket);

        } catch (Exception e1) {
            e1.printStackTrace();
        }

        //若上传不为网站，则自建jsp
    }

    public void dealmessage2(Socket socket){
        try {
            InputStream s = socket.getInputStream();
            byte[] buf = new byte[1024];
            int len = 0;
            while ( (len = s.read(buf)) != -1) {

                String contents = new String(buf, 0, len);
                dealQuery dealQuery=new dealQuery(contents);
                PrintWriter writer;
                writer = new PrintWriter(socket.getOutputStream(), true);
                writer.println(contents+dealQuery.getReply());
            }
        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
        }

    }


    class DealMessage extends Thread {
        private Socket socket = null;

        public DealMessage(Socket socket) {
            this.socket = socket;
        }

        @Override
        public void run() {
            while (true) {
                try {
                    InputStream s = socket.getInputStream();
                    byte[] buf = new byte[1024];
                    int len = 0;
                    while ( (len = s.read(buf)) != -1) {
                        String contents = new String(buf, 0, len);
                        dealQuery dealQuery=new dealQuery(contents);
                        PrintWriter writer;
                        writer = new PrintWriter(socket.getOutputStream(), true);
                        writer.println(dealQuery.getReply());
                    }
                } catch (IOException | InterruptedException e) {
                    e.printStackTrace();
                }

            }
        }
    }

    public static void main(String[] args) {
        Server server = new Server(1997);
    }




}


