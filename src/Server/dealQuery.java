package Server;

import database.operation;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Arrays;
import java.util.Vector;

public class dealQuery {
    private doc Query;
    private Vector<String> D;
    private Vector<Double> cos;
    private reply reply;

    public dealQuery(String Query) throws IOException, InterruptedException {
        this.Query=new doc(Query);
        this.D=operation.getD();
        cosQandD();
        double max=0;
        int index=0;
        for(int i=0;i<cos.size();i++)
            if(max<cos.get(i)) {
                max = cos.get(i);
                index=i;
            }
        this.reply=operation.getreplybynum(index+1);
    }

    public void cosQandD(){
        cos=new Vector<>();
        Vector<String> key=Query.getKeys();
        Integer[] cQ= Query.getcQ();
        double cQlength=0;
        int averagedlength=0;
        for(int i=0;i<D.size();i++)
            averagedlength+=D.get(i).length();
        averagedlength/=D.size();
        for(int i=0;i<cQ.length;i++)
            cQlength+=cQ[i]*cQ[i];
        for(int i=0;i<D.size();i++){
            Integer[] cD= new Integer[key.size()];
            double costemp=0;
            double cDlength=0;
            for(int j=0;j<key.size();j++) {
                cD[j] = D.get(i).split(key.get(j)).length - 1;
                cDlength+=cD[j]*cD[j];
                if(cQ[j]!=0&&cD[j]!=0){
                    costemp+=cQ[j]*cD[j];
                }
            }
            cos.add(costemp*costemp/cQlength/cDlength/(0.9+0.1*D.get(i).length()/averagedlength));
        }
    }

    public reply getReply() {
        return reply;
    }
}
