:- op(300,fx,~).        % negacion, prefija, no asociativa.
:- op(400,yfx,(/\)).    % conjuncion, infija, asociativa a izquierda.
:- op(500,yfx,(\/)).    % disyuncion, infija, asociativa a izquierda.
:- op(600,xfx,=>).      % implicacion, infija, no asociativa.
:- op(650,xfx,<=>).     % equivalencia, infija, no asociativa.

/*
Convencion: los literales y operadores ingresan espaciados. (Expecto ~a)

Pasos Previos:

sustituir Implicaciones
P => Q == ¬P \/ Q

sustituir Equivalencias
P <=> Q == (¬P \/ Q) /\ (P \/ ¬Q)
--------------------------------------------------

Primer paso (distribuirNegaciones)
  ¬¬Q == Q
  ¬(Q \/ P) == ¬Q /\ ¬P
  ¬(Q /\ P) == ¬P \/ ¬Q
  ¬top == bottom
  ¬bottom == top

Segundo paso (distribuirAND)
  Q \/ (P /\ E) == (Q \/ P) /\ (Q \/ E)
 (Q \/ E) == (E \/ Q)
 (Q /\ E) == (E /\ Q)
  Q \/ top == top
  Q \/ bottom == Q

Tercer paso (reduccion)
  Q /\  top   == Q
  Q /\ bottom == bottom

Cuarto paso (eliminarRepeticiones)
  Q /\  Q == Q
  Q /\ ¬Q == bottom
 ¬Q \/  Q == top
 ¬Q \/ ¬Q == ¬Q
*/

teorema(F):-
  write('F = '),
  writeln(F),
  fncr(~F,FNCR),
  write('FNCR = '),
  writeln(FNCR),
  write('Es refutable? '),
  refutable(FNCR).

fncr(A,Funcion):-
  writeln('Entro a Sustituir implicaciones y equivalencias con '),
  writeln(A),
  sustituirImplicaciones(A, B),
  writeln('Salgo con'),
  writeln(B),
  writeln('Entro a distribuir Negaciones'),
  distribuirNegaciones(B, C),
  writeln('Salgo con'),
  writeln(C),
  writeln('Entro a distribuir AND'),
  distribuirAND(C, D),
  writeln('Salgo con'),
  writeln(D),
  writeln('Entro a reducir'),
  reducir(D, E),
  writeln('Salgo con'),
  writeln(E),
  writeln('Entro a sacarComplementos'),
  sacarComplementos(E, F),
  writeln('Salgo con'),
  writeln(F),
  writeln('Entro a sacarTops'),
  sacarTops(F, G),
  writeln('Salgo con'),
  writeln(G),
  writeln('Entro a armarFNCR'),
  armarFNCR(G, Funcion),
  !.

/*
 * Sustituye las implicaciones por su equivalnte en Conjuncion.
 * P => Q == ¬P \/ Q
 * Se recibe un termino si ese termino tiene operadores y ese operador
 * es una implicacion lo sustituye por su equivalente en conjuncion,
 * Si no es una implicacion devuelve el termino sin modificar.
 */

sustituirImplicaciones(~A, (~Resultado)) :-
  sustituirImplicaciones(A, Resultado).

sustituirImplicaciones(A \/ B, A1 \/ B1):-
  sustituirImplicaciones(A,A1),
  sustituirImplicaciones(B,B1).

sustituirImplicaciones(A /\ B, A1 /\ B1):-
  sustituirImplicaciones(A, A1),
  sustituirImplicaciones(B, B1).

sustituirImplicaciones(A => B, A1 \/ B1):-
  sustituirImplicaciones((~A), A1),
  sustituirImplicaciones(B, B1).

sustituirImplicaciones(A <=> B, A1 /\ B1):-
  sustituirImplicaciones(A => B, A1),
  sustituirImplicaciones(B => A, B1).

sustituirImplicaciones(A, A).

/*
Primer paso (distribuirNegaciones)
%convencion: ~ ~a se ingresa como ~(~a).

%Distribuye las negaciones en cada uno de los terminos
%modificando su valor de verdad, y los opedores cambian por su opuesto.

Se reciben terminos y se distribuye la negacion a cada uno de los literales
devolviendo ese mismo termino con la negacion aplicada.
en caso de recibir top o bottom se devuelve por el opuesto.
Ej:
		¬¬Q == Q
  		¬(Q \/ P) == ~Q /\ ~P
  		¬(Q /\ P) == ~P \/ ~Q
 		¬top    == bottom
  		¬bottom == top
*/
distribuirNegaciones(~top, bottom).

