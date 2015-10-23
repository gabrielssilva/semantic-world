:- use_module(library(pio)).
:- [basic_rules].

% Dynamic rules
:- dynamic is_a/2.
:- dynamic does/2.
:- dynamic has/2.
:- dynamic affects/2.


% Describes the file's gramma
end([], []).

lines([]) --> end.
lines([L|Ls]) --> line(L), lines(Ls).

line([]) --> "\n"; end.
line([L|Ls]) --> [L], line(Ls).


% Process each line extracted from file
process_objects_in([]).

process_objects_in([Head]) :-
    atom_chars(Phrase, Head),
    write(Phrase), nl,
    atomic_list_concat(L,' ', Phrase),
    process_phrase(L).

process_objects_in([Head | Tail]) :-
    process_objects_in([Head]),
    process_objects_in(Tail).


% Process the phrase, and the pharse is a list of terms

% object has object
process_phrase([OBJ1, has, OBJ2]) :-
    create_object_has(OBJ1, OBJ2).

% object action, which results on remotion of object
process_phrase([OBJ1, ACTION, which, results, on, remotion, of, ATTR]) :-
    create_object_action(OBJ1, ACTION, bad, ATTR).

% object action, which results on addition of object
process_phrase([OBJ1, ACTION, which, results, on, addtion, of, ATTR]) :-
    create_object_action(OBJ1, ACTION, good, ATTR).

% The phrase didn't match any pattern
process_phrase(_) :- write("I am sorry, I do not understand that =("), nl, nl.


% read the base facts from initial.in file
read_base :- phrase_from_file(lines(In), 'initial.in'),
             process_objects_in(In).

% adds a facts interactive
say(A) :-
    atomic_list_concat(L,' ', A),
    process_phrase(L).
