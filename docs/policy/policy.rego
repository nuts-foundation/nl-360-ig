package zorginzage_360

import rego.v1

#
# This file implements the access policy for the 360° use case ("360-graden"), as
# specified by the nl-360-ig (https://nuts-foundation.github.io/nl-360-ig/).
#
# The 360° specification builds on the Zorginzage-specification and diverges from it as
# described in Volume 2 (authorisation) and Volume 3 (content / queries).
#
# Authorisation rules (Volume 2a):
#   - The request must conform to the FHIR CapabilityStatement (interaction, params,
#     (reverse) includes and profiles are verified by the data holder organisation before policy evaluation;
#     the data holder organisation signals this with `capability_checked == true`).
#   - Authorisation happens on organisation-level only. The requesting organisation is
#     identified by a `ura` and `facility_type` and MUST have been authenticated
#     successfully. The authentication itself is reused from the Zorginzage-specification
#     and is performed by the authentication layer before this policy runs; the source
#     asserts the authenticated organisation identity in `input.subject.organization.ura`,
#     which this policy requires to be present.
#   - The requesting health care professional is identified by an id and a role
#     (`input.subject.user.id` and `input.subject.user.role`). These are locally defined by
#     the requesting organisation and are not verified (cryptographically or content-wise);
#     authorisation of the professional and their role is performed locally and is out of
#     scope for the source. This policy only requires both to be present, for audit purposes.
#   - The data holder organisation MUST verify the legal basis of the exchange in at least one of these ways:
#       * consent has been registered in Mitz, or
#       * the requesting organisation is part of the locally registered CareTeam, or
#       * the exchange has another non-technical legal basis (e.g. a GDPR data processing
#         agreement). This last one cannot be established technically and is signalled to
#         the policy as context.
#   - A patient context MUST be derivable from the request:
#       * /Patient/_search requests MUST contain a BSN identifier.
#       * All other requests MUST contain a literal reference to the Patient resource.
#
# Input schema note:
#   For search interactions the targeted resource type is carried in
#   `input.action.fhir_rest.search_type` (a search has no single target instance).
#   `input.resource` is only populated for interactions that target a single resource
#   (e.g. a read), where `input.resource.type` names that resource's type.
#
# Content / queries (Volume 3):
#   Resources are retrieved based on their FHIR profile (`meta.profile`) through the
#   `_profile` search parameter, no longer based on SNOMED/LOINC codes. Each query accepts
#   an OR-list of profile canonicals (comma-separated): the R4 `nl-core`/`mp-` profile and
#   the STU3 `zib2017` profile. Canonicals are matched without `|version` so all published
#   versions of a profile match.
#

default allow := false

allow if {
	request_conforms_fhir_capabilitystatement
	requester_organization_authenticated
	requester_practitioner_identified
	has_legal_basis

	# The 360° specification requires every request to be scoped to a patient. A patient
	# context must be derivable from the request (a patient_id or patient_bsn); the
	# per-query rules additionally enforce the literal reference / BSN in the query itself.
	has_patient_identifier
	is_allowed_query
}

# --- Authorisation preconditions ---------------------------------------------------------

default request_conforms_fhir_capabilitystatement := false

request_conforms_fhir_capabilitystatement if {
	input.action.fhir_rest.capability_checked == true
}

# The requesting organisation must have been authenticated. The authentication layer asserts
# the authenticated organisation identity (its URA) in input.subject.organization.ura; we
# require it to be present and non-empty.
default requester_organization_authenticated := false

requester_organization_authenticated if {
	is_string(input.subject.organization.ura)
	input.subject.organization.ura != ""
}

# The requesting health care professional MUST be identified by an id and a role. These are
# locally defined by the requesting organisation and are not verified further; we only require
# both to be present (non-empty) so the exchange can be audited.
default requester_practitioner_identified := false

