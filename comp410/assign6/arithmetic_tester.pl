% ---AST Definition---
%
% There are four kinds of expressions:
%
% 1.) Numbers, which represent a numeric literal.  These are
%     represented with a structure named number with arity 1,
%     containing the following:
%     1.1.) A Prolog number, e.g., 42
%
% 2.) Arithmetic addition, which represents the idea of adding
%     two subexpressions.  This is represented with a structure
%     named plus with arity 2, containing the following:
%     2.1.) An expression, according to this AST definition
%     2.2.) Another expression according to this AST definition
%
% 3.) Arithmetic subtraction, which represents the idea of subtracting
%     one subexpression from another.  This is represented with a
%     structure named minus with arity 2, containing the following:
%     3.1.) An expression, according to this AST definition
%     3.2.) Another expression according to this AST definition
%     The second expression is intended to be subtracted from the first
%     expression.
%
% 4.) Arithmetic multiplication, which represents the idea of multiplying
%     two subexpressions together.  This is represented with a structure
%     named mult of arity 2, containing the following:
%     4.1.) An expression, according to this AST definition
%     4.2.) Another expression according to this AST definition
%
% 5.) Arithmetic negation, which represents the idea of negating a
%     subexpression.  This is represented with a structure named
%     negate of arity 1, containing the following:
%     5.1.) An expression, according to this AST definition
%
% A more compact representation of all the above information is shown
% below in a variant of a BNF grammar:
%
% n ∈ PrologNumber
% e ∈ Expression ::= number(n) | plus(e1, e2) | minus(e1, e2) |
%                    mult(e1, e2) | negate(e)

% ---Code---
%

% decBound/2: Input, Output
decBound(In, Out) :-
    In > 0,
    Out is In - 1.

% TODO: Write a procedure named makeTest
% that takes:
% 1.) The maximum depth of an AST, not including the
%     leaves
% 2.) An AST
%
% For the leaf nodes, always select 0 as the number
% to use.
%
% You may define helper procedures as you see fit,
% and the order in which you generate solutions is
% irrelevant.
% Example queries follow:
% ?- makeTest(0, T).
% T = number(0).
%
% ?- makeTest(1, T).
% T = number(0) ;
% T = plus(number(0), number(0)) ;
% T = minus(number(0), number(0)) ;
% T = mult(number(0), number(0)) ;
% T = negate(number(0)) ;
%

% makeTest/2: AST, number(0)
makeTest(_, number(0)).
% makeTest/2: AST, plus(e1, e2)
makeTest(AST, plus(E1, E2)) :-
    decBound(AST, NewAST),
    makeTest(NewAST, E1),
    makeTest(NewAST, E2).
% makeTest/2: AST, minus(e1, e2)
makeTest(AST, minus(E1, E2)) :-
    decBound(AST, NewAST),
    makeTest(NewAST, E1),
    makeTest(NewAST, E2).
% makeTest/2: AST, mult(e1, e2)
makeTest(AST, mult(E1, E2)) :-
    decBound(AST, NewAST),
    makeTest(NewAST, E1),
    makeTest(NewAST, E2).
% makeTest/2: AST, negate(e1)
makeTest(AST, negate(E1)) :-
    decBound(AST, NewAST),
    makeTest(NewAST, E1).

% TODO: Write a procedure named makeTestWithNums
% that takes:
% 1.) The maximum depth of an AST, not including the
%     leaves
% 2.) A list of numbers which may be used in leaf nodes
% 3.) An AST
%
% For the leaf nodes, nondeterministically select from
% the choices in the second parameter.  You can assume this
% will always contain a non-empty list.
%
% You may define helper procedures as you see fit,
% and the order in which you generate solutions is
% irrelevant.  You may reuse helper procedures you
% defined previously.
%
% Example queries follow:
% ?- makeTestWithNums(0, [1, 2, 3], T).
% T = number(1) ;
% T = number(2) ;
% T = number(3) .
%
% ?- makeTestWithNums(1, [2, 3], T).
% T = number(2) ;
% T = number(3) ;
% T = plus(number(2), number(2)) ;
% T = plus(number(2), number(3)) ;
% T = plus(number(3), number(2)) ;
% T = plus(number(3), number(3)) ;
% T = minus(number(2), number(2)) ;
% T = minus(number(2), number(3)) ;
% T = minus(number(3), number(2)) ;
% T = minus(number(3), number(3)) ;
% T = mult(number(2), number(2)) ;
% T = mult(number(2), number(3)) ;
% T = mult(number(3), number(2)) ;
% T = mult(number(3), number(3)) ;
% T = negate(number(2)) ;
% T = negate(number(3)) .

