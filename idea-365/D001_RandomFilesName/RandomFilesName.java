import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

/**
 * 从磁盘的指定目录中，获取一个随机的文件名称。
 * 例如：在"F:\\temp\\RandomFile"路径下存放了许多图片素材，每次执行获得一个随机的图片的名称路径
 */
public class RandomFilesName {

	public static void main(String[] args) throws Exception{
		String dirPath = "F:\\temp\\RandomFile\\" ;
		List<String> list = getFilesName(dirPath);
		System.out.println(dirPath + list.get(randomNumber(0, list.size() - 1)));
	}
	
	/**
	 * 读取文件夹下所有文件名称到一个列表中
	 * @param dirPath 文件夹路径
	 * @return list 字符串列表
	 * @throws Exception
	 */
	public static List<String> getFilesName(String dirPath) throws Exception {
		List<String> list = new ArrayList<String>(); 
		File[] files = new File(dirPath).listFiles();
		for(File f : files) {
			if(!f.isDirectory()) {
				list.add(f.getName());
			}
		}
		return list ;
	}
	
	/**
	 * 随机数发生器
	 * @param min 最小的数
	 * @param max 最大的数
	 * @return
	 */
	public static int randomNumber(int min, int max) {
        return new Random().nextInt(max)%(max-min+1) + min;
	}
}
