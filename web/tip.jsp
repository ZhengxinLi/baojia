<%--
  Created by IntelliJ IDEA.
  User: Han。
  Date: 2019/7/21
  Time: 11:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="result.dealnum" %>
<html>
<head>

    <title>Title</title>

    <style type="text/css">
        body{
            width: 100%;
            height: 100%;
            overflow:hidden;
        }
    </style>



</head>
<body>

<canvas id="canvas" width="700" height="350" >

</canvas>
<p id="clickvalue">
    此处显示坐标
</p>
<p id="fenxi" style="color: cornflowerblue"></p>

<%--<script type="text/javascript" src="js.js"></script>--%>
<script type="text/javascript">
    <%
    //处理参数，获得x，y的最大值，使得图表最大化
    int historylength=Integer.parseInt(request.getParameter("historylength"));
    double[] a=new double[historylength];
    double[] b=new double[historylength];
    double[] c=new double[historylength];
    double[] price=new double[historylength];
     double x=0,y=0,minx=0;
    for(int i=0;i<historylength;i++){
        a[i]=Double.parseDouble(request.getParameter("a"+i));
        b[i]=Double.parseDouble(request.getParameter("b"+i));
        c[i]=Double.parseDouble(request.getParameter("c"+i));
        price[i]=Double.parseDouble(request.getParameter("price"+i));
        if(y<a[i])
            y=a[i];
        if(y<b[i])
            y=b[i];
        if(y<c[i])
            y=c[i];
        if(x<price[i])
            x=price[i];
        if(minx==0)
            minx=price[i];
        else if(minx>price[i])
            minx=price[i];
    }

    double xvalue=x/12; //横坐标每一格的值
    double yvalue=y/6;  //纵坐标每一格的值

    %>
    var canvas=document.getElementById("canvas");
    var ctx=canvas.getContext('2d');
    ctx.font='bold 35px';
    //ctx.beginPath();
   zuobiao(ctx);
   xyvalue(ctx);
   <%
   //绘制图标表
   for(int i=0;i<historylength;i++){
       double xlength=10+600*price[i]/x;
       double blength=10+300*b[i]/y;
       double alength=10+300*a[i]/y;
       double clength=10+300*c[i]/y;
       %>
    ctx.fillStyle='red';
    ctx.fillRect(<%=xlength-15%>,<%=310-alength%>,10,<%=alength%>);
    ctx.fillStyle='blue';
    ctx.fillRect(<%=xlength-5%>,<%=310-blength%>,10,<%=blength%>);
    ctx.fillStyle='green';
    ctx.fillRect(<%=xlength+5%>,<%=310-clength%>,10,<%=clength%>);
    <%
   }
   %>
    drawtip();
    ctx.stroke();



    function zuobiao(ctx) {
        ctx.moveTo(10,310);
        ctx.lineTo(610,310);
        ctx.moveTo(10,310);
        ctx.lineTo(10,10);
        <%
        for(int i=10;i<=610;i+=50){
            %>
        ctx.moveTo(<%=i%>,310);
        ctx.lineTo(<%=i%>, 290);
        <%if(i<=310){

        %>
        ctx.moveTo(10,<%=i%>);
        ctx.lineTo(30,<%=i%>);
        <%
        }
        }
        %>


    }


    function xyvalue(ctx) {
        <%
        for(int i=10;i<=610;i+=50){

            %>
        ctx.fillText(<%=dealnum.deal(xvalue*(i-10)/50)%>,<%=i%>,330);
        <%
        if(i<=310){
            %>
        ctx.fillText(<%=dealnum.deal(yvalue*(i-10)/50)%>,0,<%=320-i%>);
        <%
        }
        }
        %>
    }

    function drawtip() {
        ctx.fillStyle='red';
        ctx.fillText("长：",650,45);
        ctx.fillRect(670,40,40,10);

        ctx.fillStyle='blue';
        ctx.fillText("宽：",650,65);
        ctx.fillRect(670,60,40,10);

        ctx.fillStyle='green';
        ctx.fillText("高：",650,85);
        ctx.fillRect(670,80,40,10);

        ctx.fillStyle='blue';
        ctx.fillText("x: 价格(元）",650,250);
        ctx.fillText("y:长度(cm）",650,290);
    }

    canvas.addEventListener('mousemove', function(e){
        var tip=document.getElementById("clickvalue");
        <%

        %>
        var xx=(e.clientX-10)*<%=x/600%>;
        var yy=(310-e.clientY)*<%=y/300%>;
        tip.innerHTML=xx+"   "+yy;
    });
    canvas.addEventListener('mouseout', function(e) {
        var tip=document.getElementById("clickvalue");
        tip.innerHTML="此处显示坐标";
    });

    document.getElementById("fenxi").innerHTML="历史最高价：<%=x%>    历史最低价：<%=minx%>"
</script>
</body>
</html>