% cycleThroughList/2: List, number(Head)
cycleThroughList([Head|_], number(Head)).
% cycleThroughList/2: List, Tree
cycleThroughList([_|Tail], T) :-
    cycleThroughList(Tail, T).
% makeTestWithNums/3: AST, List, Tree
makeTestWithNums(_, List, T) :-
    cycleThroughList(List, T).
% makeTestWithNums/3: AST, List, plus(e1, e2)
makeTestWithNums(AST, List, plus(E1, E2)) :-
    decBound(AST, NewAST),
    makeTestWithNums(NewAST, List, E1),
    makeTestWithNums(NewAST, List, E2).
% makeTestWithNums/3: AST, List, minus(e1, e2)
makeTestWithNums(AST, List, minus(E1, E2)) :-
    decBound(AST, NewAST),
    makeTestWithNums(NewAST, List, E1),
    makeTestWithNums(NewAST, List, E2).
% makeTestWithNums/3: AST, List, mult(e1, e2)
makeTestWithNums(AST, List, mult(E1, E2)) :-
    decBound(AST, NewAST),
    makeTestWithNums(NewAST, List, E1),
    makeTestWithNums(NewAST, List, E2).
% makeTestWithNums/3: AST, List, negate(e1)
makeTestWithNums(AST, List, negate(E1)) :-
    decBound(AST, NewAST),
    makeTestWithNums(NewAST, List, E1).

% ---Begin Testing-Related Code---

% The test suite for makeTest can be run like so:
%
% ?- testMakeTest.
%
% It should succeed.  If it doesn't, you can figure
% out which test is failing by tracing makeTestTest.
%
% The test suite for makeTestWithNums can be run
% like so:
%
% ?- testMakeTestWithNums.
%
% It should succeed.  If it doesn't, you can figure
% out which test is failing by tracing makeTestWithNumsTest.
%

makeTestTest(Bound, Expected) :-
    sort(Expected, Sorted),
    setof(T, makeTest(Bound, T), Sorted).

