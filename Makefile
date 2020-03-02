#Corcodel Denisa 336CC
build:
	flex LFA_Tema.l
	gcc lex.yy.c -o output -lfl
clean:
	rm -rf output lex.yy.c
