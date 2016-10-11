package com.cfxyz.newvm.util;

import com.cfxyz.newvm.Vm;

public final class DictUtil {
	public final static int END = 1000 ;
	public final static int ADD = 1009 ;
	
	public static void addWord(int lfa, String precedence, String smudge, String name, String code, int[] pfa, Vm space) {
		space.last = space.here ;  //更新词头地址
		
		WordUtil.createLFA(lfa, space);
		
		int precedenceBit = 0;
		int smudgeBit = 0;
		if(precedence.equals("IMMEDIATE")) {
			precedenceBit = 1 ;
		} else if(precedence.equals("NORMAL")) {
			precedenceBit = 0 ;
		}
		if(smudge.equals("HIDE")) {
			smudgeBit = 1 ;
		} else if(smudge.equals("REVEAL")) {
			smudgeBit = 0 ;
		}
		WordUtil.createNFA(precedenceBit, smudgeBit, name.length(), name, space);
		
		int cfa = 0 ;
		if(code.equals("CORE")) {
			cfa = 1 ;
		} else if (code.equals("COLON")) {
			cfa = 2 ;
		} else if (code.equals("VAR")) {
			cfa = 3 ;
		} else if (code.equals("CONSTANT")) {
			cfa = 4 ;
		}
		WordUtil.createCFA(cfa, space);
		
		WordUtil.createPFA(pfa, space);
	}
	
	public static void listWord(Vm space) {
		int x = space.last;
		while(x >= 0) {
			int next = space.memory[x] ;
			System.out.println("nextWordAddr = " + next) ;
			x++;
			
			if(space.memory[x] == 1) {
				System.out.println("Precedence = IMMEDIATE") ;
			} else if(space.memory[x] == 0) {
				System.out.println("Precedence = NORMAL") ;
			}
			x++;
			if(space.memory[x] == 1) {
				System.out.println("Smudge = HIDE") ;
			} else if(space.memory[x] == 0) {
				System.out.println("Smudge = REVEAL") ;
			}
			x++;
			int wordLength = space.memory[x] ;
			x++;
			char[] wordNameCharArray = new char[wordLength] ;
			for(int y = 0; y < wordLength; y++) {
				wordNameCharArray[y] = (char)space.memory[x] ;
				x++;
			}
			System.out.println("WordName = " + String.valueOf(wordNameCharArray)); 
			
			
			if(space.memory[x] == 1) {
				x++;
				System.out.println("CFA = CORE") ;
				System.out.print("CORE PFA = ") ;
				if(x == DictUtil.END) {
					System.out.println("CORE = END");
				} else if(x == DictUtil.ADD) {
					System.out.println("CODE = ADD");
				}
			} else if (space.memory[x] == 2) {
				x++;
				System.out.println("CFA = COLON") ;
				System.out.print("COLON PFA = ");
				while(space.memory[x] != DictUtil.END) {
					System.out.print(space.memory[x] + ", ");
					x++;
				}
			}
			
			System.out.println(space.memory[x] + "\n");
			
			if(next == -1) {
				break ;
			} else {
				x = next ;
			}
		}
	}

}
