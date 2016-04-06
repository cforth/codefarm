import java.util.HashSet;
import java.util.Set;
import java.util.TreeSet;

class BookH implements Comparable<BookH> {
	private String title;
	private double price;
	public BookH(String title, double price) {
		this.title = title;
		this.price = price;
	}
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		long temp;
		temp = Double.doubleToLongBits(price);
		result = prime * result + (int) (temp ^ (temp >>> 32));
		result = prime * result + ((title == null) ? 0 : title.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		BookH other = (BookH) obj;
		if (Double.doubleToLongBits(price) != Double.doubleToLongBits(other.price))
			return false;
		if (title == null) {
			if (other.title != null)
				return false;
		} else if (!title.equals(other.title))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "BookH [title=" + title + ", price=" + price + "]\n";
	}

	@Override
	public int compareTo(BookH o) {
		if(this.price > o.price) {
			return 1;
		} else if (this.price < o.price) {
			return  -1;
		} else {
			return this.title.compareTo(o.title);
		}
	}
	
}


public class TestSet {

	public static void main(String[] args) {
//		Set<String> set = new HashSet<String>();
//		set.add("B");
//		set.add("X");
//		set.add("A");
//		set.add("C");
//		System.out.println(set);
//		
//		Set<String> tree = new TreeSet<String>();
//		tree.add("X");
//		tree.add("A");
//		tree.add("C");
//		tree.add("B");
//		System.out.println(tree);
		
		Set<BookH> all = new HashSet<BookH>();
		all.add(new BookH("Java开发", 79.8));
		all.add(new BookH("Java开发", 79.8));
		all.add(new BookH("Java开发", 59.8));
		all.add(new BookH("Jsp开发", 39.8));
		System.out.println(all);
	}

}
