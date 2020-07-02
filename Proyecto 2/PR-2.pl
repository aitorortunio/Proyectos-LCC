/*
Tablero a modo de ejemplo :

   C1  C2  C3  C4  C5
F1  [v1, a1, a1, r1, v1]
F2  [r1, v1, a1, v1, v1]
F3  [r1, v1, a1, v1, a1]
F4  [a1, a1, r1, v1, r1]
F5  [r1, r1, a1, r1, v1]

Casos de prueba:

* --------Caso1------------
_X = [[a1, v1, v1, r1, v1],
     [a1, a1, v1, a1, a1],
     [a1, r2, r2, a1, r1],
     [r2, v1, v2, a1, r1],
     [v1, a3, a3, v1, r3]],
desplazar(der, 2, 2, _X, _N),
member(TableroX, [ _X | _N]).

* --------Caso2------------

_X = [[v2, v1, v1, r1, v1],
     [a1, a1, v1, a1, a1],
     [v2, r2, r2, a1, r1],
     [r2, v1, v2, a1, r1],
     [v1, a3, a3, v1, r3]],
desplazar(der, 2, 2, _X, _N),
member(TableroX, [ _X | _N]).

* --------Caso3------------

_X = [[r2, v1, a1, v1, r1],
     [r2, a2, r2, a1, v2],
     [v1, a2, v2, v2, r1],
     [a2, v3, r1, a2, a2],
     [v2, v1, a3, v1, r2]],
desplazar(der, 4, 2, _X, _N),
member(TableroX, [ _X | _N]).

* --------Caso4------------

_X = [[v1, a1, a1, v1, v2],
     [v1, r2, a1, a1, r1],
     [a1, r1, r2, a1, a1],
     [a3, r2, v1, r1, r1],
     [a1, v1, a1, v3, a1]],
desplazar(izq, 3, 1, _X, _N),
member(TableroX, [ _X | _N]).

* --------Caso5------------

_X = [[r1, a1, a1, v1, v1],
     [a1, r1, a1, v1, v1],
     [r1, a1, a1, a1, r1],
     [v1, r1, r1, v1, a1],
     [r1, r1, a1, v1, a1]],
desplazar(der, 3, 1, _X, _N),
member(TableroX, [ _X | _N]).

* --------Caso6------------

_X = [[r1, a1, a1, v1, v1],
     [a1, r1, a2, a2, v1],
     [r2, v1, a2, a2, a2],
     [v1, r1, a2, a2, a1],
     [r1, r1, a1, v1, a1]],
desplazar(der, 3, 5, _X, _N),
member(TableroX, [ _X | _N]).

* --------Caso7------------

_X = [[r1, a1, r1, r1, v1],
     [a1, r1, v1, r1, v1],
     [r1, r1, r1, r1, a2],
     [v1, r2, a1, a2, a1],
     [r1, r1, a1, v1, a1]],
desplazar(der, 3, 0, _X, _N),
member(TableroX, [ _X | _N]).

* --------Caso8------------

_X = [[r1, r1, r1, r1, v1],
     [v1, v1, r1, a1, r1],
     [r1, v1, a1, r1, r1],
     [v1, r2, a2, r1, a1],
     [r1, r1, a1, r1, a1]],
desplazar(der, 1, 2, _X, _N),
member(TableroX, [ _X | _N]).

* --------Caso9------------
_X = [[r1, r1, a1, v1, v1],
     [a1, r1, a1, v1, v1],
     [r1, a1, a1, a1, a1],
     [r1, r1, r1, v1, a1],
     [r1, r1, a1, v1, a1]],
desplazar(abajo, 3, 1, _X, _N),
member(TableroX, [ _X | _N]).

*/

:-use_rendering(table).

tamanio1[a1,r1,v1].
tamanio2[a2,r2,v2].
tamanio3[a3,r3,v3].

colorA[a1,a2,a3].
colorR[r1,r2,r3].
colorV[v1,v2,v3].

obtenerTamanio(Mamushka, 1):-
member(Mamushka,tamanio1).
obtenerTamanio(Mamushka, 2):-
member(Mamushka,tamanio2).
obtenerTamanio(Mamushka, 3):-
member(Mamushka,tamanio3).

obtenerColor(Mamushka, a):-
member(Mamushka,colorA).
obtenerColor(Mamushka, r):-
member(Mamushka,colorR).
obtenerColor(Mamushka, v):-
member(Mamushka,colorV).

siguienteTamanio(a1,a2).
siguienteTamanio(a2,a3).
siguienteTamanio(a3,a3).
siguienteTamanio(r1,r2).
siguienteTamanio(r2,r3).
siguienteTamanio(r3,r3).
siguienteTamanio(v1,v2).
siguienteTamanio(v2,v3).
siguienteTamanio(v3,v3).


/*
Genera un Tablero aleatorio.
+Num: Dimension del tablero a generar.
-Tablero: Tablero generado aleatoriamente.
*/
generarTablero(Num, Tablero):-
  recorrerTableroAux(Num, Num, Tablero),
  !.

recorrerTableroAux(0, _Num, []).
recorrerTableroAux(Iteraciones, LongitudTablero, [FilaRandom|Tablero]):-
  generarFilaRandom(LongitudTablero, FilaRandom),
  decrementar(Iteraciones, DecreasedIteraciones),
  recorrerTableroAux(DecreasedIteraciones, LongitudTablero,Tablero).

generarFilaRandom(0, []).
generarFilaRandom(Iteraciones, FilaRandom):-
  random(1, 4, Color),
  decrementar(Iteraciones, DecreasedIteraciones),
  generarFilaRandom(DecreasedIteraciones, FilaNueva),
  agregarMamushka(Color, FilaNueva, FilaRandom).

