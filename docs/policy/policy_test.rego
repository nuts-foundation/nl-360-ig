package zorginzage_360_test

import rego.v1

import data.zorginzage_360

# A baseline valid request: a profile-based search (Bloeddruk / Observation) that passes all
# preconditions. Individual tests override parts of this with object.union.
# For search interactions the targeted resource type lives in action.fhir_rest.search_type;
# input.resource is only used for single-resource interactions such as a read.
base_input := {
	"action": {"fhir_rest": {
		"capability_checked": true,
		"interaction_type": "search-type",
		"search_type": "Observation",
		"include": [],
		"search_params": {
			"patient": [["Patient/123"]],
			"_profile": [[
				"http://nictiz.nl/fhir/StructureDefinition/nl-core-BloodPressure",
				"http://nictiz.nl/fhir/StructureDefinition/zib-BloodPressure",
			]],
		},
	}},
	"context": {
		"mitz_consent": true,
		"patient_id": "Patient/123",
		"patient_bsn": "",
	},
	"subject": {
		"organization": {"ura": "00001234"},
		"user": {"id": "practitioner-42", "role": "01.015"},
	},
}

# --- Precondition tests ------------------------------------------------------------------

test_deny_without_capability_checked if {
	not zorginzage_360.allow with input as object.union(base_input, {
		"action": {"fhir_rest": {"capability_checked": false}},
	})
}

test_deny_without_authenticated_organisation if {
	not zorginzage_360.allow with input as object.union(base_input, {
		"subject": {"organization": {"ura": ""}},
	})
}

test_deny_without_practitioner_id if {
	not zorginzage_360.allow with input as object.union(base_input, {
		"subject": {"user": {"id": "", "role": "01.015"}},
	})
}

test_deny_without_practitioner_role if {
	not zorginzage_360.allow with input as object.union(base_input, {
		"subject": {"user": {"id": "practitioner-42", "role": ""}},
	})
}

test_deny_without_legal_basis if {
	not zorginzage_360.allow with input as object.union(base_input, {"context": {
		"mitz_consent": false,
		"local_careteam_member": false,
		"other_legal_basis": false,
	}})
}

# Legal basis: CareTeam membership is an accepted alternative to Mitz consent.
test_allow_with_local_careteam_member if {
	zorginzage_360.allow with input as object.union(base_input, {"context": {
		"mitz_consent": false,
		"local_careteam_member": true,
	}})
}

# Legal basis: another non-technical basis is an accepted alternative.
test_allow_with_other_legal_basis if {
	zorginzage_360.allow with input as object.union(base_input, {"context": {
		"mitz_consent": false,
		"other_legal_basis": true,
	}})
}

test_deny_without_patient_reference if {
	not zorginzage_360.allow with input as object.union(base_input, {
		"context": {"patient_id": ""},
		"action": {"fhir_rest": {"search_params": {
			"patient": [[""]],
			"_profile": [["http://nictiz.nl/fhir/StructureDefinition/zib-BloodPressure"]],
		}}},
	})
}

test_deny_when_patient_reference_not_literal if {
	# A search token instead of a literal Patient/ reference must be rejected.
	not zorginzage_360.allow with input as object.union(base_input, {
		"action": {"fhir_rest": {"search_params": {
			"patient": [["http://fhir.nl/fhir/NamingSystem/bsn|999999990"]],
			"_profile": [["http://nictiz.nl/fhir/StructureDefinition/zib-BloodPressure"]],
		}}},
	})
}

# --- Profile-based query tests -----------------------------------------------------------

# Bloeddruk with both R4 and STU3 canonicals OR-listed.
test_allow_observation_bloeddruk if {
	zorginzage_360.allow with input as base_input
}

# A single canonical (only the STU3 zib2017 profile) is also accepted.
test_allow_observation_single_profile if {
	zorginzage_360.allow with input as object.union(base_input, {
		"action": {"fhir_rest": {"search_params": {
			"patient": [["Patient/123"]],
			"_profile": [["http://nictiz.nl/fhir/StructureDefinition/zib-BloodPressure"]],
		}}},
	})
}

