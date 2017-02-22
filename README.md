Some basic NASM assembly for 32 and 64 bit OSX.

Build:
```$ make all```

Run:
```$ ./HelloWorld```
or
```$ ./HelloWorld64```

Examples from "All Offsets Are My Own" article entitled
[Mach-o Binaries](http://www.m4b.io/reverse/engineering/mach/binaries/2015/03/29/mach-binaries.html)
This is the the best guide for use in building a Mach-o static analyzer that
I've seen.

Display Load Commands:
```$ otool -l ExampleProgram```

For fun, run `nm`, which outputs the exported symbol table:
```
$ nm -a ExampleExportedSymbol.dylib
0000000000000fb0 S _kTOC_MAGICAL_FUN
0000000000000f90 T _toc_XX_unicode
0000000000001000 D _toc_extern_export
0000000000000f50 T _toc_maximum
                 U dyld_stub_binder
```                 

Strip the symbol table, and then re-run nm.  
```
$ strip ExampleExportedSymbol.dylib
$ nm -a ExampleExportedSymbol.dylib
```

Unfortunately, nm uses the nlist symbol table to generate its output, and after
you strip the binary, it no longer displays symbols.  However, we can statically
determine the symbols that are exported by getting the exports offset from the
dyld_info_command struct field, and walking the export trie.  See
[Export Trie](http://www.m4b.io/reverse/engineering/mach/binaries/2015/03/29/mach-binaries.html#export-trie)
for details.  There are no tools available for this, so I may end up building
one.