/*
Agrega una mamushka a la lista.
+Color: Numero aleatorio para asignarle una mamushka.
+Fila: Fila a la cual agrega la nueva mamushka.
-FilaNueva: Fila con la nueva mamushka agregada.
*/
agregarMamushka(Color, Fila, FilaNueva):-
  Color = 1,
  addLast(a1, Fila, FilaNueva).
agregarMamushka(Color, Fila, FilaNueva):-
  Color = 2,
  addLast(r1, Fila, FilaNueva).
agregarMamushka(Color, Fila, FilaNueva):-
  Color = 3,
  addLast(v1, Fila, FilaNueva).

/*
METODO PRINCIPAL PARA JUGAR
+Dir: Dirección del movimiento que se realiza.
+Num: Posición de la fila o columna que se desea desplazar.
+Cant: Cantidad de lugares que se quiere mover en la dirección indicada.
+Tablero: Tablero actual del juego.
-EvoTablero: Lista que muestra la evolución del tablero de juego.
*/
desplazar(Dir, Num, Cant, Tablero, TableroFinal):-
  corrimiento(Dir, Num, Cant, Tablero, TableroCorrido),
  colapsar(Dir, Num, TableroCorrido, TableroColapsado),
  gravedad(TableroColapsado, TableroConGravedad),
  rellenar(TableroConGravedad, TableroRelleno),
  colapsoEnCadena(TableroRelleno, TableroEnCadena),
  Mostrar = [TableroCorrido, TableroColapsado, TableroConGravedad, TableroRelleno],
  append(Mostrar, TableroEnCadena, TableroFinal),
  !.

/*
  Dado un tablero, realizo los colapsos en cadena que sean necesarios.
  +Tablero: Tablero a realizar los colapsos múltiples.
  -Lista: Lista con la evolución de los tableros.
 */
%--------Caso que hay colapso-----------
colapsoEnCadena(Tablero, [TableroColapsado,TableroGravedad,TableroRelleno|TableroFinal]):-
  length(Tablero, Longitud),
  colapsarAux(Longitud, Tablero, TableroColapsado),
  Tablero \= TableroColapsado,
  gravedad(TableroColapsado, TableroGravedad),
  rellenar(TableroGravedad, TableroRelleno),
  colapsoEnCadena(TableroRelleno, TableroFinal).

%--------Caso que no hay colapso--------
colapsoEnCadena(_Tablero, []).


colapsarAux(0, Tablero, Tablero).
colapsarAux(Longitud, Tablero, TableroFinal):-
  colapsar(der, 2, Tablero, TableroColapsado),
	decrementar(Longitud, DecreasedLongitud),
  colapsarAux(DecreasedLongitud, TableroColapsado, TableroFinal),
  !.

%-----------------------------Corrimiento-------------------------------------------------------
/*
  Dependiendo la dirección recibida deriva al método correspondiente (corrimientoHorizontal o corrimientoVertical)
  y los procedimientos subsiguientes para realizar el corrimiento de la fila o columna correspondiente.
  +Dir: Dirección del movimiento que se realiza.
  +Num: Posición de la fila o columna que se desea desplazar.
  +Cant: Cantidad de lugares que se quiere mover en la dirección indicada.
  +Tablero: Tablero actual del juego.
  -NuevoTablero: Tablero con el corrimiento indicado aplicado.
 */
corrimiento(Dir, Num, Cant, Tablero, NuevoTablero):-
  (Dir = izq ; Dir = der),
  buscarFila(1, Num, Tablero, Fila),
  corrimientoHorizontal(Dir, Cant, Fila, FilaNueva),
  reemplazarFila(Fila, FilaNueva, Tablero, NuevoTablero).

corrimiento(Dir, Num, Cant, Tablero, NuevoTablero):-
  (Dir = arriba ; Dir = abajo),
  buscarColumna(Num, Tablero, Columna),
  corrimientoVertical(Dir, Cant, Columna, ColumnaNueva),
  reemplazarColumna(Num, ColumnaNueva, Tablero, NuevoTablero).

/*
  Realiza el corrimiento de una fila.
  +Dir: Dirección del movimiento que se realiza.
  +Cant: Cantidad de lugares que se quiere mover en la dirección indicada.
  +Fila: Fila a desplazar.
  -FilaNueva: Fila desplazada.
*/
corrimientoHorizontal(Dir, Cant, Fila, FilaNueva):-
  Dir = der,
  desplazamientoAbajoDerecha(Cant, Fila, FilaNueva).

corrimientoHorizontal(Dir, Cant, Fila, FilaNueva):-
  Dir = izq,
  NCant is 5-Cant,
  desplazamientoAbajoDerecha(NCant, Fila, FilaNueva).

/*
  Realiza el corrimiento de una fila.
  +Dir: Dirección del movimiento que se realiza.
  +Cant: Cantidad de lugares que se quiere mover en la dirección indicada.
  +Columna: Columna a desplazar.
  -ColumnaNueva: Columna desplazada.
*/
corrimientoVertical(Dir, Cant, Columna, ColumnaNueva):-
  Dir = abajo,
  desplazamientoAbajoDerecha(Cant, Columna, ColumnaNueva).

corrimientoVertical(Dir, Cant, Columna, ColumnaNueva):-
  Dir = arriba,
  NCant is 5-Cant,
  desplazamientoAbajoDerecha(NCant, Columna, ColumnaNueva).

/*
  Desplaza cant veces a derecha una fila o cant veces hacia abajo una columna,
  como tanto filas como columnas son listas, para este metodo es indistinto
  de que caso se trata.
  +Cant: Cantidad de desplazamientos que se le aplica a la Fila.
  +Fila: Fila a desplazar.
  -NuevaFila: Fila con el desplazamiento aplicado.
*/
desplazamientoAbajoDerecha(0, L, L).
desplazamientoAbajoDerecha(Cant, Fila, NuevaFila):-
  Cant \= 0,
  desplazarAbajo_Der(Fila, FilaDesplazada),
  decrementar(Cant, NCant),
  desplazamientoAbajoDerecha(NCant, FilaDesplazada, NuevaFila).

