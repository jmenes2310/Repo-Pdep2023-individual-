%enunciado: https://docs.google.com/document/d/1RNgFMlSqOKiwe9SEi1U2cQjCmdFfWNflqycSfp7Qa-w/edit#

%turno(nombre,diashorario(inicio,fin))
turno(dodain,lunes,horario(9,15)).
turno(dodain,miercoles,horario(9,15)).
turno(dodain,viernes,horario(9,15)).
turno(lucas,martes,horario(10,20)).
turno(juanC,sabado,horario(18,22)).
turno(juanC,domingo,horario(18,22)).
turno(juanFdS,jueves,horario(10,20)).
turno(juanFdS,viernes,horario(12,20)).
turno(leoC,lunes,horario(14,18)).
turno(leoC,miercoles,horario(14,18)).
turno(martu,miercoles,horario(23,24)).

turno(vale,Dia,Horario):-
    turno(dodain,Dia,Horario).
turno(vale,Dia,Horario):-
    turno(juanC,Dia,Horario).

quienAtiende(UnDia,UnaHora,UnaPersona):-
    turno(UnaPersona,UnDia,horario(Inicio,Fin)),
    between(Inicio,Fin,UnaHora).
    
foreverAlone(UnaPersona,UnDia,UnaHora):-
    quienAtiende(UnDia,UnaHora,UnaPersona),
    not(otraPersonaAtiendeA(UnaHora,UnDia,UnaPersona,OtraPersona)).

    otraPersonaAtiendeA(UnaHora,UnDia,UnaPersona,OtraPersona):-
        quienAtiende(UnDia,UnaHora,OtraPersona),
        OtraPersona\=UnaPersona.

posibilidadDeAtencion(UnDia,Personas):-
    findall(Persona, distinct(Persona, quienAtiende(UnDia, _, Persona)), Personas).

%venta(Quien,Dia,Mes,golosinas(ValorEnplata))
%venta(Quien,Dia,Mes,cigarrillos(Marca))
%venta(Quien,Dia,Mes,bebida(tipo,cantidad))

venta(dodain,10,agosto,[golosinas(1200)]).
venta(dodain,12,agosto,[bebida(alcoholica,8),bebida(noAlcoholica,1),golosinas(10)]).
venta(martu,15,agosto,[golosinas(1000),cigarrillos([chesterfield,colorado,parisiennes])]).
venta(lucas,11,agosto,[golosinas(600)]).
venta(lucas,18,agosto,[bebida(noAlcoholica,2),cigarrillos([derby])]).

vendedoraSuertuda(UnaPersona):-
    venta(UnaPersona,_,_,_),
    forall(venta(UnaPersona,_,_,UnaVenta),laPrimeraVentaEsImportante(UnaVenta)).

    laPrimeraVentaEsImportante([Cabeza|_]):-
        esVentaImportante(Cabeza).

    esVentaImportante(golosinas(Precio)):-
        Precio >100.
    esVentaImportante(cigarrilos(Marcas)):-
        length(Marcas,CandidadDeMarcas),
        CandidadDeMarcas>2.
    esVentaImportante(bebida(alcoholica,_)).
    esVentaImportante(bebida(_,UnaCantidad)):-
        UnaCantidad>5.

