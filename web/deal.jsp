<%@ page import="java.util.Vector" %>
<%@ page import="bean.baojia" %>
<%@ page import="result.regression" %>
<%@ page import="database.operation" %><%--
  Created by IntelliJ IDEA.
  User: Han。
  Date: 2019/7/19
  Time: 9:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>$Title$</title>
    <%

        float a= 0;
        float b= 0;
        float c= 0;
        int num= 0;
        boolean ok=true;
        try {
            a = Float.parseFloat(request.getParameter("xx"));
            b = Float.parseFloat(request.getParameter("yy"));
            c = Float.parseFloat(request.getParameter("zz"));
            num = Integer.parseInt(request.getParameter("zhangshu"));
        } catch (NumberFormatException e) {
            response.sendRedirect("index.jsp");
            ok=false;
            e.printStackTrace();
        }
        if(ok) {
            String guige = request.getParameter("keshu");
            String id = String.valueOf(session.getAttribute("id"));
            String[] others = request.getParameterValues("hjg");

            regression regression = new regression(others, guige);
            double[] result = regression.getResult();
            String finalbaojia = "data is not enough";
            if (result != null) {
                if (num > 10000)
                    finalbaojia = String.valueOf((result[0] * a + result[1] * b + result[2] * c + result[3]) * num / 2);
                else
                    finalbaojia = String.valueOf((result[0] * a + result[1] * b + result[2] * c + result[3]) * 10000 / (num + 10000));
                if (!id.equals("null") && !id.equals(""))
                    operation.addbuy_num(Integer.parseInt(id));
            }

            //String id=request.getParameter("id");

            String url = regression.historyurl();
            url += "&id=" + id + "&guige=" + guige;
            if (result != null) {

                for (int i = 0; i < 4; i++)
                    url += "&result" + i + "=" + result[i];
            }

            response.sendRedirect("index.jsp?tip=" + finalbaojia + url);
        }
    %>

  </head>
  <body>
  $END$
  </body>
</html>