/*
  Desplaza una posición a la derecha la lista.
  +Lista: Lista a desplazar.
  -NuevaLista: Lista con el desplazamiento aplicado.
  */
desplazarAbajo_Der([H|T], RTA):-
  ultimoElemento(T, Ult),
  eliminarUltimo([H|T], Lista),
  addFirst(Ult, Lista, RTA).

%------------------------Colapsar---------------------------------------------------

/*
  Dada la fila o columna donde se realizo el movimiento en un tablero,
  reviso esa fila o columna y si hay un match de 3, 4 o 5 mamushkas las colapso
  en una nueva mamushka de un tamanio más grande
  +Dir: Dirección del movimiento que se realiza.
  +Num: Posición de la fila o columna que se desea desplazar.
  +Tablero: Tablero actual del juego.
  -TableroColapsado: Tablero con el colapso aplicado.
*/
colapsar(Dir, Num, Tablero, TableroColapsado):-
  (Dir = izq ; Dir = der),
  buscarFila(1, Num, Tablero, Fila),
  length(Tablero, Longitud),
  colapsarColumnas(Longitud, Num, Tablero, TableroInvertido),
  invertirTablero(Longitud, TableroInvertido, TableroNuevo),
  colapsarFilas(Longitud, TableroNuevo, TableroNuevo2),
  colapsarFila(Fila, Num, Tablero, FilaEspecial),
  reemplazarFilaEspecial(FilaEspecial, 1, Num, TableroNuevo2, TableroColapsado).

colapsar(Dir, Num, Tablero, TableroFinal):-
  (Dir = abajo ; Dir = arriba),
  length(Tablero, Longitud),
  invertirTablero(Longitud, Tablero, TableroInvertido),
  colapsar(der, Num, TableroInvertido, TableroColapsado),
  invertirTablero(Longitud, TableroColapsado, TableroFinal).

colapsarFilas(0, Tablero, Tablero).
colapsarFilas(Iteracion, Tablero, TableroNuevo):-
  buscarFila(1, Iteracion, Tablero, Fila),
  colapsarFila(Fila, 0, Tablero, FilaColapsada),
  reemplazarFilaEspecial(FilaColapsada, 1, Iteracion, Tablero, TableroAux),
  decrementar(Iteracion, DecreasedIteracion),
  colapsarFilas(DecreasedIteracion, TableroAux, TableroNuevo).

colapsarColumnas(0, _Num, _Tablero, []).
colapsarColumnas(Iteracion, Num, Tablero, TableroNuevo):-
  buscarColumna(Iteracion, Tablero, Columna),
  colapsarListaCascara(Columna, Num, ColumnaColapsada),
  decrementar(Iteracion, DecreasedIteracion),
  colapsarColumnas(DecreasedIteracion, Num, Tablero, Nuevo),
  addLast(ColumnaColapsada, Nuevo, TableroNuevo).

/*
  Método cáscara para buscar más parámetros para el método colapsarLista.
  Input =[a1,v1,v1,v1,r1], 2 => Output [a1,v2,x,x,r1]
  +ListaAColapsar: Lista original a colapsar.
  +Num: Posicion de la ListaAColapsar dentro del Tablero.
  -ListaColapsada: Lista con el colapso aplicado como corresponda segun Num.
*/
colapsarListaCascara(ListaAColapsar, Num, ListaColapsada):-
  ubicarMatch(ListaAColapsar, 1, 1, 1, 1, [MaxMatch, PosInicial]),
  PosFinal is (MaxMatch + PosInicial - 1),
  obtenerElemento(Num, ListaAColapsar, MamushkaActual),
  MamushkaActual \= x,
  siguienteTamanio(MamushkaActual, MamushkaAColocar),
  colapsarLista(ListaAColapsar, MaxMatch, 1, PosInicial, PosFinal, Num, MamushkaAColocar, ListaColapsada).


colapsarListaCascara(ListaAColapsar, _Num, ListaAColapsar).


/*
  Dada una Lista inicial, realizo el colapso si corresponde.
  Si no hay Match retorno la misma lista.
  Dado que tengo dos "punteros" a donde el match comienza y termina en la ListaAColapsar
  Si no me encuentro entre medio de estos dos, avanzo hasta llegar al match manteniendo la lista igual.
  Si estoy en la zona que tengo que reemplazar, coloca la MamushkaAColocar a donde correspoda, y x's
  en los demás.
  +Lista: Lista a la cual se le ubica el MaxMatch.
  +MaxMatch = Maxima cantidad de mamushkas iguales seguidas.
  +Iteracion: Posición del elemento que se esta revisando dentro de la lista.
  +PosInicial = Posicion donde comienza el MaxMatch dentro de la lista.
  +PosFinal = Posicion donde termina el MaxMatch dentro de la lista.
  +Num = Posicion donde se debe colocar la MamushkaAColocar.
  +MamushkaAColocar: Mamushka de siguiente tamanio de las que formaban parte del Match.
  -ListaColapsada: Lista con el colapso aplicado.
 */
colapsarLista([], _MaxMatch, _Iteracion, _PosInicial, _PosFinal, _Num, _MamushkaAColocar, []).

colapsarLista([H|T], MaxMatch, Iteracion, PosInicial, PosFinal, Num, MamushkaAColocar, [H|ListaColapsada]):-
  MaxMatch > 2,
  (Num < PosInicial ; Num > PosFinal),
  NuevoNum is (PosInicial+PosFinal)//2,
  NIteracion is Iteracion+1,
  colapsarLista(T, MaxMatch, NIteracion, PosInicial, PosFinal, NuevoNum, MamushkaAColocar, ListaColapsada),
  !.

