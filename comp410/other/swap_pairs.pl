swapPairs([],[]).
swapPairs([H1, H2|Tail], [H2, H1|Rest]) :-
	swapPairs(Tail, Rest).
