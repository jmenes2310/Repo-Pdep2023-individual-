import Text.Show.Functions ()

data Participante = UnParticipante {
    nombre :: String,
    especialidad :: Plato,
    trucos :: [Truco]
} deriving Show

data Plato = UnPlato {
    dificultad :: Int,
    ingredientes :: [Componente]
} deriving Show

type Truco = (Plato ->Plato)
type Componente = (String,Int)

--platos de prueba:
pizza :: Plato
pizza = UnPlato {dificultad=2 , ingredientes=[("leche",1000),("sal",20),("harina",10),("salsa", 200),("queso",400)]}


endulzar :: Int -> Truco
endulzar cantidad unPlato = agregarComponente "azucar" cantidad unPlato

salar :: Int -> Truco
salar cantidad unPlato = agregarComponente "sal" cantidad unPlato

agregarComponente :: String->Int -> Plato ->Plato
agregarComponente nombre cantidad unPlato = unPlato {ingredientes=  (nombre , cantidad) : ingredientes unPlato }

darSabor :: Int->Int ->Truco
darSabor sal  azucar  unPlato = (salar sal).(endulzar azucar) $ unPlato

duplicarPorcion :: Truco
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

--vegano
esVegano :: Plato -> Bool
esVegano unPlato = not (algunIngredienteDe unPlato tieneCosasNoVeganas)

tieneCosasNoVeganas :: Componente ->Bool
tieneCosasNoVeganas (ingrediente,_) = elem ingrediente cosasNoVeganas

cosasNoVeganas :: [String]
cosasNoVeganas = ["carne", "huevo", "leche", "queso","yogurth","manteca"]

--sin tacc
esSinTacc:: Plato -> Bool
esSinTacc unPlato= not (algunIngredienteDe unPlato tieneHarina)

tieneHarina :: Componente->Bool
tieneHarina (ingrediente,_) = ingrediente == "harina"

--hipertension
noAptoHipertension :: Plato ->Bool
noAptoHipertension unPlato = algunIngredienteDe unPlato tieneMasDe2GramosDeSal

tieneMasDe2GramosDeSal :: Componente ->Bool
tieneMasDe2GramosDeSal (ingrediente,cantidad) = ingrediente == "sal" && cantidad >2 

algunIngredienteDe :: Plato->(Componente->Bool) ->Bool
algunIngredienteDe unPlato unaFuncion = any unaFuncion (ingredientes unPlato)


pepeRonccino :: Participante
pepeRonccino = UnParticipante {nombre = "Pepe Ronccino", especialidad = platoComplejo, trucos = [darSabor 2 5 , simplificar , duplicarPorcion]}

platoComplejo :: Plato
platoComplejo = UnPlato {dificultad=8,ingredientes= [("sal",20),("azucar",10),("harina",500),("manteca",100),("leche",200),("carne",600)]}


--funcionalidades
cocinar :: Participante ->Plato
cocinar unParticipante = foldr (aplicarUnTruco) (especialidad unParticipante) (trucos unParticipante)

aplicarUnTruco :: Truco ->Plato->Plato
aplicarUnTruco unTruco unPlato = unTruco unPlato

esMejorQue :: Plato->Plato->Bool
esMejorQue unPlato otroPlato = (dificultad unPlato > dificultad otroPlato) && (sumaDePesosDeSusIngredientes unPlato < sumaDePesosDeSusIngredientes otroPlato)

sumaDePesosDeSusIngredientes :: Plato ->Int
sumaDePesosDeSusIngredientes unPlato = sum(map snd (ingredientes unPlato))

participanteEstrella :: [Participante]->Participante
participanteEstrella listaParticipantes  = foldr1 (mejorParticipante) listaParticipantes

mejorParticipante :: Participante->Participante->Participante
mejorParticipante  unParticipante otroParticipante
    | esMejorQue (cocinar unParticipante) (cocinar otroParticipante) =unParticipante
    |otherwise = otroParticipante


platinum :: Plato
platinum = UnPlato {dificultad =10, ingredientes = unaListaDeIngredientesRara}

unaListaDeIngredientesRara :: [Componente]
unaListaDeIngredientesRara = map (\unNumero -> ("Ingrediente" ++ show unNumero,unNumero)) [1..]