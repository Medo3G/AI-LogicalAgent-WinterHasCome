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
    \+ dragon_stone(X,Y,_),
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
white_walker(X,Y,result(A,S)):-
    white_walker(X,Y,S),
    (
    A = up;
    A = down;
    A = right;
    A= left
    ).

white_walker(X,Y,result(attack,S)):-
    white_walker(X,Y,S),
    LX is X-1,
    RX is X+1,
    UY is Y-1,
    DY is Y+1,
    \+ jon_snow(LX,Y,_,S),
    \+ jon_snow(RX,Y,_,S),
    \+ jon_snow(X,UY,_,S),
    \+ jon_snow(X,DY,_,S).

dead_white_walker(X,Y,result(attack,S)):-
    white_walker(X,Y,S),
    LX is X-1,
    RX is X+1,
    UY is Y-1,
    DY is Y+1,
    (
    jon_snow(LX,Y,D,S);
    jon_snow(RX,Y,D,S);
    jon_snow(X,UY,D,S);
    jon_snow(X,DY,D,S)
    ),
    D>0.

dead_white_walker(X,Y,result(A,S)):-
    dead_white_walker(X,Y,S),
    (
    A = up;
    A = down;
    A = right;
    A = left;
    A = attack
    ).

/*---Querying---*/
query(S):-
    foreach(white_walker(X,Y,s),dead_white_walker(X,Y,S)).

query_with_depth(L,N,S):-
    call_with_depth_limit(query(S),N,L).
