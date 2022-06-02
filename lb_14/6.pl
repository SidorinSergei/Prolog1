outputStr_symb([],_Out):-!.
outputStr_symb([H|Tail],Out):- put(Out,H),outputStr_symb(Tail,Out).

outFile(L):-
    open('C:/Users/Admin/Documents/f.txt',append,Out),
    outputStr_symb(L,Out),put(Out,10),close(Out).

elmInlist([El|_],El).
elmInlist([_|T],El):-elmInlist(T,El).

inputStr(A,N):-get0(X),recordList(X,A,[],N,0).
recordList(10,A,A,N,N):-!.
recordList(Symb,A,B,N,K):-K1 is K+1,
    get0(NextSymb),
    recordList(NextSymb,A,[Symb|B],N,K1).

translateNumToCode([],L,L).
translateNumToCode([H|T],L,L2):-
    number_codes(H,Y),
    translateNumToCode(T,[Y|L],L2).
%All Placement with Repeat by K+++++++++++++++++++++++++
aPR(_A,0,ListPerm):-outFile(ListPerm),!,fail.
aPR(A,N,ListPerm):-elmInlist(A,El),N1 is N-1,aPR(A,N1,[El|ListPerm]).

allPlacementRepeat:-
    tell('C:/Users/Admin/Documents/f.txt'),
    told,
    inputStr(A,_N),
    read(K),
    aPR(A,K,[]),!.


allPlacementRepeat(List,K):-
    tell('C:/Users/Admin/Documents/f.txt'),
    told,
    translateNumToCode(List,[],NL),
    reverse(NL,RNL),
    aPR(RNL,K,[]).
%---------------------------------------------------------
%All Permutation +++++++++++++++++++++
allpermutat(List,K):-
    tell('C:/Users/Admin/Documents/f.txt'),
    told,
    translateNumToCode(List,[],NL),
    reverse(NL,RNL),
    permutat(RNL,K,[]).


permutat(_List, 0, Perm):-
    open('C:/Users/Admin/Documents/f.txt',append,Out),
    outputStr_symb(Perm,Out)
    ,put(Out,10)
    ,close(Out)
    ,fail.

permutat(List, K, Permut):-
  member(H, List),
  delete(List, H, Tail),
  K1 is K - 1,
  permutat(Tail, K1, [H|Permut]).

%All permutation with repeat by K++++++++++++++++++++
aPermR([],_).
aPermR([H|T],Set):-member(H,Set),aPermR(T,Set).

allpermRepeat(List, K,L):-
         length(L,K), aPermR(L,List).

% All placemetn no repeat by K++++++++++++++++++++++++++
in_list_exlude([El|T],El,T).
in_list_exlude([H|T],El,[H|Tail]):-in_list_exlude(T,El,Tail).
%ñíà÷àëà âûçîâ in_l_e(T,El,Tail), ïîòîì ïèõàåì [H|Tail] çàòåì âûçîâ
% in_list_exlude([El|T],El,T) ãäå äîïîëíÿåòñÿ [H|Tail] Ò è ïîëó÷ ñïèñ èç
% îñòàâ ýëåìí

allPlacement(List,K):-
    tell('C:/Users/Admin/Documents/f.txt'),
    told,
    translateNumToCode(List,[],NL),
    reverse(NL,RNL),
    write(RNL),
    aP(RNL,K,[]).

aP(_P,0,P1):-reverse(P1,L1),outFile(L1),!,fail.
aP(A,N,P):-in_list_exlude(A,El,A1),N1 is N - 1,aP(A1,N1,[El|P]).
%--------------------------------------------
%All combination no repeat by K++++++++++++++++++++++

allCombination(List,K):-
     tell('C:/Users/Admin/Documents/f.txt'),
     told,
     translateNumToCode(List,[],NL),
     reverse(NL,RNL),
     write(RNL),
     aC(RNL,K,B),
     outFile(B),nl,fail.

aC(_,0,[]):-!.
aC([H|T],K,[H|L]):- K1 is K - 1,aC(T,K1,L).
aC([_|T],K,L):-aC(T,K,L).
%----------------------------------------------
% All combination with repeat by K+++++++++++++++++++++++++++++

allCombinationRepeat(List,K):-
    tell('C:/Users/Admin/Documents/f.txt'),
    told,
    translateNumToCode(List,[],NL),
    reverse(NL,RNL),
    aCR(RNL,K,Comb),
    outFile(Comb),fail.

aCR(_,0,[]):-!.
aCR([H|T],K,[H|L]):- K1 is K - 1,aCR([H|T],K1,L).
aCR([_|T],K,L):-aCR(T,K,L).
%----------------------------------------------
%All SubSet Set++++++++++++++++++++++++++++
allsubset(List):-
    tell('C:/Users/Admin/Documents/f.txt'),
    told,
    translateNumToCode(List,[],NL),
    reverse(NL,RNL),
    aS(RNL,Set),
    outFile(Set),fail.

aS([],[]).
aS([H|T],[H|L]):-aS(T,L).
aS([_H|T],L):-aS(T,L).
%------------------------------------------------------
%7 +++++++++++++++
%Check string exists 2 aa
checkTwoA([],C):- C =:=2,!,true;false.
checkTwoA([H|T],C):-
    H=97,!,C1 is C + 1,checkTwoA(T,C1);
    checkTwoA(T,C).

translateCharToCode([],L,L).
translateCharToCode([H|T],L,L2):-
    char_code(H,Y),
    translateCharToCode(T,[Y|L],L2).

noRepeatSymbol([],[_|_T],_):-true.
noRepeatSymbol([],[],C):-C<5,!,fail;true.
noRepeatSymbol([H|T],[H2|T2],C):- char_code(H2,X),H=X,!,C1 is C + 1,
               noRepeatSymbol(T,T2,C1);
               noRepeatSymbol(T,T2,C).

checkNoDubl(_,[]).
checkNoDubl(L,[H|T]):-
    text_to_string(H,S),string_chars(S,X),
    noRepeatSymbol(L,X,0),!,fail;
    checkNoDubl(L,T).

% Read File Text++++++++++++++
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
%--------------------------------------End Read File
checkFile(List):-
          see('C:/Users/Admin/Documents/f.txt'),!,
    readStringToList(L),
    seen,
    checkNoDubl(List,L).

outFile(L,_TwiceA):-
    checkTwoA(L,0),checkFile(L)->
    open('C:/Users/Admin/Documents/f.txt',append,Out),
    outputStr_symb(L,Out),put(Out,10),close(Out).

aP1(_P,0,P1):-reverse(P1,L1),outFile(L1,1),!,fail.
aP1(A,N,P):-in_list_exlude(A,El,A1),N1 is N - 1,aP1(A1,N1,[El|P]).

allCombRepTwoA(List,K,_TwiceA):-
    tell('C:/Users/Admin/Documents/f.txt'),
    told,
    K=5 -> (
    translateCharToCode(List,[],NL),
    reverse(NL,RNL),
    aCR(RNL,K,Comb),
        checkTwoA(Comb,0),aP1(Comb,K,[]),fail).
