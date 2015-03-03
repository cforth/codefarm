import java.util.*;

public class LotterySortThree {
    /*
     * 运行“排列三”彩票游戏
     * 从键盘读取3个自选数字，得出中奖结果与奖金
     */
    public static void main(String[] args) {
        
        RandomNumArray aRandomNumsArray = new RandomNumArray(3, 10);
        
        int[] nums = LotterySortThree.EnterThreeNums();
        int[] randoms = aRandomNumsArray.getArray();

        System.out.println("Your Numbers:");
        for(int i: nums)
            System.out.print(i + " ");
        System.out.println();
    
        System.out.println("Lottery Numbers:");
        for(int i: randoms)
            System.out.print(i + " ");
        System.out.println(); 
        
        int award = LotterySortThree.Run(nums, randoms);
        System.out.printf("Your Win %d yuan!\n", award);
    }

    
    /*
     * Run 静态方法
     * 比较输入数组与中奖数组，返回中奖金额。
     */
    private static int Run(int[] nums, int[] winNums) {
        Set<Integer> set = new HashSet<Integer>();
        for(int n: winNums)
            set.add(n);
        
        int award = 0;
        
        if(Arrays.equals(nums, winNums) && set.size() == 3) {
            award = 1040;
            return award;
        }
        
        Arrays.sort(nums);
        Arrays.sort(winNums);
        
        if(Arrays.equals(nums, winNums)) {
            switch(set.size()) {
            case 1:
                award = 1040;
                break;
            case 2:
                award = 346;
                break;
            case 3:
                award = 173;
                break;
            }
        }
 
        return award;       
    }


    /*
     * EnterThreeNums 静态方法
     * 从控制台读取输入的三个数字，返回这个数组
     */
    private static int[] EnterThreeNums() {
        Scanner in = new Scanner(System.in);
        
        System.out.print("Enter Three numbers: ");
        String numStr = in.nextLine();
        numStr = numStr.trim().replaceAll("\\s{1,}", " ");
        
        if (false == numStr.matches("^\\d\\s\\d\\s\\d$")) {
            System.out.println("Not 3 num!");
            System.exit(-1);
        }
        
        String[] numArray = numStr.split(" ");
        int[] nums = new int[3];
        
        for(int i=0; i<3; i++)
            nums[i] = Integer.parseInt(numArray[i]);
        
        return nums;
    }
}



/*
 * RandomNumArray对象
 * 设置一个长度为length，元素数值小于max的整型随机数组
 */
class RandomNumArray {
    private int length;
    private int max;
    private int[] array;
    
    /*
     * 初始化RandomNumArray对象
     * @param length是随机数组的元素数量
     * @param 元素数组小于max
    */
    public RandomNumArray(int length, int max) {
        this.length = length;
        this.max = max;
        this.setArray();
    }
    
    /*
     * 设置随机数组
    */
    public void setArray() {
        int[] array = new int[length];
        
        for(int i=0; i<length; i++)
            array[i] = (int)(Math.random() * max);

        this.array = array;
    }
    
    /*
     * 读取随机数组
     * @return int型随机数组
     */
    public int[] getArray() {
        return this.array;
    }
}
