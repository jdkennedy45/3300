.PHONY: run

all: run

run: program1.class
	java -cp ./:/usr/share/java/mysql.jar program1 $(HOST) $(DATABASE) $(USER) $(PASSWORD)

program1.class: program1.java
	javac -cp ./:/usr/share/java/mysql.jar program1.java

