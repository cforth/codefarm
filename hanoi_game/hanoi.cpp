#include <iostream>
#include <vector>
#include <map>
#include <string>
using namespace std;

ostream& print(ostream &out, map<string, vector<int>> &hanoi) {
	out << "\n" << endl;
	for(auto h : hanoi) {
		cout << h.first << ": "; 
		for(auto v : h.second) {
			out << v << " ";
		}
		out << "\n";
	}
	return out;
}

istream& read_cmd(istream &in, string &from, string &to) {
	cout << "Your move:" << endl;
	in >> from >> to ;
	return in;
}

void move(vector<int> &a, vector<int> &b) {
	if(!a.empty()) {
		if(b.empty() || a.back() < b.back()) {
			b.push_back(a.back());
			a.pop_back();
		}
	}
}

bool check(vector<int> &c, int num) {
	if(!c.empty() && c.size() == num) {
		cout << "You Win!!!" << endl;
		return true;
	}
	return false;
}

int main() {	
	map<string, vector<int>> hanoi = {{"a", {3,2,1}}, {"b", {}}, {"c", {}}};
	print(cout, hanoi) << endl;
	
	int win_num = hanoi["a"][0];
	string from, to;
	while(read_cmd(cin, from, to)) {
		if(hanoi.count(from) != 0 && hanoi.count(to) != 0) {
			move(hanoi[from], hanoi[to]);
			print(cout, hanoi) << endl;
			if (check(hanoi["c"], win_num)) return 0;
		} else {
			cout << "Wrong move!!!" << endl;
		}
		cin.clear();
	}
	return 0;
}
