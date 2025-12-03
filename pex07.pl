% pex5.pl
% USAFA UFO Sightings 2024
%
% name: Tanner Woodring
%
% Documentation: None.
%

% The query to get the answer(s) or that there is no answer
% ?- solve.


% "It's a tie", Dell Logic Puzzles, October 19991
% Each man (mr so-and-so) got a tie from a relative.2
what(weatherBalloon).
what(kite).
what(fighterAircraft).
what(cloud).

who(smith).
who(garcia).
who(chen).
who(jones).

when(tuesday).
when(wednesday).
when(thursday).
when(friday).

solve :-
what(SmithUFO), what(GarciaUFO), what(ChenUFO), what(JonesUFO),
all_different([SmithUFO, GarciaUFO, ChenUFO, JonesUFO]),

when(SmithTime), when(GarciaTime),
when(ChenTime), when(JonesTime),
all_different([SmithTime, GarciaTime, ChenTime, JonesTime]),

Triples = [ [smith, SmithUFO, SmithTime],
[garcia, GarciaUFO, GarciaTime],
[chen, ChenUFO, ChenTime],
[jones, JonesUFO, JonesTime] ],
    
% 1. C4C Smith did not see a weather balloon, nor kite.
\+ member([smith, weatherBalloon, _], Triples),
\+ member([smith, kite, _], Triples),
    
% 2. The one who saw the kite isn’t C4C Garcia.
\+ member([garcia, kite, _], Triples),
    
% 3. Friday’s sighting was made by either C4C Chen or the one who saw the fighter aircraft.
( member([chen, _, friday], Triples);
member([_, fighterAircraft, friday], Triples)),
    
% 4. The kite was not sighted on Tuesday.
\+ member([_, kite, tuesday], Triples),
    
% 5. Neither C4C Garcia nor C4C Jones saw the weather balloon.
\+ member([garcia, weatherBalloon, _], Triples),
\+ member([jones, weatherBalloon, _], Triples),

% 6. C4C Jones did not make their sighting on Tuesday.
\+ member([jones, _, tuesday], Triples),
    
% 7. C4C Smith saw an object that turned out to be a cloud.
member([smith, cloud, _], Triples),
    
% 8. The fighter aircraft was spotted on Friday.
member([_, fighterAircraft, friday], Triples),

% 9. The weather balloon was not spotted on Wednesday.
\+ member([_, weatherBalloon, wednesday], Triples),

tell(smith, SmithUFO, SmithTime),
tell(garcia, GarciaUFO, GarciaTime),
tell(chen, ChenUFO, ChenTime),
tell(jones, JonesUFO, JonesTime).

% Succeeds if all elements of the argument list are bound and different.
% Fails if any elements are unbound or equal to some other element.
all_different([H | T]) :- member(H, T), !, fail.
all_different([_ | T]) :- all_different(T).
all_different([_]).

tell(X, Y, Z) :-
write('C4C '), write(X), write(' saw the '), write(Y),
write(' on '), write(Z), write('.'), nl.