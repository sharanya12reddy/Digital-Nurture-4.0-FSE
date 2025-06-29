import java.util.*;

public class Main{
    static Map<Integer,Double> cache=new HashMap<>();
    static double predict(double principal,double rate,int years){
        if(years==0) return principal;
        if(cache.containsKey(years)) return cache.get(years);
        double v=predict(principal,rate,years-1)*(1+rate);
        cache.put(years,v);
        return v;
    }
    public static void main(String[] args){
        double principal=1000.0;
        double growthRate=0.05;
        int years=10;
        double result=predict(principal,growthRate,years);
        System.out.printf("Future value after %d years: %.2f%n",years,result);
    }
}
