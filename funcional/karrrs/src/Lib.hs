import Text.Show.Functions ()
import Data.List (sortBy)


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
carrerita = Carrera 3 10 [rochaMcQueen,biankerr,gushtav,rodra] ["Ronco","Tincho","Peti"]

rochaMcQueen :: Participante
rochaMcQueen = Participante "Rocha McQueen" 282 0 "Ronco" (deReversaRocha carrerita)

biankerr :: Participante
biankerr = Participante "Biankerr" 378 0 "Tincho" (impresionar carrerita)

gushtav :: Participante
gushtav = Participante "Gushtav" 230 0 "Peti" nitro

rodra :: Participante
rodra = Participante "Rodra" 153 0 "Tais" (comboLoco carrerita)


darVuelta :: Carrera ->Carrera
darVuelta unaCarrera = aplicarAlmasLento . modificarParticipantesDe $ unaCarrera

aplicarAlmasLento :: Carrera->Carrera
aplicarAlmasLento unaCarrera = unaCarrera{participantes=alMasLento $ participantes unaCarrera }

alMasLento :: [Participante]->[Participante]
alMasLento []=[]
alMasLento  (cabeza : cola)
    |all ((< (velocidad cabeza)) . velocidad) cola = (truco cabeza cabeza : cola)
    |otherwise = (cabeza : alMasLento cola)

modificarParticipantesDe :: Carrera->Carrera
modificarParticipantesDe unaCarrera = unaCarrera{participantes= map (incrementoVelocidadSegunNombre . (modificarNaftaSegunNombre unaCarrera)) (participantes unaCarrera)} 

incrementoVelocidadSegunNombre :: Participante->Participante
incrementoVelocidadSegunNombre unParticipante
    |(largoDelNombreDe unParticipante) <=5 = modificarVelocidad (+) 15 unParticipante
    |(largoDelNombreDe unParticipante) <=8 = modificarVelocidad (+) 20 unParticipante
    |otherwise = modificarVelocidad (+) 30 unParticipante

largoDelNombreDe :: Participante->Int
largoDelNombreDe unParticipante = length (nombre unParticipante)

modificarNaftaSegunNombre :: Carrera->Participante->Participante
modificarNaftaSegunNombre unaCarrera unParticipante = modificarNafta (*) (-) (largoDelNombreDe unParticipante) (longitudPista unaCarrera) unParticipante

correrCarrera :: Carrera->Carrera
correrCarrera unaCarrera = foldr ($) unaCarrera (cantidadDeVueltas unaCarrera)

cantidadDeVueltas ::Carrera->[(Carrera->Carrera)]
cantidadDeVueltas unaCarrera = replicate (vueltas unaCarrera) darVuelta

obtenerGanador :: Carrera->Participante
obtenerGanador unaCarrera = foldr1 (masRapido) (participantes unaCarrera)

masRapido :: Participante->Participante->Participante
masRapido unParticipante otroParticipante
    |velocidad unParticipante > velocidad otroParticipante = unParticipante
    |otherwise = otroParticipante

recompetidores :: Carrera->[Participante]
recompetidores unCarrera = obtenerGanador unCarrera : filter (tieneMasDe27Listros) (participantes unCarrera)

tieneMasDe27Listros :: Participante ->Bool
tieneMasDe27Listros unParticipante = nafta unParticipante > 27

carreraInfinita :: Carrera
carreraInfinita = Carrera 3 10 (cycle[rochaMcQueen,biankerr,gushtav,rodra]) ["Ronco","Tincho","Peti"]

--no se puede correr ya que al dar una vuelta nunca termina de cambiar las velocidades y nivel de combustible
--porque son infinitos participantes, por lo tanto tampoco puedo averiguar el mas lento para aplicarle el truco

--no, porque no podemos dar vuelta por lo dicho anteriormente

--no, por lo dicho en la primer respuesta