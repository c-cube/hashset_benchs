open System
open System.Collections.Generic

type [<Struct>] P =
  val i : int
  val j : int
  new(i, j) = {i=i; j=j}

let cmp =
  { new System.Collections.Generic.IEqualityComparer<P> with
      member __.Equals(this, that) =
        this.i = that.i && this.j = that.j
      
      member __.GetHashCode this = this.i + 4000 * this.j }

let inline iterNeighbors f (p: P) =
  let i, j = p.i, p.j
  f(P(i-1, j))
  f(P(i+1, j))
  f(P(i, j-1))
  f(P(i, j+1))

let rec nthLoop n (s1: HashSet<_>) (s2: HashSet<_>) =
  match n with
  | 0 -> s1
  | n ->
      let s0 = HashSet(cmp)
      let add p =
        if not(s1.Contains p || s2.Contains p) then
          ignore(s0.Add p)
      Seq.iter (fun p -> iterNeighbors add p) s1
      nthLoop (n-1) s0 s1

let nth n p =
  nthLoop n (HashSet([p], cmp)) (HashSet(cmp))

Printf.printf "result is %d\n" (nth 2000 (P(0, 0))).Count
