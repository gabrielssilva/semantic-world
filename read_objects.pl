:- use_module(library(pio)).
:- [actions].

% XXX
% Dynamic rules
:- dynamic is_a/2.
:- dynamic does/2.
:- dynamic has/2.
:- dynamic affects/2.

end([], []).

lines([]) --> end.
lines([L|Ls]) --> line(L), lines(Ls).

line([]) --> "\n"; end.
line([L|Ls]) --> [L], line(Ls).


process_objects_in([]).

process_objects_in([Head]) :-
    atom_chars(Phrase, Head),
    write(Phrase), nl,
    atomic_list_concat(L,' ', Phrase),
    process_phrase(L).

process_objects_in([Head | Tail]) :-
    process_objects_in([Head]),
    process_objects_in(Tail).


process_phrase([F, OBJ1, has, OBJ2]) :-
    create_object_has(OBJ1, OBJ2).

process_phrase([F, OBJ1, ACTION, which, results, on, remotion, of, ATTR]) :-
    create_object_action(OBJ1, ACTION, bad, ATTR).

process_phrase([F, OBJ1, ACTION, which, results, on, addtion, of, ATTR]) :-
    create_object_action(OBJ1, ACTION, good, ATTR).

process_phrase(_) :- write("I am sorry, I do not understand that =("), nl, nl.

read_objects :- phrase_from_file(lines(In), 'objects.in'),
                process_objects_in(In).

say(A) :-
    atomic_list_concat(L,' ', A),
    process_phrase([ F | L]).
