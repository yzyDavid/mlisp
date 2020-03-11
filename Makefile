all: test

mlisp: *.ml *.mli
	corebuild main.native && mv main.native mlisp

test: mlisp
	./mlisp

clean:
	rm -f mlisp
	rm -rf _build

.PHONY: all clean test
