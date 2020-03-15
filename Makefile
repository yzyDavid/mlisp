all: test

mlisp: *.ml *.mli
	corebuild -pkg yojson -pkg llvm -pkg llvm.analysis main.native && mv main.native mlisp

test: mlisp
	./mlisp

clean:
	rm -f mlisp
	rm -rf _build

.PHONY: all clean test
