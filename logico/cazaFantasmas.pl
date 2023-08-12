%enunciado: https://docs.google.com/document/d/1GBORNTd2fujNy0Zs6v7AKXxRmC9wVICX2Y-pr7d1PwE/edit#heading=h.tah786xadto6

%functor: aspiradora(potencia minima requerida paraa hacer la tarea)
herramientasRequeridas(ordenarCuarto, [aspiradora(100), trapeador, plumero]).
herramientasRequeridas(limpiarTecho, [escoba, pala]).
herramientasRequeridas(cortarPasto, [bordedadora]).
herramientasRequeridas(limpiarBanio, [sopapa, trapeador]).
herramientasRequeridas(encerarPisos, [lustradpesora, cera, aspiradora(300)]).

tiene(egon,aspiradora(200)).
tiene(egon,trapeador).
tiene(peter,trapeador).
tiene(winston,varitaDeNeuntrones).

cazafantasma(ray).
cazafantasma(UnaPersona):-
    tiene(UnaPersona,_).

satisfaceNecesidadDeTener(UnaPersona,UnaHerramienta):-
    tiene(UnaPersona,UnaHerramienta).
satisfaceNecesidadDeTener(UnaPersona,aspiradora(PotenciaRequerida)):-
    tiene(UnaPersona,aspiradora(Potencia)),
    Potencia >= PotenciaRequerida.

puedeRealizar(UnaTarea,UnaPersona):-
    tiene(UnaPersona,varitaDeNeuntrones),
    requiere(UnaTarea,_).

puedeRealizar(UnaTarea,UnaPersona):-
    %requiere(UnaTarea,UnaHerramienta),
    tiene(UnaPersona,_),
    forall(requiere(UnaTarea,UnaHerramienta),satisfaceNecesidadDeTener(UnaPersona,UnaHerramienta)).

    requiere(UnaTarea,UnaHerramienta):-
        herramientasRequeridas(UnaTarea,Herramientas),
        member(UnaHerramienta,Herramientas).

%un pedido tiene muchas tareas dentro
%tareaPedida/3: relaciona al cliente, con la tarea pedida y la cantidad de metros cuadrados sobre los cuales hay que realizar esa tarea.
tareaPedida(jaime,ordenar,10).
tareaPedida(pepe,limpiarTecho,5).
tareaPedida(pepe,arreglar,1).

precio(ordenar,1).

seLeDeberiaCobrar(UnCliente,Total):-
    tareaPedida(UnCliente,_,_),
    findall(PrecioACobrar,cobrarPor(_,UnCliente,PrecioACobrar),Precios),
    sum_list(Precios,Total).

    cobrarPor(UnaTarea,UnCliente,PrecioACobrar):-
        tareaPedida(UnCliente,UnaTarea,MetrosCuadrados),
        precio(UnaTarea,PrecioPorMetroCuadrado),
        PrecioACobrar is PrecioPorMetroCuadrado*MetrosCuadrados.

esCompleja(limpiarTecho).
esCompleja(UnaTarea):-
    requiereMasDeDosHerramientas(UnaTarea).

requiereMasDeDosHerramientas(UnaTarea):-
    herramientasRequeridas(UnaTarea,Herramientas),
    length(Herramientas,Cantidad),
    Cantidad>2.

aceptaPedido(UnaPersona,UnCliente):-
    puedeRealizarTodasLasTareasDeUnPedido(UnaPersona,UnCliente),
    estaDispuestoAAceptarlo(UnaPersona,UnCliente).

puedeRealizarTodasLasTareasDeUnPedido(UnaPersona,UnCliente):- %la persona seria el cazafantasma
    tareaPedida(UnCliente,_,_),
    cazafantasma(UnaPersona), %tambien se podia haber hecho tiene(unaPersona,_). Pero queda para mi mas declarativo usar un predicado cazafantasma
    forall(tareaPedida(UnCliente,UnaTarea,_),puedeRealizar(UnaTarea,UnaPersona)).

estaDispuestoAAceptarlo(ray,Cliente):-
    tareaPedida(Cliente,_,_),
    forall(tareaPedida(Cliente,UnaTarea,_),UnaTarea\=limpiarTecho).
    
estaDispuestoAAceptarlo(winston,Cliente):-
    tareaPedida(Cliente,_,_),
    seLeDeberiaCobrar(Cliente,Total),
    Total>500.

estaDispuestoAAceptarlo(egon,Cliente):-
    tareaPedida(Cliente,_,_),
    forall(tareaPedida(Cliente,_,_),not(esCompleja(UnaTarea))).

estaDispuestoAAceptarlo(peter,Cliente):-
    tareaPedida(Cliente,_,_). %esto en la resolucion no esta pero es necesario ponerlo, porque los pedido los realizan los clientes


