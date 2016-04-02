import java.io.File;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;

public class TestFile {

	public static void main(String[] args) throws Exception{
		//列出所有子目录中的文件
		print(new File("F:" + File.separator), 0);
	}
	
	public static void print(File file, int level) {
		StringBuffer str = new StringBuffer();
		for (int x = 0; x < level; x++) {
			str.append("|\t");
		}
		str.append("|-");
		System.out.println(str + file.getName() + "\t\t" 
				+ new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date(file.lastModified())) + "\t\t"
				+ (file.isDirectory() ? "文件夹" : "文件") + "\t\t"
				+ (file.isDirectory() ? " " : (new BigDecimal((double)file.length()/1024/1024).divide(new BigDecimal(1), 2, BigDecimal.ROUND_HALF_UP)) + "M"));
		
		if(file.isDirectory()) {
			level++;
			File result[] = file.listFiles();
			if(result != null) {
				for(int x = 0; x < result.length; x ++) {
					print(result[x], level);
				}
			}
		}
	}

}
