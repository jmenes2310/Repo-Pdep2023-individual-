%enunciado: https://docs.google.com/document/d/1P0hcfQ-k_gL1bT6UgtJyCzWSDN9OImHujB5Xq9oCvpE/edit

%personajes
esPersonaje(aang).
esPersonaje(katara).
esPersonaje(zoka).
esPersonaje(appa).
esPersonaje(momo).
esPersonaje(toph).
esPersonaje(tayLee).
esPersonaje(zuko).
esPersonaje(azula).
esPersonaje(iroh).

%elementos
esElementoBasico(fuego).
esElementoBasico(agua).
esElementoBasico(tierra).
esElementoBasico(aire).

%elementos avanzados
elementoAvanzadoDe(fuego, rayo).
elementoAvanzadoDe(agua, sangre).
elementoAvanzadoDe(tierra, metal).

%controla relaciona el personaje con el elemento que controla 
controla(zuko, rayo).
controla(toph, metal).
controla(katara, sangre).
controla(aang, aire).
controla(aang, agua).
controla(aang, tierra).
controla(aang, fuego).
controla(azula, rayo).
controla(iroh, rayo).

controla(katara,agua).

% visito/2 relaciona un personaje con un lugar que visitó. Los lugares son functores que tienen la siguiente forma:
% reinoTierra(nombreDelLugar, estructura)
% nacionDelFuego(nombreDelLugar, soldadosQueLoDefienden)
% tribuAgua(puntoCardinalDondeSeUbica)
% temploAire(puntoCardinalDondeSeUbica)
visito(aang, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])).
visito(iroh, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])).
visito(zuko, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])).
visito(toph, reinoTierra(fortalezaDeGralFong, [cuartel, dormitorios, enfermeria, salaDeGuerra, templo, zonaDeRecreo])).
visito(aang, nacionDelFuego(palacioReal, 1000)).
visito(katara, tribuAgua(norte)).
visito(katara, tribuAgua(sur)).
visito(aang, temploAire(norte)).
visito(aang, temploAire(oeste)).
visito(aang, temploAire(este)).
visito(aang, temploAire(sur)).

/*visito(zuko, temploAire(norte)).
visito(toph, temploAire(norte)).
visito(katara, temploAire(norte)).*/

esElAvatar(UnPersonaje):-
    controla(UnPersonaje,UnElemeto),
    forall(controla(UnPersonaje,UnElemeto),esElementoBasico(UnElemeto)).

noEsMaestro(UnPersonaje):-
    esPersonaje(UnPersonaje),
    not(controla(UnPersonaje,_)).

esMaestroPrincipiante(UnPersonaje):-
    controla(UnPersonaje,_),
    forall(controla(UnPersonaje,UnElemeto),not(elementoAvanzadoDe(_,UnElemeto))).%para todo elemento que controla, ninguno es elemento avanzado

esMaestroAvanazado(UnPersonaje):-
    esElAvatar(UnPersonaje).
esMaestroAvanazado(UnPersonaje):-
    controla(UnPersonaje,UnElemeto),
    elementoAvanzadoDe(_,UnElemeto).

sigueA(UnPersonaje,OtroPersonaje):- %el segundo visita todos los lugares del primero
    visito(UnPersonaje,UnLugar),
    visito(OtroPersonaje,_),
    UnPersonaje\=OtroPersonaje,
    forall(visito(UnPersonaje,UnLugar),visito(OtroPersonaje,UnLugar)).
sigueA(aang,zuko).

esUnLugarConocido(UnLugar):- %me refiero a lugar conocido a un lugar que ya fue visitado por alguien anteriormente
    visito(_,UnLugar).

esDignoDeConocer(UnLugar):-
    esUnLugarConocido(UnLugar),
    lugarDignoDeConocer(UnLugar).

lugarDignoDeConocer(temploAire(_)).
lugarDignoDeConocer(tribuAgua(norte)).
lugarDignoDeConocer(reinoTierra(_,Estructuras)):-
    not(member(muro,Estructuras)).

esPopular(UnLugar):-
    esUnLugarConocido(UnLugar),
    findall(UnPersonaje,visito(UnPersonaje,UnLugar),PersonajesQueVisitaronEseLugar),
    length(PersonajesQueVisitaronEseLugar,Cuantos),
    Cuantos > 4.

esPersonaje(bumi).
visito(bumi, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])).
controla(bumi,tierra).

esPersonaje(suki).
visito(nacionDelFuego(prisionMaximaSeguridad,200)).