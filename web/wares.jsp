<%@ page import="database.operation" %>
<%@ page import="Server.wares" %><%--
  Created by IntelliJ IDEA.
  User: lizhengxin
  Date: 2019-08-19
  Time: 19:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
        table{
            width: 500px;
            height: 200px;
        }
        td.td1{
            width: 140px;

        }
        td.td2{
            width:360px;

        }
    </style>
</head>
<body>
<%
    int num=Integer.parseInt(request.getParameter("num"));
    wares wares= operation.getwaresbynum(num);
%>
<table>
    <td class="td1">
        <img src="<%="http://47.101.198.71/images"+wares.getImages()%>" width="140px" height="200px">
    </td>
    <td class="td2">
       商品编号： <%=wares.getId()%>
        <br>
        商品名称：<%=wares.getName()%>
        <br>
        单位：<%=wares.getDanwei()%><br>
        包装：<%=wares.getBaozhuang()%><br>
        尺寸：<%=wares.getChicun()%><br>
        材质：<%=wares.getCaizhi()%><br>
        价格：<%=wares.getPrice()%>
    </td>
</table>
</body>
</html>