distribuirNegaciones(~bottom, top).

distribuirNegaciones(~(~A), A1):-
  distribuirNegaciones(A, A1).

distribuirNegaciones(~(A \/ B), Resultado):-
  distribuirNegaciones(~A, A1),
  distribuirNegaciones(~B, B1),
  distribuirNegaciones(A1 /\ B1, Resultado).

distribuirNegaciones(~(A /\ B), Resultado):-
  distribuirNegaciones(~A, A1),
  distribuirNegaciones(~B, B1),
  distribuirNegaciones(A1 \/ B1, Resultado).

distribuirNegaciones(A /\ B, A1 /\ B1):-
  distribuirNegaciones(A, A1),
  distribuirNegaciones(B, B1).

distribuirNegaciones(A \/ B, A1 \/ B1):-
  distribuirNegaciones(A, A1),
  distribuirNegaciones(B, B1).

distribuirNegaciones(A, A).

%------------------------------------------------------------
% Segundo paso (distribuirAND)
%   A \/ (B /\ C) == (A \/ B) /\ (A \/ C)
%  (P /\ E) \/ Q == (Q \/ P) /\ (Q \/ E)
/*
 Separa los terminos recibidos en Conjunciones.

 Si Recibe termino sin operadores lo devuelve sin modificar.
 Si recibe terminos con algun operador /\, distribuye
 los terminos separandolos con un /\ entre medio.
 */
distribuirAND(_A \/ top,top).

distribuirAND(top \/ _A, top).

distribuirAND(bottom \/ A, A1):-
  distribuirAND(A,A1).

distribuirAND(A \/ bottom, A1):-
  distribuirAND(A,A1).

distribuirAND(A \/ (B /\ C), Resultado):-
  distribuirAND(A \/ B, A1),
  distribuirAND(A \/ C, B1),
  distribuirAND(A1 /\ B1, Resultado).

distribuirAND((A /\ B) \/ C, Resultado):-
  distribuirAND(A \/ C, A1),
  distribuirAND(B \/ C, B1),
  distribuirAND(A1 /\ B1, Resultado).

distribuirAND(A /\ B, A1 /\ B1):-
  distribuirAND(A, A1),
  distribuirAND(B, B1).

distribuirAND(A \/ B, A1 \/ B1):-
  distribuirAND(A, A1),
  distribuirAND(B, B1).

distribuirAND(A, A).
% ----------------------------------------------------------------------
% Tercer paso (reducir)
/*
 * Elimina Tops o Bottoms
 *
 * Recibe terminos con operadores, en caso de encontrar un top o bottom
 * compara su valor de verdad con el otro literal, y lo retorna.
 * Ej:
   Q /\ top == Q
 	 Q \/ bottom == Q
 */

reducir(A /\ top, A1):-
  reducir(A, A1).

reducir(top /\ A, A1):-
  reducir(A, A1).

reducir(_A /\ bottom, bottom).

reducir(bottom /\ _A, bottom).

reducir(A /\ B, A1 /\ B1):-
  reducir(A, A1),
  reducir(B, B1).

reducir(A \/ B,A1 \/ B1):-
  reducir(A, A1),
  reducir(B, B1).

reducir(A, A).

% ----------------------------------------------------------------------
/*
 * Elimina los complementos de los terminos recibidos.
 *
 * Recibe termino de Operadores y pasa cada literal de cada termino como elemento a una lista nueva,para luego recorrerla
 * y borrar los complementos de cada literal en el mismo termino, devolviendo una lista de lista cuyos
 * elementos son cada termino del que se recibio como input.
 *
 * Ej:-Recibe (~a\/b)/\(~a\/c)/\(a/\((~b\/~c)/\(~b\/b))) y devuelve [[~a, b], [~a, c], [a], [~b, ~c], [top]]
 */
sacarComplementos(A /\ B, Resultado):-
  sacarComplementos(A, Lista1),
  sacarComplementos(B, Lista2),
  append(Lista1, Lista2, Resultado).

