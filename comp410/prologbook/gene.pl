male(ignacio).
male(leonardo).

male(dennis).
male(michael).
male('Ghenghis Khan').

female(martha).
female(salma).

female(diana).

%% A is the parent of B
parent(ignacio, leonardo).
parent(ignacio, salma).
parent(martha, leonardo).
parent(martha, salma).

parent(dennis, michael).
parent(dennis, diana).

mother(Mother, Child) :-
    parent(Mother, Child),
    female(Mother).

father(Father, Child) :-
    parent(Father, Child),
    male(Father).

son(Parent, Son) :-
    parent(Parent, Son),
    male(Son).

daughter(Parent, Daughter) :-
    parent(Parent, Daughter),
    female(Daughter).

siblings(First, Second) :-
    parent(M, Second),
    parent(M, First),
    parent(F, First),
    parent(F, Second).

siblings(Child) :-
    parent(Father, Child),
    parent(Father, X),
    parent(Mother, Child),
    parent(Mother, X).