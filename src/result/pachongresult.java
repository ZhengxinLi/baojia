package result;

import tools.ware;

import java.util.Vector;

public class pachongresult {
    private static int num=0;
    private static Vector<ware> wares;

    public static int getNum() {
        return num;
    }

    public static void setNum(int num) {
        pachongresult.num = num;
    }

    public static Vector<ware> getWares() {
        return wares;
    }

    public static void setWares(Vector<ware> wares) {
        pachongresult.wares = wares;
    }

    public static void numadd(){
        num++;
    }
}
