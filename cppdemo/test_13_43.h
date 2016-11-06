#ifndef TEST_13_39_H
#define TEST_13_39_H
#include <string>
#include <memory>
#include <utility>
#include <algorithm>
#include <initializer_list>

//��vector���ڴ������Եļ�ʵ�� 
class StrVec {
public:
	StrVec(): //allocator��Ա����Ĭ�ϳ�ʼ��
		elements(nullptr), first_free(nullptr), cap(nullptr) { }
	StrVec(std::initializer_list<std::string> lst); //ʹ���ַ����б��ʼ�� 
	StrVec(const StrVec&); //�������캯��
	StrVec &operator= (const StrVec&); //������ֵ�����
	~StrVec(); //��������
	void push_back(const std::string&); //����Ԫ��
	size_t size() const { return first_free - elements; }
	size_t capacity() const { return cap - elements; }
	std::string *begin() const { return elements; }
	std::string *end() const { return first_free; }

private:
	static std::allocator<std::string> alloc; //����Ԫ��
	//�����Ԫ�صĺ�����ʹ��
	void chk_n_alloc() {
		if (size() == capacity())
			reallocate();
	}
	//���ߺ��������������캯������ֵ�����������������ʹ��
	std::pair<std::string*, std::string*> alloc_n_copy (const std::string*, const std::string*);
	void free(); //����Ԫ�ز��ͷ��ڴ�
	void reallocate(); //��ø����ڴ沢��������Ԫ��
	std::string *elements; //ָ��������Ԫ�ص�ָ��
	std::string *first_free; //ָ�������һ������Ԫ�ص�ָ��
	std::string *cap; //ָ������β��λ�õ�ָ��
};

//StrVec���ڵ�ʵ��
StrVec::StrVec(std::initializer_list<std::string> lst) :
	elements(nullptr), first_free(nullptr), cap(nullptr) {
	for(auto beg = lst.begin(); beg != lst.end(); ++beg) {
		this->push_back(*beg);
	}	
}

void StrVec::push_back(const std::string& s) {
	chk_n_alloc(); //ȷ���пռ�������Ԫ��
	//��first_freeָ���Ԫ���й���s�ĸ���
	alloc.construct(first_free++, s);

}

std::pair<std::string*, std::string*>
StrVec::alloc_n_copy(const std::string *b, const std::string *e) {
	//����ռ䱣�������Χ�е�Ԫ��
	auto data = alloc.allocate(e - b);
	//��ʼ��������һ��pair����pair��data��uninitialized_copy�ķ���ֵ����
	return {data, uninitialized_copy(b, e, data)};
}

void StrVec::free() {
	//���ܴ��ݸ�deallocateһ����ָ�룬���elementsΪ0������ʲôҲ����
	if (elements) {
		//�������پ�Ԫ��
		for_each(elements, first_free, [this](std::string &rhs){ alloc.destroy(&rhs); });
	}
}

StrVec::StrVec(const StrVec &s) {
	//����alloc_n_copy����ռ���������s��һ�����Ԫ��
	auto newdata = alloc_n_copy(s.begin(), s.end());
	elements = newdata.first;
	first_free = cap = newdata.second;
}

StrVec::~StrVec() {
	free();
}

StrVec &StrVec::operator= (const StrVec &rhs) {
	//����alloc_n_copy�����ڴ棬��С��rhs��Ԫ��ռ�ÿռ�һ����
	auto data = alloc_n_copy(rhs.begin(), rhs.end());
	free();
	elements = data.first;
	first_free = cap = data.second;
	return *this;
}

void StrVec::reallocate() {
	//�����䵱ǰ��С�������ڴ�ռ�
	auto newcapacity = size() ? 2 * size() : 1;
	//�������ڴ�
	auto newdata = alloc.allocate(newcapacity);
	//�����ݴӾ��ڴ��ƶ������ڴ�
	auto dest = newdata; //ָ������������һ������λ��
	auto elem = elements; //ָ�����������һ��Ԫ��
	for(size_t i = 0; i != size(); ++i)
		alloc.construct(dest++, std::move(*elem++));
	free(); //һ���ƶ���Ԫ�ؾ��ͷž��ڴ�ռ�
	//�������ݽṹ��ִ����Ԫ��
	elements = newdata;
	first_free = dest;
	cap = elements + newcapacity;
}

#endif
