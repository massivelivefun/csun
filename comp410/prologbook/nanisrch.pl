%% Rooms that the player can enter
room(kitchen).
room(office).
room(hall).
room('dining room').
room(cellar).


%% The first argument is located in the second argument
%% location(Thing, Place).
location(desk, office).
location(apple, kitchen).
location(flashlight, desk).
location('washing machine', cellar).
location(nani, 'washing machine').
location(broccoli, kitchen).
location(crackers, kitchen).
location(computer, office).

location(envelope, desk).
location(stamp, envelope).
location(key, envelope).

%% There is a door that connects the first argument to the second argument
%% door(FirstRoom, SecondRoom).
door(office, hall).
door(kitchen, office).
door(hall, 'dining room').
door(kitchen, cellar).
door('dining room', kitchen).

%% All doors are two way, these two statements handle that...
connect(X, Y) :-
    door(X, Y).
connect(X, Y) :-
    door(Y, X).

edible(apple).
edible(crackers).

tastes_yucky(broccoli).

turned_off(flashlight).

here(kitchen).

where_food(X, Y) :-
    location(X, Y),
    edible(X).
where_food(X, Y) :-
    location(X, Y),
    tastes_yucky(X).

list_things(Place) :-
    location(X, Place),
    tab(2),
    write(X),
    nl,
    fail.
%% list_things(AnyPlace).
list_things(_).

list_connections(Place) :-
    connect(Place, X),
    tab(2),
    write(X),
    nl,
    fail.
%% list_connections(AnyPlace).
list_connections(_).

look :-
    here(Place),
    write('You are in the '), write(Place), nl,
    write('You can see: '), nl,
    list_things(Place),
    write('You can go to: '), nl,
    list_connections(Place).

look_in(Container) :-
    list_things(Container).

goto(Place) :-
    can_go(Place),
    move(Place),
    look.

can_go(Place) :-
    here(X),
    connect(X, Place).

is_contained_in(T1, T2) :-
    location(T1, T2).
is_contained_in(T1, T2) :-
    location(X, T2),
    is_contained_in(T1, X).
