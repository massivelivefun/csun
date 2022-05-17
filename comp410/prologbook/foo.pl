  %% isInteger(1).
%% isInteger(2).
%% isInteger(3).

main :- 
	isName(alice).

isInteger(X) :-
	X = 1;
	X = 2;
	X = 3.

isName(alice).
isName(bob).

isOne(1).

isTwo(2).

%% areEqual(1, 1).
%% areEqual(2, 2).

areEqual(X, X).

tripleEqual(X, X, X).

factorial(0, 1).
factorial(N, Result) :-
	NMinusOne is N - 1,
	factorial(NMinusOne, Rest),
	Result is N * Rest.

myBetween(Min, Max, Min) :-
	Min =< Max.
myBetween(Min, Max, Result) :-
	Min =< Max,
	NewMin is Min + 1,
	myBetween(NewMin, Max, Result).

fib(0,0).
fib(1,1).
fib(N, Result) :-
	N > 1,
	NMinusOne is N-1,
	NMinusTwo is N-2,
	fib(NMinusOne, Rest1),
	fib(NMinusTwo, Rest2),
	Result is Rest1 + Rest2.

cost(soda, 2).
cost(chips, 2).
cost(hot_dog, Result) :-
	cost(soda, SodaCost),
	Result is SodaCost * 2.
cost(OfficeSupplies, 2) :-
	office_supplies(OfficeSupplies).
cost(cold_medicine, 7).

food(soda).
food(chips).
food(hot_dog).

office_supplies(pencils).
office_supplies(pens).

test(123).
test(foo).

%% List: cons(Element, List) | nil
%% myLength: List, Length
myLength(nil, 0).
myLength(cons(_, Rest), Result) :-
	myLength(Rest, RestLength),
	Result is RestLength + 1.

%% myLength(cons(1, cons(2, cons(3, nil))), Len).

%% myAppend: List1, List2, ResultList
%% myAppend()

mortal(X) :-
	person(X).

person(socrates).
person(plato).

%% InputList1, InputList2, OutputList
%% base case
%% myAppend([], List, List).
%% myAppend(List, [], List).
%% recursive case
%% myAppend([Head|Tail], Input2, [Head|RecursiveOutput]) :-
%% 	myAppend(Tail, Input2, RecursiveOutput).
	
%% myAppend(Input1, Input2, Output) :-
%% 	Input1 = [Head|Tail],
%% 	myAppend(Tail, Input2, RecursiveOutput),
%% 	Output = [Head|RecursiveOutput].

myLength1([], 0).
myLength1([_|Tail], Length) :-
	myLength1(Tail, TailLength),
	Length is TailLength + 1.

myLength2(List, Length) :-
	myLength2(List, 0, Length).

%% myLength2: List, Accumulator, Result
myLength2([], Accum, Accum).
myLength2([_|Tail], Accum, Result) :-
	NewAccum is Accum + 1,
	myLength2(Tail, NewAccum, Result).

%% October 7th, 2019
%% selectOne: List, Item, ResultList
selectOne([Head|Tail], Head, Tail).
selectOne([Head|Tail], Selected, Remainder) :-
	selectOne(Tail, Selected, TailRemainder),
	Remainder = [Head | TailRemainder].

%% allPairs: InputList, ListOfPairs
allPairs([],[]).
allPairs(List, [[FirstItem, SecondItem]|RestResult]) :-
	selectOne(List, FirstItem, RestItems1),
	selectOne(RestItems1, SecondItem, RestItems2),
	allPairs(RestItems2, RestResult).

%% sumAll
sumAll([], 0).
sumAll([Head|Tail], Sum) :-
	sumAll(Tail, TempSum),
	Sum is Head + TempSum.

%% sublist
sublist([],[]).
sublist([Head, Tail], Result) :-
	Result = [Head|Rest],
	sublist(Tail, Rest).
sublist([_|Tail], Result) :-
	sublist(Tail, Result).

%% sumAllAccum
sumAllAccum(List, Sum) :-
	sumAllAccum(List, 0, Sum).