colapsarLista([H|T], MaxMatch, Iteracion, PosInicial, PosFinal, Num, MamushkaAColocar, [H|ListaColapsada]):-
  MaxMatch > 2,
  (PosInicial > Iteracion ; PosFinal < Iteracion),
  NIteracion is Iteracion+1,
  colapsarLista(T, MaxMatch, NIteracion, PosInicial, PosFinal, Num, MamushkaAColocar, ListaColapsada),
  !.

colapsarLista([H|T], MaxMatch, Iteracion, PosInicial, PosFinal, Num, MamushkaAColocar, [NuevaMamushkaAColocar|ListaColapsada]):-
  MaxMatch > 2,
  Num = Iteracion,
  siguienteTamanio(H, NuevaMamushkaAColocar),
  NIteracion is Iteracion+1,
  colapsarLista(T, MaxMatch, NIteracion, PosInicial, PosFinal, Num, MamushkaAColocar, ListaColapsada),
  !.

colapsarLista([_H|T], MaxMatch, Iteracion, PosInicial, PosFinal, Num, MamushkaAColocar, [x|ListaColapsada]):-
  MaxMatch > 2,
  Iteracion >= PosInicial,
  PosFinal >= Iteracion,
  NIteracion is Iteracion+1,
  colapsarLista(T, MaxMatch, NIteracion, PosInicial, PosFinal, Num, MamushkaAColocar, ListaColapsada),
  !.

colapsarLista(ListaAColapsar, _MaxMatch, _Iteracion, _PosInicial, _PosFinal, _Num, _MamushkaAColocar, ListaAColapsar).


colapsarFila(Fila, Num, Tablero, FilaColapsada):-
  ubicarMatch(Fila, 1, 1, 1, 1, [MaxMatch, PosInicial]),
  PosFinal is (MaxMatch + PosInicial -1),
  armarFilaPintada(Fila, MaxMatch, 1, PosInicial, PosFinal, FilaPintada),
  armarFilaPintadaEspecial(FilaPintada, Num, 1, MaxMatch, PosInicial, PosFinal, Tablero, MatchsValidos),
  length(Tablero, Longitud),
  colapsarFilaEspecial(FilaPintada, 1, Longitud, PosInicial, PosFinal, MatchsValidos, FilaColapsada).

/*
  Dada una lista la "pinta" marcando con nc los elementos que no cambian y dejando iguales
  los que forman parte del match de la lista. Si no existe match entonces el resultado es [nc,nc,nc,nc,nc].
  Ej: Input [r1,a1,a1,a1,r1] => [nc,a1,a1,a1,nc].
  +Lista: Lista a pintar.
  +MaxMatch: Cantidad máxima de mamushkas seguidas iguales en la lista.
  +Iteracion: Posición del elemento que se esta revisando dentro de la lista.
  +PosInicial: Posición Inicial del match en la lista.
  +PosFinal: Posición Final del match en la lista.
  -ListaPintada: Lista pintada según el match que exista.
*/
armarFilaPintada([], _MaxMatch, _Iteracion, _PosInicial, _PosFinal, []).

armarFilaPintada([_H|T], MaxMatch, Iteracion, PosInicial, PosFinal, [nc|ListaColapsada]):-
  MaxMatch > 2,
  (PosInicial > Iteracion ; PosFinal < Iteracion),
  NIteracion is Iteracion+1,
  armarFilaPintada(T, MaxMatch, NIteracion, PosInicial, PosFinal,  ListaColapsada),
  !.

armarFilaPintada([H|T], MaxMatch, Iteracion, PosInicial, PosFinal, [H|ListaColapsada]):-
  MaxMatch > 2,
  Iteracion >= PosInicial,
  PosFinal >= Iteracion,
  NIteracion is Iteracion+1,
  armarFilaPintada(T, MaxMatch, NIteracion, PosInicial, PosFinal, ListaColapsada),
  !.

armarFilaPintada([_H|T], MaxMatch, Iteracion, PosInicial, PosFinal, [nc|ListaAColapsar]):-
  MaxMatch < 3,
  NIteracion is Iteracion+1,
  armarFilaPintada(T, MaxMatch, NIteracion, PosInicial, PosFinal, ListaAColapsar).

/*
  Dada una lista "pintada", ubica donde colapsar correctamente las mamushkas según
  los colapsos cruzados que tenga.
  +Lista: Lista a pintar de forma especial.
  +Num: Posición de la fila en el tablero.
  +Iteracion: Posición del elemento que se esta revisando dentro de la lista.
  +PosInicial: Posición Inicial del match en la lista.
  +PosFinal: Posición Final del match en la lista.
  +Tablero: Tablero donde se encuentra la columna de la posición Iteración.
  -MatchsNuevo: Lista con todos los matchs cruzados que tiene Lista.
*/
armarFilaPintadaEspecial([], _Num, _Iteracion, _MaxMatch, _PosInicial, _PosFinal, _Tablero, []).

armarFilaPintadaEspecial([_H|T], Num, Iteracion, MaxMatch, PosInicial, PosFinal, Tablero, [Iteracion|MatchsNuevo]):-
  MaxMatch > 2,
  PosInicial =< Iteracion,
  PosFinal >= Iteracion,
  buscarColumna(Iteracion, Tablero, Columna),
  matchValido(Columna, Num, Iteracion, PosInicial, PosFinal, Valido),
  Valido = 1,
  NIteracion is Iteracion+1,
  armarFilaPintadaEspecial(T, Num, NIteracion, MaxMatch, PosInicial, PosFinal, Tablero, MatchsNuevo).

