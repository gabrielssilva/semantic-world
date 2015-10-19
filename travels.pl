feels(beach, hot).
feels(beach, sunny).
feels(beach, dry).

feels(mountains, nice).
feels(mountains, cloudy).


is_a(caribe, beach).
is_a(yosemite, mountains).


costs(caribe, expensive).
costs(yosemite, affordable).



menu:-write('- - - Travels Recommendation System - - -'), nl,
      % The user can query by weather
      write('[1] Query by weather'), nl,
      % or by costs. Maybe both, refining the query?
      write('[2] Query by costs'), nl,
      % The user can also insert places he traveled before (learning?)
      write('[3] Insert previous travels'), nl,
      write('[0] Exit').


menu_option(0):-!.
menu_option(1):-query_by_weather.
menu_option(2):-query_by_cost.
menu_option(3):-!.
menu_option(_):-write('Invalid Option').


main:-repeat,
      menu, nl,
      write('  Type an option: '),
      read(Option),
      menu_option(Option), nl,
      Option==0, !.


query_by_weather:-write('Type a weather: '),
                  read(Weather),
                  findall(Place, (feels(PlaceType, Weather),is_a(Place, PlaceType)), L),
                  write(L).


query_by_cost:-write('Type a cost: '),
               read(Cost),
               findall(Place, costs(Place, Cost), L),
               write(L).
