import Text.Show.Functions ()

data Chico = Chico {
    nombre :: String,
    edad:: Int,
    habilidades :: [String],
    deseos :: [Deseos]
}deriving Show

type Habilidades = [String]
type Deseos = (Chico->Chico)

timmy :: Chico
timmy = Chico "Timmy" 10 ["mirar television", "jugar en la pc"] [serMayor]

rodolfo :: Chico
rodolfo = Chico "Rodolfo" 19 ["cocina","saber manejar"] [serMayor,matar]

aprenderHabilidades :: Habilidades ->Deseos
aprenderHabilidades listaHabilidades unChico = unChico {habilidades= listaHabilidades ++ (habilidades unChico)}
--                                                      habilidades = concat [listaHabilidades,(habilidades unChico)]

serGrosoEnNeedForSpeed :: Deseos
serGrosoEnNeedForSpeed unChico = aprenderHabilidades needForSpeeds unChico

needForSpeeds :: [String]
needForSpeeds = map (\unNumero -> "Need for Speed " ++ show unNumero) [1..]

serMayor ::Deseos
serMayor unChico = cambiarEdad (18 - edad unChico) (+) unChico

wanda :: Chico -> Chico
wanda unChico = (cambiarEdad 1 (+)).head (deseos unChico) $ unChico
--wanda unChico = head (deseos unChico) unChico {edad=edad unChico +1}

cosmo :: Chico ->Chico
cosmo unChico = cambiarEdad 2 div unChico

cambiarEdad :: Int->(Int->Int ->Int) ->Chico ->Chico
cambiarEdad unNumero unaOperacion unChico = unChico {edad = unaOperacion (edad unChico) unNumero } 

muffinMagico :: Chico ->Chico
muffinMagico unChico = foldr cumplirDeseo unChico (deseos unChico)

cumplirDeseo :: Deseos ->Chico ->Chico
cumplirDeseo unDeseo unChico = unDeseo unChico 

--PARTE B

type Condicion = (Chico->Bool)

tieneHabilidad :: String ->Condicion
tieneHabilidad unaHabilidad unChico = elem unaHabilidad (habilidades unChico)

esSuperMaduro :: Condicion
esSuperMaduro unChico = edad unChico > 18 && tieneHabilidad "saber manejar" unChico

data Chica = Chica{
    nombre' :: String,
    condicion :: Condicion
}deriving Show

emilia :: Chica
emilia = Chica "Emilia" (tieneHabilidad "cocina")

quienConquistaA :: Chica -> [Chico]->Chico
quienConquistaA unaChica pretendientes
    |any (condicion unaChica) pretendientes = head (losQueCumplenCondicionDe unaChica pretendientes)
    |otherwise = last pretendientes

losQueCumplenCondicionDe :: Chica ->[Chico]->[Chico]
losQueCumplenCondicionDe unaChica pretendientes = filter (condicion unaChica) pretendientes

{-
ghci> quienConquistaA emilia [timmy, rodolfo]
Chico {nombre = "Rodolfo", edad = 19, habilidades = ["cocina","saber manejar"], deseos = [<function>]}
-}

--PARTE C
{-Dada una lista de
chicos, devuelve la lista de los nombres de
aquellos que tienen deseos prohibidos. Un deseo
está prohibido si, al aplicarlo, entre las
cinco primeras habilidades, hay alguna prohibida.
En tanto, son habilidades prohibidas enamorar,
matar y dominar el mundo.-}

habilidadesProhibidos :: Habilidades
habilidadesProhibidos = ["enamorar","matar","dominar el mundo"]

esHabilidadProhibida :: String ->Bool
esHabilidadProhibida unaHabilidad = elem unaHabilidad habilidadesProhibidos

esDeseoProhibido :: Chico ->Deseos ->Bool
esDeseoProhibido unChico unDeseo  = any esHabilidadProhibida ((take 5 . habilidades) $ unDeseo unChico)

tieneDeseoProhibido :: Chico ->Bool
tieneDeseoProhibido unChico = any (esDeseoProhibido unChico) (deseos unChico)

infractoresDeDaRules :: [Chico] ->[String]
infractoresDeDaRules chicos = map nombre (filter (tieneDeseoProhibido) (chicos))

--caso de ejemplo
matar:: Chico ->Chico
matar unChico = unChico {habilidades= "matar" : habilidades unChico}