# A retired-in-R4 zib (Ademhaling) queried with its STU3-only canonical.
test_allow_observation_retired_profile if {
	zorginzage_360.allow with input as object.union(base_input, {
		"action": {"fhir_rest": {"search_params": {
			"patient": [["Patient/123"]],
			"_profile": [["http://nictiz.nl/fhir/StructureDefinition/zib-Respiration"]],
		}}},
	})
}

test_allow_condition_probleem if {
	zorginzage_360.allow with input as object.union(base_input, {
		"action": {"fhir_rest": {
			"search_type": "Condition",
			"search_params": {
				"patient": [["Patient/123"]],
				"_profile": [[
					"http://nictiz.nl/fhir/StructureDefinition/nl-core-Problem",
					"http://nictiz.nl/fhir/StructureDefinition/zib-Problem",
				]],
			},
		}},
	})
}

test_allow_allergy_intolerance if {
	zorginzage_360.allow with input as object.union(base_input, {
		"action": {"fhir_rest": {
			"search_type": "AllergyIntolerance",
			"search_params": {
				"patient": [["Patient/123"]],
				"_profile": [[
					"http://nictiz.nl/fhir/StructureDefinition/nl-core-AllergyIntolerance",
					"http://nictiz.nl/fhir/StructureDefinition/zib-AllergyIntolerance",
				]],
			},
		}},
	})
}

# --- Include tests -----------------------------------------------------------------------

# Medicatieafspraak: MedicationRequest with _include=MedicationRequest:medication.
test_allow_medication_request_with_include if {
	zorginzage_360.allow with input as object.union(base_input, {
		"action": {"fhir_rest": {
			"search_type": "MedicationRequest",
			"include": ["MedicationRequest:medication"],
			"search_params": {
				"patient": [["Patient/123"]],
				"_profile": [[
					"http://nictiz.nl/fhir/StructureDefinition/mp-MedicationAgreement",
					"http://nictiz.nl/fhir/StructureDefinition/zib-MedicationAgreement",
				]],
			},
		}},
	})
}

# Betaler: Coverage with both payor includes (order-independent).
test_allow_coverage_with_includes_reversed if {
	zorginzage_360.allow with input as object.union(base_input, {
		"action": {"fhir_rest": {
			"search_type": "Coverage",
			"include": ["Coverage:payor:Organization", "Coverage:payor:Patient"],
			"search_params": {
				"patient": [["Patient/123"]],
				"_profile": [[
					"http://nictiz.nl/fhir/StructureDefinition/nl-core-Payer.InsuranceCompany",
					"http://nictiz.nl/fhir/StructureDefinition/zib-Payer",
				]],
			},
		}},
	})
}

# ZorgTeam: CareTeam with _include=CareTeam:participant and the fhir.nl STU3 canonical.
test_allow_careteam_with_include if {
	zorginzage_360.allow with input as object.union(base_input, {
		"action": {"fhir_rest": {
			"search_type": "CareTeam",
			"include": ["CareTeam:participant"],
			"search_params": {
				"patient": [["Patient/123"]],
				"_profile": [[
					"http://nictiz.nl/fhir/StructureDefinition/nl-core-CareTeam",
					"http://fhir.nl/fhir/StructureDefinition/nl-core-careteam",
				]],
			},
		}},
	})
}

test_deny_disallowed_include if {
	not zorginzage_360.allow with input as object.union(base_input, {
		"action": {"fhir_rest": {
			"search_type": "MedicationRequest",
			"include": ["MedicationRequest:requester"],
			"search_params": {
				"patient": [["Patient/123"]],
				"_profile": [["http://nictiz.nl/fhir/StructureDefinition/zib-MedicationAgreement"]],
			},
		}},
	})
}

# An include on a resource type that allows none must be rejected.
test_deny_include_on_type_without_includes if {
	not zorginzage_360.allow with input as object.union(base_input, {
		"action": {"fhir_rest": {
			"include": ["Observation:performer"],
			"search_params": {
				"patient": [["Patient/123"]],
				"_profile": [["http://nictiz.nl/fhir/StructureDefinition/zib-BloodPressure"]],
			},
		}},
	})
}

