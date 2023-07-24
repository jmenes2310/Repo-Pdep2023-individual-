import Text.Show.Functions ()

data Ninja = Ninja{
    nombre :: String,
    herramientas :: [Herramienta],
    rangoNinja :: Int, --no puede ser negativo
    jutsus :: [Jutsu]
}deriving Show

type Herramienta = (Nombre,Cantidad)
type Nombre = String
type Cantidad = Int
type Jutsu = (Mision->Mision)

data Mision = Mision {
    cantidadDeNinjasRequeridos::Int,
    rango :: Int,
    enemigos :: [Ninja],
    recompensa :: Herramienta 
}deriving Show

naruto :: Ninja
naruto = Ninja {nombre="naruto",herramientas=[("kunai",10),("kunia2",10)],rangoNinja=1,jutsus=[fuerzaDeUnCentenar,fuerzaDeUnCentenar]}

sasuke:: Ninja
sasuke = Ninja {nombre="sasuke",herramientas=[("kunai",100),("kunia2",100)],rangoNinja=1,jutsus=[fuerzaDeUnCentenar]}

obtenerHerramienta :: Herramienta ->Ninja->Ninja
obtenerHerramienta (nombreDeHerramienta,cantidadDeHerramienta) unNinja
    |(sumarHerramientasDe unNinja + cantidadDeHerramienta )<= 100 = agregrarHerramienta (nombreDeHerramienta,cantidadDeHerramienta) unNinja
    |otherwise = agregrarHerramienta (nombreDeHerramienta,100 - sumarHerramientasDe unNinja) unNinja

agregrarHerramienta :: Herramienta-> Ninja->Ninja
agregrarHerramienta unaHerramienta unNinja = unNinja {herramientas= unaHerramienta : (herramientas unNinja) }

sumarHerramientasDe :: Ninja->Int
sumarHerramientasDe ninja = sum . map snd $ herramientas ninja 

usarHerramienta :: Herramienta ->Ninja ->Ninja
usarHerramienta unaHerramienta unNinja = unNinja{herramientas= filter (lasQueNoUsa unaHerramienta ) (herramientas unNinja) } 

lasQueNoUsa :: Herramienta->Herramienta->Bool
lasQueNoUsa unaHerramienta otraHerramienta = unaHerramienta /= otraHerramienta

type Equipo = [Ninja]

--desafiante
esDesafiantes :: Equipo -> Mision ->Bool
esDesafiantes unEquipo unaMision = any (suRangoEs (<) (rango unaMision)) unEquipo && tieneAlMenos2Enemigos unaMision

suRangoEs :: (Int->Int->Bool)->Int->Ninja->Bool
suRangoEs comparador unNumero unNinja =  (rangoNinja unNinja) `comparador` (unNumero)

tieneAlMenos2Enemigos :: Mision ->Bool
tieneAlMenos2Enemigos unaMision = length (enemigos unaMision) >= 2

--copada
--3 bombas de humo, 5 shurikens o 14 kunais
esCopada :: Mision->Bool
esCopada unaMision = daComoRecompensa [("bobas de humo",3),("shurikens",5),("kunais",14)] unaMision

daComoRecompensa :: [Herramienta]->Mision->Bool
daComoRecompensa herramientas unaMision = elem (recompensa unaMision) herramientas

--factible
esFactible :: Equipo->Mision->Bool
esFactible unEquipo unaMision = not (esDesafiantes unEquipo unaMision) && ( (tieneNinjasNecesarios unEquipo unaMision) || (lasHerramientasSonMasDe 500 unEquipo) ) 

tieneNinjasNecesarios :: Equipo -> Mision->Bool
tieneNinjasNecesarios unEquipo unaMision = (length unEquipo) >= (cantidadDeNinjasRequeridos unaMision)

lasHerramientasSonMasDe :: Int ->Equipo->Bool
lasHerramientasSonMasDe unNumero unEquipo = (sum . map sumarHerramientasDe $ unEquipo) > unNumero

