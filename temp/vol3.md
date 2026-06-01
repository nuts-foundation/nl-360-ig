# Data set definitions

The 360° specifications use the following healthcare information models (HCIM's, also called "zibs") and FHIR specifications.

Zib | Methode | Sort | Count | Endpoint | Profile
----|---------|------|-------|----------|--------
Ademhaling| GET |||| 
Adresgegevens | GET ||||
AlcoholGebruik | GET ||||
Alert | GET | | | /Flag?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/zib-Alert | https://simplifier.net/packages/nictiz.fhir.nl.stu3.zib2017/2.2.10/files/1954733
AllergieIntoleratie | GET |||/fhir/AllergyIntolerance?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/zib-AllergyIntolerance|https://simplifier.net/packages/nictiz.fhir.nl.stu3.zib2017/2.2.18/files/2317138
BehandelAanwijzing
Behandeldoel
Betaler
Bloeddruk | GET | Date DESC | 5 | /Observation?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/zib-BloodPressure&_sort=-date&_count=5 | https://simplifier.net/packages/nictiz.fhir.nl.stu3.zib2017/2.2.10/files/1954744
BurgelijkeStaat
Contact
Contactgegevens
ContactPersoon
Darmfunctie
DecubitusWond
Gezinssituatie
Hartfrequentie
Huidaandoening
LaboratoriumUitslag
Lichaamsgewicht | GET | Date DESC | 5 | /Observation?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/zib-BodyWeight&_sort=-date&_count=5 | https://simplifier.net/packages/nictiz.fhir.nl.stu3.zib2017/2.2.10/files/1954750
Lichaamslengte | GET | Date DESC | 5 | /Observation?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/zib-BodyHeight&_sort=-date&_count=5 | https://simplifier.net/packages/nictiz.fhir.nl.stu3.zib2017/2.2.10/files/1954746
Lichaamstemperatuur | GET | Date DESC | 5 | /Observation?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/zib-BodyTemperature&_sort=-date&_count=5 | https://simplifier.net/packages/nictiz.fhir.nl.stu3.zib2017/2.2.10/files/1954748
Medicatieafspraak
MedicatieGebruik2
MedischHulpmiddel
Mobiliteit
Naamgegevens
O2Saturatie
Patient | POST | | 1 | see [Patient Context](https://simplifier.net/packages/nictiz.fhir.nl.stu3.zib2017/2.2.10/files/1954638) in Volume 3 of Zorginzage | https://simplifier.net/packages/nictiz.fhir.nl.stu3.zib2017/2.2.10/files/1954638
PartipatieInMaatschappij
Polsfrequentie
Probleem
SNAQ65+score
SNAQRCscore
SOEPVerslag (2020)
TekstUitslag
Toedieningsafspraak
Vaccinatie
VermogenTotDrinken
VermogenTotEten
VermogenTotMondverzorging
VermogenTotUiterlijkeVerzorging
VermogenTotVerpleegtechnischeHandelingen
VermogenTotZelfstandigMedicatiegebruik
VermogenTotZichKleden
VermogenTotZichWassen
Verrichting
Voedingsadvies
VrijheidsbeperkendeMaatregelen
Wilsverklaring
Wond
Woonsituatie
Zorgaanbieder
ZorgTeam
Zorgverlener
Correspondentie

# Conformance to Zorginzage-specification

The 360° specifications conforms to sections 5.2 and 5.3 of [Volume 3 of the Zorginzage-specification](https://build.fhir.org/ig/nuts-foundation/nl-zorginzage-ig/vol3.html).

