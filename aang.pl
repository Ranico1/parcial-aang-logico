esPersonaje(aang).
esPersonaje(katara).
esPersonaje(zoka).
esPersonaje(appa).
esPersonaje(momo).
esPersonaje(toph).
esPersonaje(tayLee).
esPersonaje(zuko).
esPersonaje(azula).
esPersonaje(iroh).

esElementoBasico(fuego).
esElementoBasico(agua).
esElementoBasico(tierra).
esElementoBasico(aire).

% elementoAvanzadoDe/2 relaciona un elemento básico con otro avanzado asociado

elementoAvanzadoDe(fuego, rayo).
elementoAvanzadoDe(agua, sangre).
elementoAvanzadoDe(tierra, metal).

% controla/2 relaciona un personaje con un elemento que controla

controla(zuko, rayo).
controla(toph, metal).
controla(katara, sangre).
controla(aang, aire).
controla(aang, agua).
controla(aang, tierra).
controla(aang, fuego).
controla(azula, rayo).
controla(iroh, rayo).

% visito/2 relaciona un personaje con un lugar que visitó. Los lugares son functores que tienen la siguiente forma:
% reinoTierra(nombreDelLugar, estructura)
% nacionDelFuego(nombreDelLugar, soldadosQueLoDefienden)
% tribuAgua(puntoCardinalDondeSeUbica)
% temploAire(puntoCardinalDondeSeUbica)

visito(aang, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])).
visito(iroh, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])).
visito(zuko, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])).
visito(toph, reinoTierra(fortalezaDeGralFong, [cuartel, dormitorios, enfermeria, salaDeGuerra, templo, zonaDeRecreo])).
visito(aang, nacionDelFuego(palacioReal, 1000)).
visito(katara, tribuAgua(norte)).
visito(katara, tribuAgua(sur)).
visito(aang, temploAire(norte)).
visito(aang, temploAire(oeste)).
visito(aang, temploAire(este)).
visito(aang, temploAire(sur)).


% Punto 1 

elAvatar(Personaje) :- 
    esPersonaje(Personaje),
    forall(esElementoBasico(Elemento), controla(Elemento, Personaje)). 

% Punto 2 

noEsMaestro(Personaje) :-
    esPersonaje(Personaje),
    not(controlaElementoAvanzado(Personaje)),
    not(controlaElementoBasico(Personaje)). 


esMaestroPrincipiante(Personaje) :-
    controlaElementoBasico(Personaje),
    not(controlaElementoAvanzado(Personaje)).

controlaElementoBasico(Personaje) :-
    esElementoBasico(Elemento),
    controla(Personaje, Elemento). 


esMaestroAvanzado(Personaje) :- 
    controlaElementoAvanzado(Personaje).

esMaestroAvanzado(Personaje) :-
    elAvatar(Personaje). 
    

controlaElementoAvanzado(Personaje) :-
    elementoAvanzadoDe(_, Elemento),
    controla(Personaje, Elemento).



% Punto 3

sigueA(Personaje1, Personaje2) :- 
    esPersonaje(Personaje1),
    esPersonaje(Personaje2),
    forall(visito(Personaje1,Lugar), visito(Personaje2, Lugar)).

sigueA(zuko, aang). 

% Punto 4 

esDignoDeConocer(temploAire(_)).
esDignoDeConocer(tribuAgua(norte)).


esDignoDeConocer(reinoTierra(_,Estructura)) :-
    not(tieneMuros(Estrucutra)). 

tieneMuros(Estructura) :- 
    member(muro,Estructura).  

% Punto 5

esPopular(Lugar) :- 
    visito(_,Lugar),
    findall(Personaje, visito(Personaje, Lugar), PersonajesVisitantes),
    length(PersonajesVisitantes, CantPersonajes),
    CantPersonajes > 4.


% Punto 6
esPersonaje(bumi). 
controla(bumi, tierra).
visito(bumi, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])). 
esPersonaje(zuki).
visito(zuki, nacionDelFuego(prisionMaximaSeguridad,200)). 
    