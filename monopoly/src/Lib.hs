import Text.Show.Functions ()--esta linea es necesaria para mostrar cuando tengo un tipo de dato que son funciones en mi data

data Participante = UnParticipante {
    nombre      ::String,
    dinero      ::Int,
    tactica     ::String,
    propiedades::[Propiedad],
    acciones    ::[Accion]
    } deriving Show


type Propiedad = (NombrePropiedad,ValorPropiedad)
type NombrePropiedad = String
type ValorPropiedad = Int
type Accion = Participante->Participante

carolina :: Participante
carolina = UnParticipante {nombre ="Carolina", dinero= 500, tactica ="Accionista",acciones =[pasarPorBanco], propiedades =[]}
--carolina = unParticipante "Carolina"  500 "Accionista" [] [pasarPorBanco] 

manuel :: Participante
manuel = UnParticipante {nombre ="Manuel", dinero= 500, tactica ="oferente singular",acciones =[pasarPorBanco,enojarse], propiedades =[("lh",100),("ramos",50),("recoleta",300)]}

{-pasarPorBanco :: Accion --Participante->Participante 
pasarPorBanco unParticipante = unParticipante {dinero = dinero unParticipante + 50, tactica="Comprador compuslivo"}-}
pasarPorBanco :: Accion
pasarPorBanco unParticipante = (cambiarTacticaACompradorCompulsivo . agregarDinero 40) unParticipante

agregarDinero :: Int->Participante -> Participante
agregarDinero unaCantidad unParticipante = unParticipante {dinero = dinero unParticipante + unaCantidad}
--agregarDinero unaCant unParticipante = unParticipante nombre (dinero + unaCant) tactica propiedades acciones --no se que tan bien esta eso, me lo marca como error

cambiarTacticaACompradorCompulsivo::Participante->Participante
cambiarTacticaACompradorCompulsivo unParticipante = unParticipante {tactica = "Comprador compulsivo"}

enojarse :: Accion
enojarse unParticipante = (agregarAccion gritar . agregarDinero 50) unParticipante

agregarAccion :: Accion->Participante->Participante
agregarAccion unaAccion unParticipante = unParticipante {acciones = acciones unParticipante ++ [unaAccion] } --{acciones = unaAccion : acciones unParticipante} (ese dos puntos sirve para agregar al principio de la lista, es mejor siempre usar el dos puntos y no el ++)

gritar::Accion
gritar unParticipante = unParticipante {nombre ="AHHHH" ++ nombre unParticipante }
 
subastar :: Propiedad -> Accion
subastar unaPropiedad unParticipante 
    |evaluarTactica unParticipante = agregoPropiedadYrestoDinero unaPropiedad unParticipante
    |otherwise = unParticipante

agregoPropiedadYrestoDinero :: Propiedad -> Participante ->Participante
agregoPropiedadYrestoDinero (nombrePropiedad,valorPropiedad) unParticipante = unParticipante {dinero= dinero unParticipante - valorPropiedad, propiedades = (nombrePropiedad,valorPropiedad) : propiedades unParticipante}

evaluarTactica :: Participante -> Bool
evaluarTactica unParticipante = tactica unParticipante  == "Accionista" || tactica unParticipante  == "oferente singular"

cobrarAlquileres :: Accion
cobrarAlquileres unParticipante = unParticipante {dinero= dinero unParticipante + sumarPropiedadesBaratas unParticipante + sumarPropiedadesCaras unParticipante}

sumarPropiedadesBaratas:: Participante ->Int
sumarPropiedadesBaratas unParticipante= (length (filter(<150) $ valorPropiedades unParticipante)) *10

sumarPropiedadesCaras:: Participante ->Int
sumarPropiedadesCaras unParticipante= (length (filter(>150) $ valorPropiedades unParticipante)) *20

valorPropiedades :: Participante -> [Int]
valorPropiedades unParticipante = map snd (propiedades unParticipante)

pagarAAccionistas::Accion
pagarAAccionistas unParticipante
    |tactica unParticipante == "Accionista" = agregarDinero 200 unParticipante
    |otherwise = restarDinero 100 unParticipante

restarDinero :: Int->Participante -> Participante
restarDinero unaCant unParticipante = unParticipante {dinero= dinero unParticipante - unaCant}