testMakeTest :-
    makeTestTest(0, [number(0)]),
    makeTestTest(1, [number(0),
                     plus(number(0),number(0)),
                     minus(number(0),number(0)),
                     mult(number(0),number(0)),
                     negate(number(0))]),
    makeTestTest(2, [number(0),
                     plus(number(0),number(0)),
                     plus(number(0),plus(number(0),number(0))),
                     plus(number(0),minus(number(0),number(0))),
                     plus(number(0),mult(number(0),number(0))),
                     plus(number(0),negate(number(0))),
                     plus(plus(number(0),number(0)),number(0)),
                     plus(plus(number(0),number(0)),plus(number(0),number(0))),
                     plus(plus(number(0),number(0)),minus(number(0),number(0))),
                     plus(plus(number(0),number(0)),mult(number(0),number(0))),
                     plus(plus(number(0),number(0)),negate(number(0))),
                     plus(minus(number(0),number(0)),number(0)),
                     plus(minus(number(0),number(0)),plus(number(0),number(0))),
                     plus(minus(number(0),number(0)),minus(number(0),number(0))),
                     plus(minus(number(0),number(0)),mult(number(0),number(0))),
                     plus(minus(number(0),number(0)),negate(number(0))),
                     plus(mult(number(0),number(0)),number(0)),
                     plus(mult(number(0),number(0)),plus(number(0),number(0))),
                     plus(mult(number(0),number(0)),minus(number(0),number(0))),
                     plus(mult(number(0),number(0)),mult(number(0),number(0))),
                     plus(mult(number(0),number(0)),negate(number(0))),
                     plus(negate(number(0)),number(0)),
                     plus(negate(number(0)),plus(number(0),number(0))),
                     plus(negate(number(0)),minus(number(0),number(0))),
                     plus(negate(number(0)),mult(number(0),number(0))),
                     plus(negate(number(0)),negate(number(0))),
                     minus(number(0),number(0)),
                     minus(number(0),plus(number(0),number(0))),
                     minus(number(0),minus(number(0),number(0))),
                     minus(number(0),mult(number(0),number(0))),
                     minus(number(0),negate(number(0))),
                     minus(plus(number(0),number(0)),number(0)),
                     minus(plus(number(0),number(0)),plus(number(0),number(0))),
                     minus(plus(number(0),number(0)),minus(number(0),number(0))),
                     minus(plus(number(0),number(0)),mult(number(0),number(0))),
                     minus(plus(number(0),number(0)),negate(number(0))),
                     minus(minus(number(0),number(0)),number(0)),
                     minus(minus(number(0),number(0)),plus(number(0),number(0))),
                     minus(minus(number(0),number(0)),minus(number(0),number(0))),
                     minus(minus(number(0),number(0)),mult(number(0),number(0))),
                     minus(minus(number(0),number(0)),negate(number(0))),
                     minus(mult(number(0),number(0)),number(0)),
                     minus(mult(number(0),number(0)),plus(number(0),number(0))),
                     minus(mult(number(0),number(0)),minus(number(0),number(0))),
                     minus(mult(number(0),number(0)),mult(number(0),number(0))),
                     minus(mult(number(0),number(0)),negate(number(0))),
                     minus(negate(number(0)),number(0)),
                     minus(negate(number(0)),plus(number(0),number(0))),
                     minus(negate(number(0)),minus(number(0),number(0))),
                     minus(negate(number(0)),mult(number(0),number(0))),
                     minus(negate(number(0)),negate(number(0))),
                     mult(number(0),number(0)),
                     mult(number(0),plus(number(0),number(0))),
                     mult(number(0),minus(number(0),number(0))),
                     mult(number(0),mult(number(0),number(0))),
                     mult(number(0),negate(number(0))),
                     mult(plus(number(0),number(0)),number(0)),
                     mult(plus(number(0),number(0)),plus(number(0),number(0))),
                     mult(plus(number(0),number(0)),minus(number(0),number(0))),
                     mult(plus(number(0),number(0)),mult(number(0),number(0))),
                     mult(plus(number(0),number(0)),negate(number(0))),
                     mult(minus(number(0),number(0)),number(0)),
                     mult(minus(number(0),number(0)),plus(number(0),number(0))),
                     mult(minus(number(0),number(0)),minus(number(0),number(0))),
                     mult(minus(number(0),number(0)),mult(number(0),number(0))),
                     mult(minus(number(0),number(0)),negate(number(0))),
                     mult(mult(number(0),number(0)),number(0)),
                     mult(mult(number(0),number(0)),plus(number(0),number(0))),
                     mult(mult(number(0),number(0)),minus(number(0),number(0))),
                     mult(mult(number(0),number(0)),mult(number(0),number(0))),
                     mult(mult(number(0),number(0)),negate(number(0))),
                     mult(negate(number(0)),number(0)),
                     mult(negate(number(0)),plus(number(0),number(0))),
                     mult(negate(number(0)),minus(number(0),number(0))),
                     mult(negate(number(0)),mult(number(0),number(0))),
                     mult(negate(number(0)),negate(number(0))),
                     negate(number(0)),
                     negate(plus(number(0),number(0))),
                     negate(minus(number(0),number(0))),
                     negate(mult(number(0),number(0))),
                     negate(negate(number(0)))]).

makeTestWithNumsTest(Bound, Nums, Expected) :-
    sort(Expected, Sorted),
    setof(T, makeTestWithNums(Bound, Nums, T), Sorted).

