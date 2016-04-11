import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;

public class TestFile {

	public static void main(String[] args) throws Exception{
		//列出所有子目录中的文件
		getTime();
		print(new File("d:" + File.separator), new File("F:" + File.separator + "demo" + File.separator + "test.txt"), 0);
		getTime();
	}
	
	public static void print(File readfile, File writefile, int level) throws Exception {
		StringBuffer str = new StringBuffer();
		for (int x = 0; x < level; x++) {
			str.append("|\t");
		}
		str.append("|-");
		writeFile(writefile,
				str + readfile.getName() + "\t\t" 
				+ new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date(readfile.lastModified())) + "\t\t"
				+ (readfile.isDirectory() ? "文件夹" : "文件") + "\t\t"
				+ (readfile.isDirectory() ? "\r\n" : (new BigDecimal((double)readfile.length()/1024/1024).divide(new BigDecimal(1), 2, BigDecimal.ROUND_HALF_UP)) + "M\r\n"));
		
		if(readfile.isDirectory()) {
			level++;
			File result[] = readfile.listFiles();
			if(result != null) {
				for(int x = 0; x < result.length; x ++) {
					print(result[x], writefile, level);
				}
			}
		}
	}
	
	public static void writeFile(File file, String str) throws Exception {
		// 1、目录不存在需要先创建目录
		if(!file.getParentFile().exists()) { //首先判断父目录是否存在
			file.getParentFile().mkdirs(); //不存在的话创建目录
		}
		// 2、使用OutputStream和其子类进行对象的实例化
		OutputStream output = new FileOutputStream(file, true);
		// 3、要进行文件内容的输出
		byte data[] = str.getBytes();
		output.write(data);;
		// 4、资源操作一定要进行关闭
		output.close();
	}
	
	public static void getTime() {
		Date date = new Date();
		SimpleDateFormat start = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
		System.out.println(start.format(date));	
	}

}
