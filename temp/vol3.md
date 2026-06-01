# Data set definitions

The 360° specifications use the following healthcare information models (HCIM's, also called "zibs") and FHIR specifications.

Zib | Methode | Sort | Count | Endpoint | Profile
----|---------|------|-------|----------|--------
Ademhaling| GET ||| /Observation?patient={patientId}&code=http://snomed.info/sct\|422834003 | 
Adresgegevens | GET ||| See Patient, Patient. |
AlcoholGebruik | GET ||| /Observation?patient={patientId}&code=http://snomed.info/sct\|228273003 |
Alert | GET | | | /Flag?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/zib-Alert | https://simplifier.net/packages/nictiz.fhir.nl.stu3.zib2017/2.2.10/files/1954733
AllergieIntoleratie | GET |||/fhir/AllergyIntolerance?patient={patientId}| http://nictiz.nl/fhir/StructureDefinition/zib-AllergyIntolerance
BehandelAanwijzing | GET ||| /Consent?category=http://snomed.info/sct\|11291000146105 en/of /Consent?category=http://snomed.info/sct\|11341000146107|
Behandeldoel
Betaler | GET ||| /Coverage?_include=Coverage:payor:Patient&_include=Coverage:payor:Organization | 
Bloeddruk | GET | Date DESC | 5 | /Observation?patient={patientId}&code=http://loinc.org\|85354-9&_sort=-date&_count=5 | https://simplifier.net/packages/nictiz.fhir.nl.stu3.zib2017/2.2.10/files/1954744
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
Lichaamsgewicht | GET | Date DESC | 5 | /Observation?patient={patientId}&code=http://loinc.org\|29463-7&_sort=-date&_count=5 | https://simplifier.net/packages/nictiz.fhir.nl.stu3.zib2017/2.2.10/files/1954750
Lichaamslengte | GET | Date DESC | 5 | /Observation?patient={patientId}&code=http://loinc.org\|8302-2,http://loinc.org\|8306-3,http://loinc.org\|8308-9&_sort=-date&_count=5 | https://simplifier.net/packages/nictiz.fhir.nl.stu3.zib2017/2.2.10/files/1954746
Lichaamstemperatuur | GET | Date DESC | 5 | /Observation?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/zib-BodyTemperature&_sort=-date&_count=5 | https://simplifier.net/packages/nictiz.fhir.nl.stu3.zib2017/2.2.10/files/1954748
Medicatieafspraak | GET ||| /MedicationRequest?category=http://snomed.info/sct\|16076005&_include=MedicationRequest:medication | 
MedicatieGebruik2 | GET ||| /MedicationStatement?category=urn:oid:2.16.840.1.113883.2.4.3.11.60.20.77.5.3\|6&_include=MedicationStatement:medication
MedischHulpmiddel | GET ||| /DeviceUseStatement?_include=DeviceUseStatement:device | 
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
TekstUitslag | GET ||| /DiagnosticReport ?? | 
Toedieningsafspraak
Vaccinatie | GET ||| /Immunization?status=completed | 
VermogenTotDrinken | GET ||| /Observation?patient={patientId}&code=http://snomed.info/sct\|288852001 |
VermogenTotEten | GET ||| /Observation?patient={patientId}&code=http://snomed.info/sct\|288883002 |
VermogenTotMondverzorging | GET ||| /Observation?patient={patientId}&code=http://snomed.info/sct\|288470005 |
VermogenTotUiterlijkeVerzorging | GET ||| /Observation?patient={patientId}&code=http://snomed.info/sct\|704434006 |
VermogenTotVerpleegtechnischeHandelingen | GET ||| /Observation?patient={patientId}&code=http://snomed.info/sct\|303074009 |
VermogenTotZelfstandigMedicatiegebruik | GET ||| /Observation?patient={patientId}&code=http://snomed.info/sct\|285033005 |
VermogenTotZichKleden | GET ||| /Observation?patient={patientId}&code=http://snomed.info/sct\|165235000 |
VermogenTotZichWassen | GET ||| /Observation?patient={patientId}&code=http://snomed.info/sct\|284785009 |
Verrichting | GET ||| /Procedure?category=http://snomed.info/sct\|387713003 | 
Voedingsadvies
VrijheidsbeperkendeMaatregelen
Wilsverklaring | GET ||| /Consent?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/zib-AdvanceDirective | https://simplifier.net/packages/nictiz.fhir.nl.stu3.zib2017/2.2.10/files/1954726
Wond
Woonsituatie | GET ||| /Observation?patient={patientId}&code=http://snomed.info/sct|365508006 | 
Zorgaanbieder | GET ||| /Organization
ZorgTeam | GET ||| /CareTeam | 
Zorgverlener | GET ||| /Practitioner
Correspondentie | GET ||| /DocumentReference?patient={patientId}&status=current and then follow reference

# Conformance to Zorginzage-specification

The 360° specifications conforms to sections 5.2 and 5.3 of [Volume 3 of the Zorginzage-specification](https://build.fhir.org/ig/nuts-foundation/nl-zorginzage-ig/vol3.html).

