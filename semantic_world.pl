% Asserts an entire list of facts
assert_list([]).
assert_list([Head|Tail]):-assertz(Head), assert_list(Tail).


% Converts a list into a tuple
list_to_tuple([X],X).
list_to_tuple([Head|Tail], (Head, Rest)):-list_to_tuple(Tail, Rest).


% Creates a new rule from a list
create_a_rule(L) :-
    Head=newrule,
    list_to_tuple(L,Body),
    dynamic(Head),
    assert(Head :- Body),
    listing(Head).

%% TODO: REFLECT RELATIONS
% If bob has a pen, and a pen writes, bob can write
% reflect_relations(A, B) :-


% Defines a list of facts, asserts all of them, and creates a new rule dynamically
main :-
    L=[has(bob, pen), does(pen, writes), isA(pen, object), isA(bob, human)],
    assert_list(L),
    create_a_rule(L).