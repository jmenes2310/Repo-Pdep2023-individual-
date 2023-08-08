import Text.Show.Functions ()

data Persona = Persona{
    nombre :: String,
    calorias :: Int,
    hidratacion :: Int,
    tiempoLibre:: Int,
    equipamiento :: [Objeto]
}deriving Show

type Objeto = String

juan :: Persona
juan = Persona {nombre= "Juan",calorias= 1020,hidratacion=20,tiempoLibre=2,equipamiento=["pesa","pesa","pesa","pesa"]}

type Ejercicio = (Persona->Persona)

abdominales ::Int->Ejercicio
abdominales repeticiones unaPersona = modificarCalorias (*) (-) repeticiones 8 unaPersona

modificarCalorias ::(Int->Int->Int)->(Int->Int->Int)-> Int->Int->Persona->Persona
modificarCalorias unaoperacion otraoperacion unNumero otroNumero unaPersona = unaPersona {calorias = (calorias unaPersona) `otraoperacion` (unaoperacion unNumero otroNumero)}

flexiones :: Int->Ejercicio
flexiones repeticiones unaPersona = modificarCalorias (*) (-) repeticiones 16 unaPersona{hidratacion= max 0 (hidratacion unaPersona -2)}

levantarPesas :: Int->Int->Ejercicio
levantarPesas peso repeticiones unaPersona
    |tienePesa unaPersona = (modificarCalorias (*) (-) repeticiones 32 . disminuirLoQuePesaLaPesa repeticiones peso) unaPersona
    |otherwise = unaPersona

tienePesa :: Persona->Bool
tienePesa unaPersona = elem "pesa" (equipamiento unaPersona)

disminuirLoQuePesaLaPesa :: Int->Int->Persona->Persona
disminuirLoQuePesaLaPesa repeticiones peso unaPersona = unaPersona {hidratacion= max 0 (hidratacion unaPersona - ((div repeticiones 10)*peso))}

laGranHomeroSimpson :: Persona->Persona
laGranHomeroSimpson unaPersona = unaPersona

renovarEquipo :: Persona->[String]
renovarEquipo unaPersona = map agregarNuevo (equipamiento unaPersona)

agregarNuevo :: String->String
agregarNuevo unObjeto = "Nuevo" ++ unObjeto

volverseYoguista :: Persona ->Persona
volverseYoguista unaPersona= (duplicarHidratacion.modificarCalorias div (-) (calorias unaPersona) 2 ) unaPersona{equipamiento=["colchoneta"]}

duplicarHidratacion:: Persona->Persona
duplicarHidratacion unaPersona = unaPersona {hidratacion= min 100 (hidratacion unaPersona *2)}

volverseBodyBuilder :: Persona->Persona
volverseBodyBuilder unaPersona
    |tieneTodasPesas unaPersona = (agregarBB . modificarCalorias (*) (+)(calorias unaPersona) 2) unaPersona
    |otherwise = unaPersona

tieneTodasPesas :: Persona->Bool
tieneTodasPesas unaPersona = all (=="pesa") (equipamiento unaPersona)

agregarBB :: Persona->Persona
agregarBB unaPersona = unaPersona {nombre= "BB"++ nombre unaPersona}

comerUnSandwich :: Persona->Persona
comerUnSandwich unaPersona = modificarCalorias (*) (+) 1 500 unaPersona{hidratacion =100}

--PARTE B

