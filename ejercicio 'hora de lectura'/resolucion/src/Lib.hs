module Lib
    ( someFunc
    ) where

someFunc :: IO ()
someFunc = putStrLn "someFunc"

-- los puntos promedio de hojas, lecturaobligatoria ya estan hecho en el cuaderno pero los hice sin nombre de autor

{- esto creo que lo hice mal 
[("elVisitante" , 592),("shingeki1" , 40) , ("shingeki3" , 40) , ("shingeki27", 40) , ("fundacion" , 230) , ("sandman5" , 35) , ("sandman10" , 35) , ("sandman12" , 35) , ("eragon" , 544) , ("eldest" , 704) , ("brisignr" , 700) , ("legado" , 811)] -}
type Titulo = String
type Autor = String
type CantidadDePaginas = Int
type Libro = (Titulo, Autor, CantidadDePaginas)

-- data Libro = UnLibro Titulo Autor CantidadDePaginas

elVisitante :: Libro
elVisitante = ("el visitante", "Stephen King", 592)

shingeki1 :: Libro
shingeki1 = ("shingeki cap 1", "Hajime Isayama", 40)

shingeki3 :: Libro
shingeki3 = ("shingeki cap 3", "Hajime Isayama", 40)

shingeki127 :: Libro
shingeki127 = ("shingeki cap 127", "Hajime Isayama", 40)

fundacion :: Libro
fundacion = ("fundacion", "Isaac Asimov",230 )

sandman5 :: Libro
sandman5 = ("sandman cap 5","Neil Gaiman", 35 )

sandman10 :: Libro
sandman10 = ("sandman cap 10","Neil Gaiman", 35 )

sandman12 :: Libro
sandman12 = ("sandman cap 12","Neil Gaiman", 35 )

eragon :: Libro
eragon = ("eragon","Christopher Paolini", 544)

eldest :: Libro
eldest = ("eldest","Christopher Paolini", 704)

brisignr :: Libro
brisignr = ("brisignr","Christopher Paolini", 700)

legado :: Libro
legado = ("legado","Christopher Paolini", 811)

type Biblioteca = [Libro]
biblioteca :: Biblioteca
biblioteca = [elVisitante, shingeki1, shingeki3, shingeki127, fundacion , sandman5 , sandman10 , sandman12,eragon,eldest,brisignr,legado]

--Funcion Promedio de Hojas
promedioDeHojas :: Biblioteca -> Int
promedioDeHojas unaBiblioteca = div (sum.map cantPaginas $ unaBiblioteca) (length unaBiblioteca)

cantPaginas :: Libro -> Int
cantPaginas (_ , _ , paginas) = paginas

--funcion lectura obligatoria
lecturaObligatoria :: Libro -> Bool
lecturaObligatoria unLibro = elem unLibro sagaEragon ||  (autor unLibro) == "Stephen King" || unLibro == fundacion --hay que poner fundacion porque pide que sea ese libro especifico de isac asimov

type Saga = [Libro]
sagaEragon :: Saga
sagaEragon = [eragon,eldest,brisignr,legado]

autor :: Libro -> String
autor (_ , autores , _) = autores

--esta funcion tambien se puede hacer con pattern matching

esLecturaObligatoria' :: Libro -> Bool
esLecturaObligatoria' (_,"Stephen King",_)=True
esLecturaObligatoria' ("Fundacion","Isac Asimov",230)=True  --le paso todos los paramaetros porque quiere que sea ese en especifico de isac asimov
esLecturaObligatoria' unLibro = perteneceASagaEragon unLibro
esLecturaObligatoria' _ = False --esta linea es redundante ponerla porque con la linea de arriba ya retorna false o true dependiendo lo que perteceASagaEragon

perteneceASagaEragon :: Libro ->Bool
perteneceASagaEragon unLibro = elem unLibro sagaEragon


--funcion biblioteca fantasiosa
esFantasiosa :: Biblioteca -> Bool
esFantasiosa unaBiblioteca = any esLibroFantasioso unaBiblioteca

esLibroFantasioso :: Libro ->Bool
esLibroFantasioso unLibro = esDeChristopherPaolini unLibro || esDeNeilGaiman unLibro

autordos :: Libro -> String
autordos (_ , autores , _) = autores --es la misma funcion que use en la funcion de lectura obligatoria

esDeChristopherPaolini :: Libro -> Bool
esDeChristopherPaolini unLibro = autor unLibro == "Christopher Paolini"

esDeNeilGaiman :: Libro -> Bool
esDeNeilGaiman unLibro = autor unLibro == "Neil Gaiman"
--en la bitacora de la clase 3 usa una manera parametrizada de resolver esto para que no sea tan repetitivo

--Funcion nombre de la Biblioteca
nombreDeLaBiblioteca :: Biblioteca ->String
nombreDeLaBiblioteca unaBiblioteca = sacaVocales.concatenarTitulos $ unaBiblioteca

titulo :: Libro -> String
titulo (titulos, _, _) = titulos

esVocal :: Char -> Bool
esVocal unCaracter = elem unCaracter ['a','e','i','o','u','A','E','I','O','U',' ' ]

sacaVocales :: String ->String
sacaVocales unString = filter (not.esVocal) unString

concatenarTitulos :: Biblioteca -> String
concatenarTitulos unaBiblioteca = concatMap titulo unaBiblioteca

--funcion de biblioteca ligera
bibliotecaLigera :: Biblioteca -> Bool
bibliotecaLigera unaBiblioteca = all menorDe40pags unaBiblioteca

menorDe40pags :: Libro ->Bool
menorDe40pags unLibro = cantPaginas unLibro <= 40

--funcion para clasificar segun genero (17-4-23)
generosDeLibros = ["terror","comic","manga","inclasificado"]

genero :: Libro ->String
genero unLibro 
    | titulo unLibro == "Stephen King" = "terror"
    | autor unLibro == "Hajime Isayama" = "manga"
    | menorDe40pags unLibro = "comic"
    | otherwise = "inclasificado"



type Persona = (String,String,Int)
gus :: Persona
gus = ("Gustavo","Trucco",32)
--gus es de tipo persona pero funciona en funciones de tipo libro, el type es solo un alias
--para que no pase eso usamos el data, es como que creamos nuestro propio tipo de dato
-- data Libro = UnLibro Titulo Autor CantidadDePaginas asi es la sintaxis
{-otra forma de sintaxis "record syntax" que nos da la ventaja de usar accesor sin tipearlos
data Libro = UnLibro{
    titulo:: Titulo
    autor:: Autor
    cantidadDePaginas :: CantidadDePaginas
}delivering (eq,show)
-}