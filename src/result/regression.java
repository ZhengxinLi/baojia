package result;

import Matrix.juzhen;
import bean.baojia;
import database.operation;

import java.util.Vector;

public class regression {
    private Vector<baojia> history;

    private double[] result=null;
    private String[] canshu=null;
    public regression(String[] canshu,String guige){
        this.canshu=canshu;
        history= operation.gethistory(canshu,guige);  //从数据库中得到,参数：canhsu，guge
        if(history.size()>0) {
            juzhen juzhen = new juzhen(4, history.size());
            for (int i = 0; i < history.size(); i++) {
                juzhen.setvalue(history.get(i).getA(), 0, i);
                juzhen.setvalue(history.get(i).getB(), 1, i);
                juzhen.setvalue(history.get(i).getC(), 2, i);
                juzhen.setvalue(1, 3, i);
            }
            juzhen y = new juzhen(juzhen.getCol(), 1);
            for (int i = 0; i < juzhen.getCol(); i++)
                y.setvalue(history.get(i).getPrice(), i, 0);
            juzhen xishu = juzhen.cheng(juzhen.zhuanzhi());
            juzhen yy = juzhen.cheng(y);
            double[] yyy = new double[yy.getRow()];
            for (int i = 0; i < yy.getRow(); i++)
                yyy[i] = yy.getMatrix()[i][0];
            if(juzhen.getCol()>1)
                this.result = xishu.feiqici(yyy);
        }
    }
    public String historyurl(){
        String url="&historylength="+history.size();;
        for(int i=0;i<history.size();i++){
            url+="&a"+i+"="+history.get(i).getA()+"&b"+i+"="+history.get(i).getB()+
            "&c"+i+"="+history.get(i).getC()+"&price"+i+"="+history.get(i).getPrice();
        }
        String[] C=new String[10];
        for(int i=0;i<10;i++)
            C[i]="c"+(i+1);
        for(int i=0,k=0;i<10;i++){
            if(canshu!=null&&k<canshu.length&&canshu[k].equals(C[i])) {
                url += "&ca" + (i+1) + "=1";
                k++;
            }
            else
                url+="&ca"+ (i+1) + "=0";
        }
        System.out.println(url);
        return url;
    }


    public double[] getResult() {
        return result;
    }
}
