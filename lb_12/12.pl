% 1. Найти сумму простых делителей числа.

% количество делителей для простоты

kol_del(X,Y):-  kol_del(X,Y,1).
kol_del(X,0,X):-!.
kol_del(X,Y,I):-  X mod I =:=0, I1 is I+1, kol_del(X,Y1,I1),Y is Y1+I.
kol_del(X,Y,I):-  I1 is I+1, kol_del(X,Y1,I1),Y is Y1.

% рекурсия вверх

sum_prost_del_up(X,Y):- sum_prost_del_up(X,Y,1).

sum_prost_del_up(X,0,X):-  !.

sum_prost_del_up(X,Y,I):-(X mod I) =:=  0, kol_del(I,Z),Z=:=1,
                                     I1 is I+1,sum_prost_del_up(X,Y1,I1), Y  is Y1+I.

sum_prost_del_up(X,Y,I):- I1 is I+1, sum_prost_del_up(X,Y1,I1), Y  is Y1.

% рекурсия вниз

sum_prost_del_down(X,Y):- sum_prost_del_down(X,Y,0,1).

sum_prost_del_down(X,Y,Acc,X):- Y is Acc,!.

sum_prost_del_down(X,Y,Acc,I):-I<X, X mod I=:= 0,kol_del(I,Z),Z=:=1,
                                I1 is I+1,Acc1 is  Acc+I,sum_prost_del_down(X,Y,Acc1,I1).

sum_prost_del_down(X,Y,Acc,I):- I<X, I1 is I+1,sum_prost_del_down(X,Y,Acc,I1).


% 12. Найти произведение таких делителей числа, сумма цифр которых
% меньше, чем сумма цифр исходного числа.

% Cумма цыфр

sum_dig(X,X):- X<10,!.
sum_dig(X,Y):- X1 is X  div 10, sum_dig(X1,Y1),Y is (X mod 10)+Y1.

% рекурсия вверх

proz_del_dig_up(X,Y):- proz_del_dig_up(X,Y,1).

proz_del_dig_up(X,1,X):-  !.

proz_del_dig_up(X,Y,I):-(X mod I) =:=  0, sum_dig(I,Z1), sum_dig(X,Z2),Z1<Z2,
                                     I1 is I+1 ,proz_del_dig_up(X,Y1,I1), Y  is Y1*I.

proz_del_dig_up(X,Y,I):- I1 is I+1, proz_del_dig_up(X,Y1,I1), Y  is Y1.

%рекурсия вниз
proz_del_dig_down(X,Y):- proz_del_dig_down(X,Y,1,1).

proz_del_dig_down(X,Y,Acc,X):- Y is Acc,!.

proz_del_dig_down(X,Y,Acc,I):-I<X, X mod I=:= 0,
                                 sum_dig(I,Z1), sum_dig(X,Z2),Z1<Z2,
                                I1 is I+1,Acc1 is  Acc*I,proz_del_dig_down(X,Y,Acc1,I1).

proz_del_dig_down(X,Y,Acc,I):- I<X, I1 is I+1,proz_del_dig_down(X,Y,Acc,I1).



% Пусть d ( n ) определяется как сумма собственных делителей n (чисел
% меньше n, которые делятся равномерно на n ).
% Если d ( a ) = b и d ( b ) = a , где a ≠ b , то a и b являются
% дружественной па-
% рой, и каждый из a и b называется дружным числом.
% Например, правильными делителями 220 являются 1, 2, 4, 5, 10, 11, 20,
% 22, 44, 55 и 110; следовательно, d (220) = 284 Правильными делителями
% 284  являются 1, 2, 4, 71 и 142; поэтому d (284) = 220 Найдите
% количество всех пар дружных чисел до 10000 Задача должна быть решена
% без использования списков.

% Сумма делителей числа

 sum_del_down(X,Y):- sum_del_down(X,Y,0,1).

sum_del_down(X,Y,Acc,I):- I>X div 2+1, Y is Acc,!.

sum_del_down(X,Y,Acc,I):-I<X, X mod I=:= 0,
                                I1 is I+1,Acc1 is  Acc+I,sum_del_down(X,Y,Acc1,I1).

sum_del_down(X,Y,Acc,I):- I<X, I1 is I+1,sum_del_down(X,Y,Acc,I1).

%Проверка чисел на дружественную пару

frandly_pair_of_numb(X,Y):- sum_del_down(X,Y),sum_del_down(Y,X).

%нахождение количества всех дружественых чисел:

all_frandly_pair_of_numb_to(X):- all_frandly_pair_of_numb_to(X,219,0).
all_frandly_pair_of_numb_to(X,X,Kol):- Kol1 is Kol div 2+Kol mod 2, write(Kol1).
all_frandly_pair_of_numb_to(X,I,Kol):- frandly_pair_of_numb(I,A), A =\= I,Kol1 is Kol+1, I1 is I+1, all_frandly_pair_of_numb_to(X,I1,Kol1).
all_frandly_pair_of_numb_to(X,I,Kol):- I1 is I+1, all_frandly_pair_of_numb_to(X,I1,Kol).

%1.1
%Дан целочисленный массив. Необходимо найти количество элемен-
%тов, расположенных после последнего максимального.

%максимальный элемент

list_Max_El([H|T],X):-list_Max_El([H|T],X,H).

list_Max_El([ ],Max,Max):-!.
list_Max_El([H|T],X,Max):-H>Max,Max1 = H, list_Max_El(T,X,Max1).
list_Max_El([_H|T],X,Max):-  list_Max_El(T,X,Max).

