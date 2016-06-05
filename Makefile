
all: ocaml fsharp rust
	@echo "=== F#"
	@time mono neighbors2.exe
	@echo "=== OCaml"
	@time ./neighbors2_ocaml
	@echo "=== rust"
	@time ./neighbors2_rust

ocaml:
	ocamlfind ocamlopt -O3 neighbors2.ml -o neighbors2_ocaml

rust:
	rustc -O neighbors2.rs -o neighbors2_rust

fsharp:
	fsharpc neighbors2.fsx


# ocamlfind ocamlopt -g -O3 -package containers.data -linkpkg neighbors2.ml -o neighbors2_ocaml
