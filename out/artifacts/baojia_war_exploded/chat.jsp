<%--
  Created by IntelliJ IDEA.
  User: lizhengxin
  Date: 2019-08-18
  Time: 18:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Document</title>
    <style type="text/css">
        .talk_con{
            width:600px;
            height:500px;
            border:none;
            margin:50px auto 0;
            background:#f9f9f9;
        }
        .talk_show{
            width:580px;
            height:420px;
            border:1px solid #0181cc;
            background:#fff;
            margin:10px auto 0;
            overflow:auto;
        }
        .talk_input{
            width:580px;
            margin:10px auto 0;
        }

        .talk_word{
            width:420px;
            height:26px;
            padding:0px;
            float:left;
            margin-left:10px;
            margin-top: 17px;
            outline:none;
            text-indent:10px;
        }
        .talk_sub{
           width: 80px;
            height: 50px;
            background-color: #255e95;
            color: #BFEFFF;
            margin-left: 40px;
            border: none;

        }
        .atalk{
            margin:10px;
        }
        .atalk span{
            display:inline-block;
            background:#0181cc;
            border-radius:10px;
            color:#fff;
            padding:5px 10px;
        }
        .btalk{
            margin:10px;
            text-align:right;
        }
        .btalk span{
            display:inline-block;
            background:#ef8201;
            border-radius:10px;
            color:#fff;
            padding:5px 10px;
        }
    </style>
    <script type="text/javascript">
        //
        window.onload = function(){
            var Words = document.getElementById("words");
           // var Who = document.getElementById("who");
            var TalkWords = document.getElementById("talkwords");
            var TalkSub = document.getElementById("talksub");

            TalkWords.onkeypress=keypress;


            //test

           // Words.innerHTML=Words.innerHTML+'<div class="atalk"><span>'+"<iframe src='wares.jsp?num=1' style='border: none' width='500px' height='200px' scrolling='none'></iframe>"+'</span></div>';
            //test

            TalkSub.onclick = function(){
                //定义空字符串
                var str = "";
                if(TalkWords.value == ""){
                    // 消息为空时弹窗
                    alert("消息不能为空");
                    return;
                }
                str = '<div class="atalk"><span>' + TalkWords.value +'</span></div>';
                // if(Who.value == 0){
                //     //如果Who.value为0n那么是 A说
                //     str = '<div class="atalk"><span>A说 :' + TalkWords.value +'</span></div>';
                // }
                // else{
                //     str = '<div class="btalk"><span>B说 :' + TalkWords.value +'</span></div>' ;
                // }
                Words.innerHTML = Words.innerHTML + str;
                getMyHTML("dealmessage.jsp?MyQuery="+TalkWords.value,"words");
                TalkWords.value="";
            }

        }
        
        function keypress() {
            if(event.KeyCode===13)
                document.getElementById("talksub").click();
        }
        //创建XMLHttpRequest对象
        function GetO() {
            var ajax = false;
            try {
                ajax = new ActiveXObject("Msxml2.XMLHTTP");
            } catch (e) {
                try {
                    ajax = new ActiveXObject("Microsoft.XMLHTTP");
                } catch (E) {
                    ajax = false;
                }
            }
            if (!ajax && typeof XMLHttpRequest != 'undefined') {
                ajax = new XMLHttpRequest();
            }
            return ajax;
        }

        function getMyHTML(serverPage, objID) {
            var ajax = GetO();
            //得到了一个html元素，在下面给这个元素的属性赋值
            var obj = document.all[objID];
            //设置请求方法及目标，并且设置为异步提交
            ajax.open("post", serverPage, true);
            ajax.onreadystatechange = function() {
                if (ajax.readyState == 4 && ajax.status == 200) {
                    //innerHTML是HTML元素的属性，如果您不理解属性那就理解为HTML元素的变量
                    //ajax.responseText是服务器的返回值，把值赋给id=passport1的元素的属性
                    //innerHTML这个属性或说这个变量表示一组开始标记和结束标记之间的内容
                    obj.innerHTML = obj.innerHTML+ajax.responseText;
                }
            }
            //发送请求
            ajax.send(null);
        }

    </script>

</head>
<body>
<div class="talk_con">
    <div class="talk_show" id="words">
        <div class="btalk"><span id="bsay">欢迎来到机器人问答时间</span></div>
    </div>
    <div class="talk_input">

        <input type="text" class="talk_word" id="talkwords">
        <input type="button" value="发送" class="talk_sub" id="talksub">
    </div>
</div>


</body>
</html>
