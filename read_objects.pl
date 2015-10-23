:- use_module(library(pio)).
:-[actions].

end([], []).

lines([]) --> end.
lines([L|Ls]) --> line(L), lines(Ls).

line([]) --> "\n"; end.
line([L|Ls]) --> [L], line(Ls).


get_n([Head|_], 1, Head).
get_n([_|Tail], N, Out) :- get_n(Tail, Newn, Out), N is Newn + 1.


% Converts each code list to an atom, and then to a callable
% The callables can be processed using assert
process_objects_in([]).
process_objects_in([Head|Tail]) :- atom_codes(X, Head), 
                                   term_to_atom(T, X),
                                   assert(T),
                                   %atom_concat(X, ".", First), 
                                   process_objects_in(Tail).


classify_consequence(C, "addition") :- assert(C is_a good).
classify_consequence(C, "remotion") :- assert(C is_a bad).

check_action(A) :- (not(A is_a action), assert(A is_a action)) ; !.

process_consequences_in([]).
process_consequences_in([Head|Tail]) :- string_codes(Str, Head),
                                        split_string(Str, " ", ",", L),
                                        get_n(L, 1, StrObject), get_n(L, 3, StrAction),
                                        get_n(L, 5, StrConsequence), get_n(L, 6, StrTarget),
                                        % Convert from string to atoms, to create the rules
                                        atom_codes(Object, StrObject), 
                                        atom_codes(Action, StrAction),
                                        atom_codes(Target, StrTarget),
                                        % Creates action rule
                                        assert(Object does Action),
                                        check_action(Action),
                                        % Creates consequence name
                                        string_concat(StrConsequence, StrTarget, StrConsequenceName),
                                        atom_codes(ConsequenceName, StrConsequenceName), 
                                        % Creates consequece rule
                                        assert(Action has ConsequenceName),
                                        assert(ConsequenceName is_a consequence),
                                        classify_consequence(ConsequenceName, StrConsequence),
                                        %% % Adds target to consequence
                                        assert(ConsequenceName has Target),
                                        process_consequences_in(Tail).




read_input(File, In) :- phrase_from_file(lines(In), File).

read_objects :- read_input('objects.in', In),
                process_objects_in(In).

read_consequences :- read_input('consequences.in', In),
                     process_consequences_in(In).

main :- read_objects,
        read_consequences.