% Длина списка.
list_length([],0):- !.
list_length([_H|T],X):-list_length(T,X1),X is X1+1.

kol_el_posle_Max([H|T],X):- list_Max_El([H|T],Z), kol_el_posle_Max([H|T],X,Z).
kol_el_posle_Max([],_,_):- !,fail.
kol_el_posle_Max([H|T],X,H):-list_length(T,Z), X is Z.
kol_el_posle_Max([_H|T],X,Max):-kol_el_posle_Max(T,X,Max).

%1.2
%Дан целочисленный массив. Необходимо найти индекс минимального элемента.

list_index_min([H|T],X):- list_index_min([H|T],X,1,1,H).
list_index_min([],Ind,_,Ind,_):-!.
list_index_min([H|T],X,Ind,_IndMin,Min):- H<Min, Ind1 is Ind +1,list_index_min(T,X,Ind1,Ind,H).
list_index_min([_H|T],X,Ind,IndMin,Min):- Ind1 is  Ind +1,list_index_min(T,X,Ind1,IndMin,Min).

%1.13 Дан целочисленный массив. Необходимо разместить элементы, рас-
%положенные до минимального, в конце массива.

присоединить([],L,L):-!.
присоединить([H|T],L,[H|T1]):- присоединить(T,L,T1).

list_map_do_min(List1,NewList):- list_index_min(List1,IndMin),list_map_do_min(List1,[],NewList,IndMin,1).
list_map_do_min(List1,List2,NewList,Ind,Ind):- присоединить(List1,List2,NewList),!.
list_map_do_min([H|T],List2,NewList,IndMin,Ind):- присоединить(List2,[H],NewList2),
    Ind1 is Ind+1,list_map_do_min(T,NewList2,NewList,IndMin,Ind1).

%?- list_map_do_min([4,5,6,3,1,3,4,6],X).
%X = [1, 3, 4, 6, 4, 5, 6, 3]

%1.15 Дан целочисленный массив и натуральный индекс (число, меньшее
%размера массива). Необходимо определить является ли элемент по указан-
%ному индексу локальным минимумом.


loc_min_on_ind([H|T],Ind):- loc_min_on_ind(H,T,Ind,0).
loc_min_on_ind(H1,[H2|_],Ind,Ind):-H1<H2.
loc_min_on_ind(H1,[H2|T],Ind,Beg):-Beg1 is Beg+1,loc_min_on_ind(H1,H2,T,Ind,Beg1).
 loc_min_on_ind(H1,H2,[ ],Ind,Ind):-H2<H1.
loc_min_on_ind(H1,H2,[H3|_],Ind,Ind):-H1>H2,H2<H3.
loc_min_on_ind(_,H2,[H3|T],Ind,Beg):-Beg1 is Beg+1, loc_min_on_ind(H2,H3,T,Ind,Beg1).


% 1.25 Дан целочисленный массив и интервал a..b. Необходимо найти мак-
% симальный из элементов в этом интервале.


max_in_inter([H|T],A,B,Max):- max_in_inter([H|T],A,B,[],Max,0).

%Если список закончилдся раньше чем мы успели дойти до интервала
max_in_inter([],A,_._._,Beg):-A>Beg,fail.
max_in_inter([_|T],A,B,NewList,Max,Beg):-A>=Beg,Beg1 is Beg+1,max_in_inter(T,A,B,NewList,Max,Beg1).

max_in_inter(_,_,B,NewList,Max,Beg):-B=:=Beg,list_Max_El(NewList,Max1),Max is Max1,!.


max_in_inter([H|T],A,B,NewList,Max,Beg):-A<Beg,Beg<B,
    Beg1 is Beg+1,присоединить(NewList,[H],NewList1),
    max_in_inter(T,A,B,NewList1,Max,Beg1).

%1.28 Дан целочисленный массив. Необходимо найти элементы, располо-
%женные между первым и последним максимальным.

index_first_list_max_el(List,Ind):- list_Max_El(List,Max),index_first_list_max_el(List,Max,0,Ind).
index_first_list_max_el([H|T],Max,Beg,Ind):-H=\=Max,!, Beg1 = Beg+1,index_first_list_max_el(T,Max,Beg1,Ind);Ind is Beg.

index_last_list_max_el(List,Ind):-list_Max_El(List,Max),
    index_last_list_max_el(List,Max,0,0,Ind).

index_last_list_max_el([],_,_,Ind,Ind).

index_last_list_max_el([H|T],Max,Beg,_,Ind):-H=:=Max,IndMax1 is Beg,Beg1 = Beg+1,
     index_last_list_max_el(T,Max,Beg1,IndMax1,Ind1), Ind is Ind1.

index_last_list_max_el([_|T],Max,Beg,IndMax,Ind):-Beg1 is Beg+1,
     index_last_list_max_el(T,Max,Beg1,IndMax,Ind).

list_el_Fm_Lm(List,X):-index_last_list_max_el(List,B),index_first_list_max_el(List,A),
    list_el_Fm_Lm(List,A,B,0,[],X).
list_el_Fm_Lm([],A,_,Beg,[],_):-A>Beg,fail.
list_el_Fm_Lm([_|T],A,B,Beg,NewList,X):-A>=Beg,Beg1 is Beg+1,list_el_Fm_Lm(T,A,B,Beg1,NewList,X).
list_el_Fm_Lm(_,_,B,B,X,X).
list_el_Fm_Lm([H|T],A,B,Beg,NewList,X):-A<Beg,Beg<B,
    Beg1 is Beg+1,присоединить(NewList,[H],NewList1),
    list_el_Fm_Lm(T,A,B,Beg1,NewList1,X).
