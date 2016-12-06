(ns hash-set-bench
  (:import [java.util HashSet]))

(set! *unchecked-math* true)

(deftype point-fast [^long i ^long j]
  Object
  (equals [this that] (and (= (.i this) (.i ^point-fast that))
                           (= (.j this) (.j ^point-fast that))))
  (hashCode [this] (+ (.i this) (* 4000 (.j this)))))

(defn iter-neighbors-fast [f ^point-fast p]
  (let [i ^long (.i p)
        j ^long (.j p)]
    (f (point-fast. (dec i) j))
    (f (point-fast. (inc i) j))
    (f (point-fast. i (dec j)))
    (f (point-fast. i (inc j)))))

(defn nth-fast [^long n p]
  (loop [n n
         s1 (doto (HashSet.) (.add p))
         s2 (HashSet.)]
    (if (zero? n)
      s1
      (let [s0 (HashSet. (* 4 (.size s1)))
            it (.iterator s1)]
        (letfn [(add [p]
                     (when (not (or (.contains s1 p) (.contains s2 p)))
                       (.add s0 p)))]
               (dotimes [_ (.size s1)] (iter-neighbors-fast add (.next it))))
        (recur (dec n) s0 s1)))))

(printf "result is %d\n" (count (nth-fast 2000 (point-fast. 0 0))))