sumAllAccum([], Accum, Accum).
sumAllAccum([Head|Tail], Accum, SumResult) :-
	NewAccum is Head + Accum,
	sumAllAccum(Tail, NewAccum, SumResult).

%% reverse
%% reverse([],[]).
myReverse(List, ResultList) :-
	myReverse(List, [], ResultList).

myReverse([], Accum, Accum).
myReverse([Head|Tail], Accum, Result) :-
	myReverse(Tail, [Head|Accum], Result).

%% October 14, 2019

flight(lax, sea, 1).
flight(sea, lax, 2).
flight(pdx, sea, 3).
flight(sea, pdx, 4).

%% flightPath: StartingAirport, EndingAirport, ListofFlights
flightPath(Start, End, [FlightNum]) :-
	flight(Start, End, FlightNum).
flightPath(Start, End, [FlightNum|Rest]) :-
	flight(Start, Connection, FlightNum),
	flightPath(Connection, End, Rest).

%% uniqueFlightPath: StartingAirport, EndingAirport, Traveled, ListOfFlights
uniqueFlightPath(Start, End, Traveled, [FlightNum]) :-
	flight(Start, End, FlightNum),
	%% negation as failure
	\+ member(End, Traveled).
uniqueFlightPath(Start, End, Traveled, [FlightNum | Rest]) :-
	flight(Start, Connection, FlightNum),
	\+ member(Connection, Traveled),
	uniqueFlightPath(Connection, End, [Connection | Traveled], Rest).

%% uniqueFlightPath: StartingAirport, EndingAirport, Traveled, ListOfFlights
uniqueFlightPath(Start, End, Result) :-
	uniqueFlightPath(Start, End, [Start], Result).

myLength3([], 0).
myLength3([_|Tail], Result) :-
	myLength3(Tail, TailResult),
	Result is TailResult + 1.

buildList([], 0).
buildList([_|Tail], Len) :-
	Len > 0,
	NewLen is Len - 1,
	buildList(Tail, NewLen).

myLength4(List, Len) :-
	var(List),
	nonvar(List),
	buildList(List, Len).
myLength4(List, Len) :-
	\+ (var(List), nonvar(Len)),
	myLength3(List, Len).

func(0, 2).
func(1, 3).
func(N, Result) :-
	N > 1,
	NMinusOne is N - 1,
	NMinusTwo is N - 2,
	func(NMinusOne, R1),
	func(NMinusTwo, R2),
	Result is ((3 * R1) + (4 * R2)).

evensBetween(Start, End, Start) :-
	Start =< End,
	0 is mod(Start, 2).
evenBetween(Start, End, Other) :-
	Start =< End,
	NewStart is Start + 1,
	evensBetween(NewStart, End, Other).

proc(List, Result) :-
	proc(List, 0, Result).
proc([], Accum, Accum).
proc([_|Tail], Accum, Result) :-
	NewAccum is Accum + 1,
	proc(Tail, NewAccum, Result).

isPrime(Number) :-
	StartDivisor is floor(sqrt(Number)),
	isPrime(StartDivisor, Number).

isPrime(1, _).
isPrime(Divisor, Number) :-
	Divisor > 1,
	N is mod(Number, Divisor),
	((N = 0, fail);
	 (N > 0,
	 	NewDivisor is Divisor - 1,
	 	isPrime(NewDivisor, Number))).

%% lastElement([Head|[]], Head).
%% ?- [1|[]] = [1].
lastElement([Head], Head).
lastElement([_|Tail], Element) :-
	lastElement(Tail, Element).

myNth0(0, [Head|_], Head).
myNth0(Index, [_|Tail], Result) :-
	Index > 0,
	NewIndex is Index - 1,
	myNth0(NewIndex, Tail, Result).

%% makeList: Length, Element, List
makeList(0, _, []).
makeList(N, Element, [Element|Rest]) :-
	N > 0,
	NewN is N - 1,
	makeList(NewN, Element, Rest).