sacarComplementos(A, [Resultado]) :-
  desarmarDisyunciones(A, Lista1),
  sacarRepeticiones(Lista1, Lista2),
  eliminarComplementos(Lista2, Resultado).

/*
 * Separa los terminos de disyunciones y pone cada literal
 * como elemento de una lista nueva.
 *
 */
desarmarDisyunciones(A,[A]):-
  atomic(A).
desarmarDisyunciones(~A,[~A]):-
  atomic(A).
desarmarDisyunciones(A \/ B, Resultado):-
  desarmarDisyunciones(A,Lista1),
  desarmarDisyunciones(B,Lista2),
  append(Lista1,Lista2,Resultado).

/*
 *% Elimina los complementos de un termino disyuncion y deja top si es que existe alguno.
 *
 *Recibe terminos de disyunciones en lista de listas y las devuelve
 * sin complementos.
 */

eliminarComplementos([], []).
eliminarComplementos([H|T], Resultado) :-
  borrarComplemento(H, T, Resultado).

eliminarComplementos([H|T], [top]) :-
  not(borrarComplemento(H, T, _Resultado1)),
  eliminarComplementos(T, Resultado),
  Resultado = [top].

eliminarComplementos([H|T], [H|Resultado]) :-
  not(borrarComplemento(H, T, _Resultado1)),
  eliminarComplementos(T, Resultado),
  Resultado \= [top].

/*
* En caso de encontrar el opuesto del literal H ,devuelve Top.
*/

borrarComplemento(H, T, [top]) :-
  obtenerOpuesto(H, Op),
  member(Op, T).

/*
 * Retorna verdadero en caso de encontrar el elemento X en
 * la lista pasada por parametro, Falso en caso contrario.
 */
member(X,[X|_T]).
member(X,[_H|T]):-
  member(X,T).


/*
*Retorna el opuesto de un literal.
*/
obtenerOpuesto(~A, A).
obtenerOpuesto(A, ~A) :-
  atomic(A).

/*
 * Si existe alguna aparicion de tops, se eliminan.
  Excepto que se reciba solo un top de entrada.
 */
sacarTops([[top]|[]], [[top]]).
sacarTops(Lista,Resultado):-
  	Lista \= [[top]|[]],
	sacarTopsAux(Lista,Resultado),
    Resultado \= [].

sacarTops(Lista,Resultado):-
  Lista \= [[top]|[]],
  sacarTopsAux(Lista,Resultado),
  Resultado = [].

sacarTopsAux([], []).
sacarTopsAux([[top]|T], Resultado) :-
  sacarTops(T, Resultado).

sacarTopsAux([H|T], [H|Resultado]) :-
  H \= [top],
  sacarTopsAux(T, Resultado).

/*
eliminarRepeticiones
Elimina todas las elementos repetidos de la misma lista.
*/
sacarRepeticiones([], []).
sacarRepeticiones([H|T], [H|Resultado]) :-
  borrarTodas(H, T, Resultado1),
  sacarRepeticiones(Resultado1, Resultado).

/*
 * Elimina todas las apariciones que encuentre del literal A.
 */
borrarTodas(_A, [], []).
borrarTodas(A, [A|As], Resultado) :-
  borrarTodas(A, As, Resultado).

borrarTodas(A, [B|Bs], [B|Resultado]) :-
  A \= B,
  borrarTodas(A, Bs, Resultado).

/*
 *Elimina solo una aparicion del literal A.
 */
borrarUnaVez(_A, [], []).
borrarUnaVez(A, [A|As], As).
borrarUnaVez(A, [B|Bs], [B|Bss]):-
    A \= B,
    borrarUnaVez(A, Bs, Bss).

/*
 * Crea la FNCR en base a una lista de listas de disyunciones.
 */
armarFNCR([[top]], top).
armarFNCR([A|T], Resultado /\ X):-
  A \= [top],
  armarDisyunciones(A, X),
  armarFNCR(T, Resultado).

armarFNCR([A], Resultado) :-
  A \= [top],
  armarDisyunciones(A, Resultado).

armarDisyunciones([A|[]], A).
armarDisyunciones([A|T], Resultado \/ A):-
  armarDisyunciones(T,Resultado).

