:- module foo.

:- interface.
:- import_module io.
:- pred main(io::di, io::uo) is det.

:- implementation.

:- import_module int.
:- import_module solutions.

:- pred foo(int).
:- mode foo(in) is semidet.
:- mode foo(out) is multi.
foo(1).
foo(2).
foo(3).

main(!IO) :-
	solutions(
		(pred(X::out) is nondet :-
			foo(X)),
		AllSolutions),
	io.write(AllSolutions, !IO).
