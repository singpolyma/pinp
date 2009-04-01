.PHONY: clean

pinp: lex.yy.c y.tab.h y.tab.c
	$(CC) -o pinp lex.yy.c y.tab.c
lex.yy.c: pinp.l
	$(LEX) pinp.l
y.tab.h: pinp.y
	$(YACC) -vtd pinp.y

clean:
	$(RM) *.o pinp lex.yy.c y.tab.h y.tab.c y.output
