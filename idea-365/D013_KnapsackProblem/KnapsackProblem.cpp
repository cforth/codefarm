#include <iostream>
#include <vector>
using std::cout;
using std::cin;
using std::endl;
using std::vector;

//物品 
typedef struct tagObject {
	int weight;
	int price;
	int status; //0:未选中；1：已选中；2：已经不可选 
}OBJECT;

//背包问题 
typedef struct tagKnapsackProblem {
	vector<OBJECT> objs;
	int totalC;
}KNAPSACK_PROBLEM;

//输出放入背包中的物品属性 
void PrintResult(vector<OBJECT> objs) {
	cout << "Items in the backpack:" << endl;
	for(auto o : objs) {
		if(o.status == 1)
			cout << o.weight << " ";
	}
	cout << endl;
}

//物品选择函数的函数指针
typedef int (*SELECT_POLICY)(vector<OBJECT>& , int);

//贪心算法的主体函数 
void GreedyAlgo(KNAPSACK_PROBLEM *problem, SELECT_POLICY spFunc) {
	int idx;
	int ntc = 0;
	
	//spFunc 每次选最符合策略的那个物品，选后再检查
	while((idx = spFunc(problem->objs, problem->totalC - ntc)) != -1) {
		//所选物品是否满足背包承重要求？
		if((ntc + problem->objs[idx].weight) <= problem->totalC) {
			problem->objs[idx].status = 1;
			ntc += problem->objs[idx].weight;
		}
		else {
			//不能选这个物品了，做个标记重新选
			problem->objs[idx].status = 2; 
		}
	} 
	PrintResult(problem->objs); 
}

//按照价值由大到小选取物品 
int Choosefunc1(vector<OBJECT>& objs, int c) {
    int index = -1;
    int mp = 0;
    for(int i = 0; i < static_cast<int>(objs.size()); i++) {
        if((objs[i].status == 0) && (objs[i].price > mp)) {
            mp = objs[i].price;
            index = i;
        }
    }
    return index;
}

//按照质量由轻到重选取物品 
int Choosefunc2(vector<OBJECT>& objs, int c) {
    int index = -1;
    int mp = INT_MAX;
    for(int i = 0; i < static_cast<int>(objs.size()); i++) {
        if((objs[i].status == 0) && (objs[i].weight < mp)) {
            mp = objs[i].weight;
            index = i;
        }
    }
    return index;
}

//按照价值密度（价值/质量）来选取物品 
int Choosefunc3(vector<OBJECT>& objs, int c) {
    int index = -1;
    float mp = 0.0;
    for(int i = 0; i < static_cast<int>(objs.size()); i++) {
    	float p = (float)objs[i].price/(float)objs[i].weight;
        if((objs[i].status == 0) && (p > mp)) {
            mp = p;
            index = i;
        }
    }
    return index;
}

int main() {
	int size = 7;
	int W[] = {35,30,60,50,40,10,25};
	int P[] = {10,40,30,50,35,40,30};
	
	KNAPSACK_PROBLEM problem;
	vector<OBJECT> vec;
	for(int x = 0; x < size; ++x) {
		OBJECT o = {W[x], P[x], 0};
		vec.push_back(o);
	}
	problem.objs = vec;
	problem.totalC = 150;
	KNAPSACK_PROBLEM *p = &problem;
	//GreedyAlgo(p, Choosefunc1);
	//GreedyAlgo(p, Choosefunc2);
	GreedyAlgo(p, Choosefunc3);
}