%-----------------------Refutable ------------------------------
/*
 * Crea lista de listas donde cada elemento de cada lista son los
 * literales de cada termino de conjunciones.
 *
 * Recibe terminos de conjunciones, y los separa poniendolos
 *  como elementos de una lista nueva.
 */
desarmarConjunciones(A /\ B, Resultado):-
   desarmarConjunciones(A,Lista1),
   desarmarConjunciones(B,Lista2),
   append(Lista1,Lista2,Resultado).

desarmarConjunciones(A,[Resultado]) :-
    desarmarDisyunciones(A,Resultado).

/*
 *	Recibe una fbf en fncr y determine si es o no refutable, es decir,
 *	si existe o no una derivación por resolución de bottom a partir de ella.
 */
refutable(X):-
  noEsTop(X),
  desarmarConjunciones(X, Conjunciones),
	resolventes(Conjunciones, Resolventes),
	append(Conjunciones,Resolventes,ConjyResolventes),
  literales(ConjyResolventes, Literales), %Elimina todas las listas que tienen más de 1 literal
  writeln(ConjyResolventes),
  intentarRefutar(Literales).

noEsTop(X):-
  X \= top.

%Queremos que sea distinto, para poder seguir calculando resolventes
comprobar(X,Y):-
  X \= Y.

/*
 * Obtengo todas las resolventes, esas son todas las resolventes
 * de todas las instancias.
 */
resolventes([],[]).
resolventes(Resolventes,Resultado):-
  distribuirResolventes(Resolventes,ResolventesNuevo),
  comprobar(Resolventes, ResolventesNuevo),
  append(ResolventesNuevo, Resultado1, Resultado),
  resolventes(ResolventesNuevo, Resultado1).

resolventes(Resolventes,[]):-
  Resolventes \= [],
  distribuirResolventes(Resolventes,ResolventesNuevo), % Distribuir todos con todos, de una instancia
	not(comprobar(Resolventes, ResolventesNuevo)).


%se distribuye con todos de una misma iteracion
distribuirResolventes([], []).
distribuirResolventes([H|T], Resultado):-
	distribuirTermino(H, T, Distribuida),
  distribuirResolventes(T, Resultado1),
  append(Distribuida, Resultado1, Resultado2),
  sacarRepeticiones(Resultado2, Resultado).

/*
 * Calcula las resolventes entre el primer parametro y los elementos del segundo parametro
 * Devuelve una lista vacía
 */
distribuirTermino(_A, [], []).
distribuirTermino(Termino, [H|T], Resultado):-
    distribuirUnTermino(Termino, Termino,H, Distribuida),
    distribuirTermino(Termino, T, Resultado1),
    append(Distribuida, Resultado1, Resultado).


/*
 *Busca el opuesto de un literal
 */
distribuirUnTermino(_A,[],_B,[]).
distribuirUnTermino(A, [H|T], B, [Resolvente|Resolventes]):-
    obtenerOpuesto(H, Op),
    member(Op, B),
    append(A, B, Resultado),
    borrarUnaVez(Op, Resultado,Resultado1),
    borrarUnaVez(H,Resultado1,Resultado2),
    sacarRepeticiones(Resultado2,Resolvente),
    distribuirUnTermino(A, T, B, Resolventes).

distribuirUnTermino(A, [H|T], B, Resultado):-
    obtenerOpuesto(H, Op),
    not(member(Op, B)),
    distribuirUnTermino(A, T, B, Resultado).

/*
 Armo lista de literales a partir de una lista
 de disyunciones que tengan solo un literal.
 */
literales([], []).
literales([H|T], [A|Resultado]) :-
    soloUnElemento(H),
    obtenerElem(H, A),
    literales(T, Resultado).

literales([H|T], Resultado) :-
    not(soloUnElemento(H)),
    literales(T, Resultado).

/*
  True si encuentra un literal y su complemento.
 */
intentarRefutar([bottom|[]]).
intentarRefutar([H|T]) :-
    obtenerOpuesto(H, Op),
    member(Op, T).

intentarRefutar([H|T]) :-
    obtenerOpuesto(H, Op),
    not(member(Op, T)),
    intentarRefutar(T).

obtenerElem([A], A).

soloUnElemento([_H|[]]).
