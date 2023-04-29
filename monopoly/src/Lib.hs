import Text.Show.Functions ()--esta linea es necesaria para mostrar cuando tengo un tipo de dato que son funciones en mi data

data Participante = UnParticipante {
    nombre      ::String,
    dinero      ::Int,
    tactica     ::String,
    propriedades::[Propiedad],
    acciones    ::[Accion]
    } deriving Show


type Propiedad = (NombrePropiedad,ValorPropiedad)
type NombrePropiedad = String
type ValorPropiedad = Int
type Accion = Participante->Participante

{-pasarPorBanco :: Accion --Participante->Participante 
pasarPorBanco unParticipante = unParticipante {dinero = dinero unParticipante + 50, tactica="Comprador compuslivo"}-}
pasarPorBanco :: Accion
pasarPorBanco unParticipante = (cambiarTacticaACompradorCompulsivo . agregarDinero 40) unParticipante

agregarDinero :: Int->Participante -> Participante
agregarDinero unaCantidad unParticipante = unParticipante {dinero = dinero unParticipante + unaCantidad}
--agregarDinero unaCant unParticipante = unParticipante nombre (cantDinero + unaCant) tactica propiedades acciones

cambiarTacticaACompradorCompulsivo::Participante->Participante
cambiarTacticaACompradorCompulsivo unParticipante = unParticipante {tactica = "Comprador compulsivo"}

carolina :: Participante
carolina = UnParticipante {nombre ="Carolina", dinero= 500, tactica ="Accionista",acciones =[pasarPorBanco], propriedades =[]}
--carolina = unParticipante "Carolina"  500 "Accionista" [] [pasarPorBanco] 

manuel :: Participante
manuel = UnParticipante {nombre ="Manuel", dinero= 500, tactica ="oferente singular",acciones =[pasarPorBanco,enojarse], propriedades =[]}

enojarse :: Accion
enojarse unParticipante = (agregarAccion gritar . agregarDinero 50) unParticipante

agregarAccion :: Accion->Participante->Participante
agregarAccion unaAccion unParticipante = unParticipante {acciones = acciones unParticipante ++ [unaAccion] } --{acciones = unaAccion : acciones unParticipante} (ese dos puntos sirve para agregar al principio de la lista, es mejor siempre usar el dos puntos y no el ++)

gritar::Accion
gritar unParticipante = unParticipante {nombre ="AHHHH" ++ nombre unParticipante }
 
