import Text.Show.Functions ()

data Personaje = Personaje {
    nombre :: String,
    poder :: Int,
    victorias :: [Victoria],
    equipamiento :: [Equipamiento]
}deriving Show

{-data Victoria = Victoria{
    oponente :: String,
    año :: Int
}deriving Show-}

type Victoria = (Oponente,Año)
type Oponente = String
type Año = Int
type Equipamiento = (Personaje->Personaje)

entrenamiento :: [Personaje] ->[Personaje]
entrenamiento personajes =map (modificarPoder (*) (length personajes)) personajes

modificarPoder :: (Int->Int->Int)->Int->Personaje->Personaje
modificarPoder unaOperacion unNumero unPersonaje = unPersonaje {poder=poder unPersonaje `unaOperacion` unNumero}

rivalesDignos :: [Personaje]->[Personaje]
rivalesDignos personajes = sonDignos personajes

sonDignos :: [Personaje]->[Personaje]
sonDignos personajes= filter esDigno (entrenamiento personajes)

esDigno :: Personaje ->Bool
esDigno unPersonaje = poder unPersonaje >500 && elem "Hijo de Thanos" (map fst (victorias unPersonaje))

guerraCivil :: Int ->[Personaje]->[Personaje]->[Personaje]
guerraCivil unAño unosPersonajes otrosPersonajes = zipWith (pelear unAño) unosPersonajes otrosPersonajes

pelear :: Int->Personaje->Personaje->Personaje
pelear unAño unPersonaje otroPersonaje = ganadorEntre unAño unPersonaje otroPersonaje

ganadorEntre :: Int->Personaje->Personaje->Personaje
ganadorEntre unAño unPersonaje otroPersonaje
    |masPoderEntreDos unPersonaje otroPersonaje = agregarVictoria unAño unPersonaje otroPersonaje
    |otherwise = agregarVictoria unAño otroPersonaje unPersonaje

masPoderEntreDos :: Personaje->Personaje->Bool
masPoderEntreDos unPersonaje otroPersonaje = poder unPersonaje > poder otroPersonaje

agregarVictoria :: Int->Personaje->Personaje->Personaje
agregarVictoria año ganador perdedor = ganador {victorias=(nombre perdedor , año) : victorias ganador}

escudo :: Equipamiento
escudo unPersonaje
    |length (victorias unPersonaje) < 5 = modificarPoder (+) 50 unPersonaje
    |otherwise = modificarPoder (-)100 unPersonaje

trajeMecanizado :: String -> Equipamiento
trajeMecanizado version unPersonaje = ageregarAlNombreDe "Iron " ("V"++version) unPersonaje

ageregarAlNombreDe ::String->String-> Personaje->Personaje
ageregarAlNombreDe agregaAlPrinicpio agregaAlFinal unPersonaje= unPersonaje{nombre= agregaAlPrinicpio ++ (nombre unPersonaje)++agregaAlFinal}

equipamientoExclusivo :: String->Personaje->(Personaje->Personaje)->Personaje
equipamientoExclusivo unNombre unPersonaje modificacion 
    |seLlama unNombre unPersonaje = modificacion unPersonaje
    |otherwise = unPersonaje

seLlama :: String->Personaje->Bool
seLlama unNombre unPersonaje = unNombre == (nombre unPersonaje)

stormBreaker ::Equipamiento
stormBreaker unPersonaje = equipamientoExclusivo "Thor" unPersonaje (limpiarVictorias . ageregarAlNombreDe "" " dios del trueno") 

limpiarVictorias :: Personaje->Personaje
limpiarVictorias unPersonaje = unPersonaje{victorias=[]}

extras :: [String]
extras = map (\unNumero -> "extra numero " ++ show unNumero) [1..]

gemaDelAlma :: Equipamiento
gemaDelAlma unPersonaje = equipamientoExclusivo "Thanos" unPersonaje (victoriasContraExtras)

victoriasContraExtras :: Personaje->Personaje
victoriasContraExtras unPersonaje = unPersonaje{victorias = (zip extras [2018..]) ++ victorias unPersonaje}

guanteleteDelInfinito :: [Equipamiento]->Equipamiento
guanteleteDelInfinito equipamientos unPersonaje = equipamientoExclusivo "Thanos" unPersonaje (aplicarGemasDelInfinito equipamientos)

aplicarGemasDelInfinito :: [Equipamiento]->Personaje->Personaje
aplicarGemasDelInfinito equipamientos unPersonaje = foldr agregarEquipamiento unPersonaje (filter esGemaDelInfinito equipamientos)

agregarEquipamiento:: Equipamiento->Personaje->Personaje
agregarEquipamiento unEquipamiento unPersonaje = unPersonaje{equipamiento= unEquipamiento : (equipamiento unPersonaje)}

esGemaDelInfinito = undefined