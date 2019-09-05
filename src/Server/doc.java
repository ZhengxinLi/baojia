package Server;

import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.JSON;
import com.lzx.GetJsonFromUrl;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Vector;

public class doc {
    private String Content;
    private Vector<String> keys;
    private Integer[] cQ;
    public doc(String content) throws IOException, InterruptedException {
        this.Content=content+".";
        splitkey();
        cQ=new Integer[keys.size()];
        for(int i=0;i<cQ.length;i++)
            cQ[i]=Content.split(keys.get(i)).length-1;
        printkey();
    }

    public void printkey(){
        for(int i=0;i<keys.size();i++)
            System.out.print(keys.get(i)+"   ");
        System.out.println();
    }

    public  void splitkey() throws IOException, InterruptedException {
//        Process process;
////        this.keys=new Vector<>();
////        String[] args1 = new String[]{"python", "/usr/python/test.py", this.Content};
////        process = Runtime.getRuntime().exec(args1);
////        BufferedReader in = new BufferedReader(new InputStreamReader(process.getInputStream()));
////        String line = null;
////        while ((line = in.readLine()) != null) {
////            String[] temp=dealcode(line).split(",");
////            keys.add(unicode2String(temp[0]));
////        }
////        in.close();
////        process.waitFor();
        this.keys=new Vector<>();
        GetJsonFromUrl getJsonFromUrl=new GetJsonFromUrl("http://47.101.198.71:8080/keysplit/"+this.Content);
        String json=getJsonFromUrl.getJsonString();
        JSONObject jsonx = JSON.parseObject(json);
        int num=Integer.parseInt(jsonx.getString("num"));
        for(int i=1;i<=num;i++){
            this.keys.add(jsonx.getString(String.valueOf(i)));
        }
    }

    public static String dealcode(String unicode){
        String result=unicode.replace("(u","");
        result=result.replace("'","");
        result=result.replace(")","");
        return result;
    }
    public static String unicode2String(String unicode) {

        StringBuffer string = new StringBuffer();

        String[] hex = unicode.split("\\\\u");

        for (int i = 1; i < hex.length; i++) {

            // 转换出每一个代码点
            int data = Integer.parseInt(hex[i], 16);

            // 追加成string
            string.append((char) data);
        }

        return string.toString();
    }

    public String getContent() {
        return Content;
    }


    public Vector<String> getKeys() {
        return keys;
    }

    public Integer[] getcQ() {
        return cQ;
    }
}
