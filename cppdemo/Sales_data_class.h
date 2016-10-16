#ifndef SALES_DATA_H
#define SALES_DATA_H
/*
 * 书籍销售信息类 
 */ 
class Sales_data {
	//友元声明 
	friend std::istream &read(std::istream &,  Sales_data &);
	friend std::ostream &print(std::ostream &os, const Sales_data &);
	friend Sales_data add(const Sales_data &, const Sales_data &);
	friend bool compareIsbn(const Sales_data &lhs, const Sales_data &rhs);

public:
	Sales_data() = default;  //默认构造函数 
	Sales_data(const std::string &s, unsigned n, double p) : bookNo(s), units_sold(n), revenue(p*n) {	//初始化成员，成员函数为空
	}
	Sales_data(const std::string &s) : bookNo(s) {
	}
	Sales_data(std::istream &); // 构造函数声明，从输入流初始化成员 
	Sales_data(const Sales_data&); //拷贝构造函数 
	
	std::string isbn() const { return bookNo; }  
	Sales_data &combine(const Sales_data &);
	double avg_price() const { //隐式内联函数 
		return units_sold ? revenue/units_sold : 0;
	}

private:
	std::string bookNo; //书籍的编号 
	unsigned units_sold = 0; //书籍销售数量 
	double revenue = 0.0; //书籍销售总价格 
};

/*
 * Sales_data的拷贝构造函数 
 */
Sales_data::Sales_data(const Sales_data &orig): 
	bookNo(orig.bookNo),
	units_sold(orig.units_sold),
	revenue(orig.revenue) 
	{ std::cout << "I'm copying! BookNo: " << orig.bookNo << std::endl;}

/*
 * Sales_data类的成员函数实现 
 */ 
Sales_data &Sales_data::combine(const Sales_data &rhs) {
	units_sold += rhs.units_sold;
	revenue += rhs.revenue;
	return *this;
}

/*
 * Sales_data类的接口函数声明，非成员函数，在类中声明为友元 
 */ 
std::istream &read(std::istream &, Sales_data &);
std::ostream &print(std::ostream &os, const Sales_data &);
Sales_data add(const Sales_data &, const Sales_data &);
bool compareIsbn(const Sales_data &lhs, const Sales_data &rhs);

/*
 * Sales_data类的接口函数实现 
 */ 
std::istream &read(std::istream &is, Sales_data &item) {
	double price = 0;
	is >> item.bookNo >> item.units_sold >> price;
	item.revenue = price * item.units_sold;
	return is;
} 

std::ostream &print(std::ostream &os, const Sales_data &item) {
	os	<< item.isbn() << " " 
		<< item.units_sold << " "
		<< item.revenue << " "
		<< item.avg_price();
	return os;		
}

Sales_data add(const Sales_data &lhs, const Sales_data &rhs) {
	Sales_data sum = lhs;
	sum.combine(rhs);
	return sum;
}

/*
 * 提供此类作为关联容器关键字类型时所需要的小于号比较符 
*/
bool compareIsbn(const Sales_data &lhs, const Sales_data &rhs) {
	return lhs.isbn() < rhs.isbn();
}
#endif
