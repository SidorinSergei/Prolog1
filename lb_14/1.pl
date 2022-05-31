%Дана строка. Вывести ее три раза через запятую и показать количество символов в ней.
%
showStrThree(S,Count):-
    string_length(S,Count),
    write(S),
    write(','),
    write(S),
    write(','),
    write(S),nl,
    write('count:'),write(Count).
%Дана строка. Найти количество слов.
lengthL([],0).
lengthL([_H|T],C):-
    lengthL(T,C1),
    C is C1 +1.

countWord(S,Count):- split_string(S," ","",L), lengthL(L,Count).

%Дана строка, определить самое частое слово
cmw(_H,[],C,C):-!.
cmw(H,[H|T],C,C2):-C1 is C+1,cmw(H,T,C1,C2).
cmw(H,[_|T],C,C2):-cmw(H,T,C,C2).

member1([H,_],[[H,_]|_]).
member1([H,_],[[_,_]|T]):-member1([H,_],T).

no_duble([H|T],T1):-member1(H,T),no_duble(T,T1).
no_duble([H|T],[H|T1]):-not(member1(H,T)),no_duble(T,T1).
no_duble([],[]):-!.


countMeetW([],L1,L1).
countMeetW([H|T],L1,L):- cmw(H,T,1,Count),
    countMeetW(T,[[H,Count]|L1],L).

reverseList(List,NewList):- rev(List,[],NewList).
rev([],Copy,Copy):- !.
rev([Head|Tail],Copy,NewList):-
    rev(Tail,[Head|Copy],NewList).

maxList([[H,C]],C,H):-!.
maxList([[H,C]|Tail],Max,W):-
    maxList(Tail,MaxElm,Y),
    MaxElm > C,!, Max=MaxElm,W = Y;
    Max = C, W = H.

mostOftenWord(S,W):- split_string(S," ","",L),
    countMeetW(L,[],L2),
   % reverse(L2,K),
    no_duble(L2,L1),
    maxList(L1,Max,W),
    write(Max),nl,write(W),!.

%Дана строка. Вывести первые три символа и последний три символа,
%если длина строки больше 5 Иначе вывести первый символ столько
%раз, какова длина строки.
%
%
lengthList(List,L):- lengthList(List,0,L).
lengthList([],C,L):- L is C,!.
lengthList([_Head|Tail],Count,L):-
    Count1 is Count +1,
    lengthList(Tail,Count1,L).

outFLT([],_,_):-!.
outFLT([H|T],C,Length):-
    C<3,!,write(H),write(','),C1 is C + 1, outFLT(T,C1,Length);
    C>Length-1,!,write(H),write(','),C1 is C + 1, outFLT(T,C1,Length);
    C1 is C+1,outFLT(T,C1,Length).

outFL(_,0):-!.
outFL(H,C):-
    write(H),write(','),
    L1 is C -1,
    outFL(H,L1).
firstElm([H|_],H).

outFLThreeSymbStr(S):-
    string_chars(S,L3),
    string_length(S,P),
    P>5,!,lengthList(L3,C),C1 is C - 3, outFLT(L3,0,C1);
    string_chars(S,L3), string_length(S,P),firstElm(L3,H),outFL(H,P).

%Дана строка. Показать номера символов, совпадающих с последним
%символом строки.
numS([],_,_):-!.
numS([Elm|T],Elm,C):-
    write('#Sym = '),write(','),write(C),
    nl,
    C1 is C + 1,
    numS(T,Elm,C1).
numS([_|T],Elm,C):- C1 is C + 1, numS(T,Elm,C1).

numSEqualLS(S):-
    string_chars(S,L),
    reverseList(L,RL),
    firstElm(RL,LRL),
    numS(L,LRL,0).
