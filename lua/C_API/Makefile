cc := gcc
CFLAGS := -Wall

lua1: lua1.c
	$(CC) $(CFLAGS) $^ -o $@ -llua

clean:
	@echo "cleanning project"
	-rm -f *.exe
	@echo "clean completed"
