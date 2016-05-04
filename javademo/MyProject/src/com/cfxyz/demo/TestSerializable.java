package com.cfxyz.demo;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;

@SuppressWarnings("serial")
class BookSer implements Serializable {
	private String title;

	public BookSer(String title) {
		super();
		this.title = title;
	}

	@Override
	public String toString() {
		return "BookSer [title=" + title + "]";
	}
	
}

public class TestSerializable {

	public static void main(String[] args) throws Exception {
		ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(new File("e:" + File.separator + "book.ser")));
		oos.writeObject(new BookSer("Java¿ª·¢"));
		oos.close();
		
		ObjectInputStream ois = new ObjectInputStream(new FileInputStream(new File("e:" + File.separator + "book.ser")));
		BookSer book = (BookSer) ois.readObject();
		System.out.println(book);
		ois.close();
	}

}
