:- use_module(library(pio)).

end([], []).

lines([]) --> end.
lines([L|Ls]) --> line(L), lines(Ls).

line([]) --> "\n"; end.
line([L|Ls]) --> [L], line(Ls).


% Converts each code list to an atom, and then to a callable
% The callables can be processed using assert
process_objects_in([]).
process_objects_in([Head|Tail]) :- atom_codes(X, Head), 
                                   term_to_atom(T, X),
                                   assert(T),
                                   %atom_concat(X, ".", First), 
                                   process_objects_in(Tail).

read_objects :- phrase_from_file(lines(In), 'objects.in'),
                process_objects_in(In).