import Text.Show.Functions ()

data Participante = Participante {
    nombre :: String,
    especialidad :: Plato,
    trucos :: [Truco]
} deriving Show

data Plato = Plato {
    dificultad :: Int,
    ingredientes :: [Componente]
} deriving Show

type Truco = (Plato ->Plato)
type Componente = (String,Int)

endulzar :: Int -> Truco
endulzar cantidad unPlato = agregarComponente "azucar" cantidad unPlato

salar :: Int -> Truco
salar cantidad unPlato = agregarComponente "sal" cantidad unPlato

agregarComponente :: String->Int -> Plato ->Plato
agregarComponente nombre cantidad unPlato = unPlato {ingredientes=  (nombre , cantidad) : ingredientes unPlato }

darSabor :: Int->Int ->Truco
darSabor sal  azucar  unPlato = (salar sal).(endulzar azucar) $ unPlato

duplicarPorcion :: Plato -> Plato
duplicarPorcion unPlato = unPlato {ingredientes= map multiplicarCantidadPor2 (ingredientes unPlato)}

multiplicarCantidadPor2 :: Componente ->Componente
multiplicarCantidadPor2 (nombre , cantidad) = (nombre,cantidad*2) 

simplificar :: Truco
simplificar unPlato
    |esUnBardo unPlato = unPlato {dificultad =5 , ingredientes= filter hayMucho (ingredientes unPlato)}
    |otherwise = unPlato

esUnBardo:: Plato -> Bool
esUnBardo unPlato = dificultad unPlato >7 && length (ingredientes unPlato) >5

hayMucho :: Componente->Bool
hayMucho unComponente = snd unComponente >10

esVegano :: Plato -> Bool
esVegano unPlato = any cosasNoVeganas (sacarNombreComponetes unPlato) 

sacarNombreComponetes :: Plato->[String]
sacarNombreComponetes unPlato = map fst (ingredientes unPlato)

cosasNoVeganas :: [String]
cosasNoVeganas = ["carne", "huevo", "leche", "queso","yogurth"]