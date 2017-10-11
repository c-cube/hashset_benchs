# micro benchmarks

Trying to reproduce/improve on https://www.reddit.com/r/rust/comments/4dd5yl/rust_vs_f_hashset_benchmark/ in:

- F#
- rust
- OCaml
- Clojure
- C++ (g++ and clang++)

Jon Harrop>
|So far, indeed, on my computer, F# is faster (1.93s, where rust takes 2.46s and OCaml 2.24).

Anton Carver
Wed 11 Oct 17:23:12 BST 2017
model name	: Intel(R) Xeon(R) CPU E5-2620 v4 @ 2.10GHz
=== F#
result is 8000
real 2.59
user 2.46
sys 0.13
=== OCaml
result is 8000
real 4.86
user 4.86
sys 0.00
=== rust
8000
real 1.92
user 1.92
sys 0.00
=== clojure
result is 8000
real 4.38
user 8.44
sys 0.54
=== clojure_bis
result is 8000
real 3.15
user 6.94
sys 0.48
=== C++ (G++)
8000
real 2.58
user 2.58
sys 0.00
=== C++ (Clang/LLVM)
8000
real 2.60
user 2.59
sys 0.00

Order is: Rust (1.92), G++ ~ F# ~ C++ (2.58-2.60), Clojure, OCaml (4.86)

Clojure is presumably hampered by the fact it starts a JVM each time.
I added an empty Clojure test to measure this:

=== clojure_empty (empty program for startup overhead)
real 1.28
user 3.97
sys 0.31
