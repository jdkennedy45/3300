.PHONY: run

all: run

run: program2
	 ./program2 $(HOST) $(DATABASE) $(USER) $(PASSWORD)

program2: program2.c
	gcc -std=c99 program2.c -o program2 `mysql_config --cflags --libs`

