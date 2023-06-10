import Text.Show.Functions ()

data Carrera = Carrera{
    vueltas :: Int,
    longitudPista :: Int, --en km
    participantes::[Participante],
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

--creo una carrera de ejemplo para ponerle a deReversaRocha para que asi qeude del tipo truco
carrerita :: Carrera
carrerita = Carrera 60 10 [rochaMcQueen,biankerr,gushtav,rodra] ["Ronco","Tincho","Peti"]

rochaMcQueen :: Participante
rochaMcQueen = Participante "Rocha McQueen" 282 0 "Ronco" (deReversaRocha carrerita)

biankerr :: Participante
biankerr = Participante "Biankerr" 378 0 "Tincho" (impresionar carrerita)

gushtav :: Participante
gushtav = Participante "Gushtav" 230 0 "Peti" nitro

rodra :: Participante
rodra = Participante "Rodra" 153 0 "Tais" (comboLoco carrerita)


daUnaVuelta :: Carrera ->Carrera
daUnaVuelta unaCarrera = unaCarrera{participantes= map (incrementoVelocidadSegunNombre . (modificarNaftaSegunNombre unaCarrera)) (participantes unaCarrera)} 

incrementoVelocidadSegunNombre :: Participante->Participante
incrementoVelocidadSegunNombre unParticipante
    |(largoDelNombreDe unParticipante) >=1 &&  (largoDelNombreDe unParticipante) <=5 = modificarVelocidad (+) 15 unParticipante
    |(largoDelNombreDe unParticipante) >=6 &&  (largoDelNombreDe unParticipante) <=8= modificarVelocidad (+) 20 unParticipante
    |otherwise = modificarVelocidad (+) 30 unParticipante

largoDelNombreDe :: Participante->Int
largoDelNombreDe unParticipante = length (nombre unParticipante)

modificarNaftaSegunNombre :: Carrera->Participante->Participante
modificarNaftaSegunNombre unaCarrera unParticipante = modificarNafta (*) (-) (length $ nombre unParticipante) (longitudPista unaCarrera) unParticipante