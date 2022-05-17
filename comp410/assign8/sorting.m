:- module sorting.

:- interface.
:- import_module list.

:- pred insertion_sort(list(int), list(int)).
:- mode insertion_sort(in, out) is det.

:- pred merge_sort(list(int), list(int)).
:- mode merge_sort(in, out) is det.

:- pred quick_sort(list(int), list(int)).
:- mode quick_sort(in, out) is det.

:- implementation.
:- import_module int.

% TODO: write your implementation code below.
% Stubs have been provided which compile, but fail tests.
% The only restriction is that you CANNOT use the sort
% procedures already available in the Mercury libraries
% (e.g., list.sort).  However, you can use anything else
% you want, including things like list.merge.

% INSERTION SORT HINTS:
% You had to implement this in Prolog as part of assignment 5.
% Porting this code to Mercury is likely the path of least
% resistance.

:- pred insertion_sort(list(int), list(int), list(int)).
:- mode insertion_sort(in, in, out) is det.

:- pred insert_sorted(list(int), int, list(int)).
:- mode insert_sorted(in, in, out) is det.

insertion_sort(List, Result) :-
	insertion_sort(List, [], Result).

insertion_sort([], List, List).
insertion_sort([Head|Tail], TempList, ResultList) :-
	insert_sorted(TempList, Head, SortedList),
	insertion_sort(Tail, SortedList, ResultList).

insert_sorted([], Element, [Element]).
insert_sorted([Head|Tail], Element, Result) :-
	if Head >= Element then
		(Result = [Element, Head|Tail])
	else
		(Result = [Head|Rest],
		insert_sorted(Tail, Element, Rest)).

% MERGE SORT HINTS:
% You will need to split the input list into two portions of
% approximately the same length.  You can either do this yourself,
% or make use of some of the routines in Mercury's list library
% (https://www.mercurylang.org/information/doc-release/mercury_library/list.html).
% Your split must operate in O(n) or less for merge sort to have the
% final time complexity of O(nlg(n)).
%
% You can either write your own merge, or use the one from Mercury's
% list library.

:- pred merge_sort(list(int), int, list(int)).
:- mode merge_sort(in, in, out) is det.

merge_sort(List, Result) :-
	list.length(List, Length),
	merge_sort(List, Length, Result).

merge_sort(List, Length, Result) :-
	if (Length > 1) then
		(NewLength = Length // 2,
		list.det_split_list(NewLength, List, LeftPortion, RightPortion),
		merge_sort(LeftPortion, NewLength, LeftSorted),
		merge_sort(RightPortion, (Length - NewLength), RightSorted),
		list.merge(LeftSorted, RightSorted, Result))
	else
		(Result = List).

% QUICK SORT HINTS:
% You do not need to be smart about choosing a pivot value; you can,
% for example, always pick the first value in the input list.
%
% It is possible to partition the list using procedures in Mercury's
% list library, or you can write your own.  It's ideal, though not
% required, to only perform a single pass through the list for
% the partitioning.  Whatever approach you take, your partitioning
% should operate in O(n) or less.
%
% A basic append will work for joining lists together at the end.
% Whatever method you pick, this should operate in O(n) or less.

:- pred split(int, list(int), list(int), list(int)).
:- mode split(in, in, out, out) is det.

quick_sort(List, Result) :-
	if (List = [Pivot|Tail]) then
		(split(Pivot, Tail, LeftPortion, RightPortion),
		quick_sort(LeftPortion, LeftSorted),
		quick_sort(RightPortion, RightSorted),
		list.append(LeftSorted, [Pivot|RightSorted], Result))
	else
		(Result = []).

split(Pivot, List, LeftPortion, RightPortion) :-
	if (List = [Element|Rest]) then
		(if (Element =< Pivot) then
			(LeftPortion = [Element|LeftSorted],
			RightPortion = RightSorted,
			split(Pivot, Rest, LeftSorted, RightSorted))
		else
			(LeftPortion = LeftSorted,
			RightPortion = [Element|RightSorted],
			split(Pivot, Rest, LeftSorted, RightSorted)))
	else
		(LeftPortion = [],
		RightPortion = []).
