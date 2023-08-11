%enunciado: https://docs.google.com/document/d/1xbXPZnhwyK5FSHR_oaXU4esfkTd2S-jf3rH1XLw864M/edit

%cantante(nombre,cancioQueSabe,duracionDeLaCancionQueSabe).
cantante(megurineLuka,nightFever,4).
cantante(megurineLuka,foreverYoung,5).
cantante(hatsuneMiku,tellYourWorld,4).
cantante(gumi,foreverYoung,4).
cantante(gumi,tellYourWorld,5).
cantante(seeU,novemberRain,6).
cantante(seeU,nightFever,5).


esNovedoso(UnCantante):-
    sabeAlMenosDosCanciones(UnCantante),
    tiempoTotalQueDuranTodasLasCancionesDe(UnCantante,TiempoTotal),
    TiempoTotal < 15.

    sabeAlMenosDosCanciones(UnCantante):-
        cantante(UnCantante,UnaCancion,_),
        cantante(UnCantante,OtraCancion,_),
        UnaCancion\=OtraCancion.

    tiempoTotalQueDuranTodasLasCancionesDe(UnCantante,TiempoTotal):-
        cantante(UnCantante,_,_),
        findall(Duracion,cantante(UnCantante,_,Duracion),ListaDeDuraciones),
        sum_list(ListaDeDuraciones,TiempoTotal).

esAcelerado(UnCantante):-
    cantante(UnCantante,_,_),
    not((cantante(UnCantante,_,UnaDuracion),UnaDuracion>4)).

%concierto(nombre,pais,fama,tipo).
%functores: 
%gigantes(sepaMasDetantasCanciones,tiempoMinimo) , mediamos(tiempomaximoDecanciones), pequeños(unaOMasCancionesDetantosmin)
concierto(mikuExpo,estadosUnidos,2000,gigante(2,6)).
concierto(magicalMirai,japon,3000,gigante(3,10)).
concierto(vocalekt,estadosUnidos,1000,mediano(9)).
concierto(mikuFest,argentina,100,pequenio(4)).

puedeParticiparDe(UnConcierto,hatsuneMiku):-
    concierto(UnConcierto,_,_,_).
puedeParticiparDe(UnConcierto,UnCantante):-
    cantante(UnCantante,_,_),
    concierto(UnConcierto,_,_,UnaCondicion),
    cumpleCon(UnaCondicion,UnCantante).

    cumpleCon(gigante(UnNumero,OtroNumero),UnCantante):-
        lasCancionesQueSabeSonMasDe(UnNumero,UnCantante),
        cumpleConTiempoMinimo(OtroNumero,UnCantante).
        
        lasCancionesQueSabeSonMasDe(UnaCantidad,UnCantante):-
            cantidadDeCancionesQueSabe(UnCantante,CantidadQueSabe),
            CantidadQueSabe >UnaCantidad.

        cantidadDeCancionesQueSabe(UnCantante,CantidadQueSabe):-
            findall(Cancion,cantante(UnCantante,Cancion,_),CansionesQueSabe),
            length(CansionesQueSabe,CantidadQueSabe).

        cumpleConTiempoMinimo(UnTiempo,UnCantante):-
            tiempoTotalQueDuranTodasLasCancionesDe(UnCantante,TiempoTotal),
            TiempoTotal>=UnTiempo.
    
    cumpleCon(mediano(UnNumero),UnCantante):-
        tiempoTotalQueDuranTodasLasCancionesDe(UnCantante,TiempoTotal),
        TiempoTotal=<UnNumero.

    cumpleCon(pequenio(UnNumero),UnCantante):-
        cantante(UnCantante,_,UnaDuracion),
        UnaDuracion>UnNumero.

elMasFamoso(UnCantante):-
    cantante(UnCantante,_,_),
    cantante(OtroCantante,_,_),
    UnCantante\=UnCantante,
    forall(cantante(UnCantante,_,_),esMasFamoso(UnCantante,OtroCantante)).

    esMasFamoso(UnCantante,OtroCantante):-
        cantidadDeFama(UnCantante,UnaCantidad),
        cantidadDeFama(OtroCantante,OtraCantidad),
        UnaCantidad>OtraCantidad.

    cantidadDeFama(UnCantante,UnaCantidad):-
        