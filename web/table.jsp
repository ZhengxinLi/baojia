<%@ page import="java.util.Vector" %>

<%@ page import="bean.table" %>
<%@ page import="database.operation" %><%--
  Created by IntelliJ IDEA.
  User: Han。
  Date: 2019/7/25
  Time: 19:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
        body{
            overflow: paged-y;
        }
        table{
            width: 100%;


        }
        td.td1{
            background-color: #BFEFFF;
            text-align: center;
            font-family: 微软雅黑;
            font-size: 16px;
            font-weight: bold;
            color: #255e95;

        }
        td.td2{
            background-color: #DEEEEE;
            text-align: center;
        }
        td.td3{
            text-align: center;
            background-color: #CDC9C9;
        }
    </style>
</head>
<body>
<%
    //Vector<table> tables= operation.gettable();
    String url=request.getQueryString();
    int pagenum=Integer.parseInt(request.getParameter("pagenum"));
    System.out.println(url);

%>
<input type="text" value="" style="display: none" id="pagenum">
<input type="text" value="" style="display: none" id="url">
<table border="0" cellspacing="1" cellpadding="4" bgcolor="#cccccc" align="center">
    <tr>
        <td class="td1">
            长
        </td>
        <td class="td1">
            宽
        </td>
        <td class="td1">
            高
        </td>
        <td class="td1">
            规格
        </td>
        <td class="td1">
            单面覆亮膜
        </td>
        <td class="td1">
            单面覆哑膜
        </td>
        <td class="td1">
            打孔
        </td>
        <td class="td1">
            单面击凸
        </td>
        <td class="td1">
            双面覆亮膜
        </td>
        <td class="td1">
            双面覆哑膜
        </td>
        <td class="td1">
            压痕
        </td>
        <td class="td1">
            模切‖异型
        </td>
        <td class="td1">
            单面烫金
        </td>
        <td class="td1">
            单面烫银
        </td>
        <td class="td1">
            价格
        </td>
    </tr>
    <%
        for(int i=0;i<4&&(4*pagenum+i)<Integer.parseInt(request.getParameter("historylength"));i++){
            String td="td2";
            if(i%2!=0)
                td="td3";
            %>
    <tr>
        <td class="<%=td%>">
            <%=request.getParameter("a"+(i+pagenum*4))%>
        </td>
        <td class="<%=td%>">
            <%=request.getParameter("b"+(i+pagenum*4))%>
        </td>
        <td class="<%=td%>">
            <%=request.getParameter("c"+(i+pagenum*4))%>
        </td>
        <td class="<%=td%>">
            <%=request.getParameter("guige")%>
        </td>
        <td class="<%=td%>">
            <%
                if(request.getParameter("ca1").equals("1")){
                    %>
            是
            <%
                }else{
                %>
            否
            <%
                }
            %>

        </td>
        <td class="<%=td%>" >
            <%
                if(request.getParameter("ca2").equals("1")){
            %>
            是
            <%
            }else{
            %>
            否
            <%}
            %>
        </td>
        <td class="<%=td%>">
            <%
                if(request.getParameter("ca3").equals("1")){
            %>
            是
            <%
            }else{
            %>
            否
            <%}
            %>
        </td>
        <td class="<%=td%>">
            <%
                if(request.getParameter("ca4").equals("1")){
            %>
            是
            <%
            }else{
            %>
            否
            <%}
            %>
        </td>
        <td class="<%=td%>">
            <%
                if(request.getParameter("ca5").equals("1")){
            %>
            是
            <%
            }else{
            %>
            否
            <%}
            %>
        </td>
        <td class="<%=td%>">
            <%
                if(request.getParameter("ca6").equals("1")){
            %>
            是
            <%
            }else{
            %>
            否
            <%}
            %>
        </td>
        <td class="<%=td%>">
            <%
                if(request.getParameter("ca7").equals("1")){
            %>
            是
            <%
            }else{
            %>
            否
            <%}
            %>
        </td>
        <td class="<%=td%>">
            <%
                if(request.getParameter("ca8").equals("1")){
            %>
            是
            <%
            }else{
            %>
            否
            <%}
            %>
        </td>
        <td class="<%=td%>">
            <%
                if(request.getParameter("ca9").equals("1")){
            %>
            是
            <%
            }else{
            %>
            否
            <%}
            %>
        </td>
        <td class="<%=td%>">
            <%
                if(request.getParameter("ca10").equals("1")){
            %>
            是
            <%
            }else{
            %>
            否
            <%
                }
            %>
        </td>
        <td class="<%=td%>">
            <%=request.getParameter("price"+(i+pagenum*4))%>
        </td>
    </tr>
    <%
        }

    %>
    <tr>
        <td colspan="7" align="center" style="background-color: aliceblue">
            <input type="button" id="pre" value="前一页">
        </td>
        <td colspan="8" align="center" style="background-color: aliceblue">
            <input type="button" id="next" value="下一页">
        </td>
    </tr>
</table>
<p id="fenxi" style="color: #255e95" align="center">

</p>
<script type="text/javascript">
    document.getElementById("url").value="<%=url%>";
    document.getElementById("pagenum").value="<%=pagenum%>";


    var pre=document.getElementById("pre");
    var next=document.getElementById("next");
    pre.onclick=function () { preclick() };
    next.onclick=function () { nextclick() };

    <%
    if(pagenum==0){
        %>
    pre.disabled=true;
    <%
    }else{
   %>
    pre.disabled=false;
    <%}%>

    <%
    int historynum=Integer.parseInt(request.getParameter("historylength"));
  if(pagenum*4<historynum&&(pagenum+1)*4>=historynum){
      %>
    next.disabled=true;
    <%
    }else{
   %>
    next.disabled=false;
    <%}%>

    function preclick() {
        debugger;
        var pagen= document.getElementById("pagenum").value;
        var changeurl=document.getElementById("url").value;
        debugger;
       // alert(changeurl);
        pagen=parseInt(pagen)-1;
        changeurl=changeurl.replace("pagenum="+(parseInt(pagen)+1),"pagenum="+pagen);
        window.location.href="table.jsp?"+changeurl;
    }

    function nextclick() {
        var pagen= document.getElementById("pagenum").value;
        var changeurl=document.getElementById("url").value;
        //alert(changeurl);
        pagen=parseInt(pagen)+1;
        changeurl=changeurl.replace("pagenum="+(parseInt(pagen)-1),"pagenum="+pagen);
        window.location.href="table.jsp?"+changeurl;
    }
    <%
    String fenxi="上表格是与您的选择为相关的历史订单详情，根据上述参数，我们为您的估价为："+request.getParameter("tip")+",<br>";
    try {
    double result0=Double.parseDouble(request.getParameter("result0"));
    double result1=Double.parseDouble(request.getParameter("result1"));
    double result2=Double.parseDouble(request.getParameter("result2"));
    double result3=Double.parseDouble(request.getParameter("result3"));
    fenxi+="分析得出回归方程：价格="+result0+"x长+"+result1+"x宽+"+result2+"x高+"+result3+".";
    }
    catch (NumberFormatException e) {
    fenxi=request.getParameter("tip");
}

    %>
    document.getElementById("fenxi").innerHTML="<%=fenxi%>"
</script>
</body>
</html>
