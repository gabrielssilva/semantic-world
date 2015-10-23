% Operators
:- op(900, xfx, [is_a, does, has]).

% Dynamic rules
:- dynamic is_a/2.
:- dynamic does/2.
:- dynamic has/2.

% Basic relation structure
object has attribute.
object has object.

object does action.
attibute does action.

action has consequence.

consquence is_a type.
consquence has attribute.
consquence has object.

% :-[simple_base].

% why object A does action B, because of attribute/object C
why(A, B, C) :- (B is_a action), (((A has C), (C does B)); (A does B)), (A is_a object).

% get a object A that does action B
get(A, B) :- why(A, B, _).

% what happens if the attribute/object A do action B, the consquence C
what_happens(A, B, C) :-
    % checks if A has that action B
    get(A, B),
    % cheks if B has a consquence C
    has(B, C), (C is_a consequence).

% object/attribute A does action B, and the consequence of B has effect
do(A, B) :-
    what_happens(A, B, C),
        % if it is a bad consequence, removes the attribute from A
        ((C is_a bad), remove_from(A, D));
        % if it is a good consequence, adds the attribute to A
        ((C is_a good), add_to(A, D)).

remove_from(A, B) :- retract(has(A, B)).
add_to(A, B) :- asserta(has(A, B)).

% Desicibres the object/action/attribute/consequence A.
describe(A, X) :- (A has X); (A is_a X); (A does X).

% Register a action A that takes B
generic_action(A, B) :- Op=..[A, B], asserta(Op).

% Executes a action A that takes B
do_generic_action(A, B) :- callable(A), Op=..[A, B], Op.

main :- knife has A,
        write(A).
