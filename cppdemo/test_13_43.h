#ifndef TEST_13_39_H
#define TEST_13_39_H
#include <string>
#include <memory>
#include <utility>
#include <algorithm>
#include <initializer_list>

//类vector类内存分配策略的简化实现 
class StrVec {
public:
	StrVec(): //allocator成员进行默认初始化
		elements(nullptr), first_free(nullptr), cap(nullptr) { }
	StrVec(std::initializer_list<std::string> lst); //使用字符串列表初始化 
	StrVec(const StrVec&); //拷贝构造函数
	StrVec &operator= (const StrVec&); //拷贝赋值运算符
	~StrVec(); //析构函数
	void push_back(const std::string&); //拷贝元素
	size_t size() const { return first_free - elements; }
	size_t capacity() const { return cap - elements; }
	std::string *begin() const { return elements; }
	std::string *end() const { return first_free; }

private:
	static std::allocator<std::string> alloc; //分配元素
	//被添加元素的函数所使用
	void chk_n_alloc() {
		if (size() == capacity())
			reallocate();
	}
	//工具函数，被拷贝构造函数、赋值运算符和析构函数所使用
	std::pair<std::string*, std::string*> alloc_n_copy (const std::string*, const std::string*);
	void free(); //销毁元素并释放内存
	void reallocate(); //获得更多内存并拷贝已有元素
	std::string *elements; //指向数组首元素的指针
	std::string *first_free; //指向数组第一个空闲元素的指针
	std::string *cap; //指向数组尾后位置的指针
};

//StrVec类内的实现
StrVec::StrVec(std::initializer_list<std::string> lst) :
	elements(nullptr), first_free(nullptr), cap(nullptr) {
	for(auto beg = lst.begin(); beg != lst.end(); ++beg) {
		this->push_back(*beg);
	}	
}

void StrVec::push_back(const std::string& s) {
	chk_n_alloc(); //确保有空间容纳新元素
	//在first_free指向的元素中构造s的副本
	alloc.construct(first_free++, s);

}

std::pair<std::string*, std::string*>
StrVec::alloc_n_copy(const std::string *b, const std::string *e) {
	//分配空间保存给定范围中的元素
	auto data = alloc.allocate(e - b);
	//初始化并返回一个pair，该pair由data和uninitialized_copy的返回值构成
	return {data, uninitialized_copy(b, e, data)};
}

void StrVec::free() {
	//不能传递给deallocate一个空指针，如果elements为0，函数什么也不做
	if (elements) {
		//逆序销毁旧元素
		for_each(elements, first_free, [this](std::string &rhs){ alloc.destroy(&rhs); });
	}
}

StrVec::StrVec(const StrVec &s) {
	//调用alloc_n_copy分配空间以容纳与s中一样多的元素
	auto newdata = alloc_n_copy(s.begin(), s.end());
	elements = newdata.first;
	first_free = cap = newdata.second;
}

StrVec::~StrVec() {
	free();
}

StrVec &StrVec::operator= (const StrVec &rhs) {
	//调用alloc_n_copy分配内存，大小与rhs中元素占用空间一样多
	auto data = alloc_n_copy(rhs.begin(), rhs.end());
	free();
	elements = data.first;
	first_free = cap = data.second;
	return *this;
}

void StrVec::reallocate() {
	//将分配当前大小两倍的内存空间
	auto newcapacity = size() ? 2 * size() : 1;
	//分配新内存
	auto newdata = alloc.allocate(newcapacity);
	//将数据从旧内存移动到新内存
	auto dest = newdata; //指向新数组中下一个空闲位置
	auto elem = elements; //指向旧数组中下一个元素
	for(size_t i = 0; i != size(); ++i)
		alloc.construct(dest++, std::move(*elem++));
	free(); //一旦移动完元素就释放旧内存空间
	//更新数据结构，执行新元素
	elements = newdata;
	first_free = dest;
	cap = elements + newcapacity;
}

#endif