testMakeTestWithNums :-
    makeTestWithNumsTest(0, [1], [number(1)]),
    makeTestWithNumsTest(0, [1, 2, 3], [number(1),
                                        number(2),
                                        number(3)]),
    makeTestWithNumsTest(1, [2], [number(2),
                                  plus(number(2),number(2)),
                                  minus(number(2),number(2)),
                                  mult(number(2),number(2)),
                                  negate(number(2))]),
    makeTestWithNumsTest(1, [2, 3], [number(2),
                                     number(3),
                                     plus(number(2),number(2)),
                                     plus(number(2),number(3)),
                                     plus(number(3),number(2)),
                                     plus(number(3),number(3)),
                                     minus(number(2),number(2)),
                                     minus(number(2),number(3)),
                                     minus(number(3),number(2)),
                                     minus(number(3),number(3)),
                                     mult(number(2),number(2)),
                                     mult(number(2),number(3)),
                                     mult(number(3),number(2)),
                                     mult(number(3),number(3)),
                                     negate(number(2)),
                                     negate(number(3))]),
    makeTestWithNumsTest(2, [2], [number(2),
                                  plus(number(2),number(2)),
                                  plus(number(2),plus(number(2),number(2))),
                                  plus(number(2),minus(number(2),number(2))),
                                  plus(number(2),mult(number(2),number(2))),
                                  plus(number(2),negate(number(2))),
                                  plus(plus(number(2),number(2)),number(2)),
                                  plus(plus(number(2),number(2)),plus(number(2),number(2))),
                                  plus(plus(number(2),number(2)),minus(number(2),number(2))),
                                  plus(plus(number(2),number(2)),mult(number(2),number(2))),
                                  plus(plus(number(2),number(2)),negate(number(2))),
                                  plus(minus(number(2),number(2)),number(2)),
                                  plus(minus(number(2),number(2)),plus(number(2),number(2))),
                                  plus(minus(number(2),number(2)),minus(number(2),number(2))),
                                  plus(minus(number(2),number(2)),mult(number(2),number(2))),
                                  plus(minus(number(2),number(2)),negate(number(2))),
                                  plus(mult(number(2),number(2)),number(2)),
                                  plus(mult(number(2),number(2)),plus(number(2),number(2))),
                                  plus(mult(number(2),number(2)),minus(number(2),number(2))),
                                  plus(mult(number(2),number(2)),mult(number(2),number(2))),
                                  plus(mult(number(2),number(2)),negate(number(2))),
                                  plus(negate(number(2)),number(2)),
                                  plus(negate(number(2)),plus(number(2),number(2))),
                                  plus(negate(number(2)),minus(number(2),number(2))),
                                  plus(negate(number(2)),mult(number(2),number(2))),
                                  plus(negate(number(2)),negate(number(2))),
                                  minus(number(2),number(2)),
                                  minus(number(2),plus(number(2),number(2))),
                                  minus(number(2),minus(number(2),number(2))),
                                  minus(number(2),mult(number(2),number(2))),
                                  minus(number(2),negate(number(2))),
                                  minus(plus(number(2),number(2)),number(2)),
                                  minus(plus(number(2),number(2)),plus(number(2),number(2))),
                                  minus(plus(number(2),number(2)),minus(number(2),number(2))),
                                  minus(plus(number(2),number(2)),mult(number(2),number(2))),
                                  minus(plus(number(2),number(2)),negate(number(2))),
                                  minus(minus(number(2),number(2)),number(2)),
                                  minus(minus(number(2),number(2)),plus(number(2),number(2))),
                                  minus(minus(number(2),number(2)),minus(number(2),number(2))),
                                  minus(minus(number(2),number(2)),mult(number(2),number(2))),
                                  minus(minus(number(2),number(2)),negate(number(2))),
                                  minus(mult(number(2),number(2)),number(2)),
                                  minus(mult(number(2),number(2)),plus(number(2),number(2))),
                                  minus(mult(number(2),number(2)),minus(number(2),number(2))),
                                  minus(mult(number(2),number(2)),mult(number(2),number(2))),
                                  minus(mult(number(2),number(2)),negate(number(2))),
                                  minus(negate(number(2)),number(2)),
                                  minus(negate(number(2)),plus(number(2),number(2))),
                                  minus(negate(number(2)),minus(number(2),number(2))),
                                  minus(negate(number(2)),mult(number(2),number(2))),
                                  minus(negate(number(2)),negate(number(2))),
                                  mult(number(2),number(2)),
                                  mult(number(2),plus(number(2),number(2))),
                                  mult(number(2),minus(number(2),number(2))),
                                  mult(number(2),mult(number(2),number(2))),
                                  mult(number(2),negate(number(2))),
                                  mult(plus(number(2),number(2)),number(2)),
                                  mult(plus(number(2),number(2)),plus(number(2),number(2))),
                                  mult(plus(number(2),number(2)),minus(number(2),number(2))),
                                  mult(plus(number(2),number(2)),mult(number(2),number(2))),
                                  mult(plus(number(2),number(2)),negate(number(2))),
                                  mult(minus(number(2),number(2)),number(2)),
                                  mult(minus(number(2),number(2)),plus(number(2),number(2))),
                                  mult(minus(number(2),number(2)),minus(number(2),number(2))),
                                  mult(minus(number(2),number(2)),mult(number(2),number(2))),
                                  mult(minus(number(2),number(2)),negate(number(2))),
                                  mult(mult(number(2),number(2)),number(2)),
                                  mult(mult(number(2),number(2)),plus(number(2),number(2))),
                                  mult(mult(number(2),number(2)),minus(number(2),number(2))),
                                  mult(mult(number(2),number(2)),mult(number(2),number(2))),
                                  mult(mult(number(2),number(2)),negate(number(2))),
                                  mult(negate(number(2)),number(2)),
                                  mult(negate(number(2)),plus(number(2),number(2))),
                                  mult(negate(number(2)),minus(number(2),number(2))),
                                  mult(negate(number(2)),mult(number(2),number(2))),
                                  mult(negate(number(2)),negate(number(2))),
                                  negate(number(2)),
                                  negate(plus(number(2),number(2))),
                                  negate(minus(number(2),number(2))),
                                  negate(mult(number(2),number(2))),
                                  negate(negate(number(2)))]).