--fallar una mision

fallarMision :: Equipo->Mision->Equipo
fallarMision unEquipo unaMision = disminuir2Rangos . sacarAlosDeMenorRango unaMision $ unEquipo

sacarAlosDeMenorRango :: Mision -> Equipo->Equipo
sacarAlosDeMenorRango unaMision unEquipo = filter (suRangoEs (>=) (rango unaMision)) unEquipo

disminuir2Rangos :: Equipo->Equipo
disminuir2Rangos unEquipo = map (modificarRango subtract 2) unEquipo

modificarRango :: (Int->Int->Int)->Int->Ninja->Ninja
modificarRango operacion unNumero unNinja = unNinja {rangoNinja= max ((rangoNinja unNinja) `operacion` unNumero) 0 }

--cumplir una mision
cumplirMision :: Equipo->Mision->Equipo
cumplirMision unEquipo unaMision = otorgarRecompensa unaMision .(promocionarRango 1) $ unEquipo

promocionarRango :: Int->Equipo ->Equipo
promocionarRango unNumero unEquipo = map (modificarRango (+) unNumero) unEquipo

otorgarRecompensa :: Mision->Equipo->Equipo
otorgarRecompensa unaMision unEquipo = map (obtenerHerramienta (recompensa unaMision)) unEquipo

--jutsus

clonesDeSombra :: Int ->Jutsu
clonesDeSombra cantidadDeClones unaMision = reducirNinjasNecesarios unaMision cantidadDeClones

reducirNinjasNecesarios :: Mision->Int->Mision
reducirNinjasNecesarios unaMision unNumero = unaMision{cantidadDeNinjasRequeridos = max 1 (cantidadDeNinjasRequeridos unaMision - unNumero)}

fuerzaDeUnCentenar :: Jutsu
fuerzaDeUnCentenar unaMision = unaMision{enemigos= filter (suRangoEs (>=) 500) (enemigos unaMision) } 

--ejecutar mision

ejecutarMision :: Equipo ->Mision->Equipo
ejecutarMision unEquipo unaMision
    |(esFactible unEquipo (aplicarTodosLosJutsus unEquipo unaMision)) || (esCopada (aplicarTodosLosJutsus unEquipo unaMision)) = cumplirMision unEquipo unaMision
    |otherwise = fallarMision unEquipo unaMision

aplicarTodosLosJutsus :: Equipo ->Mision->Mision
aplicarTodosLosJutsus unEquipo unaMision = foldr ($) unaMision (todosLosJutsusDe unEquipo)

todosLosJutsusDe :: Equipo -> [Jutsu]
todosLosJutsusDe unEquipo = concatMap jutsus unEquipo

laGranGuerraNinja :: Mision
laGranGuerraNinja = Mision 100000 100 (ninjasInfinitos zetsu) ("abanico de Madara Uchiha",1)

zetsu :: Ninja
zetsu = Ninja "Zetsu " [] 600  []

ninjasInfinitos :: Ninja->[Ninja]
ninjasInfinitos unNinja = map (\unNumero -> unNinja{nombre= (nombre unNinja)++ show unNumero}) [1..]

--ninjas finitos y laGranGuerraNinja tiene ninjasInfinitos
{-
a) dependeria del equipo, porque si ninguno tiene un rango menor al necesitado para la mision, terminar de evaluar y devuelve falso porque se trata de un &&. En cambio, si alguno del equipo 
tiene rango menor al necesario ahi si nunca terminaria de evaluar la cantidad de enemigos

b)si, ya que solo se evalua el apartado de recompensa de una mision el cual no es infinito, entonces puede evaluarlo tranquilamente.
En este caso evaluaria que la recompensa sean  3 bombas de humo, 5 shurikens o 14 kunais.

c) devolveria una lista infinita con todos los zetsus con rango >= a 500, osea, todos
-}