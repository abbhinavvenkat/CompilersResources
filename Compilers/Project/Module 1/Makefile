CC=g++
CFLAGS=-lfl
OUTPUT=lexer

all: flex compile run

run:
	./$(OUTPUT)

compile:
	$(CC) lex.yy.c $(CFLAGS) -o $(OUTPUT)

bison:
	bison -d parse.y

flex:
	flex lex.l

clean:
	rm a.out lex.yy.c