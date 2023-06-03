import Text.Show.Functions ()
import Data.Char (toUpper)
data Barbaro = Barbaro{
    nombre :: String,
    fuerza :: Int,
    habilidades :: [Habilidad],
    objetos :: [Objeto]
}deriving Show

type Objeto = (Barbaro ->Barbaro)
type Habilidad = String

dave :: Barbaro
dave = Barbaro "Dave" 100 ["tejer","escribirPoesia"] [ardilla, varitaDefectuosa]

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
type Evento = (Barbaro -> Bool)
invasionDeSuciosDuendes :: Evento
invasionDeSuciosDuendes unBarbaro = sabeEscribirPoesia unBarbaro

sabeEscribirPoesia :: Barbaro -> Bool
sabeEscribirPoesia unBarbaro = elem "escribir poesia" (habilidades unBarbaro)

cremalleraDelTiempo :: Evento
cremalleraDelTiempo unBarbaro = seLlama "Faffy" unBarbaro || seLlama "Astro" unBarbaro

seLlama :: String -> Barbaro -> Bool
seLlama unNombre unBarbaro = nombre unBarbaro == unNombre

