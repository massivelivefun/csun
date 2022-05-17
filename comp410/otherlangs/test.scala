// ...: A
// ...: Iterator[A]

def unit[A](a: A): Iterator[A]

def mzero[A](): Iterator[A]

def mplus[A](
    it1: Iterator[A],
    it2: Iterator[A]): Iterator[A]

def bind[A, B](
    it: Iterator[A],
    f: A => Iterator[B]): Iterator[B]
