#![allow(non_snake_case)]

use std::collections::HashSet;
use std::hash::BuildHasherDefault;
//use std::collections::HashSet::DefaultHasher;

use std::default::Default;
use std::hash::Hasher;

pub struct FnvHasher(u64);

impl Default for FnvHasher {
    #[inline]
    fn default() -> FnvHasher {
        FnvHasher(0xcbf29ce484222325)
    }
}

impl Hasher for FnvHasher {
    #[inline]
    fn finish(&self) -> u64 {
        self.0
    }

    #[inline]
    fn write(&mut self, _: &[u8]) {}

    #[inline]
    fn write_i32(&mut self, i: i32) {
        self.0 = self.0 * 4000 + i as u64;
    }
}

type Set = HashSet<(i32, i32), BuildHasherDefault<FnvHasher>>;

fn Empty() -> Set {
       let fnv = BuildHasherDefault::<FnvHasher>::default();
       HashSet::with_hasher(fnv)
}

fn iterNeighbors<F>(mut f: F, (i, j): (i32, i32)) -> ()
    where F: FnMut((i32, i32)) -> ()
{
    f((i-1, j));
    f((i+1, j));
    f((i, j-1));
    f((i, j+1));
}

fn nthLoop(n: i32, s1: Set, s2: Set) -> Set {
    if n == 0 {
        return s1;
    } else {
        let mut s0 = Empty();
        for &p in &s1 {
            let add = |p| {
                if !(s1.contains(&p) || s2.contains(&p)) {
                    s0.insert(p);
                }
            };
            iterNeighbors(add, p);
        }
        drop(s2);
        return nthLoop(n-1, s0, s1);
    }
}

fn nth(n: i32, p: (i32, i32)) -> Set {
    let mut s1 = Empty();
    s1.insert(p);
    let s2 = Empty();
    nthLoop(n, s1, s2)
}

fn main() {
    let s = nth(2000, (0, 0));
    println!("{}", s.len());
}
