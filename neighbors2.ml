
type p = {
  i: int;
  j: int;
}

let mk_p i j = {i; j}

let equal_p p1 p2 = p1.i = p2.i && p1.j = p2.j

let hash_p p = p.i + p.j * 4000 

let iter_neighbors f {i; j} =
  f (mk_p (i-1) j);
  f (mk_p (i+1) j);
  f (mk_p i (j-1));
  f (mk_p i (j+1));
  ()

module PTbl = Hashtbl.Make(struct
    type t = p
    let equal = equal_p
    let hash = hash_p
  end)

type hashset = unit PTbl.t

let rec nth_loop n (s1:hashset) (s2:hashset) =
  match n with
    | 0 -> s1
    | _ ->
      let s0 = PTbl.create 32 in
      let add p =
        if not (PTbl.mem s1 p || PTbl.mem s2 p)
        then PTbl.replace s0 p ()
      in
      PTbl.iter
        (fun p' () -> iter_neighbors add p') s1;
      nth_loop (n-1) s0 s1

let nth n p =
  let s1 = PTbl.create 32 in
  PTbl.add s1 p ();
  let s2 = PTbl.create 32 in
  nth_loop n s1 s2

let () =
  Printf.printf "result is %d\n" (nth 2000 (mk_p 0 0) |> PTbl.length)

