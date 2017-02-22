SDIR=src
LDIR=lib

all: mkdir HelloWorld HelloWorld64 ExampleProgram $(LDIR)/libtoc.dylib toc

mkdir:
	mkdir -p lib

HelloWorld: $(LDIR)/HelloWorld.o
	ld -macosx_version_min 10.7.0 -o $@ $<
	echo "Linked $< to $@"

HelloWorld64: $(LDIR)/HelloWorld64.o
	ld -macosx_version_min 10.7.0 -lSystem -arch x86_64 -o $@ $<
	echo "Linked $< to $@"

$(LDIR)/HelloWorld.o: $(SDIR)/HelloWorld.asm
	/usr/local/Cellar/nasm/2.12.01/bin/nasm -f macho -o $@ $<
	echo "Assembled $<"

$(LDIR)/HelloWorld64.o: $(SDIR)/HelloWorld64.asm
	/usr/local/Cellar/nasm/2.12.01/bin/nasm -f macho64 -o $@ $<
	echo "Assembled $<"

ExampleProgram: $(SDIR)/ExampleProgram.c
	gcc -o $@ $<
	echo "Compiled $< to $@"

$(LDIR)/libtoc.dylib: $(SDIR)/libtoc.c
	gcc -dynamiclib -install_name @executable_path/$@ -o $@ $<
	echo "Compiled $< to $@"

toc: $(SDIR)/toc.c
	gcc -o $@ -L$(LDIR) -l$@ $<
	echo "Compiled $< to $@"

clean:
	rm -rf lib
	rm -f HelloWorld HelloWorld64 ExampleProgram toc
	echo "Clean done."
