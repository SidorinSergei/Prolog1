
%Дан файл. Прочитать из файла строки и вывести длину наибольшей строки.
%

readFileLMaxLenStr(X) :-
    open('C:/Users/Admin/Documents/f.txt', read, Str),
    read_file(Str,[],L),
    close(Str),
    maxList(L,X).

read_file(Stream,L,L2) :-
    \+ at_end_of_stream(Stream),
    read_line_to_string(Stream,X),
    %read_line(Stream,X),reverse(Xs, X),
    %string_to_list(S, Xs),
    %write(S),nl,
    read_file(Stream,[X|L],L2).
read_file(_,L,L).

maxList([H],S):- string_length(H,C), S is C.
maxList([H|Tail],Max):-
    maxList(Tail,MaxElm),
    string_length(H,P),
    MaxElm > P,!, Max=MaxElm;
    string_length(H,P),Max = P.

%Дан файл. Определить, сколько в файле строк, не содержащих пробелы.

readString(A,N,Flag):- get0(X),
    concatSymbol(X,A,[],N,0,Flag).

concatSymbol(-1,A,A,N,N,1):-!.
concatSymbol(10,A,A,N,N,0):-!.
concatSymbol(X,A,B,N,K,Fl):-
    K1 is K+1,
    append(B,[X],B1),
    get0(X1),
    concatSymbol(X1,A,B1,N,K1,Fl).

readStringToList(List):-readString(A,_N,Flag),readStringToList([A],List,Flag).
readStringToList(List,List,1):-!.
readStringToList(Cur_list,List,0):-
	readString(A,_N,Fl),
        append(Cur_list,[A],C_l),
        readStringToList(C_l,List,Fl).

ss([]).
ss([H|T]):- char_code(H,X),X = 32,!, fail;ss(T).

searchSpace([],C,C).
searchSpace([H|T],C,C1):-
    string_chars(H,X),
    ss(X),!,S is C+1, searchSpace(T,S,C1);
    searchSpace(T,C,C1).

readFileStrNotSpace(X):-
    see('C:/Users/Admin/Documents/f.txt'),!,
    readStringToList(List),
    seen, 
    searchSpace(List,0,X),
    write('Count string don"t space: '), write(X).

%Дан файл, найти и вывести на экран только те строки, в которых букв
%А больше, чем в среднем на строку.


countA([],C,C).
countA([H|T],C,C1):- char_code(H,X),X = 65,!, S is C+1,countA(T,S,C1);countA(T,C,C1).

outString([]).
outString([H|T]):-write(H),outString(T).

searchString([]).
searchString([H|T]):-
    string_chars(H,X),
    length(X,Len),
    countA(X,0,CA),
    Mid is Len/CA,
    CA > Mid,!,outString(X),nl, searchString(T);
    searchString(T).


readFile_AMoreMiddleArifStr:-
    see('C:/Users/Admin/Documents/f.txt'),!,
    readStringToList(List),
    seen,
    searchString(List).

%Дан файл, вывести самое частое слово.

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


listToString([],L2,L2).
listToString([H|T],L2,St):-
    text_to_string(H,Y),
    atomic_concat(Y," ",X),
    string_concat(L2,X,F),
    listToString(T,F,St).

readFile_MostOftenW:-
    see('C:/Users/Admin/Documents/f.txt'),!,
    readStringToList(List),
    seen,
    listToString(List,"",S),
    split_string(S," ","",L),
    countMeetW(L,[],L2),
    no_duble(L2,L1),
    maxList(L1,Max,W),
    write(Max),nl,write(W),!.


%Дан файл, вывести в отдельный файл строки, состоящие из слов, не
%повторяющихся в исходном файле.


countMeetWStr([]).
countMeetWStr([H|T]):- cmw(H,T,1,Count),Count>1,!,fail;
    countMeetWStr(T).

listToNoDubL([],L,L).
listToNoDubL([H|T],L,L2):-
    text_to_string(H,S),
    split_string(S," ","",X),
    countMeetWStr(X),!,listToNoDubL(T,[H|L],L2); listToNoDubL(T,L,L2).

writeStr_symbol([]):-!.
writeStr_symbol([H|Tail]):-put(H),writeStr_symbol(Tail).

writeListStrToFile([]):-!.
writeListStrToFile([H|T]):-writeStr_symbol(H),nl,writeListStrToFile(T).

readFile_writeFileNorepeat:-
    see('C:/Users/Admin/Documents/f.txt'),!,
    readStringToList(List),
    seen, 
    %listToString(List,"",S),
    %split_string(S," ","",L),
    listToNoDubL(List,[],LnoDubStr),
    reverse(LnoDubStr,RLnDS),
    tell('C:/Users/Admin/Documents/fg.txt'),
    writeListStrToFile(RLnDS),
    told,!.
