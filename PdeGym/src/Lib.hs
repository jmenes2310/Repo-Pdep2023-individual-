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

type Ejercicio = (Int ->Persona->Persona)

abdominales ::Ejercicio
abdominales repeticiones unaPersona = modificarCalorias (*) (-) repeticiones 8 unaPersona

modificarCalorias ::(Int->Int->Int)->(Int->Int->Int)-> Int->Int->Persona->Persona
modificarCalorias unaoperacion otraoperacion unNumero otroNumero unaPersona = unaPersona {calorias = (calorias unaPersona) `otraoperacion` (unaoperacion unNumero otroNumero)}

flexiones :: Ejercicio
flexiones repeticiones unaPersona = modificarCalorias (*) (-) repeticiones 16 unaPersona{hidratacion= max 0 (hidratacion unaPersona -2)}

levantarPesas :: Int->Ejercicio
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

type Rutina = [Ejercicio]

esPeligrosa :: Persona->Int->Rutina->Bool
esPeligrosa unaPersona repeticiones unaRutina = estadoPeligroso ( foldr (realizarUnEjercicio repeticiones) unaPersona unaRutina)

realizarUnEjercicio :: Int->(Int->Persona->Persona) ->Persona->Persona
realizarUnEjercicio repeticiones unEjercicio  unaPersona = unEjercicio repeticiones unaPersona

estadoPeligroso :: Persona ->Bool
estadoPeligroso unaPersona = calorias unaPersona <50 && hidratacion unaPersona <10

esBalanceada ::Persona->Int->Rutina->Bool
esBalanceada unaPersona repeticiones unaRutina = estadoBalanceado unaPersona ( foldr (realizarUnEjercicio repeticiones) unaPersona unaRutina)

estadoBalanceado :: Persona->Persona->Bool
estadoBalanceado unaPersona personaLuegoDeRutina= hidratacion personaLuegoDeRutina >80 && (calorias personaLuegoDeRutina < div (calorias unaPersona) 2)