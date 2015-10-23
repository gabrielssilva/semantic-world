% Operators
:- op(900, xfx, [is_a, does, has, affects]).


% Dynamic rules
:- dynamic is_a/2.
:- dynamic does/2.
:- dynamic has/2.
:- dynamic affects/2.


% Basic relation structure
object has object.

object does action.

action is_a type.
action affects object.


% why object A does action B, because of object C
why(A, B, C) :- (B is_a action), (((A has C), (C does B)); (A does B)), (A is_a object).


% get a object A that does action B
get(A, B) :- why(A, B, _).


% what happens if the object A do action B, the consquence C
what_happens(A, B, C) :-
    % checks if A has that action B
    get(A, B),
    % cheks if B has a consquence C
    has(B, C), (C is_a consequence).


% object A does action B, and the consequence of B has effect
do(A, B) :-
    get(A, B),
        B affects D,
        % if it is a bad consequence, removes the object from A
        ((B is_a bad), remove_from(A, D));
        % if it is a good consequence, adds the object to A
        ((B is_a good), add_to(A, D)).

remove_from(A, B) :- retract(A has B).
add_to(A, B) :- asserta(A has B).


% Desicibres the object/action/consequence A.
describe(A, X) :- (A has X); (A is_a X); (A does X); (A affects X).


% Creations
create_object(A) :- delete_generic(A, is_a, object), asserta(A is_a object).

create_action(A, B, C) :-
    delete_generic(A, is_a, action),
    asserta(A is_a action),
    delete_generic(A, is_a, B),
    asserta(A is_a B),
    delete_generic(A, affects, C),
    asserta(A affects C).

create_object_has(A, B) :-
    create_object(A), create_object(B),
    delete_generic(A, has, B), asserta(A has B).

create_object_action(A, ACTION, TYPE, ATTR) :-
    create_object_has(A, ATTR), create_action(ACTION, TYPE, ATTR),
    delete_generic(A, does, ACTION), asserta(A does ACTION).


% Deletions
delete_generic(A, Op, B) :- callable(Op), C=..[Op, A, B], retract(C), fail.
delete_generic(A, Op, B).


% Register a action A that takes B
generic_action(A, B) :- Op=..[A, B], asserta(Op).
