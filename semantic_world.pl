% Asserts an entire list of facts
assert_list([]).
assert_list([Head|Tail]):-assertz(Head), assert_list(Tail).


% Converts a list into a tuple
list_to_tuple([X],X).
list_to_tuple([A,B],(A,B)).
list_to_tuple([A,B|T],(A,B,Rest)):-list_to_tuple(T,Rest).


% Creates a new rule from a list
create_a_rule(L) :- 
    Head=newrule,
    list_to_tuple(L,Body),
    dynamic(Head),
    assert(Head :- Body),
    listing(Head).

% Defines a list of facts, asserts all of them, and creates a new rule dynamically
main :- L=[isA(pen, object), does(pen, writes)],
        assert_list(L),
        create_a_rule(L).