:- include('KB.pl').


/*---Move Up---*/

jon_snow(X,Y,D,result(up,S)):-
  jon_snow(X,OY,_,S),
  OY > 0,
  Y is OY -1,
  \+ obstacle(X,Y),
  \+ white_walker(X,Y,S),
  dragon_stone(X,Y,D).

jon_snow(X,Y,D,result(up,S)):-
  jon_snow(X,OY,D,S),
  OY > 0,
  Y is OY -1,
  \+ obstacle(X,Y),
  \+ white_walker(X,Y,S),
  \+ dragon_stone(X,Y,_).


/*---Move Down---*/

jon_snow(X,Y,D,result(down,S)):-
    jon_snow(X,OY,_,S),
    dimensions(_,H),
    MaxH is H -1,
    OY < MaxH,
    Y is OY +1,
    \+ obstacle(X,Y),
    \+ white_walker(X,Y,S),
    dragon_stone(X,Y,D).

jon_snow(X,Y,D,result(down,S)):-
    jon_snow(X,OY,D,S),
    dimensions(_,H),
    MaxH is H -1,
    OY < MaxH,
    Y is OY +1,
    \+ obstacle(X,Y),
    \+ white_walker(X,Y,S),
    \+ dragon_stone(X,Y,_).

/*---Move Left---*/

jon_snow(X,Y,D,result(left,S)):-
    jon_snow(OX,Y,_,S),
    OX > 0,
    X is OX -1,
    \+ obstacle(X,Y),
    \+ white_walker(X,Y,S),
      dragon_stone(X,Y,D).

jon_snow(X,Y,D,result(left,S)):-
    jon_snow(OX,Y,D,S),
    OX > 0,
    X is OX -1,
    \+ obstacle(X,Y),
    \+ white_walker(X,Y,S),
    \+ dragon_stone(X,Y,_).


/*---Move Right---*/

jon_snow(X,Y,D,result(right,S)):-
    jon_snow(OX,Y,_,S),
    dimensions(W,_),
    MaxW is W -1,
    OX < MaxW,
    X is OX +1,
    \+ obstacle(X,Y),
    \+ white_walker(X,Y,S),
    dragon_stone(X,Y,D).

jon_snow(X,Y,D,result(right,S)):-
    jon_snow(OX,Y,D,S),
    dimensions(W,_),
    MaxW is W -1,
    OX < MaxW,
    X is OX +1,
    \+ obstacle(X,Y),
    \+ white_walker(X,Y,S),
    \+ dragon_stone(X,Y,_).


/*---Attack---*/
jon_snow(X,Y,D,result(attack,S)):-
    jon_snow(X,Y,OD,S),
    OD > 0,
    D is OD -1,
    LX is X-1,
    RX is X+1,
    UY is Y-1,
    DY is Y+1,
    (
    white_walker(LX,Y,S);
    white_walker(RX,Y,S);
    white_walker(X,UY,S);
    white_walker(X,DY,S)
    ).

jon_snow(X,Y,D,result(attack,S)):-
    jon_snow(X,Y,_,S),
    dragon_stone(X,Y,D),
    LX is X-1,
    RX is X+1,
    UY is Y-1,
    DY is Y+1,
    (
    white_walker(LX,Y,S);
    white_walker(RX,Y,S);
    white_walker(X,UY,S);
    white_walker(X,DY,S)
    ).

/*---White_walkers---*/
white_walker(_,_,result(A,S)):-
  A \= attack.

white_walker(X,Y,result(attack,S)):-
      LX is X-1,
      RX is X+1,
      UY is Y-1,
      DY is Y+1,
      \+ jon_snow(LX,Y,_,S),
      \+ jon_snow(RX,Y,_,S),
      \+ jon_snow(X,UY,_,S),
      \+ jon_snow(X,DY,_,S).



query(S):-
  \+ white_walker(0,1,S).


/*---Querying---*/
query_with_depth(L,N,S):-
  call_with_depth_limit(query(S),N,L).