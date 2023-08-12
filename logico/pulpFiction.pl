%enunciado: https://docs.google.com/document/d/15mo_2391atBqMjcYzLtKvGG6JiPzjbeyEGVlwZjv4B8/edit

personaje(pumkin,     ladron([licorerias, estacionesDeServicio])).
personaje(honeyBunny, ladron([licorerias, estacionesDeServicio])).
personaje(vincent,    mafioso(maton)).
personaje(jules,      mafioso(maton)).
personaje(marsellus,  mafioso(capo)).
personaje(winston,    mafioso(resuelveProblemas)).
personaje(mia,        actriz([foxForceFive])).
personaje(butch,      boxeador).

pareja(marsellus, mia).
pareja(pumkin,    honeyBunny).

%trabajaPara(Empleador, Empleado)
trabajaPara(marsellus, vincent).
trabajaPara(marsellus, jules).
trabajaPara(marsellus, winston).

%Punto 1
%es un maton
esPeligroso(UnPersonaje):-
    personaje(UnPersonaje,mafioso(maton)).
%roba licorerias
esPeligroso(UnPersonaje):-
    personaje(UnPersonaje,ladron(LugaresQueRoba)),
    member(licorerias,LugaresQueRoba).
%tiene empleado peligrosos
esPeligroso(UnPersonaje):-
    trabajaPara(UnPersonaje,_),
    forall(trabajaPara(UnPersonaje,OtroPersonaje),esPeligroso(OtroPersonaje)).
    
%Punto 2 relaciona dos personajes cuando son peligrosos y además son pareja o amigos. 
amigo(vincent, jules).
amigo(jules, jimmie).
amigo(vincent, elVendedor).

duoTemible(UnPersonaje,OtroPersonaje):-
    esPeligroso(UnPersonaje),
    esPeligroso(OtroPersonaje),
    sonAmigos(UnPersonaje,OtroPersonaje).

duoTemible(UnPersonaje,OtroPersonaje):-
    esPeligroso(UnPersonaje),
    esPeligroso(OtroPersonaje),
    sonPareja(UnPersonaje,OtroPersonaje).

%esto podria ser redundante,porque ya tenemos la info en la base de conocimiento con los predicados amigos y pareja
%lo hicimos asi porque los amigos pueden estas puestos al reves o la pareja tambien.
sonAmigos(UnPersonaje,OtroPersonaje):-
    amigo(UnPersonaje,OtroPersonaje).

sonAmigos(UnPersonaje,OtroPersonaje):-
    amigo(OtroPersonaje,UnPersonaje).

sonPareja(UnPersonaje,OtroPersonaje):-
    pareja(OtroPersonaje,UnPersonaje).

sonPareja(UnPersonaje,OtroPersonaje):-
    pareja(UnPersonaje,OtroPersonaje).

%punto 3
%encargo(Solicitante, Encargado, Tarea). 
%las tareas pueden ser cuidar(Protegido), ayudar(Ayudado), buscar(Buscado, Lugar)
encargo(marsellus, vincent,   cuidar(mia)).
encargo(vincent,  elVendedor, cuidar(mia)).
encargo(marsellus, winston, ayudar(jules)).
encargo(marsellus, winston, ayudar(vincent)).
encargo(marsellus, vincent, buscar(butch, losAngeles)).

estaEnProblemas(butch).
estaEnProblemas(UnPersonaje):-
    trabajaPara(Jefe,UnPersonaje),
    esPeligroso(Jefe),
    misionPeligrosa(Jefe,UnPersonaje).

misionPeligrosa(Jefe,UnPersonaje):-
    encargo(Jefe,UnPersonaje,(cuidar(ParejaDelJefe))),
    pareja(Jefe,ParejaDelJefe).
misionPeligrosa(Jefe,UnPersonaje):-
    encargo(Jefe,UnPersonaje,(buscar(OtroPersonaje,_))),
    esBoxeador(OtroPersonaje).

esBoxeador(OtroPersonaje):-
    personaje(OtroPersonaje,boxeador).

%punto 4 
sanCayetano(UnPersonaje):-
    personaje(UnPersonaje,_),
    forall(estaCerca(UnPersonaje,OtroPersonaje),encargo(UnPersonaje,OtroPersonaje,_)).

