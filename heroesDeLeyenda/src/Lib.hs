--los heroes tiene epiteto(nombre),artefactos (nombre,rareza), lista d tares [(heroes->Heroe)]
import Text.Show.Functions ()

data Heroe = Heroe{
    epiteto ::String,
    reconocimiento::Int,
    artefactos :: [Artefacto],
    tareas :: [Tarea]
}deriving Show

type Artefacto = (Nombre,Int)
type Tarea = (Heroe->Heroe)
type Nombre = String

pasaALaHitoria :: Heroe->Heroe
pasaALaHitoria unHeroe
    |reconocimiento unHeroe >100 = modificarEpiteto "El mitico" unHeroe
    |reconocimiento unHeroe >500 =añadirArtefacto ("Lanza del olimpo",100) . modificarEpiteto "El magnifico" $ unHeroe
    |reconocimiento unHeroe >100 =añadirArtefacto ("Xiphos",50) . modificarEpiteto "Hoplita" $ unHeroe
    |otherwise = unHeroe

modificarEpiteto :: String->Heroe->Heroe
modificarEpiteto nuevoEpiteto unHeroe =unHeroe{epiteto = nuevoEpiteto} 

añadirArtefacto :: Artefacto->Heroe->Heroe
añadirArtefacto unArtefacto unHeroe = unHeroe{artefactos =unArtefacto : (artefactos unHeroe) }

encontrarArtefacto :: Artefacto->Tarea
encontrarArtefacto unArtefacto unHeroe = sumarReconocimiento (snd unArtefacto) . añadirArtefacto unArtefacto $ unHeroe

sumarReconocimiento :: Int->Heroe->Heroe
sumarReconocimiento unNumero unHeroe = unHeroe{reconocimiento=unNumero + reconocimiento unHeroe}

escalarElOlimpo :: Tarea
escalarElOlimpo unHeroe = añadirArtefacto ("El relámpago de Zeus",500) . deshecharObjetos . triplicarRarezaDeObjetos . sumarReconocimiento 500 $ unHeroe

deshecharObjetos :: Heroe->Heroe
deshecharObjetos unHeroe = unHeroe{artefactos = filter (not.menosDe1000DeRareza) (artefactos unHeroe)}

menosDe1000DeRareza :: Artefacto->Bool
menosDe1000DeRareza unArtefacto = snd unArtefacto <1000

triplicarRarezaDeObjetos :: Heroe->Heroe
triplicarRarezaDeObjetos unHeroe = unHeroe{artefactos = map (multiplicarRarezaPor3) (artefactos unHeroe)}

multiplicarRarezaPor3 :: Artefacto ->Artefacto
multiplicarRarezaPor3 (nombre,rareza) = (nombre , rareza *3)

ayudarACruzarLaCalle :: Int -> Tarea
ayudarACruzarLaCalle cuadras unHeroe = modificarEpiteto ("Groso"++ replicate cuadras 'o') unHeroe

type Bestia = (Nombre , Debilidad)
type Debilidad = (Heroe ->Bool)

matarALaBestia :: Bestia -> Tarea
matarALaBestia unaBestia unHeroe
    |(snd unaBestia) unHeroe = modificarEpiteto ("el asesino de " ++ fst unaBestia) unHeroe
    |otherwise = pierdePrimerArtefacto . modificarEpiteto ("El cobarde") $ unHeroe

pierdePrimerArtefacto :: Heroe->Heroe
pierdePrimerArtefacto unHeroe = unHeroe{artefactos = tail (artefactos unHeroe)}

heracles :: Heroe
heracles = Heroe "Guardian del Olimpo" 700 [("pistola",1000),("relampagoDeZeuz",500)] [matarALaBestia leonDeNemea]

leonDeNemea ::Bestia
leonDeNemea = ("Leon de Nemea",tieneEpitetoLargo)

tieneEpitetoLargo :: Heroe->Bool
tieneEpitetoLargo unHeroe = length (epiteto unHeroe) > 20

hacerUnaTarea :: Tarea ->Heroe->Heroe
hacerUnaTarea unaTarea unHeroe = unaTarea unHeroe

presumen :: (Heroe,Heroe)->(Heroe,Heroe)
presumen (unHeroe,otroHeroe)
    |reconocimientoDistintoEntre unHeroe otroHeroe = ganadorDe (reconocimiento) unHeroe otroHeroe
    |rarezasDistintasEntre unHeroe otroHeroe = ganadorDe (sumatoriaDeRarerzas) unHeroe otroHeroe
    |otherwise = presumen (hacerTareasDelOtro unHeroe otroHeroe , hacerTareasDelOtro otroHeroe unHeroe)

reconocimientoDistintoEntre :: Heroe->Heroe->Bool
reconocimientoDistintoEntre unHeroe otroHeroe = reconocimiento unHeroe /= reconocimiento otroHeroe

rarezasDistintasEntre :: Heroe->Heroe->Bool
rarezasDistintasEntre unHeroe otroHeroe = sumatoriaDeRarerzas unHeroe /=  sumatoriaDeRarerzas otroHeroe

sumatoriaDeRarerzas :: Heroe ->Int
sumatoriaDeRarerzas unHeroe = sum $ map snd (artefactos unHeroe)

ganadorDe :: (Heroe->Int)-> Heroe->Heroe->(Heroe,Heroe)
ganadorDe aspecto unHeroe otroHeroe
    |aspecto unHeroe > aspecto otroHeroe = (unHeroe,otroHeroe)
    |otherwise = (otroHeroe,unHeroe)

{-ganadorDeReconocimiento :: Heroe->Heroe->(Heroe,Heroe)
ganadorDeReconocimiento unHeroe otroHeroe
    |reconocimiento unHeroe > reconocimiento otroHeroe = (unHeroe,otroHeroe)
    |otherwise = (otroHeroe,unHeroe)

ganadorDeRarezas :: Heroe->Heroe->(Heroe,Heroe)
ganadorDeRarezas unHeroe otroHeroe
    |sumatoriaDeRarerzas unHeroe > sumatoriaDeRarerzas otroHeroe =(unHeroe,otroHeroe)
    |otherwise = (otroHeroe,unHeroe)-}

hacerTareasDelOtro :: Heroe->Heroe->Heroe
hacerTareasDelOtro heroe1 heroe2 = foldr hacerUnaTarea heroe1 (tareas heroe2)

heroe' :: Heroe
heroe' = Heroe "1" 100 [] []

heroe'' :: Heroe
heroe'' = Heroe "2" 100 [] []

--respuesta punto 8 : no habra un resultado ya que cuando entre por el otherwise entrarán de nuevo a la funcion presumen
--y ademas como ninguno tenia tareas del otro por resolver quedaran exactamente igual y asi sucesivamente !!

type Labor = [Tarea]

realizarLabor :: Labor->Heroe->Heroe
realizarLabor labor unHeroe = foldr hacerUnaTarea unHeroe labor

--respuesta punto 10 : no, ya que nuncatermina de realizar tareas, es decir, estará infinitamente realizando tareas, para que podamos conocer 
--el resultado finales debe ser una lista finita 

