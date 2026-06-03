Volume 3 of this specifcation describes the agreements and specifications about content.

# Data set definitions

The 360° specifications use the healthcare information models (HCIM's, also called "zibs") and FHIR specifications described as specified in the following table.

| Zib | Methode | Sort | Count | Endpoint | Profile |
|-----|---------|------|-------|----------|---------|
| Ademhaling | GET | Date DESC | 5 | /Observation?patient={patientId}&code=http://snomed.info/sct\|422834003&_sort=-date&_count=5 | ?WHAT IS THE CORRECT PROFILE? |
| Adresgegevens | GET | n/a | n/a | See Patient, Patient.address | https://simplifier.net/packages/nictiz.fhir.nl.stu3.zib2017/2.3.2/files/3018955 |
| AlcoholGebruik | GET | Date DESC | 5 | /Observation?patient={patientId}&code=http://snomed.info/sct\|228273003&_sort=-date&_count=5 | https://simplifier.net/packages/nictiz.fhir.nl.stu3.zib2017/2.2.18/files/2317134 |
| Alert | GET | Date DESC | no limit | /Flag?patient={patientId}&_sort=-date ?HOW TO FILTER ON ACTIVE, status is not a search param? | https://simplifier.net/packages/nictiz.fhir.nl.stu3.zib2017/2.2.10/files/1954733 |
| AllergieIntoleratie | GET | Date DESC | no limit | /fhir/AllergyIntolerance?patient={patientId}&_sort=-date ?HOW TO FILTER ON ACTIVE, status is not a search param? | http://nictiz.nl/fhir/StructureDefinition/zib-AllergyIntolerance |
| BehandelAanwijzing | GET | Date DESC | no limit | /Consent?category=http://snomed.info/sct\|11291000146105,http://snomed.info/sct\|11341000146107 ?HOW TO FILTER ON ACTIVE? | ?USE WAY OF BGZ OR WAY OF PZP HERE? |
| Behandeldoel | GET | |
| Betaler | GET ||| /Coverage?_include=Coverage:payor:Patient&_include=Coverage:payor:Organization |  |
| Bloeddruk | GET | Date DESC | 5 | /Observation?patient={patientId}&code=http://loinc.org\|85354-9&_sort=-date&_count=5 | https://simplifier.net/packages/nictiz.fhir.nl.stu3.zib2017/2.2.10/files/1954744 |
| BurgelijkeStaat | GET ||| See Patient, Patient.maritalStatus | n/a |
| Contact | GET ||| /Encounter?class=http://hl7.org/fhir/v3/ActCode\|IMP,http://hl7.org/fhir/v3/ActCode\|ACUTE,http://hl7.org/fhir/v3/ActCode\|NONAC |
| Contactgegevens | GET | | | See Patient, Patient.telecom | https://simplifier.net/packages/nictiz.fhir.nl.stu3.zib2017/2.2.20/files/2741661 |
| ContactPersoon | GET | | | See Patient, Patient.contact | n/a |
| Darmfunctie | GET ||| /Observation?patient={patientId}&code=http://snomed.info/sct\|111989001 | https://simplifier.net/nictizstu3-zib2017/zib-bowelfunction |
| DecubitusWond | GET ||| /Observation?patient={patientId}&code=http://snomed.info/sct\|399912005 | https://simplifier.net/nictizstu3-zib2017/zib-pressureulcer |
| Gezinssituatie | GET ||| /Observation?patient={patientId}&code=http://snomed.info/sct\|365470003 | https://simplifier.net/packages/nictiz.fhir.nl.stu3.zib2017/2.2.20/files/2741820 |
| Hartfrequentie |
| Huidaandoening | GET ||| /Observation?patient={patientId}&category=http://snomed.info/sct\|95320005 | https://simplifier.net/nictizstu3-zib2017/zib-skindisorder |
| LaboratoriumUitslag | GET ||| /Observation?patient={patientId}&category=http://snomed.info/sct\|49581000146104 | https://simplifier.net/packages/nictiz.fhir.nl.stu3.zib2017/2.2.18/files/2317239 |
| Lichaamsgewicht | GET | Date DESC | 5 | /Observation?patient={patientId}&code=http://loinc.org\|29463-7&_sort=-date&_count=5 | https://simplifier.net/packages/nictiz.fhir.nl.stu3.zib2017/2.2.10/files/1954750 |
| Lichaamslengte | GET | Date DESC | 5 | /Observation?patient={patientId}&code=http://loinc.org\|8302-2,http://loinc.org\|8306-3,http://loinc.org\|8308-9&_sort=-date&_count=5 | https://simplifier.net/packages/nictiz.fhir.nl.stu3.zib2017/2.2.10/files/1954746 |
| Lichaamstemperatuur | GET | Date DESC | 5 | /Observation?patient={patientId}&code=http://loinc.org\|8310-5&_sort=-date&_count=5 | https://simplifier.net/nictizstu3-zib2017/bodytemp |
| Medicatieafspraak | GET ||| /MedicationRequest?category=http://snomed.info/sct\|16076005&_include=MedicationRequest:medication |  |
| MedicatieGebruik2 | GET ||| /MedicationStatement?category=urn:oid:2.16.840.1.113883.2.4.3.11.60.20.77.5.3\|6&_include=MedicationStatement:medication |
| MedischHulpmiddel | GET ||| /DeviceUseStatement?_include=DeviceUseStatement:device |  |
| Mobiliteit | GET ||| /Observation?patient={patientId}&xyz=123 |  |
| Naamgegevens | GET ||| See Patient, Patient.name | https://simplifier.net/packages/nictiz.fhir.nl.stu3.zib2017/2.2.20/files/2741667 |
| O2Saturatie |
| Patient | POST | | 1 | See [Patient Context](https://simplifier.net/packages/nictiz.fhir.nl.stu3.zib2017/2.2.10/files/1954638) in Volume 3 of Zorginzage | https://simplifier.net/packages/nictiz.fhir.nl.stu3.zib2017/2.2.10/files/1954638 |
| PartipatieInMaatschappij | GET ||| /Observation?patient={patientId}&code=http://snomed.info/sct\|314845004 | https://simplifier.net/nictizstu3-zib2017/zib-participationinsociety  |
| Polsfrequentie | GET ||| /Observation?patient={patientId}&code=http://loinc.org\|8893-0 | https://simplifier.net/nictizstu3-zib2017/zib-pulserate  |
| Probleem | GET ||| /Condition?patient={patientId} | https://simplifier.net/packages/nictiz.fhir.nl.stu3.zib2017/2.2.18/files/2317327 |
| SNAQ65+score | GET ||| /Observation?patient={patientId}&code=http://snomed.info/sct\|108321000146101 | https://simplifier.net/nictizstu3-zib2017/zib-snaq65plusscore |
| SNAQRCscore | GET ||| /Observation?patient={patientId}&code=http://snomed.info/sct\|108311000146106 | https://simplifier.net/nictizstu3-zib2017/zib-snaqrcscore |
| SOEPVerslag (2020) | GET | Date DESC | 5 | /Composition?patient={patientId}&type=http://loinc.org\|67781-5&_sort=-date&_count=5 | n/a |
| TekstUitslag | GET ||| /DiagnosticReport ?? |  |
| Toedieningsafspraak |
| Vaccinatie | GET ||| /Immunization?status=completed |  |
| VermogenTotDrinken | GET ||| /Observation?patient={patientId}&code=http://snomed.info/sct\|288852001 | |
| VermogenTotEten | GET ||| /Observation?patient={patientId}&code=http://snomed.info/sct\|288883002 | |
| VermogenTotMondverzorging | GET ||| /Observation?patient={patientId}&code=http://snomed.info/sct\|288470005 | |
| VermogenTotUiterlijkeVerzorging | GET ||| /Observation?patient={patientId}&code=http://snomed.info/sct\|704434006 | |
| VermogenTotVerpleegtechnischeHandelingen | GET ||| /Observation?patient={patientId}&code=http://snomed.info/sct\|303074009 | |
| VermogenTotZelfstandigMedicatiegebruik | GET ||| /Observation?patient={patientId}&code=http://snomed.info/sct\|285033005 | |
| VermogenTotZichKleden | GET ||| /Observation?patient={patientId}&code=http://snomed.info/sct\|165235000 | |
| VermogenTotZichWassen | GET ||| /Observation?patient={patientId}&code=http://snomed.info/sct\|284785009 | |
| Verrichting | GET ||| /Procedure?category=http://snomed.info/sct\|387713003 |  |
| Voedingsadvies | GET ||| /NutritionOrder?patient={patientId} | https://simplifier.net/packages/nictiz.fhir.nl.stu3.zib2017/2.2.18/files/2317294 |
| VrijheidsbeperkendeMaatregelen | GET ||| /Procedure??patient={patientId}&category=http://snomed.info/sct\|225214000 | https://simplifier.net/nictizstu3-zib2017/zib-freedomrestrictingmeasures |
| Wilsverklaring | GET ||| /Consent?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/zib-AdvanceDirective | https://simplifier.net/packages/nictiz.fhir.nl.stu3.zib2017/2.2.10/files/1954726 |
| Wond | GET |||| |
| Woonsituatie | GET ||| /Observation?patient={patientId}&code=http://snomed.info/sct|365508006 |  |
| Zorgaanbieder | GET ||| See ZorgTeam, CareTeam.participant.member | https://simplifier.net/packages/nictiz.fhir.nl.stu3.zib2017/2.3.2/files/3018965 |
| ZorgTeam | GET ||| /CareTeam?patient={patientId}&_include=CareTeam:participant | https://simplifier.net/packages/nictiz.fhir.nl.stu3.zib2017/2.3.2/files/3018958 |
| Zorgverlener | GET ||| See ZorgTeam, CareTeam.participant.member | https://simplifier.net/packages/nictiz.fhir.nl.stu3.zib2017/2.3.2/files/3018968 |
| Correspondentie | GET ||| /DocumentReference?patient={patientId}&status=current and then follow reference | https://simplifier.net/packages/nictiz.fhir.nl.stu3.zib2017/2.3.2/files/3018952 |

# Conformance to Zorginzage-specification

The 360° specifications conforms to sections 5.2 and 5.3 of [Volume 3 of the Zorginzage-specification](https://build.fhir.org/ig/nuts-foundation/nl-zorginzage-ig/vol3.html).