estaCerca(UnPersonaje,OtroPersonaje):-
    sonAmigos(UnPersonaje,OtroPersonaje).
estaCerca(UnPersonaje,OtroPersonaje):-
    trabajaPara(UnPersonaje,OtroPersonaje).

%punto 5 -- Importante comparador de magnitudes 
masAtareado(UnPersonaje):-
    encargosQueTiene(UnPersonaje,UnaCantidad),
    forall(encargosQueTiene(_,OtraCantidad),UnaCantidad>=OtraCantidad).
    
encargosQueTiene(UnPersonaje,Cantidad):-
    personaje(UnPersonaje,_),
    findall(UnEncargo,encargo(_,UnPersonaje,UnEncargo), EncargosQueTienenUnPersonaje),
    length(EncargosQueTienenUnPersonaje,Cantidad).

%punto 6
personajesRespetables(Personajes):-
    findall(UnPersonaje,(personaje(UnPersonaje,_),esRespetable(UnPersonaje)),Personajes).


esRespetable(UnPersonaje):-
    nivelDeRespeto(UnPersonaje,Cantidad),
    Cantidad>9.

%actriz
nivelDeRespeto(UnPersonaje,Cantidad):-
    personaje(UnPersonaje,actriz(Peliculas)),
    length(Peliculas,CantidadDePeliculas),
    Cantidad is CantidadDePeliculas / 10.
%mafiosos
nivelDeRespeto(UnPersonaje,Cantidad):-
    personaje(UnPersonaje,mafioso(TipoMafioso)),
    cantidadSegunTipoDeMafioso(TipoMafioso,Cantidad).

cantidadSegunTipoDeMafioso(resuelveProblemas,10).
cantidadSegunTipoDeMafioso(capo,20).
cantidadSegunTipoDeMafioso(maton,1).

%punto 7
% hartoDe/2: un personaje está harto de otro, cuando 
%todas las tareas asignadas al primero requieren interactuar con el segundo (cuidar, buscar o ayudar)
%o un amigo del segundo.
    
hartoDe(UnPersonaje,OtroPersonaje):-
    personaje(UnPersonaje,_),
    personaje(OtroPersonaje,_),
    forall(encargo(_,UnPersonaje,_),interactuaCon(UnPersonaje,OtroPersonaje)).

interactuaCon(UnPersonaje,OtroPersonaje):-
    encargo(_,UnPersonaje,UnaTarea),
    afecta(UnaTarea,OtroPersonaje).
interactuaCon(UnPersonaje,OtroPersonaje):-
    encargo(_,UnPersonaje,UnaTarea),
    sonAmigos(OtroPersonaje,UnTercero),
    afecta(UnaTarea,UnTercero).

afecta(cuidar(OtroPersonaje),OtroPersonaje).
afecta(buscar(OtroPersonaje,_),OtroPersonaje).
afecta(ayudar(OtroPersonaje),OtroPersonaje).

%punto 8
caracteristicas(vincent,  [negro, muchoPelo, tieneCabeza]).
caracteristicas(jules,    [tieneCabeza, muchoPelo]).
caracteristicas(marvin,   [negro]).


%importe siempre toman un punto asi

duoDiferenciable(UnPersonaje,OtroPersonaje):-
    esDuo(UnPersonaje,OtroPersonaje),
    seDiferencian(UnPersonaje,OtroPersonaje).
duoDiferenciable(UnPersonaje,OtroPersonaje):-
    esDuo(UnPersonaje,OtroPersonaje),
    seDiferencian(OtroPersonaje,UnPersonaje).

seDiferencian(UnPersonaje,OtroPersonaje):-
    caracteristica(UnPersonaje,UnaCaracteristica),
    caracteristicas(OtroPersonaje,CaracteristicasDelOtro),
    not(member(UnaCaracteristica,CaracteristicasDelOtro)).
    
esDuo(UnPersonaje,OtroPersonaje):-
    sonAmigos(UnPersonaje,OtroPersonaje).
esDuo(UnPersonaje,OtroPersonaje):-
    sonPareja(UnPersonaje,OtroPersonaje).

%esto es lo mas importante, porque te da un elemnto de una lista
caracteristica(UnPersonaje,Caracteristica):-
    caracteristicas(UnPersonaje,Caracteristicas),
    member(Caracteristica,Caracteristicas).