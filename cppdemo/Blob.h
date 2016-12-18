#ifndef BLOB_H
#define BLOB_H
#include <vector>
#include <memory>
#include <string>

template <typename T>
class Blob {
public:
	typedef typename std::vector<T>::size_type size_type;
	//���캯��
	Blob();
	Blob(std::initializer_list<T> il);
	//Blob�е�Ԫ����Ŀ
	size_type size() const { return data->size(); }
	bool empty() const { return data->empty(); }
	//��Ӻ�ɾ��Ԫ��
	void push_back(const T &t) { data->push_back(t); }
	//�ƶ��汾
	void push_back(T &&t) { data->push_back(std::move(t));	}
	void pop_back();
	//Ԫ�ط���
	T& back();
	T& operator[](size_type i);
private:
	std::shared_ptr<std::vector<T>> data;
	//��data[i]��Ч�����׳�msg
	void check(size_type i, const std::string &msg) const;
};

template <typename T>
void Blob<T>::check(size_type i, const std::string &msg) const {
	if(i >= data->size())
		throw std::out_of_range(msg);
}

template <typename T>
T& Blob<T>::back() {
	check(0, "back on empty Blob");
	return data->back();
}

template <typename T>
T& Blob<T>::operator[](size_type i) {
	//���i̫��check���׳��쳣����ֹ����һ�������ڵ�Ԫ��
	check(i, "subscript out of range");
	return (*data)[i];
}

template <typename T>
void Blob<T>::pop_back() {
	check(0, "pop_back on empty Blob");
	data->pop_back();
}

template <typename T>
Blob<T>::Blob() :
	data(std::make_shared<std::vector<T>>()) {}

template <typename T>
Blob<T>::Blob(std::initializer_list<T> il) :
	data(std::make_shared<std::vector<T>>(il)) {}

#endif
