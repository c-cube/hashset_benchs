time=/usr/bin/time -p

.PHONY: all run force targets ocaml fsharp rust g++ clang++

APP = neighbors2
TARGETS = $(APP)_ocaml $(APP)_rust $(APP).exe $(APP)_g++ $(APP)_clang++

# Build any needed targets and run
all: $(TARGETS) run

# Build any needed targets
build: $(TARGETS)

# Force build of all targets
force: ocaml fsharp rust g++ clang++

# Run all the benchmarks
run:
	@getent passwd $$USER | cut -d ':' -f 5 | cut -d ',' -f 1
	@date
	@grep 'model name' /proc/cpuinfo|uniq
	@echo "=== F#"
	@$(time) mono neighbors2.exe
	@echo "=== OCaml"
	@$(time) ./neighbors2_ocaml
	@echo "=== rust"
	@$(time) ./neighbors2_rust
	@echo "=== clojure"
	@$(time) clojure neighbors2.clj
	@echo "=== clojure_bis"
	@$(time) clojure neighbors2_bis.clj
	@echo "=== clojure_empty (empty program for startup overhead)"	
	@$(time) clojure < /dev/null > /dev/null
	@echo "=== C++ (G++)"
	@$(time) ./neighbors2_g++
	@echo "=== C++ (Clang/LLVM)"
	@$(time) ./neighbors2_clang++

ocaml neighbors2_ocaml: neighbors2.ml
	ocamlfind ocamlopt -O3 neighbors2.ml -o neighbors2_ocaml

rust neighbors2_rust: neighbors2.rs
	rustc -O neighbors2.rs -o neighbors2_rust

fsharp neighbors2.exe: neighbors2.fsx
	fsharpc neighbors2.fsx

g++ neighbors2_g++: neighbors2.cc
	g++ --std=c++11 -O3 -o neighbors2_g++ neighbors2.cc

clang++ neighbors2_clang++: neighbors2.cc
	clang++-4.0 --std=c++11 -O3 -o neighbors2_clang++ neighbors2.cc

# ocamlfind ocamlopt -g -O3 -package containers.data -linkpkg neighbors2.ml -o neighbors2_ocaml

# To run ocamlfind ocamlopt -O3 requires flambda

# You will need opam if you don't have it already:
#   sudo apt install opam
#   opam update
#   [see https://opam.ocaml.org/doc/Usage.html#Basics]
#
#   opam switch 4.04.0+flambda
#   opam install ocamlfind


