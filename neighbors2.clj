; courtesy @didibus

(ns hash-set-bench
  (:import [java.util HashSet]))

(set! *unchecked-math* true)

(deftype Point [^long i ^long j]
  Object
  (equals [this that] (and (= (.i this) (.i ^Point that))
                           (= (.j this) (.j ^Point that))))
  (hashCode [this] (+ (.i this) (* 4000 (.j this)))))

(defn iter-neighbors [f ^Point p]
  (let [i ^long (.i p)
        j ^long (.j p)]
    (f (Point. (dec i) j))
    (f (Point. (inc i) j))
    (f (Point. i (dec j)))
    (f (Point. i (inc j)))))

(defn nth* [^long n p]
  (loop [n n
         s1 (HashSet. [p])
         s2 (HashSet.)]
    (if (zero? n)
      s1
      (let [s0 (HashSet.)]
        (letfn [(add [p]
                     (when (not (or (.contains s1 p) (.contains s2 p)))
                       (.add s0 p)))]
               (doseq [p s1] (iter-neighbors add p))
               (recur (dec n) s0 s1))))))

(printf "result is %d\n" (count (nth* 2000 (Point. 0 0))))
