import java.text.SimpleDateFormat;
import java.util.Date;

public class TestSimpleDateFormat {

	public static void main(String[] args) throws Exception {
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-mm-dd HH:mm:ss.SSS");
		String str = sdf.format(date); //日期型数据变为字符串
		System.out.println(str);
		str = "2001-11-11 11:11:11.111";
		date = sdf.parse(str);  //字符串变为日期型数据
		System.out.println(date);
	}

}
