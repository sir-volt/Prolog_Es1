%esercizi fatti per conto nostro
%punto 1: crea una funzione "search"
search(X, cons(X, _)).
%caso base dove la lista ha come testa subito l'elemento che cerco
search(X, cons(_, Xs)) :- search(X, Xs).
%caso con ricorsione: il mio elemento non è nella testa, ma nella coda, perciò vado a fare la ricerca su una coda Xs

%punto 2: funzione di search dove verifica che l'elemento vi sia due volte di fila
search2(X, cons(X, cons(X, _))).
search2(X, cons(_, Xs)) :- search2(X, Xs).

%punto 3: funzione di search dove verifica che l'elemento vi sia due volte con un elemento in mezzo tra loro
search3(X, cons(X, cons(_, cons(X,  _)))).
search3(X, cons(_, Xs)) :- search3(X, Xs).
%punto 4: funzione di search dove verifica che almeno un elemento vi sia due volte nella lista
%nel caso base, verifico che il primo elemento della testa sia X, poi vado ad usare il metodo search (che trova un elemento in una lista) nella coda
%negli altri casi, vado a chiamare ogni volta la search_anytwo chiedendo sempre di cercare X ma questa volta solo sulla coda (dato che sappiamo che la testa non è X)
search_anytwo(X, cons(X, T)) :- search(X, T).
search_anytwo(X, cons(_, T)) :- search_anytwo(X, T).
%punto 5: funzione size che indica quanti elementi vi sono in una lista
%la funzione base è zero, mentre nelle altre versioni si fa un ciclo che va sempre più dentro il numero di elementi (prima s(X), passando al ciclo successivo è s(s(X)), ecc...)
size(nil, zero).
size(cons(_, T), s(X)) :- size(T, X).
%punto 6: funzione sum_list che somma gli elementi della lista usando i numeri Peano (zero, s(zero)...)
%ci serve la versione normale di sum
sum(zero, N, N).
sum(s(N), M, s(O)) :- sum(N, M, O).
%ora lavoriamo alla somma degli elementi di list
sum_list(nil, zero).
sum_list(cons(H, T), X) :- sum(H, Xs, X), sum_list(T, Xs).
%punto 7: funzione count con tail recursion (fatta dal prof)
count(List, E, N) :- count(List, E, zero, N).
count(nil, E, N, N).
count(cons(E, L), E, N, M) :- count(L, E, s(N), M).
count(cons(E, L), E2, N, M) :- E \= E2 , count(L, E2, N, M).
%punto 8: funzione max a partire da count
%uso greater vecchio
old_greater(s(_), zero).
old_greater(s(M), s(N)) :- old_greater(M, N).
%ora facciamo il max
max(cons(H, T), Max) :- max(T, H, Max).
max(nil, M, M).
max(cons(Ts, L), T, M) :- old_greater(T, Ts), max(L, T, M).
max(cons(Tm, L), T, M) :- old_greater(Tm, T), max(L, Tm, M).
%punto 9: funzione min-max a partire da max
min-max(List, Min, Max) :- min-max(List, s(s(s(s(s(s(s(s(s(s(szero)))))))))), zero, Min, Max).
min-max(nil, S, M, S, M).
min-max(cons(Tm, L), Tmin, Tmax, S, M) :- old_greater(Tm, Tmax), min-max(L, Tmin, Tm, S, M).
min-max(cons(Tm, L), Tmin, Tmax, S, M) :- old_greater(Tmin, Tm), min-max(L, Tm, Tmax, S, M).
min-max(cons(Tm, L), Tmin, Tmax, S, M) :- old_greater(Tm, Tmin), old_greater(Tmax, Tm), min-max(L, Tmin, Tmax, S, M).
%punto 10: funzione "same" che verifica che entrambe le liste passate siano uguali
same(cons(H, T), cons(H, T)).
%punto 11: funzione "bigger", dove verifico che ogni elemento di una lista in una posizione sia maggiore di quello della successiva lista nella stessa posizione
%utilizzo la funzione greater generica con 3 casi: in cui il primo elemento è il più grande, in cui il secondo elemento è più grande, o dove entrambi sono zero.
%i primi due parametri sono i valori da valutare, il terzo parametro è il valore che restituisco (che corrisponde al più grande)
greater(s(N), zero, s(N)).
greater(zero, s(N), s(N)).
greater(zero, zero, zero).
greater(s(M), s(N), s(O)) :- greater(M, N, O).
all_bigger(nil, nil).
all_bigger(cons(H, T), cons(Hn, Tn)) :- greater(H, Hn, H), all_bigger(T, Tn).
%punto 12:funzione "sublist" per ottenere delle sottoliste
sublist(nil, nil).
sublist(nil, cons(_, _)).
sublist(cons(H, T), N) :- search(H, N), sublist(T, N).
%punto 13: funzione "seq" creata dal prof, vedo che non è completamente relazionale
seq(zero, _, nil).
seq(s(N), E, cons(E,T)) :- seq(N, E, T).
%punto 14: funzione "seqR" che prende una sequenza e aggiunge ogni elemento dentro una lista
%ES: s(s(s(zero) -> cons(s(s(zero)), cons(s(zero), cons(zero, nil)))
%posso usare concat
concat(nil, L, L).
concat(cons(H,T), L, cons(H, O)) :-concat(T, L, O).
%e poi completare seqR
seqR(zero, nil).
seqR(s(X), cons(X, T)) :- seqR(X, T).
%punto 15: nuova funzione "seqR2", che invece di andare dall'elemento più grande allo zero, va dal più piccolo al più grande
%devo aggiungere un predicato nuovo chiamato "last"
last(nil, E, cons(E, nil)).
last(cons(H, T), E, cons(H, O)) :- last(T, E, O).
%ora creo seqR2
%seqR2(N, List) :- seqR2(N, nil, List).
%seqR2(zero, M, M).
%seqR2(s(X), cons(H, O), M) :- last(cons(H, O), X, cons(H, T)), seqR2(X, cons(H, T), M).
seqR2(zero, nil).
seqR2(s(X), cons(H, O)) :- last(cons(H, O), s(X), M), seqR2(X, M).
%punto 16: un paio di soluzioni Prolog di funzioni Scala
%1: LAST: restituisce ultimo elemento di lista
lastEl(cons(H, nil), H).
lastEl(cons(_, T), X) :- lastEl(T, X).
%2: MAP, mappa tutti gli elementi aggiungendo 1 a ciascuno di questi
map(nil, nil).
map(cons(H, T), cons(s(H), O)) :- map(T, O).
%3:FILTER, dove gli elementi devono superare un certo filtro, in questo caso che siano maggiori di zero
non-zero_filter(nil, nil).
non-zero_filter(cons(H, T), cons(H, M)) :- H\=zero, non-zero_filter(T, M).
non-zero_filter(cons(H, T), M) :- non-zero_filter(T, M).
%4: REVERSED, inverti la lista
reversed(List1, List2) :- reversed(List1, nil, List2).
reversed(nil, M, M).
reversed(cons(H, T), X, M) :- reversed(T, cons(H, X), M).
%: DROP,perdi il primo N di elementi
drop(nil, s(_), nil).
drop(cons(H, T), zero, cons(H,T)).
drop(cons(H, T), s(X), O) :- drop(T, X, O).
%6: TAKE: prende un numero di elementi dalla lista
take(nil, s(_), nil).
take(cons(H, T), zero, nil).
take(cons(H, T), s(X), cons(H, O)) :- take(T, X, O).