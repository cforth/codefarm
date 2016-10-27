#include <iostream>
#include <string>
#include <set>
using std::cout;
using std::cin;
using std::endl;
//申明Folder类 
class Folder;

class Message {
	friend class Folder;
	friend void swap(Message &, Message &);
public:
	//folders被隐式初始化为空集合
	explicit Message(const std::string &str = ""):
		contents(str) { }
	//拷贝控制成员，用来管理指向本Message的指针
	Message(const Message&); //拷贝构造函数
	Message& operator=(const Message&); //拷贝赋值运算符
	~Message();
	//从给定Folder集合中添加/删除本Message
	void save(Folder&);
	void remove(Folder&);
private:
	std::string contents; //实际消息文本
	std::set<Folder*> folders; //包含本Message的Folder
	//拷贝构造函数、拷贝赋值运算符和析构函数所使用的的工具函数
	//将本Message添加到指向参数的Folder中
	void add_to_Folders(const Message&);
	//从folder中的每个Folder中删除本Message
	void remove_from_Folders(); 
};

class Folder {
	friend class Message;
public:
	Folder() { }
	~Folder() {
		std::cout << "delete folder!!" << std::endl;
	}
	void addMsg(Message*);
	void remMsg(Message*);
	std::ostream& print(std::ostream &out) {
		for(auto m: messages) {
			out << m->contents << "\n";
		}
		return out;
	}
private:
	std::set<Message*> messages;
};

void Message::save(Folder &f) {
	folders.insert(&f); //将给定Folder添加到我们的Folder列表中
	f.addMsg(this); //将本Message添加到f的Message集合中 
}

void Message::remove(Folder &f) {
	folders.erase(&f); //将给定Folder从我们的Folder列表中删除
	f.remMsg(this); //将本Message从f的Message集合中删除 
}

//将本Message添加到指向m的Folder中
void Message::add_to_Folders(const Message &m) {
	for(auto f: m.folders) //对每个包含m的Folder
		f->addMsg(this); //向该Folder添加一个指向本Message的指针
}

Message::Message(const Message &m): 
	contents(m.contents), folders(m.folders) {
		std::cout << "copy msg: " << m.contents << std::endl;
		add_to_Folders(m); //将本消息添加到指向m的Folder中 
}

//从对应的Folder中删除本Message
void Message::remove_from_Folders() {
	for(auto f: folders) //对folders中的每个指针
		f->remMsg(this); //从该Folder中删除本Message 
} 

Message::~Message() {
	std::cout << "delete msg!!" << std::endl;
	remove_from_Folders();
}

Message& Message::operator=(const Message &rhs) {
	std::cout << "operator= msg: " << rhs.contents << std::endl;
	//通过先删除指针再插入它们来处理赋值情况
	remove_from_Folders(); //更新已有Folder
	contents = rhs.contents; //从rhs拷贝消息内容
	folders = rhs.folders; //从rhs拷贝Folder指针
	add_to_Folders(rhs); //将本Message添加到那些Folder中
	return *this; 
}

void swap(Message &lhs, Message &rhs) {
	std::cout << "swap!!! " << lhs.contents << " " << rhs.contents << std::endl;
	using std::swap;
	for(auto f: lhs.folders)
		f->remMsg(&lhs);
	for(auto f: rhs.folders)
		f->remMsg(&rhs);
	//交换contents和Folder指针set
	swap(lhs.folders, rhs.folders); //使用swap(set&, set&)
	swap(lhs.contents, rhs.contents); //使用swap(string&, string&)
	//将每个Message的指针添加到它的（新）Folder中
	for(auto f: lhs.folders)
		f->addMsg(&lhs);
	for(auto f: rhs.folders)
		f->addMsg(&rhs); 
}

void Folder::addMsg(Message *msg) {
	messages.insert(msg);
}

void Folder::remMsg(Message *msg) {
	messages.erase(msg);
}

int main() {
	Folder f1; //Folder类其实就是包装过的Set容器 
	Folder f2;
	Message m1("111");
	Message m2("222");
	Message m3(m1);
	Message m4;
	m4 = m3;
	swap(m1, m2); //调用重载过的swap函数 
	m1.save(f1);
	m2.save(f1);
	m1.save(f2);
	m2.save(f2);
	f1.print(cout) << endl;
	f2.print(cout) << endl;
	return 0;
}
