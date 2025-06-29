import java.util.*;

class Product{
    int productId;
    String productName;
    String category;
    Product(int id,String name,String cat){
        productId=id;
        productName=name;
        category=cat;
    }
}

public class Main{
    static int linearSearch(Product[] arr,int id){
        for(int i=0;i<arr.length;i++) if(arr[i].productId==id) return i;
        return -1;
    }
    static int binarySearch(Product[] arr,int id){
        int l=0,r=arr.length-1;
        while(l<=r){
            int m=l+(r-l)/2;
            if(arr[m].productId==id) return m;
            if(arr[m].productId<id) l=m+1; else r=m-1;
        }
        return -1;
    }
    public static void main(String[] args){
        Product[] productsSorted={
            new Product(101,"Laptop","Electronics"),
            new Product(102,"Mouse","Electronics"),
            new Product(103,"Keyboard","Electronics"),
            new Product(104,"Shoes","Fashion"),
            new Product(105,"Watch","Accessories")
        };
        int targetId=103;
        int linIdx=linearSearch(productsSorted,targetId);
        int binIdx=binarySearch(productsSorted,targetId);
        System.out.println("Linear search found: "+(linIdx!=-1?productsSorted[linIdx].productName:"Not Found"));
        System.out.println("Binary search found: "+(binIdx!=-1?productsSorted[binIdx].productName:"Not Found"));
    }
}