armarFilaPintadaEspecial([_H|T], Num, Iteracion, MaxMatch, PosInicial, PosFinal, Tablero, MatchsNuevo):-
  MaxMatch > 2,
  PosInicial =< Iteracion,
  PosFinal >= Iteracion,
  NIteracion is Iteracion+1,
  armarFilaPintadaEspecial(T, Num, NIteracion, MaxMatch, PosInicial, PosFinal, Tablero, MatchsNuevo).

armarFilaPintadaEspecial([_H|T], Num, Iteracion, MaxMatch, PosInicial, PosFinal, Tablero, MatchsNuevo):-
  MaxMatch > 2,
  (PosInicial > Iteracion ; PosFinal < Iteracion),
  NIteracion is Iteracion+1,
  armarFilaPintadaEspecial(T, Num, NIteracion, MaxMatch, PosInicial, PosFinal, Tablero, MatchsNuevo).

armarFilaPintadaEspecial([], _Num, Iteracion, _MaxMatch, _PosInicial, _PosFinal, Tablero, _MatchsTablero):-
    length(Tablero, Longitud),
    Iteracion > Longitud.

armarFilaPintadaEspecial(_Fila, _Num, _Iteracion, MaxMatch, _PosInicial, _PosFinal, _Tablero, []):-
  MaxMatch < 3.

/*
  Dada una lista "pintada", ubica donde colapsar correctamente las mamushkas según
  la cantidad de mamushkas que colapsan y si tienen un colapso cruzado. De ser este caso,
  deja la mamushkaSiguiente en la posición del primer cruce de izquierda a derecha o arriba a abajo.
  Ej: Si no hay colapsos cruzados, sólo es un colapso por extremos.
    [nc,a1,a1,a1,nc] => [nc,x,a2,x,nc]
  Ej: Si hay un colapso cruzado en la última columna que coincide con el match de la fila.
    [nc,a1,a1,a1,nc] => [nc,x,x,a2,nc]
  +Lista: Lista a pintar de forma especial.
  +Iteracion: Posición del elemento que se esta revisando dentro de la lista.
  +PosInicial: Posición Inicial del match en la lista.
  +PosFinal: Posición Final del match en la lista.
  +Tablero: Tablero donde se encuentra la columna de la posición Iteración.
  +Matchs: Lista con todos los matchs cruzados que tiene Lista.
  -ListaPintadaColapsada: Lista colapsada correctamente según matchs cruzados o sólo colapso por extremos.
*/
%------------------------------Caso lista vacia-----------------------------------------------------------
colapsarFilaEspecial([], _Iteracion, _Longitud, _PosInicial,_PosFinal, [], []).

colapsarFilaEspecial([], _Iteracion, _Longitud, _PosInicial, _PosFinal, [_PrimerColumna|_T], []).

colapsarFilaEspecial([H|T], Iteracion, Longitud, PosInicial, PosFinal, [], [H|Lista]):-
  (Iteracion < PosInicial ; Iteracion > PosFinal),
  NIteracion is Iteracion+1,
  colapsarFilaEspecial(T, NIteracion, Longitud, PosInicial, PosFinal, [], Lista).

colapsarFilaEspecial([H|T], Iteracion, Longitud, PosInicial, PosFinal, [], [MamushkaNueva|Lista]):-
  Iteracion is (PosInicial+PosFinal)//2,
  siguienteTamanio(H, MamushkaNueva),
  NIteracion is Iteracion+1,
  colapsarFilaEspecial(T, NIteracion, Longitud, PosInicial, PosFinal, [], Lista).

colapsarFilaEspecial([_H|T], Iteracion, Longitud, PosInicial, PosFinal, [], [x|Lista]):-
  Tope is Longitud -1,
  PosInicial < Tope,
  Iteracion >= PosInicial,
  Iteracion =< PosFinal,
  NIteracion is Iteracion+1,
  colapsarFilaEspecial(T, NIteracion, Longitud, PosInicial, PosFinal, [], Lista).

colapsarFilaEspecial(Fila, _Iteracion, Longitud, PosInicial, _PosFinal, [], Fila):-
    Tope is Longitud -2,
    PosInicial > Tope.

%-------------------------------Caso lista no vacia-------------------------------------------------------------------
colapsarFilaEspecial([H|T], Iteracion, Longitud, PosInicial, PosFinal, [PrimerColumna|T2], [H|Lista]):-
  (Iteracion < PosInicial ; Iteracion > PosFinal),
  NIteracion is Iteracion+1,
  colapsarFilaEspecial(T, NIteracion, Longitud, PosInicial, PosFinal, [PrimerColumna|T2], Lista).

colapsarFilaEspecial([H|T], Iteracion, Longitud, PosInicial, PosFinal, [PrimerColumna|T2], [MamushkaNueva|Lista]):-
  Iteracion = PrimerColumna,
  siguienteTamanio(H, MamushkaNueva),
  NIteracion is Iteracion+1,
  colapsarFilaEspecial(T, NIteracion, Longitud, PosInicial, PosFinal, [PrimerColumna|T2], Lista).

colapsarFilaEspecial([_H|T], Iteracion, Longitud, PosInicial, PosFinal, [PrimerColumna|T2], [x|Lista]):-
  Iteracion >= PosInicial,
  Iteracion =< PosFinal,
  NIteracion is Iteracion+1,
  colapsarFilaEspecial(T, NIteracion, Longitud, PosInicial, PosFinal, [PrimerColumna|T2], Lista).

/*
  Dada una lista, ubico a donde se encuentra el match.
  Me sirve si el MaxMatch >= 3.
  +Lista: Lista a la cual se le ubica el MaxMatch.
  +Cant = Lleva la cuenta de la cantidad de mamushkas iguales seguidas hasta el momento.
  +MaxMatch = Maxima cantidad de mamushkas iguales seguidas.
  +PosInicial = Posicion donde comienza el MaxMatch dentro de la lista.
  +PosActual = Posicion del elemento revisado actualmente dentro de la lista.
  +Resultado = Lista con 2 elementos, MaxMatch y PosInicial del MaxMatch de Lista.
 */
