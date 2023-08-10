%enunciado:https://docs.google.com/document/d/e/2PACX-1vR9SBhz2J3lmqcMXOBs1BzSt7N1YWPoIuubAmQxPIOcnbn5Ow9REYt4NXQzOwXXiUaEQ4hfHNEt3_C7/pub

%mago(nombre,tipoDeSangre,caracteristicas,dondeOdiariaEntrar)
mago(harry,mestiza,[corajudo,amistoso,orgulloso,inteligente],slytherin).
mago(harry2,mestiza,[corajudo,amistoso,orgulloso,inteligente],slytherin).
mago(harry3,mestiza,[corajudo,amistoso,orgulloso,inteligente],slytherin).
mago(draco,pura,[inteligente,orgulloso],hufflepuff).
%mago(hermione,impura,[inteligente,orgullosa,responsable],cac).

%casa(nombreDeLaCasa,caracteristicaNecesaria).
casa(gryffindor,corajudo).
casa(slytherin,orgulloso).
casa(slytherin,inteligente).
casa(ravenclaw,inteligente).
casa(ravenclaw,responsable).
casa(hufflepuff,amistoso).

permiteEntrar(slytherin,UnMago):-
    mago(UnMago,Sangre,_,_),
    Sangre\=impura.
permiteEntrar(UnaCasa,UnMago):-
    casa(UnaCasa,_),
    UnaCasa\=slytherin,
    mago(UnMago,_,_,_).

caracterApropiadoPara(UnaCasa,UnMago):-
    casa(UnaCasa,_),
    mago(UnMago,_,CaracteristicasDelMago,_),
    forall(casa(UnaCasa,UnaCaracteristica),member(UnaCaracteristica,CaracteristicasDelMago)).

podriaQuedarSeleccionado(UnMago,UnaCasa):-
    caracterApropiadoPara(UnaCasa,UnMago),
    mago(UnMago,_,_,CasaQueOdia),
    UnaCasa\=CasaQueOdia.
podriaQuedarSeleccionado(hermione,gryffindor).

cadenaDeAmistades(UnosMagos):-
    todosSonAmistosos(UnosMagos),
    cadaUnoEnLaMismaCasaQueElSiguiente(UnosMagos).

todosSonAmistosos([]).
todosSonAmistosos([PrimerMago|RestoDeMagos]):-
    esAmistoso(PrimerMago),
    todosSonAmistosos(RestoDeMagos). 

esAmistoso(UnMago):-
    mago(UnMago,_,CaracteristicasDelMago,_),
    member(amistoso,CaracteristicasDelMago).
/*todosSonAmistosos(Magos):-
    member(Mago,Magos),
    mago(Mago,_,_,_),
    forall(mago(Mago,_,CaracteristicasDelMago,_),member(amistoso,CaracteristicasDelMago)).*/

cadaUnoEnLaMismaCasaQueElSiguiente([]).
cadaUnoEnLaMismaCasaQueElSiguiente([UnicoMago|[]]):-%caso para el cual la lista tiene un solo elemento
    mago(UnicoMago,_,_,_).
cadaUnoEnLaMismaCasaQueElSiguiente([Primero,Segundo|Resto]):- %el primero debe poder quedar en la misma casa que el segundo
    podriaQuedarSeleccionado(Segundo,UnaCasa),
    podriaQuedarSeleccionado(Primero,UnaCasa),
    cadaUnoEnLaMismaCasaQueElSiguiente([Segundo|Resto]).%debo poner al segundo porque sino no estaria evaluando al segundo con el tercero,es decir pasaria directo del 3 al 4
    

%PARTE 2 - COPA DE LAS CASAS
esDe(hermione, gryffindor).
esDe(ron, gryffindor).
%esDe(ron, ravenclaw).
esDe(harry, gryffindor).
esDe(draco, slytherin).
esDe(luna, ravenclaw).

%malaAccion(quienLaHizo,lo que hizo,puntaje que resta)
accionQueHizo(harry,andarFueraDeLaCama).
accionQueHizo(harry,lugarProhibido(bosque)).
accionQueHizo(harry,lugarProhibido(tercerPiso)).
accionQueHizo(hermione,lugarProhibido(zonaRestringidaDeBiblioteca)).
accionQueHizo(hermione,lugarProhibido(tercerPiso)).
accionQueHizo(ron,ganasEnAjedrez).
accionQueHizo(hermione,salvarASusAmigos).
accionQueHizo(harry,derrotarAVoldemort).

accion(andarFueraDeLaCama,-50).
accion(lugarProhibido(bosque),-50).
accion(lugarProhibido(tercerPiso),-75).
accion(lugarProhibido(zonaRestringidaDeBiblioteca),-10).
accion(lugarProhibido(tercerPiso),-75).
accion(ganasEnAjedrez,50).
accion(salvarASusAmigos,50).
accion(derrotarAVoldemort,60).

buenAlumno(UnMago):-
    accionQueHizo(UnMago,_),
    forall(accionQueHizo(UnMago,UnaAccion),not(esMalaAccion(UnaAccion))).

    esMalaAccion(UnaAccion):-
        accion(UnaAccion,Puntaje),
        Puntaje<0.

esAccionRecurrente(UnaAccion):-
    accionQueHizo(UnMago,UnaAccion),
    accionQueHizo(OtroMago,UnaAccion),
    UnMago\=OtroMago.

puntajeTotalDe(UnaCasa,PuntajeTotal):-
    esDe(_,UnaCasa),
    findall(Sumatoria,distinct(puntajeDeUnMagoPertenecienteA(UnMago,Sumatoria,UnaCasa)),ListaDePuntos),
    sum_list(ListaDePuntos,TotalDePuntosPorAcciones),
    findall(Puntos,distinct(puntajePorResponderPreguntasDe(UnMago,UnaCasa,Puntos)),ListaDePuntosPorResponder),
    sum_list(ListaDePuntosPorResponder,TotalDePuntosPorResponder),
    PuntajeTotal is TotalDePuntosPorAcciones + TotalDePuntosPorResponder.

    puntajePorResponderPreguntasDe(UnMago,UnaCasa,Puntos):-
        esDe(UnMago,UnaCasa),
        preguntaRespondidaEnClase(_,Puntos,_,UnMago).

    puntajeDeUnMagoPertenecienteA(UnMago,Sumatoria,UnaCasa):-
    esDe(UnMago,UnaCasa),
    findall(Puntos,loQueSumaUnaAccionHechaPor(UnMago,Puntos),PuntajeTotal),
    sum_list(PuntajeTotal,Sumatoria).
    
    loQueSumaUnaAccionHechaPor(UnMago,Puntos):-
        accionQueHizo(UnMago,UnaAccion),
        distinct(accion(UnaAccion,Puntos)).

esLaCasaGanadora(UnaCasa):-
    esDe(_,UnaCasa),
    esDe(_,OtraCasa),
    UnaCasa\=OtraCasa,
    forall(UnaCasa\=OtraCasa,tieneMasPuntos(UnaCasa,OtraCasa)).

    tieneMasPuntos(UnaCasa,OtraCasa):-
        puntajeTotalDe(UnaCasa,UnPuntaje),
        puntajeTotalDe(OtraCasa,OtroPuntaje),
        UnPuntaje>OtroPuntaje.

%preguntaRespondidaEnClase(cualFueLaPRegunta,dificultad,profesor,quienLaRespondio).
preguntaRespondidaEnClase(dondeSeEncuentraUnBezour,10,snape,hermione).
preguntaRespondidaEnClase(comoHacerLevitarUnaPluma,25,flitwick,hermione).