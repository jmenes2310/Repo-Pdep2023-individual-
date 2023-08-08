import Text.Show.Functions ()

data Jugador = Jugador {
  nombre :: String,
  padre :: String,
  habilidad :: Habilidad
} deriving (Eq, Show)

data Habilidad = Habilidad {
  fuerzaJugador :: Int,
  precisionJugador :: Int
} deriving (Eq, Show)

bart :: Jugador
bart = Jugador {nombre= "Bart",padre= "Homero",habilidad= Habilidad 25 60}

todd :: Jugador
todd = Jugador {nombre= "Todd",padre= "Ned",habilidad= Habilidad 15 80}

rafa :: Jugador
rafa = Jugador {nombre= "Rafa",padre= "Gorgory",habilidad= Habilidad 10 1}

data Tiro = Tiro{ 
    velocidad :: Int,
    precision :: Int,
    altura :: Int
} deriving (Eq, Show)

type Puntos = Int

type Palo = (Habilidad->Tiro)

putter :: Palo
putter unaHabilidad = Tiro {velocidad=10,precision= establecerPrecion (precisionJugador unaHabilidad) (*),altura=0}

madera :: Palo
madera unaHabilidad = Tiro {velocidad=100,precision=establecerPrecion (precisionJugador unaHabilidad) (div) ,altura=5}

hierros ::Int-> Palo
hierros n unaHabilidad = Tiro {velocidad=fuerzaJugador unaHabilidad *n,precision= div (precisionJugador unaHabilidad) n ,altura=max (((!!) listaDeHierros (n-1))-3) 0}

establecerPrecion :: Int->(Int->Int->Int)->Int
establecerPrecion unNumero unaOperacion = unaOperacion unNumero 2

listaDeHierros :: [Int]
listaDeHierros = [1..10]

palos:: [Palo]
palos = palosDeHierro ++ [putter,madera]
--map (\unNumero-> hierros unNumero) listaDeHierros ++ [putter,madera]

palosDeHierro :: [Palo]
palosDeHierro = map (\unNumero-> hierros unNumero) listaDeHierros

type Golpe = (Jugador->Palo->Tiro)

golpe :: Golpe
golpe unJugador unPalo = unPalo (habilidad unJugador)

--PUNTO 3

type CondicionDeObstaculo = (Tiro ->Bool)

--superaObstaculo:: (Tiro ->Bool) ->Tiro->Bool
--superaObstaculo unaCondicion unTiro = unaCondicion unTiro

condicionTunelConRampita :: CondicionDeObstaculo
condicionTunelConRampita unTiro = precision unTiro >90

tunelConRampita :: Tiro->Tiro
tunelConRampita unTiro
    |condicionTunelConRampita unTiro = efectoLagunaYTunel (*) 2 unTiro{precision=100,altura=0} 
    |otherwise = tiroNulo

{-efectoTunelConRampita :: Tiro ->Tiro
efectoTunelConRampita unTiro = efectoLagunaYTunel (*) 2 unTiro{precision=100,altura=0}-}

condicionLaguna :: CondicionDeObstaculo
condicionLaguna unTiro = lagunaUHoyo (altura unTiro) 1 5 (velocidad unTiro) 80 

laguna :: Int->Tiro->Tiro
laguna largoLaguna unTiro
    |condicionLaguna unTiro= efectoLagunaYTunel div largoLaguna unTiro
    |otherwise = tiroNulo

{-efectoLaguna :: Tiro->Int->Tiro
efectoLaguna unTiro largoLaguna = efectoLagunaYTunel div largoLaguna unTiro-}

efectoLagunaYTunel :: (Int->Int->Int) ->Int->Tiro ->Tiro
efectoLagunaYTunel  unaOperacion unNumero unTiro= unTiro {velocidad= (unaOperacion) (velocidad unTiro) unNumero}

condicionHoyo :: CondicionDeObstaculo
condicionHoyo unTiro = lagunaUHoyo (velocidad unTiro) 5 20 (precision unTiro) 25

hoyo :: Tiro->Tiro
hoyo unTiro
    |condicionHoyo unTiro = tiroNulo
    |otherwise = tiroNulo

entreDosValores ::Int ->Int -> Int ->Bool
entreDosValores unNumero primerValor segundoValor = elem unNumero [primerValor .. segundoValor]

lagunaUHoyo :: Int ->Int ->Int->Int->Int->Bool
lagunaUHoyo primerValor segundoValor tercerValor cuartoValor quintoValor = entreDosValores primerValor segundoValor tercerValor && cuartoValor > quintoValor

tiroNulo :: Tiro
tiroNulo = Tiro 0 0 0

palosUtiles :: Jugador -> (Tiro ->Bool) ->[Palo]
palosUtiles unJugador unObstaculo = filter (sirve unJugador unObstaculo) palos

sirve :: Jugador -> (Tiro ->Bool) ->Palo ->Bool
sirve unJugador unObstaculo unPalo =  unObstaculo (unPalo (habilidad unJugador))

cuantosObstaculosConsecutivos :: [(Tiro->Tiro)]->Tiro->Int
cuantosObstaculosConsecutivos obstaculos unTiro = length (takeWhile (loSupera unTiro) obstaculos)

loSupera :: Tiro->(Tiro->Tiro)->Bool
loSupera unTiro efectodeObstaculo = efectodeObstaculo unTiro /= tiroNulo

tiroej :: Tiro
tiroej = Tiro {velocidad=10,precision=95,altura=0}

paloMasUtil :: Jugador -> [(Tiro->Tiro)]->Palo
paloMasUtil unJugador obstaculos = foldr1 (cualEsMasUtil unJugador obstaculos) palos

cualEsMasUtil :: Jugador ->[(Tiro->Tiro)]->Palo->Palo->Palo
cualEsMasUtil unJugador obstaculos unPalo otroPalo 
    |cuantosObstaculosConsecutivos obstaculos (unPalo (habilidad unJugador)) > cuantosObstaculosConsecutivos obstaculos (otroPalo (habilidad unJugador)) = unPalo
    |otherwise = otroPalo

listaDePuntos :: [(Jugador,Puntos)]
listaDePuntos = [(bart,10),(todd,5),(rafa,0)]

padresPerdedores :: [String]
padresPerdedores = (tail.map padre. map fst) listaDePuntos