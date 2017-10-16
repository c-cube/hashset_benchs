#include <utility>
#include <unordered_set>
#include <iostream>

typedef std::pair<int, int> Pair;

struct PairHash {
  int operator()(const Pair& p) const {
    return p.first + p.second * 4000;
  }
};

typedef std::unordered_set<Pair, PairHash> Set;

inline bool contains(const Set& s, const Pair& p) {
  return s.find(p) != s.end();
}

template <typename Add>
void iter_neighbors(const Add& add, const Pair& p) {
  const int i = p.first;
  const int j = p.second;
  add({i-1, j});
  add({i+1, j});
  add({i, j-1});
  add({i, j+1});
}

const Set nth_loop(int n, Set& s1, Set& s2, Set& s0) {
  if (n == 0) {
    return s1;
  } else {
    auto add = [&](const Pair& p){
      if (!(contains(s1, p) || contains(s2, p))) {
        s0.insert(p);
      }
    };
    for (auto p : s1) {
      iter_neighbors(add, p);
    }
    s2.clear();
    return nth_loop(n-1, s0, s1, s2);
  }
}

Set nth(int n, const Pair& p) {
  Set s1;
  Set s2;
  Set s0;
  s1.insert(p);
  return nth_loop(n, s1, s2, s0);
}

int main(int argc, const char* argv[]) {
  Set s = nth(2000, {0, 0});
  std::cout << s.size() << std::endl;
}
