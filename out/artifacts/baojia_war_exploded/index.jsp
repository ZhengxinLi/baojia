<%--
  Created by IntelliJ IDEA.
  User: Han。
  Date: 2019/7/21
  Time: 10:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<%
    String id=request.getParameter("id");
    System.out.println(id);
    session.setAttribute("id",id);
%>

<form action="deal.jsp" >

    <table width="100%"  align="center" cellpadding="0" cellspacing="0" class="stable">

        <tr>
            <th>纸张尺寸</th>
            <th>纸张规格</th>
            <th>张数</th>
        </tr>
        <tr align="center">
            <td align="center">
                <input name="xx" type="text" id="xx" size="5" >
                长
                <input name="yy" type="text" id="yy" size="5" >
                宽
                <input type="text" name="zz" id="zz" size="5">
                高
            </td>

            <td valign="top">
                <select name="keshu" id="keshu">
                    <option value="80g" selected="selected">80g</option>
                    <option value="60g">60g</option>
                    <option value="200g">200g</option>
                </select>
            </td>

            <td valign="top">
                <input type="text" name="zhangshu" id="zhangshu" size="4" >张
            </td>
        </tr>

    </table>
    <br/>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="stable">
        <tr id="hdgx_bt">
            <th colspan="6">后道工序选择</th>
        </tr>
        <tr>
            <td colspan="7">
                <table id="tb" width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="stable">
                    <tr>
                        <td>
                            <input name="hjg" type="checkbox" id="cs" value="c1"/>
                            单面覆亮膜
                        </td>
                        <td>
                            <input name="hjg" type="checkbox" id="hjg_fm" value="c2"/>
                            单面覆哑膜
                        </td>
                        <td>
                            <input name="hjg" type="checkbox" id="hjg_dk" value="c3" />
                            打孔
                        </td>
                        <td>
                            <input name="hjg" type="checkbox" id="jt" value="c4" />
                            单面击凸
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <input name="hjg" type="checkbox" id="as" value="c5" />
                            双面覆亮膜
                        </td>
                        <td>
                            <input name="hjg" type="checkbox" id="bs" value="c6"  />
                            双面覆哑膜
                        </td>
                        <td>
                            <input name="hjg" type="checkbox" id="yh" value="c7"/>
                            压痕
                        </td>
                        <td>
                            <input name="hjg" type="checkbox" id="hjg" value="c8"  />
                            模切‖异型
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <input name="hjg" type="checkbox" id="tj" value="c9" />
                            单面烫金
                        </td>
                        <td>
                            <input name="hjg" type="checkbox" id="ty" value="c10"  />
                            单面烫银
                        </td>
                        <td>
                            <%--预留位置--%>
                        </td>
                        <td>
                            <%--预留位置--%>
                        </td>
                    </tr>

                    <tr style="display: none" id="calculatePrice">

                        <td style="text-align: center; font-weight: 600" colspan="6">

                            </td>
                    </tr>
                </table>
            </td>
        </tr>



        <tr>
            <td align="center">
                <input type="submit" value="预估价"  />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="reset" name="button" id="button" value="重置">

            </td>
        </tr>
    </table>
</form>
<br><br><br>

<%
    String show=request.getParameter("tip");
    if(show!=null){
        if(!show.equals("data is not enough")){
        %>
<p style="color: cornflowerblue">以下是根据您的选择为您绘制的图表</p><br>
<iframe src="<%="table.jsp?"+request.getQueryString()+"&pagenum=0"%>" width="100%" height="300px" style="border: none"></iframe>
<br><br><br>

<iframe src="<%="tip2.jsp?"+request.getQueryString()%>" width="100%" height="600px" style="border: none" scrolling="no">

</iframe>
<br><br>
<%
    }
        else{
            %>
<br><br>
<p style="color: crimson" align="center">数据不足，无法为您报价，请选择其他参数</p><br><br><br>
<%
        }
%>
<iframe src="pachong.jsp?pagenum=1" width="100%" height="850px" style="border: none" scrolling="no"></iframe>
<%
    }
%>

</body>
</html>
