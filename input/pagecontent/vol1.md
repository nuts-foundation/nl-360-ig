### Inleiding

Deze implementatiegids 360-graden-cliëntbeeld bevat de afspraken en specificaties die nodig zijn voor de use case "360
graden cliëntbeeld". Het doel van deze implementatiegids is het technisch definiëren van deze use case.

### Relatie tot generieke Zorginzage-specificatie

Deze implementatiegids is gebaseerd op
de [Zorginzage-specificatie](https://nuts-foundation.github.io/nl-zorginzage-ig/). Tenzij expliciet aangegeven in deze
implementatiegids worden de afspraken en specificaties uit de Zorginzage-specificatie ongewijzigd hergebruikt voor de
realisatie van de use case "360 graden cliëntbeeld".

De Zorginzage-specificatie geeft geen invulling aan **lokalisatie** in afwachting van de nationale verwijs index (NVI).
De 360-graden-cliëntbeeld toepassing heeft er tot die tijd voor gekozen om een blinde opvraging bij het bronsysteem van
een zorgaanbieder toe te staan op het moment dat er een verwerkersovereenkomst is, of de zorgaanbieder lokaal is
vastgelegd in het CareTeam van de patient.

### Relatie to het Functioneel Ontwerp

Deze implementatiegids geeft technische invulling aan
het [Functioneel Ontwerp Toepassing op Nuts 360° cliëntbeeld](https://github.com/nuts-foundation/nl-360-ig/raw/f9e79a041d0ed197eba06474ddeae1c13cc28a3e/docs/fo.pdf).

Waar volume 2 een technisch inhoudelijk uitwerking bevat volgt hier een toelichting op de connectie met het functioneel
ontwerp.

Het FO schets voor **autorisatie** een situatie waarbij het wenselijk is regionale variatie in te bouwen. Voor
bronsystemen is er daarom voor gekozen alleen op organisatie te autoriseren. Wel is het verplicht zorgverlener
informatie mee te geven zodat het bronsysteem een audit trail kan opbouwen. Het raadplegende systeem moet daarnaast op
basis van de regionale afspraken lokaal de autorisatie op zorgverlenerrol toepassen.

Voor **toestemmingen** laat het FO open op welke manier die toestemming is vastgelegd. De techniek dwingt echter af dat
we de mogelijkheden benoemen zodat deze controle ook bij de bron kan worden ingebouwd. Er is daarom omschreven in volume
2 dat er drie manieren zijn waarop toestemming verleend kan worden in het bronsysteem.

Als uitgangspunt wordt er in het FO omschreven dat er gebruik wordt gemaakt van Zorginformatiebouwstenen (Zibs) en FHIR API's
standaard. Het is gebruikelijk in FHIR per resource of groep resources een bevraging te doen. Ook is er vastgelegd in
het FO dat een progressieve opbouw wenselijk is zodat gegevens kunnen worden weergegeven op het moment dat ze
beschikbaar komen, niet als de hele data set overgebracht is. Om die redenen is er voor gekozen queries op het niveau
van zibs en niet op toepassing te organiseren.

### Rollen en uitvoerders

 Rol                          | Uitvoerder                              
------------------------------|-----------------------------------------
 Eigenaar van de specificatie | Stichting Nuts                          
 Deelnemer                    | XIS-leverancier of platform-leverancier 
 Eigenaar Discovery Service   | n.t.b.                                  

