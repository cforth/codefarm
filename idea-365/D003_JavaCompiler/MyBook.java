
public class MyBook {
    private String title;
    private double price;
    public MyBook() {
        System.out.println("********Book类的无参构造*******");
    }
    public MyBook(String title, double price) {
        System.out.println("********Book类的有参构造*******");
        this.title = title;
        this.price = price;
    }
    @Override
    public String toString() {
        return "MyBook [title=" + title + ", price=" + price + "]";
    }
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }
    public double getPrice() {
        return price;
    }
    public void setPrice(double price) {
        this.price = price;
    }
}

