<%@ page import="java.nio.charset.StandardCharsets" %>
<%@ page import="Server.dealQuery" %>
<%@ page import="Server.reply" %>
<%@ page import="Server.userselect" %>
<%@ page import="database.operation" %>
<%@ page import="java.util.Vector" %>
<%@ page import="Server.wares" %><%--
  Created by IntelliJ IDEA.
  User: lizhengxin
  Date: 2019-08-18
  Time: 19:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    request.setCharacterEncoding("GBK");
    String Query=request.getParameter("MyQuery");//解决中文显示乱码问题
    try {

        reply reply;
        String curselecttip = "产品类型";

        if(userselect.getCurselect()!=null&& userselect.getCurselect().contains(Query)){  //连续问题，且用户输入在问题内容中，则继续回答
            reply= operation.cengdeal(Query);
            if(userselect.getType()==null) {
                userselect.setType(Query);
                curselecttip="包装方式";
            }
            else if(userselect.getBaozhuang()==null) {
                userselect.setBaozhuang(Query);
                curselecttip="尺寸";
            }
            else if (userselect.getChicun()==null) {
                userselect.setChicun(Query);
                curselecttip="材质";
            }

        }
        else{
            userselect.init();
            dealQuery dealQuery = new dealQuery(Query);
            reply = dealQuery.getReply();      //reply有三个参数，一个是内容，一个是是否连续问，一个是否连续问完显示商品
        }


        String front="<div class='btalk'><span>";
        String behind="</span></div>";
        String []replys=reply.getReply().split(",");
        String result="";
        if(reply.getCeng()==1) {     //reply中包含的是继续查询需要输入的内容
            userselect.setCurselect(reply.getReply());
            result += "请选择"+curselecttip+"<br>";
            for(int i=0;i<replys.length;i++)
                result+="<br>"+replys[i];
        }
        else if(reply.getShow()==1) {   //reply中包含的内容为商品编号
            result += "为您推荐如下<br>";
            Vector<wares> wares=new Vector<>();
            for(int i=0;i<replys.length;i++){
                result+="<iframe src='wares.jsp?num="+replys[i]+"' style='border: none' width='500px' height='200px' scrolling='no'></iframe>";
            }

        }
        else{
            for(int i=0;i<replys.length;i++)
                result+="<br>"+replys[i];
        }


        out.println(front+result+behind);
    } catch (InterruptedException e) {
        e.printStackTrace();
    }
    System.out.println(Query);


%>
</body>
</html>
