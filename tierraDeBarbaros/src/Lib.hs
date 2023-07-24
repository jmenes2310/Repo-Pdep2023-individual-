import Text.Show.Functions ()
import Data.Char (toUpper)
import Data.Char (isUpper)

data Barbaro = Barbaro{
    nombre :: String,
    fuerza :: Int,
    habilidades :: [Habilidad],
    objetos :: [Objeto]
}deriving Show

type Objeto = (Barbaro ->Barbaro)
type Habilidad = String

dave :: Barbaro
dave = Barbaro "Dave" 100 ["cantar","tejer","tejer","escribirPoesia"] [ardilla, varitaDefectuosa]

espada :: Int -> Objeto
espada persoDeLaEspada unBarbaro = unBarbaro {fuerza = fuerza unBarbaro + persoDeLaEspada*2}

amuletosMistico :: Habilidad ->Objeto
amuletosMistico unaHabilidad unBarbaro = añadirHabilidad unaHabilidad unBarbaro 

varitaDefectuosa :: Objeto
varitaDefectuosa unBarbaro = añadirHabilidad "hacer magia" . desapaecerObjetos $ unBarbaro

añadirHabilidad :: Habilidad ->Barbaro ->Barbaro
añadirHabilidad unaHabilidad unBarbaro = unBarbaro {habilidades = unaHabilidad : habilidades unBarbaro}

desapaecerObjetos :: Barbaro -> Barbaro
desapaecerObjetos unBarbaro = unBarbaro {objetos = []}

ardilla :: Objeto
ardilla unBarbaro = unBarbaro

cuerda :: Objeto ->Objeto->Objeto
cuerda unObjeto otroObjeto = unObjeto . otroObjeto

megafono :: Objeto
megafono unBarbaro = unBarbaro {habilidades= [(ponerEnMayusculas . concatenarHabilidades) $ habilidades unBarbaro]} 

concatenarHabilidades :: [String] ->String
concatenarHabilidades listaDeHabilidades = concat listaDeHabilidades

ponerEnMayusculas :: String ->String
ponerEnMayusculas habilidadesConcatenadas = map toUpper habilidadesConcatenadas

megafonoBarbarico :: Objeto
megafonoBarbarico unBarbaro = (cuerda ardilla megafono) unBarbaro

--PUNTO 3
type Evento = (Barbaro -> Bool)
type Aventura = [Evento]

invasionDeSuciosDuendes :: Evento
invasionDeSuciosDuendes unBarbaro = sabe "escribir poesria atroz" unBarbaro

sabe :: String->Barbaro -> Bool
sabe habilidad unBarbaro = elem habilidad (habilidades unBarbaro)

cremalleraDelTiempo :: Evento
cremalleraDelTiempo unBarbaro = unBarbaro `seLlama` "Faffy"  || unBarbaro `seLlama` "Astro" 

seLlama :: Barbaro ->String ->  Bool
seLlama unBarbaro unNombre = nombre unBarbaro == unNombre

ritualDeFechorias :: Evento
ritualDeFechorias unBarbaro = saqueo unBarbaro || gritoDeGuerra unBarbaro || caligrafia unBarbaro

saqueo :: Barbaro ->Bool
saqueo unBarbaro =  sabe "robar" unBarbaro && fuerza unBarbaro >80

gritoDeGuerra :: Barbaro -> Bool
gritoDeGuerra unBarbaro = poderDeGritoDe unBarbaro > 4 * length (objetos unBarbaro)

poderDeGritoDe :: Barbaro->Int
poderDeGritoDe unBarbaro =(length.concatenarHabilidades.habilidades) unBarbaro 

caligrafia :: Barbaro -> Bool
caligrafia unBarbaro = all tienenMasDe3Vocales (habilidades unBarbaro) && comienzanConMayuscula (habilidades unBarbaro)

tienenMasDe3Vocales :: [Char]->Bool
tienenMasDe3Vocales cadena = length (filter lasQueSonVocalesDe cadena) >3

lasQueSonVocalesDe :: Char ->Bool
lasQueSonVocalesDe unCaracter = elem unCaracter vocales

vocales :: [Char]
vocales = ['A','E','I','O','U','a','e','i','o','u']

comienzanConMayuscula :: [String]->Bool
comienzanConMayuscula lista = all isUpper (map head lista)

sobrevivientes :: [Barbaro]->Aventura->[Barbaro]
sobrevivientes barbaros unaAventura = filter (sobrevive unaAventura) barbaros

sobrevive :: Aventura -> Barbaro->Bool
sobrevive unaAventura unBarbaro = all (supera unBarbaro) unaAventura

supera :: Barbaro->Evento->Bool
supera unBarbaro unEvento = unEvento unBarbaro

sinRepetidos ::Eq a => [a]->[a] --lo hago asi porque nos piden que se elimine los elementos repetidos de una lista, no solo las habilidades
sinRepetidos []= []
sinRepetidos (cabeza:cola) 
    |elem cabeza cola = sinRepetidos cola
    |otherwise = cabeza : sinRepetidos cola


--descendiente :: Barbaro ->[Barbaro]
--descendiente unBarbaro = map (\unNumero -> utilizarTodosLosObjetos unBarbaro {nombre = nombre unBarbaro ++ (replicate unNumero '*'),habilidades=sinRepetidos (habilidades unBarbaro)}) [1..]

{-descendiente :: Barbaro ->[Barbaro]
descendiente unBarbaro =infinitosDescendientes . utilizarTodosLosObjetos $ unBarbaro {habilidades= sinRepetidos $ habilidades unBarbaro}

infinitosDescendientes::Barbaro->[Barbaro]
infinitosDescendientes unBarbaro = map (\unNumero-> unBarbaro{nombre=nombre unBarbaro ++ (replicate unNumero '*')}) [1..]-}

descendiente :: Barbaro ->[Barbaro]
descendiente unBarbaro =tail ( iterate (agregarAsterisco . utilizarTodosLosObjetos . habilidadesSinRepetir)  unBarbaro)
--hay que hacerle tail porque iterate cuando en la cabeza deja el elemento sin aplicar la funcion

habilidadesSinRepetir :: Barbaro->Barbaro
habilidadesSinRepetir unBarbaro = unBarbaro{habilidades=sinRepetidos (habilidades unBarbaro)}

utilizarTodosLosObjetos :: Barbaro ->Barbaro
utilizarTodosLosObjetos unBarbaro = foldr utilizarObjeto unBarbaro (objetos unBarbaro)

utilizarObjeto :: Objeto->Barbaro->Barbaro
utilizarObjeto unObjeto unBarbaro = unObjeto unBarbaro

agregarAsterisco :: Barbaro ->Barbaro
agregarAsterisco unBarbaro = unBarbaro {nombre = (nombre unBarbaro)++ "*"}