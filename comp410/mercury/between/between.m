:- module between.

:- interface.
:- import_module io.
:- pred main(io::di, io::uo) is det.

:- type bool ---> yes ; no.

% exp ::- true | false | and(exp, exp) | or(exp, exp)
:- type exp --->
	truth ;
	falsehood ;
	and(exp, exp) ;
	or(exp, exp).

:- type expression --->
	integer(int) ;
	unop(unaryOperation, expression) ;
	binop(expression, binaryOperation, expression).

:- type unaryOperation ---> negate.

:- type binaryOperation ---> plus ; times.

:- implementation.

:- import_module int.
:- import_module solutions.
:- import_module list.

:- pred between(int, int, int).
:- mode between(in, in, out) is nondet.
:- mode between(in, in, in) is semidet.

between(Min, Max, Min) :-
	Min =< Max.

between(Min, Max, Result) :-
	Max > Min,
	between(Min + 1, Max, Result).

%		first(list(int), int)
%% :- pred first(list(T), T).
%% :- mode first(in, out) is semidet.
%% first([Head|_], Head).

%		first(list(int), int)
:- pred first(list(int), int).
:- mode first(in, out) is det.
first([], 0).
first([Head|_], Head).

:- pred myLast(list(int), int).
:- mode myLast(in, out) is nondet.
myLast([Last|[]], Last).
myLast([_|Tail], Result) :-
	myLast(Tail, Result).

:- pred sumList(list(int), int).
:- mode sumList(in, out) is det.
sumList([], 0).
sumList([Head|Tail], Result) :-
	sumList(Tail, Rest),
	Result is Rest + Head.

:- pred andHelper(bool, bool, bool).
:- mode andHelper(in, in, out).
andHelper(yes, yes, yes).
andHelper(yes, no, no).
andHelper(no, yes, no).
andHelper(no, no, no).

:- pred orHelper(bool, bool, bool).
:- mode orHelper(in, in, out).
orHelper(yes, yes, yes).
orHelper(yes, no, yes).
orHelper(no, yes, yes).
orHelper(no, no, no).

:- pred evaluate(exp, bool).
:- mode evaluate(in, out) is det.
evaluate(truth, yes).
evaluate(falsehood, no).
evaluate(and(E1, E2), Result) :-
	evaluate(E1, Left),
	evaluate(E2, Right),
	andHelper(Left, Right, Result).
evaluate(or(E1, E2), Result) :-
	evaluate(E1, Left),
	evaluate(E2, Right),
	orHelper(Left, Right, Result).

:- pred extract(list(int), list(int)).
:- mode extract(in, out) is det.
extract([], []).
extract([Head|Tail], Result) :-
	(if Head < 5 then
		(Result = [Head|Rest],
		extract(Tail, Rest))
	else
		extract(Tail, Result)).

:- pred myMap(list(A), pred(A, B), list(B)).
:- mode myMap(in, pred(in, out) is det, out) is det.
myMap([], _, []).
myMap([HeadA|TailAs], P, [HeadB|TailBs]) :-
	call(P, HeadA, HeadB),
	myMap(TailAs, P, TailBs).

:- pred filter(list(T), pred(T), list(T)).
:- mode filter(in, pred(in) is semidet, out) is det.
filter([], _, []).
filter([Head|Tail], Pred, Result) :-
	if call(Pred, Head) then
		(Result = [Head|Rest],
		filter(Tail, Pred, Rest))
	else
		filter(Tail, Pred, Result).

%% :- pred parition(list(int), pred(Num::in), list(int), list(int)) is 
	
main(!IO) :-
	solutions(
		(pred(X::out) is nondet :-
			% true && (false || false)
			%% evaluate(and(truth, or(falsehood, falsehood)), X)
			filter([1, 2, 3],
				(pred(In::in) is ))
			%% extract([9, 2, 6, 5], X)
			%% between(3, 5, X)
			%% myLast([1, 2], X)
			%% sumList([1, 2, 3], X)
			),
		AllSolutions),
	io.write(AllSolutions, !IO).