%% makeListAtMost: Length, Element, List
makeListAtMost(N, _, []) :-
	N >= 0.
makeListAtMost(N, Element, [Element|Rest]) :-
	N > 0,
	NewN is N - 1,
	makeListAtMost(NewN, Element, Rest).

%% n^2 time complexity
%% myReverse: List, ReversedList
%% myReverse([],[]).
%% myReverse([Head|Tail], Result) :-
%% 	myReverse(Tail, TailReversed),
%% 	append(TailReversed, [Head], Result).

efficientReverse([], Accum, Accum).
efficientReverse([Head|Tail], Accum, Result) :-
	efficientReverse(Tail, [Head|Accum], Result).

%% foo: Input (N), Output
foo(0, 2).
foo(1, 3).
foo(N, Output) :-
	N > 1,
	NMinusOne is N - 1,
	NMinusTwo is N - 2,
	foo(NMinusOne, R1),
	foo(NMinusTwo, R2),
	Output is (3 * R1) + (4 * R2).

foo(1) :- !.
foo(2).
foo(3).

% green cut
% red cut
% blue cut

someProcedure(Param) :-
	condition(Param),
	doSomething(Param).
someProcedure(Param) :-
	\+ condition(Param),
	doSomethingElse(Param).

% using implication
someProcedure(Param) :-
	condition(Param) ->
		doSomething(Param);
		doSomethingElse(Param).

% using cut
someProcedure(Param) :-
	condition(Param),
	!,
	doSomething(Param).
someProcedure(Param) :-
	doSomethingElse(Param).

%% myAppend([], List, List).
%% myAppend([H|T], List, List).

iterateOver([], _).
iterateOver([Head|Tail], Procedure) :-
	call(Procedure, Head),
	iterateOver(Tail, Procedure).

myAppend([], List, List).
myAppend([Head|Tail], List, [Head|Rest]) :-
	myAppend(Tail, List, Rest).

%% i \in Integer
%% b \in Boolean ::= true | false
%% e \in Expression ::= integer(i) |
%% 						boolean(b) |
%% 						lessThan(e1, e2) |
%% 						and(e1, e2) |
%% 						if(e1, e2, e3) |
%% 						print(e)

and(false, _, false).
and(_, false, false).
and(true, true, true).

%% eval: AST, Result
eval(integer(N), int(N)).
eval(boolean(B), bool(B)).
eval(lessThan(E1, E2), bool(Result)) :-
	eval(E1, int(E1Int)),
	eval(E2, int(E2Int)),
	(E1Int < E2Int ->
		Result = true;
		Result = false).
eval(and(E1, E2), bool(Result)) :-
	eval(E1, bool(E1Bool)),
	eval(E2, bool(E2Bool)),
	and(E1Bool, E2Bool, Result).
eval(if(Guard, IfTrue, IfFalse), Result) :-
	eval(Guard, bool(GuardResult)),
	(GuardResult == true ->
		eval(IfTrue, Result);
		eval(IfFalse, Result)).
eval(print(E), void) :-
	eval(E, Result),
	writeln(Result).


%% interpreter
interpret(true) :- !.
interpret((A is B)) :-
	!,
	A is B.
interpret((A = B)) :-
	!,
	A = B.
interpret((A, B)) :-
	!,
	interpret(A),
	interpret(B).
interpret((A; B)) :-
	!,
	(interpret(A);
	 interpret(B)).
interpret(\+(A)) :-
	!,
	\+ interpret(A).
interpret(Call) :-
	clause(Call, Body),
	interpret(Body).

interp2(true) :- !.
interp2((A, B)) :-
	!,
	interp2(A),
	interp2(B).
interp2(Call) :-
	format('Call: ~w~n', [Call]),
	clause(Call, Body),
	interp2(Body),
	format('Return: ~w~n', [Call]).

%% building trace

%% interp3(true, _) :- !.
%% interp3((A, B), N) :-
%% 	!,
%% 	interp3(A, N),
%% 	interp3(B, N).
%% interp3(Call) :-
%% 	interp3(Call, 0).

