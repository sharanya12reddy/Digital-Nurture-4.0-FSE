interface Document{
    void open();
}
class WordDocument implements Document{
    public void open(){ System.out.println("Word document opened"); }
}
class PdfDocument implements Document{
    public void open(){ System.out.println("PDF document opened"); }
}
class ExcelDocument implements Document{
    public void open(){ System.out.println("Excel document opened"); }
}

abstract class DocumentFactory{
    abstract Document createDocument();
}
class WordFactory extends DocumentFactory{
    Document createDocument(){ return new WordDocument(); }
}
class PdfFactory extends DocumentFactory{
    Document createDocument(){ return new PdfDocument(); }
}
class ExcelFactory extends DocumentFactory{
    Document createDocument(){ return new ExcelDocument(); }
}

public class Main{
    public static void main(String[] args){
        DocumentFactory wordFactory=new WordFactory();
        DocumentFactory pdfFactory=new PdfFactory();
        DocumentFactory excelFactory=new ExcelFactory();

        Document d1=wordFactory.createDocument();
        Document d2=pdfFactory.createDocument();
        Document d3=excelFactory.createDocument();

        d1.open();
        d2.open();
        d3.open();
    }
}
