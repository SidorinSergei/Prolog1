man(stas).
man(sergey).
man(samson).
man(semen).
man(scott).
man(sidney).
man(slava).
woman(sveta).
woman(sada).
woman(sara).
woman(safira).
woman(sabina).
woman(sai).
parents(sveta,slava).
parents(sergey,slava).
parents(slava,samson).
parents(sada,samson).
parents(semen,sada).
parents(sara,sada).
parents(semen,safira).
parents(sara,safira).
parents(scott,sidney).
parents(sabina,sidney).
parents(safira,sai).
parents(sidney,sai).
parents(samson,stas).
parents(sai,stas).
%11.11
father(X,Y):- parents(X,Y),man(x).
father(X):- parents(Y,X),man(Y),write(Y).
%11.12
sister(X,Y):- parents(Z,X),parents(Z,Y),woman(X).
sister(X):- sister(Y,X),woman(Y),write(Y),nl.
%11.13
grand_ma(X,Y):- parents(X,Z),parents(Z,Y),woman(X).
grand_ma(X):- grand_ma(Y,X),write(Y),nl.
%11.14
grand_ma_and_son(X,Y):-
parents(X,Z),parents(Z,Y),woman(X),man(Y)|
parents(Y,Z),parents(Z,X),man(X),woman(Y).
%11.15
pUp(X,X):- X<10,!.
pUp(X,P):-
X1 is X div 10,
pUp(X1,P1),
P is P1*(X mod 10).
%11.16
pDown(X,Y):- pDown(X,Y,X,1),!.
pDown(K,Y,X1,Y1):- 
	X1>0,
	!,
	Z is Y1*(X1 mod 10),
	X2 is X1 div 10,
	pDown(K,Y,X2,Z).
pDown(_,X,_,Y):- X is Y.
%17 Найти количество нечетных цифр числа, больших 3.n рек. вверх

kol_di(0,0):- ! .

kol_di(X,Y): - X mod 10>3,
          D is (X mod 10), D mod 2 >0,
           X1 - X div 10, kol_di(X1,Y1), Y - Y1+1,!.
kol_di(X,Y): - X1 is  X div 10, kol_di(X1,Y1), Y is  Y1.

%18 Найти количество нечетных цифр числа, больших 3.n рек. вверх

kol_di_d(X,Y): - kol_di_d(X,Y,0),!.
kol_di_d(X,Y,ACC): -X>0, X mod 10>3,
          D is (X mod 10), D mod 2 >0,
          X1 - X div 10, ACC1 - ACC+1, kol_di_d(X1,Y,ACC1).
kol_di_d(X,Y,ACC): -X>0, X1 is X div 10, kol_di_d(X1,Y,ACC).
kol_di_d(_,X,Y): -X is Y


%19 Задание 19 Реализовать предикат fib(N,X), где X – число Фибоначчи с
%номером N, причем 1 и 2 элемент равны 1 с помощью рекурсии вверх.

fib(1,1):-!.
fib(2,1):-!.
fib(N,X):- N1 is N-1,N2 is N-2, fib(N1,X1),fib(N2,X2), X is X1+X2.

%20 Задание 19 Реализовать предикат fib(N,X), где X – число Фибоначчи с
%номером N, причем 1 и 2 элемент равны 1 с помощью рекурсии вверх

fib_d(N,X):- fib_d(N,X,1,1,2),!.
fib_d(N,F,F,_,N):- !.
fib_d(N,X,A,B,C):- A1 is A+B, C1 is C+1,fib_d(N,X,A1,A,C1).