# --- Patient context (BSN search) --------------------------------------------------------

test_allow_patient_search_with_bsn if {
	zorginzage_360.allow with input as object.union(base_input, {
		"context": {"patient_id": "", "patient_bsn": "999999990"},
		"action": {"fhir_rest": {
			"search_type": "Patient",
			"include": [],
			"search_params": {"identifier": [["http://fhir.nl/fhir/NamingSystem/bsn|999999990"]]},
		}},
	})
}

test_deny_patient_search_without_bsn if {
	not zorginzage_360.allow with input as object.union(base_input, {
		"context": {"patient_id": "Patient/123", "patient_bsn": ""},
		"action": {"fhir_rest": {
			"search_type": "Patient",
			"include": [],
			"search_params": {"identifier": [["http://example.com/other|123"]]},
		}},
	})
}

# --- Correspondentie (DocumentReference) -------------------------------------------------

test_allow_document_reference_search_current if {
	zorginzage_360.allow with input as object.union(base_input, {
		"action": {"fhir_rest": {
			"search_type": "DocumentReference",
			"include": [],
			"search_params": {
				"patient": [["Patient/123"]],
				"status": [["current"]],
			},
		}},
	})
}

# A read targets a single resource, so the resource type comes from input.resource.type.
test_allow_document_reference_read if {
	zorginzage_360.allow with input as object.union(base_input, {
		"resource": {"type": "DocumentReference"},
		"action": {"fhir_rest": {
			"interaction_type": "read",
			"include": [],
			"search_params": {},
		}},
	})
}

test_deny_document_reference_wrong_status if {
	not zorginzage_360.allow with input as object.union(base_input, {
		"action": {"fhir_rest": {
			"search_type": "DocumentReference",
			"include": [],
			"search_params": {
				"patient": [["Patient/123"]],
				"status": [["superseded"]],
			},
		}},
	})
}

# --- Deny tests --------------------------------------------------------------------------

test_deny_unknown_resource_type if {
	not zorginzage_360.allow with input as object.union(base_input, {
		"action": {"fhir_rest": {
			"search_type": "UnknownResource",
			"search_params": {
				"patient": [["Patient/123"]],
				"_profile": [["http://example.com/unknown"]],
			},
		}},
	})
}

# A profile that does not belong to the requested resource type must be rejected.
test_deny_profile_for_wrong_resource_type if {
	not zorginzage_360.allow with input as object.union(base_input, {
		"action": {"fhir_rest": {
			"search_type": "Condition",
			"search_params": {
				"patient": [["Patient/123"]],
				"_profile": [["http://nictiz.nl/fhir/StructureDefinition/zib-BloodPressure"]],
			},
		}},
	})
}

# Mixing an allowed and a disallowed profile is rejected (every requested profile must be allowed).
test_deny_partially_disallowed_profiles if {
	not zorginzage_360.allow with input as object.union(base_input, {
		"action": {"fhir_rest": {"search_params": {
			"patient": [["Patient/123"]],
			"_profile": [[
				"http://nictiz.nl/fhir/StructureDefinition/zib-BloodPressure",
				"http://nictiz.nl/fhir/StructureDefinition/zib-Problem",
			]],
		}}},
	})
}

# A profile-based search without any _profile parameter is rejected.
# Built as a full literal (not object.union) because object.union deep-merges maps and would
# otherwise retain the base _profile parameter.
test_deny_search_without_profile if {
	not zorginzage_360.allow with input as {
		"action": {"fhir_rest": {
			"capability_checked": true,
			"interaction_type": "search-type",
			"search_type": "Observation",
			"include": [],
			"search_params": {"patient": [["Patient/123"]]},
		}},
		"context": {"mitz_consent": true, "patient_id": "Patient/123", "patient_bsn": ""},
		"subject": {
			"organization": {"ura": "00001234"},
			"user": {"id": "practitioner-42", "role": "01.015"},
		},
	}
}

test_deny_wrong_interaction_type if {
	not zorginzage_360.allow with input as object.union(base_input, {
		"action": {"fhir_rest": {"interaction_type": "create"}},
	})
}
