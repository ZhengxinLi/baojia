package result;

public class dealnum {
    public static String deal(double x){
        String temp=String.valueOf(x);
        if(temp.length()<=5)
            return temp;
        else
            return temp.substring(0,5);
    }
}