requester_practitioner_identified if {
	is_string(input.subject.user.id)
	input.subject.user.id != ""
	is_string(input.subject.user.role)
	input.subject.user.role != ""
}

# The legal basis of the exchange, verified in at least one of the three allowed ways.
default has_legal_basis := false

has_legal_basis if {
	input.context.mitz_consent == true
}

has_legal_basis if {
	# The requesting organisation is part of the locally registered CareTeam.
	input.context.local_careteam_member == true
}

has_legal_basis if {
	# Another, non-technical legal basis exists (e.g. a GDPR data processing agreement).
	input.context.other_legal_basis == true
}

# A patient context must be derivable from the request.
default has_patient_identifier := false

has_patient_identifier if {
	is_string(input.context.patient_id)
	input.context.patient_id != ""
}

has_patient_identifier if {
	is_string(input.context.patient_bsn)
	input.context.patient_bsn != ""
}

# The non-Patient queries must carry a literal reference to the Patient resource
# (e.g. patient=Patient/123). See Volume 2a, "Authorisation".
default has_patient_reference := false

has_patient_reference if {
	is_string(input.context.patient_id)
	input.context.patient_id != ""
	startswith(input.action.fhir_rest.search_params.patient[0][0], "Patient/")
}

# --- Query helpers -----------------------------------------------------------------------

# The set of profile canonicals requested through the `_profile` search parameter.
# `_profile=A,B` is a single OR-group [["A", "B"]]; `_profile=A&_profile=B` is [["A"], ["B"]].
# Either way, every requested canonical must be allowed for the resource type.
requested_profiles := {p |
	some group in input.action.fhir_rest.search_params._profile
	some p in group
}

# The set of (reverse) includes requested through _include / _revinclude.
requested_includes := {i | some i in input.action.fhir_rest.include}

# Holds if at least one profile was requested and every requested profile is allowed.
profiles_allowed(allowed) if {
	count(requested_profiles) > 0
	count(requested_profiles - allowed) == 0
}

# Holds if every requested include is allowed (an empty allowed set only permits no includes).
includes_allowed(allowed) if {
	count(requested_includes - allowed) == 0
}

# --- Allowed queries ---------------------------------------------------------------------

default is_allowed_query := false

# Generic profile-based query: GET [base]/{ResourceType}?patient={ref}&_profile={canonicals}
# The resource type must have an entry in profiles_by_type, every requested profile must be
# allowed for that type, every requested include must be allowed, and the request must carry
# a literal patient reference.
is_allowed_query if {
	input.action.fhir_rest.interaction_type == "search-type"
	allowed_profiles := profiles_by_type[input.action.fhir_rest.search_type]
	profiles_allowed(allowed_profiles)
	includes_allowed(object.get(includes_by_type, input.action.fhir_rest.search_type, set()))
	has_patient_reference
}

# POST [base]/Patient/_search with a BSN identifier (Patient Context).
# See Volume 2a: /Patient/_search requests MUST contain a BSN identifier.
is_allowed_query if {
	input.action.fhir_rest.interaction_type == "search-type"
	input.action.fhir_rest.search_type == "Patient"
	is_string(input.context.patient_bsn)
	input.context.patient_bsn != ""
	startswith(input.action.fhir_rest.search_params.identifier[0][0], "http://fhir.nl/fhir/NamingSystem/bsn|")
}

# Correspondentie: GET [base]/DocumentReference?patient={ref}&status=current
# This zib is selected by status rather than by _profile.
is_allowed_query if {
	input.action.fhir_rest.interaction_type == "search-type"
	input.action.fhir_rest.search_type == "DocumentReference"
	input.action.fhir_rest.search_params.status == [["current"]]
	has_patient_reference
}

# Correspondentie: read the DocumentReference that was found above ("and then follow the reference").
# A read interaction targets a single resource, so the type comes from input.resource.type.
is_allowed_query if {
	input.action.fhir_rest.interaction_type == "read"
	input.resource.type == "DocumentReference"
}

