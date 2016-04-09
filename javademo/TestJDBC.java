import java.sql.Connection;
import java.sql.DriverManager;

public class TestJDBC {
	private static final String DBDRIVER = "oracle.jdbc.driver.OracleDriver";
	private static final String DBURL = "jdbc:oracle:thin:@localhost:1521:orcl";
	private static final String USER = "scott";
	private static final String PASSWORD = "tiger";
	
	public static void main(String[] args) throws Exception {
		//第一步：加载数据库驱动程序，此时不需要实例化，因为会由容器自己负责管理
		Class.forName(DBDRIVER);
		//第二步：连接数据库
		Connection conn = DriverManager.getConnection(DBURL, USER, PASSWORD);
		System.out.println(conn);
		//关闭数据库
		conn.close();
	}

}