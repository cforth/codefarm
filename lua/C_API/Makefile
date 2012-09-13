#使用linux上的gcc编译时，需要加上-lm -ldl选项
#在windows的cygwin上使用gcc则不必

cc := gcc
CFLAGS := -Wall

lua1: lua1.c
	$(CC) $(CFLAGS) $^ -o $@ -llua -lm -ldl

hellolua: hellolua.c
	$(CC) $(CFLAGS) $^ -o $@ -llua -lm -ldl

clean:
	@echo "cleanning project"
	-rm -f *.exe
	@echo "clean completed"