{-
type Rutina = [(Persona->Persona)]

esPeligrosa :: Persona->Int->[(Int->Persona->Persona)]->Bool
esPeligrosa unaPersona repeticiones unaRutina = estadoPeligroso (realizarUnaRutina  unaRutina repeticiones unaPersona)

realizarUnEjercicio :: Int->(Int->Persona->Persona) ->Persona->Persona
realizarUnEjercicio repeticiones unEjercicio  unaPersona = unEjercicio repeticiones unaPersona

estadoPeligroso :: Persona ->Bool
estadoPeligroso unaPersona = calorias unaPersona <50 && hidratacion unaPersona <10

esBalanceada ::Persona->Int->[(Int->Persona->Persona)]->Bool
esBalanceada unaPersona repeticiones unaRutina = estadoBalanceado unaPersona (realizarUnaRutina  unaRutina repeticiones unaPersona)

estadoBalanceado :: Persona->Persona->Bool
estadoBalanceado unaPersona personaLuegoDeRutina= hidratacion personaLuegoDeRutina >80 && (calorias personaLuegoDeRutina < div (calorias unaPersona) 2)

elAbominableAbdominal :: Rutina
elAbominableAbdominal = map abdominales [1..]

seleccionarGrupoDeEjercicio :: Persona->[Persona]->[Persona]
seleccionarGrupoDeEjercicio unaPersona personas = filter (tienenMismoTiempoLibre unaPersona) personas

tienenMismoTiempoLibre :: Persona->Persona->Bool
tienenMismoTiempoLibre unaPersona otraPersona = tiempoLibre unaPersona == tiempoLibre otraPersona

type PromedioRutina = (Int,Int)

promedioDeRutina :: Int-> [(Int->Persona->Persona)]->[Persona]->PromedioRutina
promedioDeRutina repeticiones unaRutina personas = (promedio calorias repeticiones unaRutina personas , promedio hidratacion repeticiones unaRutina personas)

promedio :: (Persona->Int)->Int-> [(Int->Persona->Persona)]->[Persona]->Int
promedio operacion repeticiones unaRutina personas = div (sum.(map operacion) . (todoHacenLaRutina repeticiones unaRutina) $ personas) (length personas)

todoHacenLaRutina :: Int->[(Int->Persona->Persona)]->[Persona]->[Persona]
todoHacenLaRutina repeticiones unaRutina personas = map (realizarUnaRutina unaRutina repeticiones) personas

realizarUnaRutina :: [(Int->Persona->Persona)]->Int->Persona->Persona
realizarUnaRutina  unaRutina repeticiones unaPersona = foldr (realizarUnEjercicio repeticiones) unaPersona unaRutina -}

--rehago la parte b
type Rutina = (Int , [Ejercicio])

esPeligrosa :: Rutina ->Persona ->Bool
esPeligrosa unaRutina unaPersona =estadoPeligroso (hacerRutina unaRutina unaPersona)

estadoPeligroso :: Persona ->Bool
estadoPeligroso unaPersonaDespuesDeHacerRutina = calorias unaPersonaDespuesDeHacerRutina <50 && hidratacion unaPersonaDespuesDeHacerRutina <10

hacerRutina :: Rutina->Persona->Persona
hacerRutina unaRutina unaPersona 
    |tieneTiempo  unaRutina unaPersona= foldr (hacerEjercicio) unaPersona (snd unaRutina)
    |otherwise = unaPersona

tieneTiempo :: Rutina ->Persona->Bool
tieneTiempo unaRutina unaPersona = tiempoLibre unaPersona >= fst unaRutina

hacerEjercicio :: Ejercicio->Persona->Persona
hacerEjercicio unEjercicio unaPersona = unEjercicio unaPersona

esBalanceada :: Rutina ->Persona->Bool
esBalanceada unaRutina unaPersona = estadoBalanceado (hacerRutina unaRutina unaPersona) unaPersona

estadoBalanceado :: Persona ->Persona ->Bool
estadoBalanceado unaPersonaDespuesDeHacerRutina unaPersonaAntesDeHacerRutina = div (calorias unaPersonaDespuesDeHacerRutina) 2 < calorias unaPersonaAntesDeHacerRutina && hidratacion unaPersonaDespuesDeHacerRutina >80

elAbominableAbdominal :: Rutina
elAbominableAbdominal = (60,map abdominales [1..]) --tiempo en minutos

seleccionarGrupoDeEjercicio :: Persona ->[Persona]->[Persona]
seleccionarGrupoDeEjercicio unaPersona grupoDePersonas = filter (tienenElMismoTiempoDisponible unaPersona) grupoDePersonas

tienenElMismoTiempoDisponible ::Persona->Persona->Bool
tienenElMismoTiempoDisponible unaPersona otraPersona = tiempoLibre unaPersona == tiempoLibre otraPersona

type PromedioRutina = (Int,Int)

promedioDeRutina :: Rutina->[Persona]->PromedioRutina
promedioDeRutina unaRutina personas= ( promedioRutina calorias (todoHacenLaRutina unaRutina personas) , promedioRutina hidratacion (todoHacenLaRutina unaRutina personas) )

todoHacenLaRutina :: Rutina ->[Persona]->[Persona]
todoHacenLaRutina unaRutina personas = map (hacerRutina unaRutina) personas

promedioRutina :: (Persona->Int)->[Persona]->Int
promedioRutina sobreQue personas =(sum.(map sobreQue) $ personas) `div` (length personas)