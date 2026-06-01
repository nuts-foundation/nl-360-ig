# Data set definitions

The 360° specifications use the following healthcare information models (HCIM's, also called "zibs") and FHIR specifications.

Zib | Methode | Sort | Count | Endpoint | Profile
----|---------|------|-------|----------|--------
Ademhaling| GET |||| 
Adresgegevens | GET ||||
AlcoholGebruik | GET ||| /Observation?patient={patientId}&code=http://snomed.info/sct\|228273003 |
Alert | GET | | | /Flag?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/zib-Alert | https://simplifier.net/packages/nictiz.fhir.nl.stu3.zib2017/2.2.10/files/1954733
AllergieIntoleratie | GET |||/fhir/AllergyIntolerance?patient={patientId}| http://nictiz.nl/fhir/StructureDefinition/zib-AllergyIntolerance
BehandelAanwijzing | GET ||| /Consent?category=http://snomed.info/sct\|11291000146105 en/of /Consent?category=http://snomed.info/sct\|11341000146107|
Behandeldoel
Betaler | GET ||| /Coverage?_include=Coverage:payor:Patient&_include=Coverage:payor:Organization | 
Bloeddruk | GET | Date DESC | 5 | /Observation?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/zib-BloodPressure&_sort=-date&_count=5 | https://simplifier.net/packages/nictiz.fhir.nl.stu3.zib2017/2.2.10/files/1954744
BurgelijkeStaat
Contact | GET ||| /Encounter?class=http://hl7.org/fhir/v3/ActCode\|IMP,http://hl7.org/fhir/v3/ActCode\|ACUTE,http://hl7.org/fhir/v3/ActCode\|NONAC
Contactgegevens
ContactPersoon | | | | See Patient, Patient.contact|
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
Probleem | GET ||| /Condition | 
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
Verrichting | GET ||| /Procedure?category=http://snomed.info/sct\|387713003 | 
Voedingsadvies
VrijheidsbeperkendeMaatregelen
Wilsverklaring | GET ||| /Consent?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/zib-AdvanceDirective | https://simplifier.net/packages/nictiz.fhir.nl.stu3.zib2017/2.2.10/files/1954726
Wond
Woonsituatie | GET ||| /Observation?patient={patientId}&code=http://snomed.info/sct|365508006 | 
Zorgaanbieder
ZorgTeam | GET ||| /CareTeam | 
Zorgverlener
Correspondentie

# Conformance to Zorginzage-specification

The 360° specifications conforms to sections 5.2 and 5.3 of [Volume 3 of the Zorginzage-specification](https://build.fhir.org/ig/nuts-foundation/nl-zorginzage-ig/vol3.html).