ubicarMatch([_H], _Cant, MaxMatch, PosInicial, _PosActual, Resultado):-
 Resultado = [MaxMatch, PosInicial].

ubicarMatch([x|T], _Cant, MaxMatch, PosInicial, PosActual, Resultado):-
  NPosActual is PosActual+1,
  PosInicial is NPosActual,
  ubicarMatch(T, 1, MaxMatch, PosInicial, NPosActual, Resultado),
  !.

ubicarMatch([H,T|Ts], _Cant, MaxMatch, PosInicial, PosActual, Resultado):-
  H \= T,
  NPosActual is PosActual+1,
  MaxMatch > 2,
  ubicarMatch([T|Ts], 1, MaxMatch, PosInicial, NPosActual, Resultado),
  !.

ubicarMatch([H,T|Ts], _Cant, MaxMatch, _PosInicial, PosActual, Resultado):-
  H \= T,
  NPosActual is PosActual+1,
  NPosInicial is NPosActual,
  ubicarMatch([T|Ts], 1, MaxMatch, NPosInicial, NPosActual, Resultado),
  !.

ubicarMatch([H,T|Ts], Cant, MaxMatch, PosInicial, PosActual, Resultado):-
  H = T,
  NCant is Cant+1,
  NPosActual is PosActual+1,
  comprobarNuevoMaxMatch(NCant, MaxMatch, NMaxMatch),
  ubicarMatch([T|Ts], NCant, NMaxMatch, PosInicial, NPosActual, Resultado),
  !.

/*
  Actualizo MaxMatch si la cantidad que estoy contando
  actualmente es mayor al actual MaxMatch.
  +NCant: Cantidad de matchs de la iteración actual.
  +MaxMatch: Cantidad máxima de matchs hasta el momento.
  -NMaxMatch: Nuevo MaxMatch.
*/
comprobarNuevoMaxMatch(NCant, MaxMatch, NCant):-
  NCant > MaxMatch.

comprobarNuevoMaxMatch(_NCant, MaxMatch, MaxMatch).

/*
  Devuelve 1 en caso de que haya un match y que corresponda a la fila movida
  0 en caso contrario.
  +Columna: Columna a revisar por match.
  +NumFila: Posicion de la fila en el tablero.
  +Pos: Posicion de la columna.
  +PosInicialFila: Posicion inicial del match en la fila.
  +PosFinalFila: Posicion final del match en la fila.
  -Valido: Validez del match cruzado.
*/
matchValido(Columna, NumFila, Pos, PosInicialFila, PosFinalFila, 1):-
  hayMatch(Columna),
  ubicarMatch(Columna, 1, 1, 1, 1, [MaxMatch, PosInicialCol]),
  PosFinalCol is (MaxMatch + PosInicialCol - 1),
  PosInicialFila =< Pos,
  PosFinalFila >= Pos,
  PosInicialCol =< NumFila,
  PosFinalCol >= NumFila,
  !.

matchValido(_Columna, _Pos, _PosInicial, _PosFinal, 0).

/*
  Retorna verdadero en caso de haber un match en la lista pasada por parametro.
  Falso en caso contrario.
  +Lista: Lista a revisar por matchs.
*/
hayMatch([H, T, Ts|_]):-
  H = T,
  comparoSiguiente(H, Ts),
  !.

hayMatch([_H|T]):-
  hayMatch(T).

/*
  Recorre la fila pintada Especial y si el elemento cambió, es decir
  que no es 'nc' entonces lo reemplaza en la fila correspondiente del Tablero.
  +Lista: Lista pintada Especial.
  +Iteracion: Posicion del elemento en la lista que se esta recorriendo.
  +Tablero: Tablero donde se va a reemplazar la lista pintada.
  -TableroNuevo: Tablero con la lista pintada especial reemplazada en Tablero.
 */
reemplazarFilaEspecial([], _Iteracion, _Num, Tablero, Tablero).

reemplazarFilaEspecial([H|T], Iteracion, Num, Tablero, TableroNuevo):-
  H = nc,
  NIteracion is Iteracion+1,
  reemplazarFilaEspecial(T, NIteracion, Num, Tablero, TableroNuevo).

reemplazarFilaEspecial([H|T], Iteracion, Num, Tablero, TableroNuevo):-
  buscarFila(1, Num, Tablero, Fila),
  reemplazarElemento(Iteracion, Fila, H, FilaNueva),
  reemplazarElemento(Num, Tablero, FilaNueva, TableroAux),
  NIteracion is Iteracion +1,
  reemplazarFilaEspecial(T, NIteracion, Num, TableroAux, TableroNuevo).

/*
+Iteraciones: Cantidad de columnas y filas que tiene el tablero.
+Tablero: Tablero a invertir.
+TableroInvertido: Tablero invertido.
*/
invertirTablero(0, _Tablero, []).
invertirTablero(Iteraciones, Tablero, TableroInvertido):-
buscarColumna(Iteraciones, Tablero, Columna),
decrementar(Iteraciones, DecreasedIteraciones),
invertirTablero(DecreasedIteraciones, Tablero, TableroNuevo),
addLast(Columna, TableroNuevo, TableroInvertido),
!.

%------------------------------Gravedad----------------------------------------------------------------------
/*
  Dado un tablero, busco las X's (futuras posiciones a reemplaza por mamushkas)
  y las lleva los más arriba posible (en su correspondiente columna) en un nuevo tablero.
  +TableroColapsado: Tablero al cual aplicarle gravedad.
  -TableroConGravedad: Tablero con la gravedad aplicada.
*/
gravedad(TableroColapsado, TableroConGravedad):-
  length(TableroColapsado, Longitud),
  gravedadColumnas(Longitud, TableroColapsado, TableroConGravedad),
  !.

