import Text.Show.Functions ()

data Carrera = Carrera{
    vueltas :: Int,
    longitudPista :: Int,
    participantes::Participante,
    publico :: [String]
}deriving Show

data Participante = Participante{
    nombre::String,
    nafta :: Int,
    velocidad::Int,
    enamorado::String,
    truco::Truco
}deriving Show

type Truco = (Participante->Participante)

deReversaRocha :: Carrera ->Truco
deReversaRocha unaCarrera unParticipante = modificarNafta (*) (-)(longitudPista unaCarrera) 5 unParticipante

modificarNafta ::(Int->Int->Int)-> (Int->Int->Int)->Int->Int->Participante->Participante
modificarNafta unaOperacion otraOperacion unNumero otroNumero unParticipante = unParticipante{nafta = (nafta unParticipante) `otraOperacion` (unNumero `unaOperacion` otroNumero) }

impresionar ::Carrera ->Truco
impresionar unaCarrera unParticipante
    |estaElEnamorado unaCarrera unParticipante = modificarVelocidad (*) 2 unParticipante
    |otherwise = unParticipante

estaElEnamorado :: Carrera ->Participante->Bool
estaElEnamorado unaCarrera unParticipante = elem (enamorado unParticipante) (publico unaCarrera)

modificarVelocidad :: (Int->Int->Int)->Int->Participante->Participante
modificarVelocidad unaOperacion unNumero unParticipante = unParticipante{velocidad= velocidad unParticipante `unaOperacion` unNumero }

nitro::Truco
nitro unParticipante = modificarVelocidad (+) 15 unParticipante

comboLoco :: Carrera->Truco
comboLoco unaCarrera unParticipante = nitro.(deReversaRocha unaCarrera) $ unParticipante

rochaMcQueen :: Participante
rochaMcQueen = Participante "Rocha McQueen" 282 0 "Ronco" deReversaRocha