# --- Data set definitions (Volume 3) -----------------------------------------------------

# Allowed `_profile` canonicals per resource type. Both the R4 (nl-core / mp-) canonical and
# the STU3 zib2017 canonical are listed so a query using either (or both, OR-listed) matches.
profiles_by_type := {
	"Observation": {
		# Ademhaling (retired in zib2020 (R4); STU3 zib2017 only)
		"http://nictiz.nl/fhir/StructureDefinition/zib-Respiration",
		# AlcoholGebruik
		"http://nictiz.nl/fhir/StructureDefinition/nl-core-AlcoholUse",
		"http://nictiz.nl/fhir/StructureDefinition/zib-AlcoholUse",
		# Bloeddruk
		"http://nictiz.nl/fhir/StructureDefinition/nl-core-BloodPressure",
		"http://nictiz.nl/fhir/StructureDefinition/zib-BloodPressure",
		# Darmfunctie
		"http://nictiz.nl/fhir/StructureDefinition/nl-core-BowelFunction",
		"http://nictiz.nl/fhir/StructureDefinition/zib-BowelFunction",
		# Gezinssituatie (retired in zib2020 (R4); STU3 zib2017 only)
		"http://nictiz.nl/fhir/StructureDefinition/zib-FamilySituation",
		# Hartfrequentie
		"http://nictiz.nl/fhir/StructureDefinition/nl-core-HeartRate",
		"http://nictiz.nl/fhir/StructureDefinition/zib-HeartRate",
		# LaboratoriumUitslag
		"http://nictiz.nl/fhir/StructureDefinition/nl-core-LaboratoryTestResult",
		"http://nictiz.nl/fhir/StructureDefinition/zib-LaboratoryTestResult-Observation",
		# Lichaamsgewicht
		"http://nictiz.nl/fhir/StructureDefinition/nl-core-BodyWeight",
		"http://nictiz.nl/fhir/StructureDefinition/zib-BodyWeight",
		# Lichaamslengte
		"http://nictiz.nl/fhir/StructureDefinition/nl-core-BodyHeight",
		"http://nictiz.nl/fhir/StructureDefinition/zib-BodyHeight",
		# Lichaamstemperatuur
		"http://nictiz.nl/fhir/StructureDefinition/nl-core-BodyTemperature",
		"http://nictiz.nl/fhir/StructureDefinition/zib-BodyTemperature",
		# Mobiliteit
		"http://nictiz.nl/fhir/StructureDefinition/nl-core-Mobility",
		"http://nictiz.nl/fhir/StructureDefinition/zib-Mobility",
		# O2Saturatie
		"http://nictiz.nl/fhir/StructureDefinition/nl-core-O2Saturation",
		"http://nictiz.nl/fhir/StructureDefinition/zib-OxygenSaturation",
		# PartipatieInMaatschappij
		"http://nictiz.nl/fhir/StructureDefinition/nl-core-ParticipationInSociety",
		"http://nictiz.nl/fhir/StructureDefinition/zib-ParticipationInSociety",
		# Polsfrequentie
		"http://nictiz.nl/fhir/StructureDefinition/nl-core-PulseRate",
		"http://nictiz.nl/fhir/StructureDefinition/zib-PulseRate",
		# SNAQ65+score
		"http://nictiz.nl/fhir/StructureDefinition/nl-core-SNAQ65plusScore",
		"http://nictiz.nl/fhir/StructureDefinition/zib-SNAQ65plusScore",
		# SNAQRCscore
		"http://nictiz.nl/fhir/StructureDefinition/nl-core-SNAQrcScore",
		"http://nictiz.nl/fhir/StructureDefinition/zib-SNAQrcScore",
		# VermogenTotDrinken
		"http://nictiz.nl/fhir/StructureDefinition/nl-core-AbilityToDrink",
		"http://nictiz.nl/fhir/StructureDefinition/zib-AbilityToDrink",
		# VermogenTotEten
		"http://nictiz.nl/fhir/StructureDefinition/nl-core-AbilityToEat",
		"http://nictiz.nl/fhir/StructureDefinition/zib-AbilityToEat",
		# VermogenTotMondverzorging
		"http://nictiz.nl/fhir/StructureDefinition/nl-core-AbilityToPerformMouthcareActivities",
		"http://nictiz.nl/fhir/StructureDefinition/zib-AbilityToPerformMouthcareActivities",
		# VermogenTotUiterlijkeVerzorging
		"http://nictiz.nl/fhir/StructureDefinition/nl-core-AbilityToGroom",
		"http://nictiz.nl/fhir/StructureDefinition/zib-AbilityToGroome",
		# VermogenTotVerpleegtechnischeHandelingen (retired in zib2020 (R4); STU3 zib2017 only)
		"http://nictiz.nl/fhir/StructureDefinition/zib-AbilityToPerformNursingActivities",
		# VermogenTotZelfstandigMedicatiegebruik (retired in zib2020 (R4); STU3 zib2017 only)
		"http://nictiz.nl/fhir/StructureDefinition/zib-AbilityToManageMedication",
		# VermogenTotZichKleden
		"http://nictiz.nl/fhir/StructureDefinition/nl-core-AbilityToDressOneself",
		"http://nictiz.nl/fhir/StructureDefinition/zib-AbilityToDressOneself",
		# VermogenTotZichWassen
		"http://nictiz.nl/fhir/StructureDefinition/nl-core-AbilityToWashOneself",
		"http://nictiz.nl/fhir/StructureDefinition/zib-AbilityToWashOneSelf",
		# Woonsituatie
		"http://nictiz.nl/fhir/StructureDefinition/nl-core-LivingSituation",
		"http://nictiz.nl/fhir/StructureDefinition/zib-LivingSituation",
	},
	"Flag": {
		# Alert
		"http://nictiz.nl/fhir/StructureDefinition/nl-core-Alert",
		"http://nictiz.nl/fhir/StructureDefinition/zib-Alert",
	},
	"AllergyIntolerance": {
		# AllergieIntolerantie
		"http://nictiz.nl/fhir/StructureDefinition/nl-core-AllergyIntolerance",
		"http://nictiz.nl/fhir/StructureDefinition/zib-AllergyIntolerance",
	},
	"Consent": {
		# BehandelAanwijzing
		"http://nictiz.nl/fhir/StructureDefinition/nl-core-TreatmentDirective2",
		"http://nictiz.nl/fhir/StructureDefinition/zib-TreatmentDirective",
		# Wilsverklaring
		"http://nictiz.nl/fhir/StructureDefinition/nl-core-AdvanceDirective",
		"http://nictiz.nl/fhir/StructureDefinition/zib-AdvanceDirective",
	},
	"Goal": {
		# Behandeldoel
		"http://nictiz.nl/fhir/StructureDefinition/nl-core-TreatmentObjective",
		"http://nictiz.nl/fhir/StructureDefinition/zib-TreatmentObjective",
	},
	"Coverage": {
		# Betaler
		"http://nictiz.nl/fhir/StructureDefinition/nl-core-Payer.InsuranceCompany",
		"http://nictiz.nl/fhir/StructureDefinition/zib-Payer",
	},
	"Encounter": {
		# Contact
		"http://nictiz.nl/fhir/StructureDefinition/nl-core-Encounter",
		"http://nictiz.nl/fhir/StructureDefinition/zib-Encounter",
	},
	"Condition": {
		# DecubitusWond
		"http://nictiz.nl/fhir/StructureDefinition/nl-core-PressureUlcer",
		"http://nictiz.nl/fhir/StructureDefinition/zib-PressureUlcer",
		# Huidaandoening
		"http://nictiz.nl/fhir/StructureDefinition/nl-core-SkinDisorder",
		"http://nictiz.nl/fhir/StructureDefinition/zib-SkinDisorder",
		# Probleem
		"http://nictiz.nl/fhir/StructureDefinition/nl-core-Problem",
		"http://nictiz.nl/fhir/StructureDefinition/zib-Problem",
		# Wond
		"http://nictiz.nl/fhir/StructureDefinition/nl-core-Wound",
		"http://nictiz.nl/fhir/StructureDefinition/zib-Wound",
	},
	"MedicationRequest": {
		# Medicatieafspraak (R4 from nictiz.fhir.nl.r4.medicationprocess9)
		"http://nictiz.nl/fhir/StructureDefinition/mp-MedicationAgreement",
		"http://nictiz.nl/fhir/StructureDefinition/zib-MedicationAgreement",
	},
	"MedicationStatement": {
		# MedicatieGebruik2 (R4 from nictiz.fhir.nl.r4.medicationprocess9)
		"http://nictiz.nl/fhir/StructureDefinition/mp-MedicationUse2",
		"http://nictiz.nl/fhir/StructureDefinition/zib-MedicationUse",
	},
	"MedicationDispense": {
		# Toedieningsafspraak (R4 from nictiz.fhir.nl.r4.medicationprocess9)
		"http://nictiz.nl/fhir/StructureDefinition/mp-AdministrationAgreement",
		"http://nictiz.nl/fhir/StructureDefinition/zib-AdministrationAgreement",
	},
	"DeviceUseStatement": {
		# MedischHulpmiddel
		"http://nictiz.nl/fhir/StructureDefinition/nl-core-MedicalDevice",
		"http://nictiz.nl/fhir/StructureDefinition/zib-MedicalDevice",
	},
	"Immunization": {
		# Vaccinatie
		"http://nictiz.nl/fhir/StructureDefinition/nl-core-Vaccination-event",
		"http://nictiz.nl/fhir/StructureDefinition/zib-Vaccination",
	},
	"Composition": {
		# SOEPVerslag (2020)
		"http://nictiz.nl/fhir/StructureDefinition/nl-core-SOAPReport",
		"http://nictiz.nl/fhir/StructureDefinition/gp-EncounterReport",
	},
	"DiagnosticReport": {
		# TekstUitslag
		"http://nictiz.nl/fhir/StructureDefinition/nl-core-TextResult",
		"http://nictiz.nl/fhir/StructureDefinition/zib-TextResult",
	},
	"Procedure": {
		# Verrichting
		"http://nictiz.nl/fhir/StructureDefinition/nl-core-Procedure-event",
		"http://nictiz.nl/fhir/StructureDefinition/zib-Procedure",
		# VrijheidsbeperkendeMaatregelen
		"http://nictiz.nl/fhir/StructureDefinition/nl-core-FreedomRestrictingIntervention",
		"http://nictiz.nl/fhir/StructureDefinition/zib-FreedomRestrictingMeasures",
	},
	"NutritionOrder": {
		# Voedingsadvies
		"http://nictiz.nl/fhir/StructureDefinition/nl-core-NutritionAdvice",
		"http://nictiz.nl/fhir/StructureDefinition/zib-NutritionAdvice",
	},
	"CareTeam": {
		# ZorgTeam
		"http://nictiz.nl/fhir/StructureDefinition/nl-core-CareTeam",
		"http://fhir.nl/fhir/StructureDefinition/nl-core-careteam",
	},
}

# Allowed (reverse) includes per resource type, as listed in the Volume 3 endpoints.
includes_by_type := {
	"Coverage": {"Coverage:payor:Patient", "Coverage:payor:Organization"},
	"MedicationRequest": {"MedicationRequest:medication"},
	"MedicationStatement": {"MedicationStatement:medication"},
	"MedicationDispense": {"MedicationDispense:medication"},
	"DeviceUseStatement": {"DeviceUseStatement:device"},
	"CareTeam": {"CareTeam:participant"},
}
