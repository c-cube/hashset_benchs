# micro benchmarks

Trying to reproduce/improve on https://www.reddit.com/r/rust/comments/4dd5yl/rust_vs_f_hashset_benchmark/ in:

- F#
- rust
- OCaml
- Clojure
- C++ (g++ and clang++)

Simon Cruanes:
|So far, indeed, on my computer, F# is faster (1.93s, where rust takes 2.46s and OCaml 2.24).

Anton Carver:
Clojure is presumably hampered by the fact it starts a JVM each time.
I added an empty Clojure test to measure this:

=== clojure_empty (empty program for startup overhead)
real 1.28
user 3.97
sys 0.31

Anton Carver
Fri 13 Oct 22:06:35 BST 2017
model name	: Intel(R) Xeon(R) CPU E5-2620 v4 @ 2.10GHz
=== F#
result is 8000
real 2.58
user 2.45
sys 0.13
=== OCaml
result is 8000
real 2.65
user 2.65
sys 0.00
=== rust
8000
real 1.96
user 1.96
sys 0.00
=== clojure
result is 8000
real 4.80
user 9.25
sys 0.42
=== clojure_bis
result is 8000
real 3.07
user 6.63
sys 0.48
=== clojure_empty (empty program for startup overhead)
real 1.23
user 3.91
sys 0.24
=== C++ (G++)
8000
real 2.54
user 2.54
sys 0.00
=== C++ (Clang/LLVM)
8000
real 2.60
user 2.60
sys 0.00

Order is: Rust (1.96), G++ ~ F# ~ C++ (2.54-2.60), OCaml (2.65), Clojure

