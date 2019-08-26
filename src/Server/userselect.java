package Server;

public class userselect {
    private static String type=null;
    private static String baozhuang=null;
    private static String chicun=null;
    private static String caizhi=null;

    public static String curselect=null;
    public static String getType() {
        return type;
    }

    public static void setType(String type) {
        userselect.type = type;
    }

    public static String getBaozhuang() {
        return baozhuang;
    }

    public static void setBaozhuang(String baozhuang) {
        userselect.baozhuang = baozhuang;
    }

    public static String getChicun() {
        return chicun;
    }

    public static void setChicun(String chicun) {
        userselect.chicun = chicun;
    }

    public static String getCaizhi() {
        return caizhi;
    }

    public static void setCaizhi(String caizhi) {
        userselect.caizhi = caizhi;
    }

    public static void init(){
        type=null;
        baozhuang=null;
        caizhi=null;
        chicun=null;
        curselect=null;
    }

    public static String getCurselect() {
        return curselect;
    }

    public static void setCurselect(String curselect) {
        userselect.curselect = curselect;
    }
}
