all: HelloWorld HelloWorld64

HelloWorld: HelloWorld.o
	 ld -macosx_version_min 10.7.0 -o $@ $<
	 echo "Linked $< to $@"

HelloWorld64: HelloWorld64.o
	ld -macosx_version_min 10.7.0 -lSystem -o $@ $<
	echo "Linked $< to $@"

HelloWorld.o : HelloWorld.asm
	/usr/local/Cellar/nasm/2.12.01/bin/nasm -f macho $<
	echo "Assembled $<"

HelloWorld64.o : HelloWorld64.asm
	/usr/local/Cellar/nasm/2.12.01/bin/nasm -f macho64 $<
	echo "Assembled $<"

clean:
	 rm *.o HelloWorld HelloWorld64
	 echo "Clean done."
