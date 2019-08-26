<%--
  Created by IntelliJ IDEA.
  User: Han。
  Date: 2019/8/8
  Time: 18:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body style="overflow:hidden;">
<%
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
%>
<div id="container" style="height: 90%"></div>
<p id="fenxi" align="center" style="color: cornflowerblue"></p>
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/echarts.min.js"></script>
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts-gl/echarts-gl.min.js"></script>
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts-stat/ecStat.min.js"></script>
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/extension/dataTool.min.js"></script>
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/map/js/china.js"></script>
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/map/js/world.js"></script>
<script type="text/javascript" src="https://api.map.baidu.com/api?v=2.0&ak=nYKKiAU0NeZjSebaD56NEQUbXDsEORkx>>&__ec_v__=20190126"></script>
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/extension/bmap.min.js"></script>
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/simplex.js"></script>
<script type="text/javascript">
    var aa=new Array();
    var bb=new Array();
    var cc=new Array();
    var pp=new Array();
    <%
    for(int i=0;i<historylength;i++){%>

    aa[<%=i%>]=<%=a[i]%>;
    bb[<%=i%>]=<%=b[i]%>;
    cc[<%=i%>]=<%=c[i]%>;
    pp[<%=i%>]=<%=price[i]%>;
    <%
    }
    %>


    var dom = document.getElementById("container");
    var myChart = echarts.init(dom);
    var app = {};
    option = null;
    var posList = [
        'left', 'right', 'top', 'bottom',
        'inside',
        'insideTop', 'insideLeft', 'insideRight', 'insideBottom',
        'insideTopLeft', 'insideTopRight', 'insideBottomLeft', 'insideBottomRight'
    ];

    app.configParameters = {
        rotate: {
            min: -90,
            max: 90
        },
        align: {
            options: {
                left: 'left',
                center: 'center',
                right: 'right'
            }
        },
        verticalAlign: {
            options: {
                top: 'top',
                middle: 'middle',
                bottom: 'bottom'
            }
        },
        position: {
            options: echarts.util.reduce(posList, function (map, pos) {
                map[pos] = pos;
                return map;
            }, {})
        },
        distance: {
            min: 0,
            max: 100
        }
    };

    app.config = {
        rotate: 90,
        align: 'left',
        verticalAlign: 'middle',
        position: 'insideBottom',
        distance: 15,
        onChange: function () {
            var labelOption = {
                normal: {
                    rotate: app.config.rotate,
                    align: app.config.align,
                    verticalAlign: app.config.verticalAlign,
                    position: app.config.position,
                    distance: app.config.distance
                }
            };
            myChart.setOption({
                series: [{
                    label: labelOption
                }, {
                    label: labelOption
                }, {
                    label: labelOption
                }, {
                    label: labelOption
                }]
            });
        }
    };


    var labelOption = {
        normal: {
            show: true,
            position: app.config.position,
            distance: app.config.distance,
            align: app.config.align,
            verticalAlign: app.config.verticalAlign,
            rotate: app.config.rotate,
            formatter: '{c}  {name|{a}}',
            fontSize: 16,
            rich: {
                name: {
                    textBorderColor: '#fff'
                }
            }
        }
    };

    option = {
        color: ['#8EE5EE', '#FFDEAD', '#FFC1C1', '#e5323e'],
        tooltip: {
            trigger: 'axis',
            axisPointer: {
                type: 'shadow'
            }
        },
        legend: {
            data: ['长', '宽', '高']
        },
        toolbox: {
            show: true,
            orient: 'vertical',
            left: 'right',
            top: 'center',
            feature: {
                mark: {show: true},
                dataView: {show: true, readOnly: false},
                magicType: {show: true, type: ['line', 'bar', 'stack', 'tiled']},
                restore: {show: true},
                saveAsImage: {show: true}
            }
        },
        calculable: true,
        xAxis: [
            {
                type: 'category',
                axisTick: {show: false},
                data: pp
            }
        ],
        yAxis: [
            {
                type: 'value'
            }
        ],
        series: [
            {
                name: '长',
                type: 'bar',
                barGap: 0,
                label: labelOption,
                data: aa
            },
            {
                name: '宽',
                type: 'bar',
                label: labelOption,
                data: bb
            },
            {
                name: '高',
                type: 'bar',
                label: labelOption,
                data: cc
            }
        ]
    };;
    if (option && typeof option === "object") {
        myChart.setOption(option, true);
    }

    document.getElementById("fenxi").innerHTML="历史最高价：<%=x%>    历史最低价：<%=minx%>"
</script>
</body>
</html>
