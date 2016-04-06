import java.io.PrintStream;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.Scanner;

class EchoThread implements Runnable {
	private Socket client;
	public EchoThread(Socket client) {
		this.client = client;
	}
	
	@Override
	public void run() {
		try {
			// 得到客户端输入数据以及向客户端输出数据的对象
			Scanner scan = new Scanner(client.getInputStream());
			PrintStream out = new PrintStream(client.getOutputStream());
			boolean flag = true;
			while(flag) {
				if(scan.hasNext()) {
					String str = scan.next().trim(); //得到客户端发送的内容
					if(str.equalsIgnoreCase("byebye")) {
						out.println("拜拜，下次再会！"); //程序要结束
						flag = false;
					} else {   //回应输入信息
						out.println("ECHO : " + str);
					}
				}
			}
			System.out.println("客户端关闭连接.....");
			scan.close();
			out.close();
			client.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}

public class EchoServer {

	public static void main(String[] args) throws Exception {
		ServerSocket server = new ServerSocket(9999);
		System.out.println("等待连接.....");
		boolean flag = true;
		while(flag) {
			Socket client = server.accept();   //连接客户端
			new Thread(new EchoThread(client)).start();
			System.out.println("客户端已经连接.....");
		}
		server.close();
	}

}
