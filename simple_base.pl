:- dynamic is_a/2.
:- dynamic does/2.
:- dynamic has/2.

has(object, attribute).
does(attibute, action).
does(object, action).

is_a(pen, object).
is_a(point, attribute).
is_a(ink, attribute).
has(pen, point).
has(pen, ink).

is_a(knife, object).
is_a(blade, attribute).
has(knife, blade).

is_a(hammer, object).
does(hammer, hurts).

is_a(hurts, action).
does(blade, hurts).
does(point, hurts).
does(pen, write).

has(action, consequence).

is_a(write, action).
has(write, out_of_ink).

is_a(consquence, type).
has(consquence, attribute).

is_a(out_of_ink, consequence).
is_a(out_of_ink, bad).
has(out_of_ink, ink).


% why object A does action B, because of attribute/object C
why(A, B, C) :- is_a(B, action), ((has(A, C), does(C, B)); does(A, B)), is_a(A, object).

% get a object A that does action B
get(A, B) :- why(A, B, _).

% what happens if the attribute/object A do action B, the consquence C
what_happens(A, B, C) :-
    % checks if A has that action B
    get(A, B),
    % cheks if B has a consquence C
    has(B, C), is_a(C, consequence).

% object/attribute A does action B, and the consequence of B has effect
do(A, B) :-
    what_happens(A, B, C),
        % if it is a bad consequence, removes the attribute from A
        ((is_a(C, bad), remove_from(A, D));
        % if it is a good consequence, adds the attribute to A
        is_a(C, good), add_to(A, D)).

remove_from(A, B) :- retract(has(A, B)).
add_to(A, B) :- asserta(has(A, B)).

% Desicibres the object/action/attribute/consequence A.
describe(A, B) :- has(A, B); is_a(A, B); does(A, B).
