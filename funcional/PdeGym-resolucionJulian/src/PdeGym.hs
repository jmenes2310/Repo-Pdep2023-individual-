import Text.Show.Functions

---------- Datas y Tipos ----------

data Persona = Persona {
  nombre           :: String,
  calorias         :: Int,
  hidratacion      :: Int,
  tiempoDisponible :: Int,
  equipamientos    :: [Equipamiento]
} deriving Show

type Equipamiento = String
type Ejercicio = Persona -> Persona

---------- Datas y Tipos ----------

---------- Funciones Auxiliares ----------

mapNombre :: (String -> String) -> Persona -> Persona
mapNombre unaFuncion unaPersona = unaPersona { nombre = unaFuncion . nombre $ unaPersona }

mapCalorias :: (Int -> Int) -> Persona -> Persona
mapCalorias unaFuncion unaPersona = unaPersona { calorias = unaFuncion . calorias $ unaPersona }

perderCalorias :: Int -> Persona -> Persona
perderCalorias unaCantidad = mapCalorias (subtract unaCantidad)

mapHidratacion :: (Int -> Int) -> Persona -> Persona
mapHidratacion unaFuncion unaPersona = unaPersona { hidratacion = max 0 . min 100 . unaFuncion . hidratacion $ unaPersona }

perderHidratacion :: Int -> Persona -> Persona
perderHidratacion unaCantidad = mapHidratacion (subtract unaCantidad)

mapEquipamientos :: ([Equipamiento] -> [Equipamiento]) -> Persona -> Persona
mapEquipamientos unaFuncion unaPersona = unaPersona { equipamientos = unaFuncion . equipamientos $ unaPersona }

setEquipamientos :: [Equipamiento] -> Persona -> Persona
setEquipamientos unosEquipamientos = mapEquipamientos (const unosEquipamientos)


---------- Funciones Auxiliares ----------

-- Parte A

-- Ejercicios

-- Punto A.1

abdominales :: Int -> Ejercicio
abdominales unasRepeticiones = perderCalorias (8 * unasRepeticiones)

-- Punto A.2

flexiones :: Int -> Ejercicio
flexiones unasRepeticiones = perderCalorias (16 * unasRepeticiones) . perderHidratacion (unasRepeticiones `div` 10 * 2)

-- Punto A.3

levantarPesas :: Int -> Int -> Ejercicio
levantarPesas unPeso unasRepeticiones unaPersona
  | tiene "pesa" unaPersona = perderCalorias (32 * unasRepeticiones) . perderHidratacion (unasRepeticiones `div` 10 * unPeso) $ unaPersona
  | otherwise               = unaPersona

tiene :: Equipamiento -> Persona -> Bool
tiene unEquipamiento = elem unEquipamiento . equipamientos

-- Punto A.4

laGranHomeroSimpson :: Ejercicio
laGranHomeroSimpson = id

-- Otras Acciones

-- Punto 1

renovarEquipo :: Persona -> Persona
renovarEquipo = mapEquipamientos (map ("Nuevo " ++))

-- Punto 2

volverseYoguista :: Persona -> Persona
volverseYoguista = mapCalorias (`div` 2) . mapHidratacion (* 2) . setEquipamientos ["colchoneta"]

-- Punto 3

volverseBodyBuilder :: Persona -> Persona
volverseBodyBuilder unaPersona
  | tieneSoloPesas unaPersona = mapNombre (++ " BB") . mapCalorias (* 3) $ unaPersona
  | otherwise                 = unaPersona

tieneSoloPesas :: Persona -> Bool
tieneSoloPesas = all esPesa . equipamientos

esPesa :: Equipamiento -> Bool
esPesa = (== "pesa")

-- Punto 4

comerUnSandwich :: Persona -> Persona
comerUnSandwich = mapCalorias (+ 500) . mapHidratacion (+ 100)

-- Parte B

data Rutina = Rutina {
  duracion   :: Int,
  ejercicios :: [Ejercicio]
} deriving Show

hacerRutina :: Rutina -> Persona -> Persona
hacerRutina unaRutina unaPersona
  | leAlcanzaElTiempoPara unaRutina unaPersona = foldr ($) unaPersona (ejercicios unaRutina)
  | otherwise                                  = unaPersona

leAlcanzaElTiempoPara :: Rutina -> Persona -> Bool
leAlcanzaElTiempoPara unaRutina unaPersona = tiempoDisponible unaPersona >= duracion unaRutina

-- Punto B.1

esPeligrosa :: Rutina -> Persona -> Bool
esPeligrosa unaRutina unaPersona = estaAgotada . hacerRutina unaRutina $ unaPersona

estaAgotada :: Persona -> Bool
estaAgotada unaPersona = calorias unaPersona < 50 && hidratacion unaPersona < 10

-- Punto B.2

esBalanceada :: Rutina -> Persona -> Bool
esBalanceada unaRutina unaPersona = quedaBien . hacerRutina unaRutina $ unaPersona
  where quedaBien personaPostRutina = hidratacion personaPostRutina > 80 && calorias personaPostRutina < calorias unaPersona `div` 2

elAbominableAbdominal :: Rutina
elAbominableAbdominal = Rutina 60 (map abdominales [1..]) -- arbitrariamente decidí que los tiempos en persona y en rutina están en minutos

-- Parte C

-- Punto C.1

seleccionarGrupoDeEjercicio :: Persona -> [Persona] -> [Persona]
seleccionarGrupoDeEjercicio unaPersona = filter (tienenElMismoTiempoDisponible unaPersona)

tienenElMismoTiempoDisponible :: Persona -> Persona -> Bool
tienenElMismoTiempoDisponible unaPersona otraPersona = tiempoDisponible unaPersona == tiempoDisponible otraPersona

-- Punto C.2

promedioDeRutina :: Rutina -> [Persona] -> (Int, Int)
promedioDeRutina unaRutina unasPersonas = estadisticasGrupales . map (hacerRutina unaRutina) $ unasPersonas

estadisticasGrupales :: [Persona] -> (Int, Int)
estadisticasGrupales unasPersonas = (promedioDe calorias unasPersonas, promedioDe hidratacion unasPersonas)

promedioDe :: (b -> Int) -> [b] -> Int
promedioDe funcionPonderadora = promedio . map funcionPonderadora

promedio :: [Int] -> Int
promedio unosValores = sum unosValores `div` length unosValores
