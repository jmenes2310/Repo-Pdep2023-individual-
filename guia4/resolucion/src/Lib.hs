--EJERCICIO 1----------------
type Lista = [Int]

lista :: Lista
lista =[1,2,3]

sumar :: Lista ->Int
sumar unalista = sum unalista


-----------ejercicio 4---------------
--Se tiene información detallada de la duración en minutos de las llamadas que se llevaron a cabo en un período determinado, discriminadas en horario normal y horario reducido. 
--Definir la función cuandoHabloMasMinutos, devuelve en que horario se habló más cantidad de minutos, en el de tarifa normal o en el reducido
type Dupla = (String, Lista)
type Llamada = (Dupla, Dupla)

duracionLlamadas :: Llamada
duracionLlamadas = (("horarioReducido",[20,10,25,15]),("horarioNormal",[10,5,8,2,9,10]))

cuandoHabloMasMinutos :: String
cuandoHabloMasMinutos 
    |((sumaMinutos . snd) $ fst duracionLlamadas) > ((sumaMinutos . snd) $ snd duracionLlamadas) = (fst.fst) duracionLlamadas
    |((sumaMinutos . snd) $ fst duracionLlamadas) < ((sumaMinutos . snd) $ snd duracionLlamadas) = (fst.snd) duracionLlamadas
    |otherwise = ""

cuandoHizoMasLLamadas :: String
cuandoHizoMasLLamadas 
    |((sumaMinutos . snd) $ fst duracionLlamadas) > ((sumaMinutos . snd) $ snd duracionLlamadas) = (fst.fst) duracionLlamadas
    |((sumaMinutos . snd) $ fst duracionLlamadas) < ((sumaMinutos . snd) $ snd duracionLlamadas) = (fst.snd) duracionLlamadas
    |otherwise = ""


sumaMinutos :: Lista ->Int
sumaMinutos unaLista = sum unaLista


--------------ejercicios irden superior 1-----------
existAny :: (Int ->Bool) -> (Int,Int,Int) ->Bool
existAny unaFuncion unaTupla = any unaFuncion (tuplaALista  unaTupla)

tuplaALista :: (Int,Int,Int) -> [Int]
tuplaALista (numero1, numero2, numero3) = [numero1,numero2,numero3]


-----------ejercicio 2 orden superior
mejor :: (Int->Int) -> (Int->Int)->Int -> Int
mejor unaFuncion unaFuncion2 unNumero = max (unaFuncion unNumero) (unaFuncion2 unNumero)

-------------ejercicio 10 orden superior + lista -----------------
type Funcion = Int->Int
type ListaFuncion = [Funcion]

aplicarFunciones :: ListaFuncion -> Int -> [Int]
aplicarFunciones listaFuncion unNumero =  map (funcion unNumero) listaFuncion

funcion :: Int -> Funcion -> Int
funcion unNumero unaFuncion = unaFuncion unNumero -- usando aplicacion parcial queda Funcion->Int y ahi si lo agarra map

-------------------ejercicio 15 orden superir mas listas
primerosPares :: [Int] -> [Int]
primerosPares unaLista = takeWhile even unaLista -- takeWhile va mirando uno por uno y corta cuando ya no cumple condicion



-----------------ejercicio 17 orden superior mas listas---------------
{- En una población, se estudió que el crecimiento anual de la altura de las personas sigue esta fórmula de acuerdo a la edad:
1 año: 22 cm 
2 años: 20 cm 
3 años: 18 cm 
... así bajando de a 2 cm por año hasta 
9 años: 6 cm 
10 a 15 años: 4 cm 
16 y 17 años: 2 cm 
18 y 19 años: 1 cm 
20 años o más: 0 cm -}

type Edad = Int
crecimientoAnual:: Edad ->Int
crecimientoAnual unaEdad
    |unaEdad <=10 = 24 - (unaEdad * 2)
    |unaEdad <=15 = 4
    |unaEdad <=17 = 2
    |unaEdad <=19 = 1
    |unaEdad >=20 = 0

crecimientoEntreEdades :: Edad -> Edad -> Int
crecimientoEntreEdades edad1 edad2 = (sum.map crecimientoAnual) $ funcionEdad edad1 edad2 -- primero aplica funcionEdad con las dos edades que nos da el usuario (osea acorta la lista de listaEdades) a esa pequeña lista con el map crecimientoAnual la va recorriendo y a cada edad le pone lo que creceria. Entonces nos queda una lista con las altura que creceria cada edad despues el sum suma todo

funcionEdad :: Edad ->Edad ->[Edad]
funcionEdad edad1 edad2 = takeWhile(< edad2) $ dropWhile(< edad1)listaEdades -- esta funcion de toda la lista de edades que tenemos la acorta a las edades que pide el usuario

listaEdades :: [Edad]
listaEdades = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]

alturasEnUnAnio :: Edad->[Int]->[Int]
alturasEnUnAnio unaEdad listaAlturas = map (+ (crecimientoAnual unaEdad)) listaAlturas

alturaEnEdades :: Int ->Edad-> [Edad]->[Int]
alturaEnEdades unaAltura unaEdad listaDeEdades = map (alturaFinal unaAltura unaEdad) listaDeEdades

alturaFinal :: Int->Edad->Edad->Int
alturaFinal unaAltura unaEdad otraEdad = crecimientoEntreEdades unaEdad otraEdad + unaAltura


--otra forma de hacer altura entre edades utilizando una linea y las funciones de los puntoa anteriores
alturaEnEdades2 :: Int ->Edad-> [Edad]->[Int]
alturaEnEdades2 unaAltura unaEdad listaDeEdades = map (+unaAltura) (map (crecimientoEntreEdades unaEdad) listaDeEdades)