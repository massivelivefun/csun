%% order(CustomerName, City, CreditRating)
%% aaa, aa: high credit quality
%% a, bbb: medium credit quality
%% bb, b, ccc...: low credit quality

%% just keep it simple: aaa, bbb, ccc
%% and only consider aaa credit rating as good
order('Bob Irving', 'Northridge', aaa).
order('Alex Rath', 'Long Beach', bbb).
order('Klint Farver', 'Thousand Oaks', ccc).

%% forSale(ProductNumber, ProductName, ReorderQuantityForInv)
%% ReorderPointForInv: When at or below this level reorder
forSale(001, 'Toothpaste', 20).
forSale(002, 'AA Batteries', 8).
forSale(003, 'Gold Bar', 3).

%% invRecord(ProductNumber, QuantityInStock)
%% The product number followed by quantity of the product in stock
invRecord(001, 72).
invRecord(002, 15).
invRecord(003, 2).

valid_order(Customer, Item, Quantity) :-
    order(Customer, _, aaa),
    forSale(ProductNumber, Item, _),
    invRecord(ProductNumber, NumberInStock),
    Quantity =< NumberInStock.

%% ProductName version checks all clauses
%% ProductNumber version does not check all clauses
%% Find if reorder is required through ProductName
reorder(ProductName) :-
    forSale(ProductNumber, ProductName, ReorderQuantity),
    invRecord(ProductNumber, NumberInStock),
    ReorderQuantity >= NumberInStock,
    write('It is time to reorder more of: '), nl,
    tab(2), write(ProductName).

%% Find if reorder is required through ProductNumber
reorder(ProductNumber) :-
    forSale(ProductNumber, ProductName, ReorderQuantity),
    invRecord(ProductNumber, NumberInStock),
    ReorderQuantity >= NumberInStock,
    write('It is time to reorder more of: '), nl,
    tab(2), write(ProductName).
