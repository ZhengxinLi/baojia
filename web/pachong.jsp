<%@ page import="java.util.Vector" %>
<%@ page import="tools.pachong" %>
<%@ page import="tools.ware" %>
<%@ page import="result.pachongresult" %>
<%@ page import="java.util.logging.LoggingPermission" %>
<%@ page import="database.operation" %><%--
  Created by IntelliJ IDEA.
  User: lizhengxin
  Date: 2019-08-09
  Time: 23:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
        td.td1{
            width: 15%;
        }
        td.td2{
            width: 35%;
        }
        body{
            width: 100%;
            height: 100%;
        }
        table{
            height: 40%;
        }
        .title{
            color: #255e95;
            font-family: 微软雅黑, serif;
            font-size: 15px;
        }
        .content{
            opacity: 50%;
            font-size: 14px;

        }

    </style>
</head>

<body>
<p style="color: #255e95">以下是从京东商城获取的纸张信息（参数详情请点击相应连接）</p>

<%

    Vector<ware> wares;
    if(pachongresult.getNum()==0){
        pachong pachong=new pachong();
        wares=pachong.getWares();
        if(wares.size()>0) {
            pachongresult.setWares(wares);
            pachongresult.numadd();
        }
        else{
            wares=pachongresult.getWares();
        }

    }
    else{
        wares=pachongresult.getWares();
        pachongresult.numadd();
        if (pachongresult.getNum()>=10)
            pachongresult.setNum(0);
    }

    for(int i=0;i<wares.size();i++){
        System.out.println(wares.get(i).getLocation());
    }
    int pagenum=Integer.parseInt(request.getParameter("pagenum"));

    int length=0;
    if(pagenum*6<=wares.size())
        length=6;
    else
        length=wares.size()-(pagenum-1)*6;
    String [] name=new String[length];
    String [] price=new String[length];
    for(int i=0;i<length;i++) {
        name[i] = wares.get((pagenum - 1) * 6 + i).getWarename();
        price[i]=String.valueOf(wares.get((pagenum-1)*6+i).getPrice());
    }

%>
<input type="text" style="display: none" id="pagenum" value="<%=pagenum%>">
<table>
<%
    for(int i=(pagenum-1)*6;i<wares.size()&&i<pagenum*6;i+=2){
        %>
<tr>
    <td class="td1">
        <a href="<%=wares.get(i).getLocation()%>" target="_blank"><img src="<%=wares.get(i).getImg()%>" width="60%" height="60%"></a>
    </td>
    <td class="td2">
        <span class="title"> 纸张名：</span>  <span class="content"> <%=wares.get(i).getWarename()%></span><br>
        <span class="title"> 纸张详情：</span><span class="content"><%=wares.get(i).getOther()%></span><br>
        <span class="title">纸张价格：</span><span class="content"><%=wares.get(i).getPrice()%></span><br>
        <span class="title">商家：</span>  <span class="content"><%=wares.get(i).getShopname()%> </span>
    </td>
    <%
        if(wares.size()>i+1){
    %>
    <td class="td1">
        <a href="<%=wares.get(i+1).getLocation()%>" target="_blank"><img src="<%=wares.get(i+1).getImg()%>" width="60%" height="60%"></a>
    </td>
    <td class="td2">
        <span class="title">纸张名：</span>   <span class="content"><%=wares.get(i+1).getWarename()%>  </span><br>
        <span class="title">纸张详情：</span>  <span class="content"> <%=wares.get(i+1).getOther()%>  </span> <br>
        <span class="title">纸张价格：</span>  <span class="content"><%=wares.get(i+1).getPrice()%></span><br>
        <span class="title">商家：</span>   <span class="content"><%=wares.get(i+1).getShopname()%></span>
    </td>
    <%
        }
    %>
</tr>
<%
    }

%>
    <tr>
        <td colspan="2" align="center">
            <input type="button" value="前一页" id="pre">
        </td>
        <td colspan="2" align="center">
            <input type="button" value="后一页" id="next">
        </td>
    </tr>
</table>


<div id="container" style="height: 50%"></div>

<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/echarts.min.js"></script>
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts-gl/echarts-gl.min.js"></script>
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts-stat/ecStat.min.js"></script>
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/extension/dataTool.min.js"></script>
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/map/js/china.js"></script>
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/map/js/world.js"></script>
<script type="text/javascript" src="https://api.map.baidu.com/api?v=2.0&ak=nYKKiAU0NeZjSebaD56NEQUbXDsEORkx&__ec_v__=20190126"></script>
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/extension/bmap.min.js"></script>
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/simplex.js"></script>


<script type="text/javascript">
    var warename=new Array();
    var wareprice=new Array();
    <%
    for(int i=0;i<name.length;i++){
        %>
    warename[<%=i%>]='<%="第"+(i+1)+"件"%>';
    wareprice[<%=i%>]='<%=price[i]%>';
    <%
    }

    %>
    var dom = document.getElementById("container");
    var myChart = echarts.init(dom);
    var app = {};
    option = null;
    option = {
        xAxis: {
            type: 'category',
            data: warename
        },
        yAxis: {
            type: 'value'
        },
        series: [{
            data: wareprice,
            type: 'line'
        }]
    };
    ;
    if (option && typeof option === "object") {
        myChart.setOption(option, true);
    }

    var pagenum=document.getElementById("pagenum");
    var pre=document.getElementById("pre");
    var next=document.getElementById("next");
    pre.onclick=function () { preclick() };
    next.onclick=function () { nextclick() };
    <%
   if(pagenum==1){
       %>
    pre.disabled=true;
    <%
    }else{
   %>
    pre.disabled=false;
    <%}%>

    <%
   if(pagenum*6>=wares.size()){
      %>
    next.disabled=true;
    <%
    }else{
   %>
    next.disabled=false;
    <%}%>

    function preclick() {

        var pagen= document.getElementById("pagenum").value;
        pagen=parseInt(pagen)-1;
        window.location.href="pachong.jsp?pagenum=" + pagen;
    }

    function nextclick() {
        var pagen= document.getElementById("pagenum").value;
        pagen=parseInt(pagen)+1;
        window.location.href="pachong.jsp?pagenum=" + pagen;
    }
</script>
</body>
</html>