/*
  Realiza lo descripto en gravedad con el agregado de que tiene un parámetro más
  para saber a que columna le aplica la gravedad en cada iteración.
  +Iteraciones: Número de iteración actual, comienza desde el largo de la lista.
  +TableroColapsado: Tablero al cual aplicarle gravedad.
  -TableroConGravedad: Tablero con la gravedad aplicada.
*/
gravedadColumnas(0, Tablero, Tablero).
gravedadColumnas(Iteraciones, Tablero, TableroGravedad):-
  buscarColumna(Iteraciones, Tablero, Columna),
  columnaGravedad(Columna, Tablero, ColumnaGravedad),
  reemplazarColumna(Iteraciones, ColumnaGravedad, Tablero, TableroNuevo),
  decrementar(Iteraciones, DecreasedIteraciones),
  gravedadColumnas(DecreasedIteraciones, TableroNuevo, TableroGravedad).

/*
  Separo la columna en dos listas. Lista de X's y lista de mamushkas y las concateno en ese orden.
  +Columna: Columna a la cual se le aplica la gravedad.
  -ColumnaGravedad: Columna con la gravedad aplicada.
*/
columnaGravedad(Columna, Tablero, ColumnaGravedad):-
  length(Tablero, Longitud),
  listarX(Longitud, Columna, [], ColumnaSinMamushkas),
  listarMamushkas(Longitud, Columna, [], ColumnaSinX),
  append(ColumnaSinMamushkas, ColumnaSinX, ColumnaGravedad).

/*
  +Pos: Numero de posicion actual, comienza desde el largo de la lista.
  +Columna: Columna original.
  +Lista: Lista a donde agrego las X's.
  -ColumnaSinMamushkas: Lista sin las mamushkas, sólo con las X's.
*/
listarX(0, _Columna , Lista, Lista).
listarX(Pos, [x|T], Lista, [x|ColumnaSinMamushkas]):-
  decrementar(Pos, DecreasedPos),
  listarX(DecreasedPos, T, Lista, ColumnaSinMamushkas).
listarX(Pos, [A|T], Lista, ColumnaSinMamushkas):-
  A \= x,
  decrementar(Pos, DecreasedPos),
  listarX(DecreasedPos, T, Lista, ColumnaSinMamushkas).

/*
  +Pos: Número de posición actual, comienza desde el largo de la lista.
  +Columna: Columna original.
  +Lista: Lista a donde agrego las mamushkas.
  -ColumnaSinMamushkas: Lista sin las X's, sólo con las mamushkas.
*/
listarMamushkas(0, _Columna , Lista, Lista).
listarMamushkas(Pos, [A|T], Lista, [A|ColumnaSinX]):-
  A \= x,
  decrementar(Pos, DecreasedPos),
  listarMamushkas(DecreasedPos, T, Lista, ColumnaSinX).
listarMamushkas(Pos, [x|T], Lista, ColumnaSinX):-
  decrementar(Pos, DecreasedPos),
  listarMamushkas(DecreasedPos, T, Lista, ColumnaSinX).

%--------------------------Rellenar-----------------------------------------------------
/*
  Dado un tablero, busca X's y las reemplaza con mamushkas al azar de tamanio 1.
  +TableroConGravedad: Tablero con la gravedad aplicada.
  -TableroRelleno: Devuelve el tablero con mamushkas random ingresadas.
*/
rellenar(TableroConGravedad, TableroRelleno):-
  length(TableroConGravedad, Longitud),
  recorrerFilasParaRellenar(Longitud, TableroConGravedad, TableroRelleno).

/*
  Recorre todas las filas para reemplazar los espacios vacios('X') por una mamushka de tamaño chico con color aleatorio.
  +Iteraciones: Número de iteracion actual, comienza desde el largo de la lista.
  +TableroConGravedad: Tablero con la gravedad aplicada.
  -TableroRelleno: Devuelve el tablero con mamushkas random ingresadas.
*/
recorrerFilasParaRellenar(0, _TableroConGravedad, []).
recorrerFilasParaRellenar(Iteraciones, TableroConGravedad, TableroRelleno):-
  buscarFila(1, Iteraciones, TableroConGravedad, Fila),
  rellenarFila(Fila, FilaRellena),
  decrementar(Iteraciones, DecreasedIteraciones),
  recorrerFilasParaRellenar(DecreasedIteraciones, TableroConGravedad, TableroNuevo),
  addLast(FilaRellena, TableroNuevo, TableroRelleno).

/*
  Reemplaza los lugares vacios('x') con mamushkas color random de tamaño chico.
  +Fila: Fila a rellenar los lugares con 'x'.
  +FilaRellena: Fila rellena con mamushkas en los lugares donde había 'x'.
*/
rellenarFila([], []).
rellenarFila([A|T], [A|FilaRellena]):-
  A \= x,
  rellenarFila(T, FilaRellena).
rellenarFila([x|T], [A|FilaRellena]):-
  random(1, 4, C),
  agregarMamushka(C, [], [A|_B]),
  rellenarFila(T, FilaRellena).

%---------------------------------Metodos complementarios------------------------------------------

/*
  Reemplaza la columna Num del Tablero por Columnanueva y la reemplaza en el tablero.
  +Num: Posición de la columna a ser reemplazada.
  +ColumnaNueva: Columna que va reemplazar a la columna de la posición Num.
  +Tablero: Tablero que contiene la columna  de las posición Num.
  -NuevoTablero: Tablero con ColumnaNueva reemplazada en Num.
*/
reemplazarColumna(Num, ColumnaNueva, Tablero, NuevoTablero):-
  length(Tablero, Longitud),
  recorrerFilasParaReemplazar(Longitud, Num, ColumnaNueva, Tablero, NuevoTablero).