%% interp3(Call, N) :-
%% 	format('Call: (~w): ~w~n', [N, Call]),
%% 	clause(Call, Body),
%% 	NewN is N + 1,
%% 	interp3(Body, NewN),
%% 	format('Exit: (~w): ~w~n', [N, Call]).

decBound(In, Out) :-
	In > 0,
	Out is In - 1.

gen(true).
gen(false).
gen(Bound, and(E1, E2)) :-
	decBound(Bound, NewBound),
	gen(NewBound, E1),
	gen(NewBound, E2).
gen(Bound, or(E1, E2)) :-
	decBound(Bound, NewBound),
	gen(NewBound, E1),
	gen(NewBound, E2).
gen(Bound, not(E)) :-
	decBound(Bound, NewBound),
	gen(NewBound, E).

interp(true) :- !.
interp((A, B)) :-
	!,
	interp(A),
	interp(B).
interp((A is B)) :-
	!,
	A is B.
interp((A > B)) :-
	!,
	A > B.
interp(Call) :-
	findall(pair(Call, Body), clause(Call, Body), CallBodyPairs),
	random_permutation(CallBodyPairs, Mutated),
	member(pair(Call, Body), Mutated),
	interp(Call, Body).

%% November 6th, 2019
%% Peano Arithmetic

%% n is a element of the Set of Natural Numbers ::= zero | successor(n)

add(zero, Result, Result).
add(succ(Left), Right, Result) :-
	add(Left, succ(Right), Result).

%% add(succ(Left), Right, succ(Rest)) :-
%% 	add(Left, Right, Rest).

lt(zero, succ(_)).
lt(succ(Left), succ(Right)) :-
	lt(Left, Right).

lte(zero, zero).
lte(zero, succ(_)).
lte(succ(Left), succ(Right)) :-
	lt(Left, Right).

lte(N, N).
lte(N, M) :-
	lt(N, M).

allNatNums(Left, Right, Result) :-
	add(Left, Right, Result),
	lte(Left, Right).

%% Idea: variables in the is which don't have values are
%% 		instantiated to fixed values

instantiateList([], _, _).
instantiateList([Head|Tail], Min, Max) :-
	between(Min, Max, Head),
	instantiateList(Tail, Min, Max).

instantiate(Term, Min, Max) :-
	term_variables(Term, Variables),
	instanitateList(Variables, Min, Max).

relational((_ < _)).
relational((_ =< _)).
relational((_ > _)).
relational((_ >= _)).

%% interp(Term, Min, Max)
interp(true, _, _) :- !.
interp(Relational, Min, Max) :-
	relational(Relational),
	!,
	instantiate(Relational, Min, Max),
	call(Relational).
interp((A is B), Min, Max) :-
	!,
	instantiate(B, Min, Max),
	A is B.
interp((A, B), Min, Max) :-
	!,
	interp(A, Min, Max),
	interp(B, Min, Max).
interp(Call, Min, Max) :-
	clause(Call, Body),
	interp(Body, Min, Max).
% old code for relational handling
%% interp((A < B), Min, Max) :-
%% 	!,
%% 	instantiate((A < B), Min, Max),
%% 	A < B.
%% interp((A =< B), Min, Max) :-
%% 	!,
%% 	instantiate((A =< B), Min, Max),
%% 	A =< B.

genSucc(0, zero).
genSucc(Num, succ(Rest)) :-
	Num > 0,
	NewNum is Num - 1,
	genSucc(NewNum, Rest).

% November 13, 2019

%% allEqual([]).
%% allEqual([H|T]) :-
%% 	helper(T, H).
%% helper([], _).
%% helper([H|T], H) :-
%% 	helper(T, H).

allEqual([]).
allEqual([_]).
allEqual([A, A|Rest]) :-
	allEqual([A|Rest]).

takeUpTo(N, _, []) :-
	N >= 0.
takeUpTo(N, [H|T], [H|Rest]) :-
	N > 0,
	NewN is N - 1,
	takeUpTo(NewN, T, Rest).

% November 18, 2019