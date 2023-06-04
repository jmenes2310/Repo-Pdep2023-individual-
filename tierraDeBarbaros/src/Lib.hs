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
varitaDefectuosa unBarbaro = añadirHabilidad "hacer magia" . borrarHabilidades $ unBarbaro

añadirHabilidad :: Habilidad ->Barbaro ->Barbaro
añadirHabilidad unaHabilidad unBarbaro = unBarbaro {habilidades = unaHabilidad : habilidades unBarbaro}

borrarHabilidades :: Barbaro -> Barbaro
borrarHabilidades unBarbaro = unBarbaro {habilidades = []}

ardilla :: Objeto
ardilla unBarbaro = unBarbaro

cuerda :: Objeto ->Objeto->Objeto
cuerda unObjeto otroObjeto = unObjeto . otroObjeto

megafono :: Objeto
megafono unBarbaro = unBarbaro {habilidades= [(ponerEnMayusculas . concatenarHabilidades) $ habilidades unBarbaro]} 

concatenarHabilidades :: [String] ->String
concatenarHabilidades habilidades = concat habilidades

ponerEnMayusculas :: String ->String
ponerEnMayusculas habilidadesConcatenadas = map toUpper habilidadesConcatenadas

megafonoBarbarico :: Objeto
megafonoBarbarico unBarbaro = (cuerda ardilla megafono) unBarbaro

--PUNTO 3
type Aventura = (Barbaro -> Bool)

invasionDeSuciosDuendes :: Aventura
invasionDeSuciosDuendes unBarbaro = sabeEscribirPoesia unBarbaro

sabeEscribirPoesia :: Barbaro -> Bool
sabeEscribirPoesia unBarbaro = elem "escribir poesia" (habilidades unBarbaro)

cremalleraDelTiempo :: Aventura
cremalleraDelTiempo unBarbaro = unBarbaro `seLlama` "Faffy"  || unBarbaro `seLlama` "Astro" 

seLlama :: Barbaro ->String ->  Bool
seLlama unBarbaro unNombre = nombre unBarbaro == unNombre

ritualDeFechorias :: Aventura
ritualDeFechorias unBarbaro = saqueo unBarbaro && gritoDeGuerra unBarbaro && caligrafia unBarbaro

saqueo :: Barbaro -> Bool
saqueo unBarbaro = unBarbaro `tieneHabilidadDe` "robar" && fuerza unBarbaro >80

tieneHabilidadDe :: Barbaro ->Habilidad->Bool
tieneHabilidadDe unBarbaro unaHabilidad = elem unaHabilidad (habilidades unBarbaro)

gritoDeGuerra :: Barbaro -> Bool
gritoDeGuerra unBarbaro = (length.concatenarHabilidades.habilidades) unBarbaro > length (objetos unBarbaro)

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
sobrevivientes barbaros unaAventura = filter (unaAventura) barbaros

sinRepetidos ::[Habilidad] -> [Habilidad]
sinRepetidos []= []
sinRepetidos (cabeza:cola) 
    |elem cabeza cola = sinRepetidos cola
    |otherwise = cabeza : sinRepetidos cola


descendiente :: Barbaro ->[Barbaro]
descendiente unBarbaro = map (\unNumero -> utilizarTodosLosObjetos unBarbaro {nombre = nombre unBarbaro ++ (replicate unNumero '*'),habilidades=sinRepetidos (habilidades unBarbaro)}) [1..]

utilizarTodosLosObjetos :: Barbaro ->Barbaro
utilizarTodosLosObjetos unBarbaro = foldr utilizarObjeto unBarbaro (objetos unBarbaro)

utilizarObjeto :: Objeto->Barbaro->Barbaro
utilizarObjeto unObjeto unBarbaro = unObjeto unBarbaro