/*
  Recorre todas las filas y arma la lista con todos los elementos de esa columna.
  +Iteraciones: Numero de iteracion actual, comienza desde el largo de la lista.
  +Num: Posición de la columna a ser reemplazada.
  +ColumnaNueva: Columna que va reemplazar a la columna de la posición Num.
  +Tablero: Tablero que contiene la columna  de las posicion Num.
  -NuevoTablero: Tablero con ColumnaNueva reemplazada en Num.
*/
recorrerFilasParaReemplazar(0, _Num, _ColumnaNueva, _Tablero, _NuevoTablero).
recorrerFilasParaReemplazar(Iteraciones, Num, ColumnaNueva, Tablero, NuevoTablero):-
  obtenerElemDeColumna(Iteraciones, ColumnaNueva, Elem),
  reemplazarElemento(Num, Fila ,Elem, FilaNueva),
  obtenerElemento(Iteraciones, Tablero, Fila),
  decrementar(Iteraciones, DecreasedIteraciones),
  recorrerFilasParaReemplazar(DecreasedIteraciones, Num, ColumnaNueva, Tablero, Nuevo),
  addLast(FilaNueva, Nuevo, NuevoTablero).

/*
  Listo los elementos de la columna Num.
  +Num: Posición de la columna.
  +Tablero: Tablero que contiene la columna de la posicion Num.
  -Columna: Columna de la posicion Num.
*/
buscarColumna(Num, Tablero, Columna):-
  length(Tablero, Longitud),
  recorrerFilas(Longitud, Num, Tablero, Columna),
  !.

/*
  Recorre todas las filas del tablero y arma la lista con todos los elementos de la columna Num.
  +Iteraciones: Numero de iteración actual, comienza desde el largo de la lista.
  +Num: Posición de la columna.
  +Tablero: Tablero que contiene la columna de las posición Num.
  -Columna: Columna de la posicion Num.
*/
recorrerFilas(0, _Num, _Tablero, _Columna).
recorrerFilas(Iteraciones, Num, Tablero, Columna):-
  obtenerElemento(Iteraciones, Tablero, Fila), %En este caso obtenerElemento funciona como obtener lista
                                               %ya que esta en un tablero (lista de listas).
obtenerElemento(Num, Fila, Elem),
decrementar(Iteraciones, DecreasedIteraciones),
recorrerFilas(DecreasedIteraciones, Num, Tablero, Lista),
addLast(Elem, Lista, Columna).

/*
  Reemplazo la lista A por la B del tablero y devuelvo el nuevo tablero.
  +A: Lista a ser reemplazada.
  +B: Lista reemplazante.
  +Tablero: Tablero que contiene la lista A.
  -TableroNuevo: Tablero con la lista B reemplazada por la A.
*/
reemplazarFila(A, B, [A|T], [B|T]).
reemplazarFila(A, B, [H|T], [H|Aux]):-
  A \= H,
  reemplazarFila(A, B, T, Aux).

/*
  +Iteracion: Número de iteracion actual, comienza desde la iteración 0.
  +Num: Posición de la Fila a buscar.
  +Tablero: Tablero donde se encuentra la Fila
  -Fila: Fila de la posición Num del Tablero.
*/
buscarFila(Iteracion, Num, [H|_T], H):-
	Iteracion = Num.

buscarFila(Iteracion, Num, [_H|T], Fila):-
  Iteracion \= Num,
  NIteracion is Iteracion+1,
  buscarFila(NIteracion, Num, T, Fila).

/*
  Retorna verdadero si Elem = Elem1.
  +Elem: Elemento 1 a comparar.
  +Elem1: Elemento 2 a comparar.
*/
comparoSiguiente(Elem, Elem1):-
  Elem = Elem1.

reemplazarElemento(1, [_|T], X, [X|T]).
reemplazarElemento(Itearaciones, [H|T], X, [H|R]):-
  Itearaciones > 1,
  DecreasedIteraciones is Itearaciones-1,
  reemplazarElemento(DecreasedIteraciones, T, X, R).

obtenerElemento(1, [Elem|_T], Elem).
obtenerElemento(Pos, [_H|T] , Elem):-
  decrementar(Pos, DecreasedPos),
  obtenerElemento(DecreasedPos, T , Elem).

ultimoElemento([X], X).
ultimoElemento([_H|T], Ult):-
  ultimoElemento(T, Ult).

/*
  +Lista: Lista Original.
  -ListaNueva: Lista sin ultimo elemento.
 */
eliminarUltimo([_H], []).
eliminarUltimo([H|T], [H|RTA]):-
  eliminarUltimo(T, RTA).

/*
  +Color: Elemento a insertar último en la lista.
  +Lista: Lista a la cual se le va a insertar último el elemento Color.
  -ListaNueva: Lista con Color insertado como último elemento.
*/
addLast(Color, [], [Color]).
addLast(Color, [H|T], [H|Lista]):-
  addLast(Color, T, Lista).

/*
  +A: Elemento a insertar en Lista.
  +Lista: Lista en la cual se le va a insertar el elemento A.
  -ListaNueva: Lista cuyo primer elemento es A.
*/
addFirst(A, Lista, [A|Lista]).

/*
  Devuelve el elemento de la columna en la posicion Num.
  +Num: Posición del elemento en la columna.
  +Columna: Columna a la cual se va a buscar el elemento.
  -Elem: Elemento que se encuentra en la posición Num de la columna.
*/
obtenerElemDeColumna(1, [A|_B], A).
obtenerElemDeColumna(Num, [_A|B], Elem):-
  decrementar(Num, DecreasedNum),
  obtenerElemDeColumna(DecreasedNum, B, Elem).

/*
 +Cant: Cantidad a la cual se le va a decrementar en 1.
 -NCant: Cantidad decrementada en 1.
*/
decrementar(Cant, NCant) :-
  NCant is Cant-1.
