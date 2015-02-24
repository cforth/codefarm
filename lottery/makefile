#运行 make 源代码名字（不带".c"后缀）
#例如 make 8_puzzle
#可以自动编译生成 8_puzzle可执行文件
CC := gcc
CFLAGS := -Wall
clean:
	@echo "cleanning project"
	-rm -f  *.exe *.class
	@echo "clean completed"

#编译java文件
JFLAGS := -encoding utf8
JC := javac
%.class: %.java
	$(JC) $(JFLAGS) $<
