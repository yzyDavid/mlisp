all: test

mlisp: *.ml *.mli
	corebuild -pkg yojson -pkg llvm -pkg llvm.analysis main.native && mv main.native mlisp

builtin: builtin.so

builtin.so: builtin.h builtin.c
	clang builtin.c -g -O0 -shared -fPIC -o builtin.so

test: mlisp
	./mlisp

clean:
	rm -f mlisp
	rm -rf _build
	rm -f builtin.so

.PHONY: all clean test builtin
