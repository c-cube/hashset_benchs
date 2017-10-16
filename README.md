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
Mon 16 Oct 13:47:30 BST 2017
model name	: Intel(R) Xeon(R) CPU E5-2620 v4 @ 2.10GHz
=== F#
result is 8000
real 2.54
user 2.46
sys 0.09
=== OCaml
result is 8000
real 2.64
user 2.63
sys 0.00
=== rust
8000
real 1.97
user 1.97
sys 0.00
=== clojure
result is 8000
real 4.77
user 9.31
sys 0.40
=== clojure_bis
result is 8000
real 3.13
user 6.57
sys 0.44
=== clojure_empty (empty program for startup overhead)
real 1.29
user 4.16
sys 0.29
=== C++ (G++)
8000
real 2.34
user 2.33
sys 0.00
=== C++ (Clang/LLVM)
8000
real 2.38
user 2.38
sys 0.00

Order is: Rust (1.97), G++ ~ C++ (2.34-2.38), F# (2.54) OCaml (2.64), Clojure

