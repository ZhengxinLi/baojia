package database;

import Server.reply;
import Server.userselect;
import Server.wares;
import bean.baojia;
import bean.table;
import tools.ware;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

public class operation {
    private static Connection ct=null;
    private static PreparedStatement ps=null;
    private static ResultSet rs=null;


    private static ResultSet findForResultSet(String sql) {// 查询语句
        ResultSet myrs=null;
        try {
            DBUtil db = new DBUtil();
            if(ct==null)
                ct = db.getCon();
            else if(ct.isClosed())
                ct = db.getCon();
            ps = ct.prepareStatement(sql);
            myrs = ps.executeQuery();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return myrs;
    }

    private static void update(String sql) { // 更新，插入，删除语句
        int r = 0;
        try {
            DBUtil db = new DBUtil();
            if(ct==null)
                ct = db.getCon();
            else if(ct.isClosed())
                ct = db.getCon();
            ps = ct.prepareStatement(sql);
            r = ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public static void test(String sql){
        rs=findForResultSet(sql);
        String mytext="";
        try {
            while(rs.next())
            System.out.println(rs.getString(2));
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    public static Vector<baojia> gethistory(String[] canshu, String guige){
        Vector<baojia> history=new Vector<>();
        String[] C=new String[10];
        for(int i=0;i<10;i++)
            C[i]="c"+(i+1);
        String sql="select * from baojia where guige='"+guige+"'";
        for(int i=0,k=0;i<10;i++){
            if(canshu!=null&&k<canshu.length&&canshu[k].equals(C[i])) {
                sql += " and " + C[i] + "='1'";
                k++;
            }
            else
                sql+=" and "+C[i]+"='0'";
        }
        System.out.println(sql);
        rs=findForResultSet(sql);
        try {
            while (rs.next()){
                baojia baojia=new baojia();
                baojia.setA(rs.getFloat(1));
                baojia.setB(rs.getFloat(2));
                baojia.setC(rs.getFloat(3));
                baojia.setPrice(rs.getFloat(4));
                boolean ok=true;
                for(int i=0;i<history.size();i++){
                    float a=history.get(i).getA()/baojia.getA();
                    float b=history.get(i).getB()/baojia.getB();
                    float c=history.get(i).getC()/baojia.getC();
                    if(a==b&&b==c) {
                        ok = false;
                        break;
                    }
                }
                if(ok)
                    history.add(baojia);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return history;
    }

    public static  void main(String []args){
        for(int i=0;i<100;i++){
            Integer []randomcanshu=new Integer[11];
            int a=(int)(Math.random()*3);
            if(a==0)
                randomcanshu[0]=80;
            else if(a==1)
                randomcanshu[0]=120;
            else
                randomcanshu[0]=200;
            for(int j=1;j<=10;j++)
                randomcanshu[j]=(int)(Math.random()*2);
            float a1=(float)(Math.random()*15+1);
            float a2=(float)(Math.random()*15+1);
            float a3=(float)(Math.random()*15+1);
            float price=0;
            int temp=0;
            for(int j=1;j<=3;j++)
                temp+=randomcanshu[j];
            price+=(temp/2+1)*a1;
            temp=0;
            for(int j=4;j<=7;j++)
                temp+=randomcanshu[j];
            price+=(temp+1)*a2;
            temp=0;
            for(int j=8;j<=10;j++)
                temp+=randomcanshu[j];
            price+=(temp*2+1)*a3;
            if(randomcanshu[0]==120)
                price*=1.5;
            else if(randomcanshu[0]==200)
                price*=2;
            String sql="insert into baojia values('"+a1+"','"+a2+"','"+a3+"','"+price+"','"+randomcanshu[0]+"g";
            for(int j=1;j<=10;j++)
                sql+="','"+randomcanshu[j];
            sql+="')";
            operation.update(sql);

        }
    }

    public static Vector<table> gettable(){
        Vector<table> tables=new Vector<>();
        String sql="select * from baojia";
        rs=findForResultSet(sql);
        try {
            while (rs.next()){
                table table=new table();
                table.setA(rs.getFloat(1));
                table.setB(rs.getFloat(2));
                table.setC(rs.getFloat(3));
                table.setPrice(rs.getFloat(4));
                table.setGuige(rs.getString(5));

                table.setC1(rs.getInt(6));
                table.setC2(rs.getInt(7));
                table.setC3(rs.getInt(8));
                table.setC4(rs.getInt(9));
                table.setC5(rs.getInt(10));
                table.setC6(rs.getInt(11));
                table.setC7(rs.getInt(12));
                table.setC8(rs.getInt(13));
                table.setC9(rs.getInt(14));
                table.setC10(rs.getInt(15));
                tables.add(table);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tables;
    }

    public static void addbuy_num(int id){
        String  sql="select * from user_entper where userid='"+id+"'";
        int num=0;
        rs=findForResultSet(sql);
        try {
            rs.next();
            num=rs.getInt(28);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        num++;
        sql="update user_entper set buy_num='"+num+"' where userid='"+id+"'";
        update(sql);
    }

    public static void inserwares(Vector<ware> wares){
        String sql="delete from ware";
        update(sql);
        for(int i=0;i<wares.size();i++){
            sql="insert into ware values('"+wares.get(i).getWarename()+"','"+wares.get(i).getOther()+"','"+wares.get(i).getPrice()+"','"+
                    wares.get(i).getImg()+"','"+wares.get(i).getLocation()+"','"+wares.get(i).getShopname()+"')";
            update(sql);
        }
    }





    /******************dealrobot***********/
    public static reply getreplybynum(int num){
        String sql="select * from QDbase where num='"+num+"'";
        rs=findForResultSet(sql);
        reply reply=new reply();
        try {
            rs.next();
            reply.setCeng(rs.getInt(5));
            reply.setShow(0);

            if(rs.getInt(4)==1) { //若为1则为直接回答
                reply.setReply(rs.getString(3));
                userselect.init();
            }
            else {   //否则为sql查询语句，执行如下
                String content=rs.getString(3);
                String[] splits=content.split(",");
                sql=splits[0];
                int k=Integer.parseInt(splits[1]);
                rs=findForResultSet(sql);
                reply.setReply(getString(k));

                //userselect.init();
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reply;
    }
    public static reply cengdeal(String q) {
        String sql="select * from wares";
        reply reply=new reply();
        reply.setShow(0);
        reply.setCeng(1);
        if(userselect.getType()!=null) {
            sql += " where type='" + userselect.getType() + "'";
            if(userselect.getBaozhuang()!=null) {
                sql += " and baozhuang='" + userselect.getBaozhuang() + "'";
                if(userselect.getChicun()!=null) {
                    sql += " and chicun='" + userselect.getChicun() + "'";
                    //条件具备完毕，可以显示
                    sql += " and caizhi='" + q + "'";
                    rs = findForResultSet(sql);
                    String temp = "";
                    try {
                        while (rs.next())
                            temp += rs.getInt(1) + ",";
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                    reply.setShow(1);
                    reply.setCeng(0);
                    reply.setReply(temp);

                }
                else{
                    sql+=" and chicun='"+q+"'";
                    rs=findForResultSet(sql);
                    reply.setReply(getString(9));
                }
            }
            else{
                sql+=" and baozhuang='"+q+"'";
                rs=findForResultSet(sql);
                reply.setReply(getString(8));
            }
        }
        else {
            sql += " where type='" + q + "'";
            rs=findForResultSet(sql);
            reply.setReply(getString(6));
        }


        return reply;
    }

    public static String getString(int k){
        String temp="";
        try {
            while (rs.next()) {
                if(!temp.contains(rs.getString(k)))
                    temp += rs.getString(k)+",";
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }

    public static Vector<String> getD(){
        String sql="select * from QDbase";
        Vector<String> question=new Vector<>();
        rs=findForResultSet(sql);
        try {
            while (rs.next()){
                question.add(rs.getString(2));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return question;
    }

    public static wares getwaresbynum(int num){
        String sql="select * from wares where num='"+num+"'";
        rs=findForResultSet(sql);
        wares wares=new wares();
        try {
            rs.next();
            wares.setNum(rs.getInt(1));
            wares.setId(rs.getString(2));
            wares.setType(rs.getString(3));
            wares.setName(rs.getString(4));
            wares.setDanwei(rs.getString(5));
            wares.setBaozhuang(rs.getString(6));
            wares.setPrice(rs.getString(7));
            wares.setChicun(rs.getString(8));
            wares.setCaizhi(rs.getString(9));
            wares.setImages(rs.getString(10));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return wares;
    }

}
