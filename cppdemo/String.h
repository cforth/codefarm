#ifndef STRING_H
#define STRING_H
#include <cstring>
#include <algorithm>
#include <cstddef>
#include <iostream>
#include <initializer_list>
#include <memory>

class String {
friend String operator+(const String&, const String&);
friend String add(const String&, const String&);
friend std::ostream &operator<<(std::ostream&, const String&);
friend std::ostream &print(std::ostream&, const String&);

public:
	String() = default;
	String(const char *cp) :
		sz(std::strlen(cp)), p(a.allocate(sz))
		{ std::uninitialized_copy(cp, cp + sz, p); }
	String(const String &s) :
		sz(s.sz), p(a.allocate(s.sz))
		{ std::uninitialized_copy(s.p, s.p + sz, p); }
	String(String &&s) noexcept :
		sz(s.size()), p(s.p)
		{ s.p = 0; s.sz = 0; }
	String(size_t n, char c) :
		sz(n), p(a.allocate(n))
		{ std::uninitialized_fill_n(p, sz, c); }
	String &operator=(const String &);
	String &operator=(String &&) noexcept;
	
	~String() noexcept { if (p) a.deallocate(p, sz); }
	
	String &operator=(const char*);
	String &operator=(char);
	String &operator=(std::initializer_list<char>);
	
	const char *begin() { return p; }
	const char *begin() const { return p; }
	const char *end() { return p + sz; }
	const char *end() const { return p + sz; }
	
	size_t size() const { return sz; }
	void swap(String &s) {
		auto tmp = p;
		p = s.p;
		s.p = tmp;
		auto cnt = sz;
		sz = s.sz;
		s.sz = cnt; 
	}

private:
	std::size_t sz = 0;
	char *p = nullptr;
	static std::allocator<char> a;
};

String make_plural(size_t ctr, const String &, const String &);

inline void swap(String &s1, String &s2) {
	s1.swap(s2);
}

#endif
