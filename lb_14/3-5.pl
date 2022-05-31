%Дана строка. Необходимо найти общее количество русских символов.
%

countSymb([],CurC,CurC).
countSymb([H|T],CurC,C):-
    char_code(H,X),
    X @>= 1040,X @=< 1103,!,C1 is CurC+1,countSymb(T,C1,C);
    countSymb(T,CurC,C).

commonCountRus(S,X):-
    string_chars(S,C),
    countSymb(C,0,X).

%Дана строка. Необходимо проверить образуют ли строчные
%символы латиницы палиндром.

isLowercaseStr([]).
isLowercaseStr([H|T]):-
    char_code(H,X),
    ((X @>=1074,X @=<1103);(X @>=97, X @=<122)),!,isLowercaseStr(T);
    fail.

palind([],L,L).
palind([H|T],L,L1):-palind(T,[H|L],L1).

equalList([],[]).
equalList([H|T],[E|R]):-
    H=E,!,equalList(T,R);
    fail.

isPallindrom(S):-
    string_chars(S,C),
    isLowercaseStr(C),!,palind(C,[],NL),equalList(C,NL);
    write('Â ñòðîêå åñòü äðóãèå ñèìâîëû(âñå äá ñòðî÷íûå').

%Найти в тексте даты формата «день.месяц.год».
checkLD([H],C):- char_code(H,C).
checkLD([_H|T],C):-
    checkLD(T,C).

yearD([],_,_).
yearD([H|T],S,Count):-
    char_code(H,X),
    (X @>=48,X @=<57),!,string_concat(S,H,S1),C1 is Count + 1,yearD(T,S1,C1);
    char_code(H,X),((X = 187),Count=4),!,write(S),nl;
    yearD([],"",5).

monthD([],_,_,_).
monthD([H|T],S,FD,CD):-
    char_code(H,X),
    (FD = 0,CD<2,(X=48;X=49)),!,string_concat(S,H,S1),C1 is CD + 1,monthD(T,S1,1,C1);
    string_chars(S,LS),checkLD(LS,D),char_code(H,X),
             (D = 48,X @>=48,X @=<57,CD<2),!,string_concat(S,H,S1),C1 is CD + 1,monthD(T,S1,1,C1);
    string_chars(S,LS),checkLD(LS,D),char_code(H,X),
              (D = 49,CD<2,(X @>=48,X @=<50)),!,string_concat(S,H,S1),C1 is CD + 1,monthD(T,S1,1,C1);
    char_code(H,X),(X = 46),CD = 2,!,string_concat(S,H,S1),yearD(T,S1,0);
     monthD([],"",0,4).

dayD([],_S,_).
dayD([H|T],S,CD):-
    char_code(H,X),
    (X @>=48,X @=<51),!, C1 is CD + 1,string_concat(S,H,S1),dayD(T,S1,C1);
    string_chars(S,LS),checkLD(LS,D),
               char_code(H,X),(D @>=48,D @=<50),(X@>=48,X @=<57),CD<2,!,
               string_concat(S,H,S1),C1 is CD + 1,dayD(T,S1,C1);
    string_chars(S,LS),checkLD(LS,D),char_code(H,X),(D = 51),(X=48;X=49),(CD<2),!,               string_concat(S,H,S1), C1 is CD + 1,dayD(T,S1,C1);
    char_code(H,X),(X = 46),CD=2,!,string_concat(S,H,S1),monthD(T,S1,0,0);
    dayD([],"",3).

parseDate([]).
parseDate([H|T]):-
    char_code(H,X),
    X = 171,!,dayD(T,"",0),parseDate(T);
    parseDate(T).

searchAllDate([H|T]):-
    %text_to_string(H,S),
    string_chars(H,S),
    parseDate(S),
    %parse_time(H,'2006-12-08',L),
    %split_string(S,"«»","",L),
    %write(L),
    searchAllDate(T).


read_file(Stream,L,L2) :-
    \+ at_end_of_stream(Stream),
    read_line_to_string(Stream,X),
    %read_line(Stream,X),reverse(Xs, X),
    %string_to_list(S, Xs),
    %write(S),nl,
    read_file(Stream,[X|L],L2).
read_file(_,L,L).

readTextDate:-
    open('C:/Users/Admin/Documents/g.txt', read, Str),
    read_file(Str,[],L),
    close(Str),
    reverse(L,NL),!,
    searchAllDate(NL).
