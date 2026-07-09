Volume 3 of this specifcation describes the agreements and specifications about content.

### Data set definitions

The 360° specifications use the healthcare information models (HCIM's, also called "zibs") and FHIR specifications described as specified in the following table.

Remarks:
- Two versions of FHIR are supported in this specification: FHIR STU3 and FHIR R4. 
- Two HCIM/zib releases are supported in this specification: HCIM/zib Release 2017 and HCIM/zib Release 2020.
- There is no 1-on-1 relation between FHIR version and HCIM/zib for all informaion models.
- For each combination of HCIM/zib and FHIR version zero or more FHIR profiles are supported.
- Resource queries are primarily based on **FHIR profile** (`meta.profile`) through the `_profile` search parameter. 
- Source systems **MUST** populate `meta.profile` on their resources with the canonical(s) listed here; if they do not, the query returns nothing.
- When a combination of HCIM/zib and FHIR version is supported by multiple FHIR profiles the query accepts multiple profile canonicals as an OR list (comma-separated). 
- The profile canonicals are expressed without `|version` so that all published versions of a profile match.
- For a small number of combinations of HCIM ("zib") and FHIR version no FHIR profile is available. In these cases the resource queries are based on **SNOMED code** through the `code` search parameter. This is flagged per row.
- The STU3 profiles come from `nictiz.fhir.nl.stu3.zib2017`
- The R4 profiles come from `nictiz.fhir.nl.r4.nl-core`, for some HCIM's/zibs supplemented with `nictiz.fhir.nl.stu3.zib2017`. 
- The R4 profiles for the medication HCIM's/zibs come from `nictiz.fhir.nl.r4.medicationprocess9`.
- All queries are specified in the table below.
 
| Zib | HTTP Method | FHIR version | Query | Supported profiles (`_profile`) |
|-----|--------|--------------|----------|---------------------------------|
| Ademhaling | GET | STU3 | /Observation?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/zib-Respiration | http://nictiz.nl/fhir/StructureDefinition/zib-Respiration |
| Ademhaling | GET | R4 | /Observation?patient={patientId}&_code=http://snomed.info/sct\|422834003 | _retired in zib2020 (R4); STU3 zib2017 only_ |
| Adresgegevens | GET | STU3 | See Patient, Patient.address | http://fhir.nl/fhir/StructureDefinition/nl-core-patient |
| Adresgegevens | GET | R4 | See Patient, Patient.address | http://nictiz.nl/fhir/StructureDefinition/nl-core-Patient |
| AlcoholGebruik | GET | STU3 | /Observation?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/zib-AlcoholUse | http://nictiz.nl/fhir/StructureDefinition/zib-AlcoholUse |
| AlcoholGebruik | GET | R4 | /Observation?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/nl-core-AlcoholUse,http://nictiz.nl/fhir/StructureDefinition/zib-AlcoholUse | http://nictiz.nl/fhir/StructureDefinition/nl-core-AlcoholUse<br>http://nictiz.nl/fhir/StructureDefinition/zib-AlcoholUse |
| Alert | GET | STU3 | /Flag?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/zib-Alert | http://nictiz.nl/fhir/StructureDefinition/zib-Alert |
| Alert | GET | R4 | /Flag?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/nl-core-Alert,http://nictiz.nl/fhir/StructureDefinition/zib-Alert | http://nictiz.nl/fhir/StructureDefinition/zib-Alert<br>http://nictiz.nl/fhir/StructureDefinition/nl-core-Alert |
| AllergieIntolerantie | GET | STU3 | /AllergyIntolerance?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/zib-AllergyIntolerance | http://nictiz.nl/fhir/StructureDefinition/zib-AllergyIntolerance |
| AllergieIntolerantie | GET | R4 | /AllergyIntolerance?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/nl-core-AllergyIntolerance,http://nictiz.nl/fhir/StructureDefinition/zib-AllergyIntolerance | http://nictiz.nl/fhir/StructureDefinition/nl-core-AllergyIntolerance<br>http://nictiz.nl/fhir/StructureDefinition/zib-AllergyIntolerance |
| BehandelAanwijzing | GET | STU3 | /Consent?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/zib-TreatmentDirective | http://nictiz.nl/fhir/StructureDefinition/zib-TreatmentDirective |
| BehandelAanwijzing | GET | R4 | /Consent?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/nl-core-TreatmentDirective2 | http://nictiz.nl/fhir/StructureDefinition/nl-core-TreatmentDirective2 |
| Betaler | GET | STU3 | /Coverage?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/zib-Payer&_include=Coverage:payor:Patient&_include=Coverage:payor:Organization | http://nictiz.nl/fhir/StructureDefinition/zib-Payer |
| Betaler | GET | R4 | /Coverage?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/nl-core-Payer.InsuranceCompany&_include=Coverage:payor:Patient&_include=Coverage:payor:Organization | http://nictiz.nl/fhir/StructureDefinition/nl-core-Payer.InsuranceCompany |
| Bloeddruk | GET | STU3 | /Observation?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/zib-BloodPressure | http://nictiz.nl/fhir/StructureDefinition/zib-BloodPressure |
| Bloeddruk | GET | R4 | /Observation?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/nl-core-BloodPressure,http://nictiz.nl/fhir/StructureDefinition/zib-BloodPressure | http://nictiz.nl/fhir/StructureDefinition/nl-core-BloodPressure<br>http://nictiz.nl/fhir/StructureDefinition/zib-BloodPressure |
| BurgelijkeStaat | GET | STU3 | See Patient, Patient.maritalStatus | http://fhir.nl/fhir/StructureDefinition/nl-core-patient |
| BurgelijkeStaat | GET | R4 | See Patient, Patient.maritalStatus | http://nictiz.nl/fhir/StructureDefinition/nl-core-Patient |
| Contact | GET | STU3 | /Encounter?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/zib-Encounter | http://nictiz.nl/fhir/StructureDefinition/zib-Encounter |
| Contact | GET | R4 | /Encounter?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/nl-core-Encounter,http://nictiz.nl/fhir/StructureDefinition/zib-Encounter | http://nictiz.nl/fhir/StructureDefinition/nl-core-Encounter<br>http://nictiz.nl/fhir/StructureDefinition/zib-Encounter |
| Contactgegevens | GET | STU3 | See Patient, Patient.telecom | http://fhir.nl/fhir/StructureDefinition/nl-core-patient |
| Contactgegevens | GET | R4 | See Patient, Patient.telecom | http://nictiz.nl/fhir/StructureDefinition/nl-core-Patient |
| ContactPersoon | GET | STU3 | See Patient, Patient.contact | http://fhir.nl/fhir/StructureDefinition/nl-core-relatedperson |
| ContactPersoon | GET | R4 | See Patient, Patient.contact | http://nictiz.nl/fhir/StructureDefinition/nl-core-ContactPerson |
| Correspondentie | GET | STU3 | /DocumentReference?patient={patientId}&status=current and then follow the reference | n/a |
| Correspondentie | GET | R4 | /DocumentReference?patient={patientId}&status=current and then follow the reference | n/a |
| DecubitusWond | GET | STU3 | /Condition?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/zib-PressureUlcer | http://nictiz.nl/fhir/StructureDefinition/zib-PressureUlcer |
| DecubitusWond | GET | R4 | /Condition?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/nl-core-PressureUlcer,http://nictiz.nl/fhir/StructureDefinition/zib-PressureUlcer | http://nictiz.nl/fhir/StructureDefinition/nl-core-PressureUlcer<br>http://nictiz.nl/fhir/StructureDefinition/zib-PressureUlcer |
| Gezinssituatie | GET | STU3 | /Observation?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/zib-FamilySituation | http://nictiz.nl/fhir/StructureDefinition/zib-FamilySituation<br>_retired in zib2020 (R4); STU3 zib2017 only_ |
| Gezinssituatie | GET | R4 | /Observation?patient={patientId}&_code=http://snomed.info/sct\|365470003 | _retired in zib2020 (R4); STU3 zib2017 only_ |
| Huidaandoening | GET | STU3 | /Condition?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/zib-SkinDisorder | http://nictiz.nl/fhir/StructureDefinition/zib-SkinDisorder |
| Huidaandoening | GET | R4 | /Condition?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/nl-core-SkinDisorder,http://nictiz.nl/fhir/StructureDefinition/zib-SkinDisorder | http://nictiz.nl/fhir/StructureDefinition/nl-core-SkinDisorder<br>http://nictiz.nl/fhir/StructureDefinition/zib-SkinDisorder |
| LaboratoriumUitslag | GET | STU3 | /Observation?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/zib-LaboratoryTestResult-Observation | http://nictiz.nl/fhir/StructureDefinition/zib-LaboratoryTestResult-Observation |
| LaboratoriumUitslag | GET | R4 | /Observation?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/nl-core-LaboratoryTestResult | http://nictiz.nl/fhir/StructureDefinition/nl-core-LaboratoryTestResult |
| Lichaamsgewicht | GET | STU3 | /Observation?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/zib-BodyWeight | http://nictiz.nl/fhir/StructureDefinition/zib-BodyWeight |
| Lichaamsgewicht | GET | R4 | /Observation?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/nl-core-BodyWeight,http://nictiz.nl/fhir/StructureDefinition/zib-BodyWeight | http://nictiz.nl/fhir/StructureDefinition/nl-core-BodyWeight<br>http://nictiz.nl/fhir/StructureDefinition/zib-BodyWeight |
| Lichaamslengte | GET | STU3 | /Observation?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/zib-BodyHeight | http://nictiz.nl/fhir/StructureDefinition/zib-BodyHeight |
| Lichaamslengte | GET | R4 | /Observation?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/nl-core-BodyHeight,http://nictiz.nl/fhir/StructureDefinition/zib-BodyHeight | http://nictiz.nl/fhir/StructureDefinition/nl-core-BodyHeight<br>http://nictiz.nl/fhir/StructureDefinition/zib-BodyHeight |
| Lichaamstemperatuur | GET | STU3 | /Observation?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/zib-BodyTemperature | http://nictiz.nl/fhir/StructureDefinition/zib-BodyTemperature |
| Lichaamstemperatuur | GET | R4 | /Observation?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/nl-core-BodyTemperature,http://nictiz.nl/fhir/StructureDefinition/zib-BodyTemperature | http://nictiz.nl/fhir/StructureDefinition/nl-core-BodyTemperature<br>http://nictiz.nl/fhir/StructureDefinition/zib-BodyTemperature |
| MedicatieGebruik2 | GET | STU3 | /MedicationStatement?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/zib-MedicationUse&_include=MedicationStatement:medication | http://nictiz.nl/fhir/StructureDefinition/zib-MedicationUse |
| MedicatieGebruik2 | GET | R4 | /MedicationStatement?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/mp-MedicationUse2&_include=MedicationStatement:medication | http://nictiz.nl/fhir/StructureDefinition/mp-MedicationUse2<br>_R4 from nictiz.fhir.nl.r4.medicationprocess9_ |
| MedischHulpmiddel | GET | STU3 | /DeviceUseStatement?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/zib-MedicalDevice&_include=DeviceUseStatement:device | http://nictiz.nl/fhir/StructureDefinition/zib-MedicalDevice |
| MedischHulpmiddel | GET | R4 | /DeviceUseStatement?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/nl-core-MedicalDevice&_include=DeviceUseStatement:device | http://nictiz.nl/fhir/StructureDefinition/nl-core-MedicalDevice |
| Mobiliteit | GET | STU3 | /Observation?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/zib-Mobility | http://nictiz.nl/fhir/StructureDefinition/zib-Mobility |
| Mobiliteit | GET | R4 | /Observation?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/nl-core-Mobility | http://nictiz.nl/fhir/StructureDefinition/nl-core-Mobility |
| Naamgegevens | GET | STU3 | See Patient, Patient.name | http://fhir.nl/fhir/StructureDefinition/nl-core-patient |
| Naamgegevens | GET | R4 | See Patient, Patient.name | http://nictiz.nl/fhir/StructureDefinition/nl-core-Patient |
| O2Saturatie | GET | STU3 | /Observation?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/zib-OxygenSaturation | http://nictiz.nl/fhir/StructureDefinition/zib-OxygenSaturation |
| O2Saturatie | GET | R4 | /Observation?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/nl-core-O2Saturation | http://nictiz.nl/fhir/StructureDefinition/nl-core-O2Saturation |
| PartipatieInMaatschappij | GET | STU3 | /Observation?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/zib-ParticipationInSociety | http://nictiz.nl/fhir/StructureDefinition/zib-ParticipationInSociety |
| PartipatieInMaatschappij | GET | R4 | /Observation?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/nl-core-ParticipationInSociety | http://nictiz.nl/fhir/StructureDefinition/nl-core-ParticipationInSociety |
| Patient | POST | STU3 | See [Patient Context](https://nuts-foundation.github.io/nl-zorginzage-ig/vol3.html#patient-context) in Volume 3 of Zorginzage | http://fhir.nl/fhir/StructureDefinition/nl-core-patient |
| Patient | POST | R4 | See [Patient Context](https://nuts-foundation.github.io/nl-zorginzage-ig/vol3.html#patient-context) in Volume 3 of Zorginzage | http://nictiz.nl/fhir/StructureDefinition/nl-core-Patient |
| Polsfrequentie | GET | STU3 | /Observation?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/zib-PulseRate | http://nictiz.nl/fhir/StructureDefinition/zib-PulseRate |
| Polsfrequentie | GET | R4 | /Observation?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/nl-core-PulseRate | http://nictiz.nl/fhir/StructureDefinition/nl-core-PulseRate |
| Probleem | GET | STU3 | /Condition?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/zib-Problem | http://nictiz.nl/fhir/StructureDefinition/zib-Problem |
| Probleem | GET | R4 | /Condition?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/nl-core-Problem | http://nictiz.nl/fhir/StructureDefinition/nl-core-Problem |
| SNAQ65+score | GET | STU3 | /Observation?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/zib-SNAQ65plusScore | http://nictiz.nl/fhir/StructureDefinition/zib-SNAQ65plusScore |
| SNAQ65+score | GET | R4 | /Observation?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/nl-core-SNAQ65plusScore | http://nictiz.nl/fhir/StructureDefinition/nl-core-SNAQ65plusScore |
| SNAQRCscore | GET | STU3 | /Observation?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/zib-SNAQrcScore | http://nictiz.nl/fhir/StructureDefinition/zib-SNAQrcScore |
| SNAQRCscore | GET | R4 | /Observation?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/nl-core-SNAQrcScore | http://nictiz.nl/fhir/StructureDefinition/nl-core-SNAQrcScore |
| Vaccinatie | GET | STU3 | /Immunization?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/zib-Vaccination | http://nictiz.nl/fhir/StructureDefinition/zib-Vaccination |
| Vaccinatie | GET | R4 | /Immunization?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/nl-core-Vaccination-event | http://nictiz.nl/fhir/StructureDefinition/nl-core-Vaccination-event |
| VermogenTotDrinken | GET | STU3 | /Observation?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/zib-AbilityToDrink | http://nictiz.nl/fhir/StructureDefinition/zib-AbilityToDrink |
| VermogenTotDrinken | GET | R4 | /Observation?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/nl-core-AbilityToDrink,http://nictiz.nl/fhir/StructureDefinition/zib-AbilityToDrink | http://nictiz.nl/fhir/StructureDefinition/nl-core-AbilityToDrink<br>http://nictiz.nl/fhir/StructureDefinition/zib-AbilityToDrink |
| VermogenTotEten | GET | STU3 | /Observation?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/zib-AbilityToEat | http://nictiz.nl/fhir/StructureDefinition/zib-AbilityToEat |
| VermogenTotEten | GET | R4 | /Observation?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/nl-core-AbilityToEat,http://nictiz.nl/fhir/StructureDefinition/zib-AbilityToEat | http://nictiz.nl/fhir/StructureDefinition/nl-core-AbilityToEat<br>http://nictiz.nl/fhir/StructureDefinition/zib-AbilityToEat |
| VermogenTotMondverzorging | GET | STU3 | /Observation?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/zib-AbilityToPerformMouthcareActivities | http://nictiz.nl/fhir/StructureDefinition/zib-AbilityToPerformMouthcareActivities |
| VermogenTotMondverzorging | GET | R4 | /Observation?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/nl-core-AbilityToPerformMouthcareActivities,http://nictiz.nl/fhir/StructureDefinition/zib-AbilityToPerformMouthcareActivities | http://nictiz.nl/fhir/StructureDefinition/nl-core-AbilityToPerformMouthcareActivities<br>http://nictiz.nl/fhir/StructureDefinition/zib-AbilityToPerformMouthcareActivities |
| VermogenTotUiterlijkeVerzorging | GET | STU3 | /Observation?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/zib-AbilityToGroome | http://nictiz.nl/fhir/StructureDefinition/zib-AbilityToGroome |
| VermogenTotUiterlijkeVerzorging | GET | R4 | /Observation?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/nl-core-AbilityToGroom | http://nictiz.nl/fhir/StructureDefinition/nl-core-AbilityToGroom |
| VermogenTotVerpleegtechnischeHandelingen | GET | STU3 | /Observation?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/zib-AbilityToPerformNursingActivities | http://nictiz.nl/fhir/StructureDefinition/zib-AbilityToPerformNursingActivities |
| VermogenTotVerpleegtechnischeHandelingen | GET | R4 | /Observation?patient={patientId}&_code=http://snomed.info/sct\|303074009 | _retired in zib2020 (R4); STU3 zib2017 only_ |
| VermogenTotZelfstandigMedicatiegebruik | GET | STU3 | /Observation?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/zib-AbilityToManageMedication | http://nictiz.nl/fhir/StructureDefinition/zib-AbilityToManageMedication |
| VermogenTotZelfstandigMedicatiegebruik | GET | R4 | /Observation?patient={patientId}&_code=http://snomed.info/sct\|285033005 | _retired in zib2020 (R4); STU3 zib2017 only_ |
| VermogenTotZichKleden | GET | STU3 | /Observation?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/zib-AbilityToDressOneself | http://nictiz.nl/fhir/StructureDefinition/zib-AbilityToDressOneself |
| VermogenTotZichKleden | GET | R4 | /Observation?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/nl-core-AbilityToDressOneself,http://nictiz.nl/fhir/StructureDefinition/zib-AbilityToDressOneself | http://nictiz.nl/fhir/StructureDefinition/nl-core-AbilityToDressOneself<br>http://nictiz.nl/fhir/StructureDefinition/zib-AbilityToDressOneself |
| VermogenTotZichWassen | GET | STU3 | /Observation?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/zib-AbilityToWashOneSelf | http://nictiz.nl/fhir/StructureDefinition/zib-AbilityToWashOneSelf |
| VermogenTotZichWassen | GET | R4 | /Observation?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/nl-core-AbilityToWashOneself | http://nictiz.nl/fhir/StructureDefinition/nl-core-AbilityToWashOneself |
| Verrichting | GET | STU3 | /Procedure?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/zib-Procedure | http://nictiz.nl/fhir/StructureDefinition/zib-Procedure |
| Verrichting | GET | R4 | /Procedure?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/nl-core-Procedure-event | http://nictiz.nl/fhir/StructureDefinition/nl-core-Procedure-event |
| Voedingsadvies | GET | STU3 | /NutritionOrder?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/zib-NutritionAdvice | http://nictiz.nl/fhir/StructureDefinition/zib-NutritionAdvice |
| Voedingsadvies | GET | R4 | /NutritionOrder?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/nl-core-NutritionAdvice | http://nictiz.nl/fhir/StructureDefinition/nl-core-NutritionAdvice |
| VrijheidsbeperkendeMaatregelen | GET | STU3 | /Procedure?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/zib-FreedomRestrictingMeasures | http://nictiz.nl/fhir/StructureDefinition/zib-FreedomRestrictingMeasures |
| VrijheidsbeperkendeMaatregelen | GET | R4 | /Procedure?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/nl-core-FreedomRestrictingIntervention | http://nictiz.nl/fhir/StructureDefinition/nl-core-FreedomRestrictingIntervention |
| Wilsverklaring | GET | STU3 | /Consent?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/zib-AdvanceDirective | http://nictiz.nl/fhir/StructureDefinition/zib-AdvanceDirective |
| Wilsverklaring | GET | R4 | /Consent?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/nl-core-AdvanceDirective,http://nictiz.nl/fhir/StructureDefinition/zib-AdvanceDirective | http://nictiz.nl/fhir/StructureDefinition/nl-core-AdvanceDirective<br>http://nictiz.nl/fhir/StructureDefinition/zib-AdvanceDirective |
| Wond | GET | STU3 | /Condition?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/zib-Wound | http://nictiz.nl/fhir/StructureDefinition/zib-Wound |
| Wond | GET | R4 | /Condition?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/nl-core-Wound | http://nictiz.nl/fhir/StructureDefinition/nl-core-Wound |
| Woonsituatie | GET | STU3 | /Observation?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/zib-LivingSituation | http://nictiz.nl/fhir/StructureDefinition/zib-LivingSituation |
| Woonsituatie | GET | R4 | /Observation?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/nl-core-LivingSituation | http://nictiz.nl/fhir/StructureDefinition/nl-core-LivingSituation |
| Zorgaanbieder | GET | STU3 | /Organization?patient={patientId}&profile=http://fhir.nl/fhir/StructureDefinition/nl-core-organization | http://fhir.nl/fhir/StructureDefinition/nl-core-organization |
| Zorgaanbieder | GET | R4 | /Organization?patient={patientId}&profile=http://nictiz.nl/fhir/StructureDefinition/nl-core-HealthcareProvider-Organization | http://nictiz.nl/fhir/StructureDefinition/nl-core-HealthcareProvider-Organization |
| ZorgTeam | GET | STU3 | /CareTeam?patient={patientId}&_profile=http://fhir.nl/fhir/StructureDefinition/nl-core-careteam | http://fhir.nl/fhir/StructureDefinition/nl-core-careteam |
| ZorgTeam | GET | R4 | /CareTeam?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/nl-core-CareTeam | http://fhir.nl/fhir/StructureDefinition/nl-core-careteam |
| Zorgverlener | GET | STU3 | /PractitionerRole?patient={patientId}&_profile=http://fhir.nl/fhir/StructureDefinition/nl-core-practitionerrole<br>/Practitioner?patient={patientId}&_profile=http://fhir.nl/fhir/StructureDefinition/nl-core-practitioner | http://fhir.nl/fhir/StructureDefinition/nl-core-practitionerrole<br>http://fhir.nl/fhir/StructureDefinition/nl-core-practitioner<br>_choose PractitionerRole and/or Practitioner according to context_ |
| Zorgverlener | GET | R4 | /PractitionerRole?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/nl-core-HealthProfessional-PractitionerRole<br>/Practitioner?patient={patientId}&_profile=http://nictiz.nl/fhir/StructureDefinition/nl-core-HealthProfessional-Practitioner | http://nictiz.nl/fhir/StructureDefinition/nl-core-HealthProfessional-PractitionerRole<br>http://nictiz.nl/fhir/StructureDefinition/nl-core-HealthProfessional-Practitioner<br>_choose PractitionerRole and/or Practitioner according to context_ |

### CapabilityStatement

- Data holder organisations **MUST** publish a CapabilityStatement for each FHIR-server. 
- Data user organisations **MUST** only send requests to a data holder organisation's FHIR-server that conform to its CapabilityStatement.

### Pagination

- Data holder organisations **MUST** support pagination with a page size from `0` up to and including `100` via the parameter `_count`.
- Data user organisations **MAY** include a page size in resource queries via the parameter `_count` with a maximum value of 100.
- Data user organisations **MAY** include `_count=0` (or `_summary=count`) in queries to retrieve the total _number_ of resources that match the query

### Conformance to Zorginzage-specification

The 360° specifications conforms to sections 5.2 and 5.3 of [Volume 3 of the Zorginzage-specification](https://build.fhir.org/ig/nuts-foundation/nl-zorginzage-ig/vol3.html).

