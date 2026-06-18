### Relation to the zorginzage-specification

The zorginzage-specification is the foundation for the technical contents of this use case. This part of the guide will
focus only on those parts that divert from, or add to, the zorginzage-specification. Make sure you have read the
relevant implementation guide first.

https://nuts-foundation.github.io/nl-zorginzage-ig/

### Localisation

The national reference index ('nationale verwijsindex', 'NVI') is not yet launched at the time of writing. This limits the options for an indexed
pull scenario.

- An undirected BSN broadcast based on addressing information is not allowed
- If a legal basis is established between the data user organisation and a potential data holder organisation for the data exchange, the data user organisation is allowed to search for a patient at that potential data holder organisation.
- If a potential data holder organisation is member of a `CareTeam`-resource or another index registered at the data user organisation, the data user organisation is allowed to search for a patient at that potential data holder organisation

The mechanism of searching and retrieving the patient id is described in the zorginzage specification.

### Authorisation

During the data exchange the data holder organisation will only authorise the data user on organisation-level. The data user organisation MUST perform
authorisation for the health care professional and their role locally. The latter is a hard requirement, but there is no
technical enforcement during the data exchange.

The access policy at the data holder organisation for accessing data by another healthcare organisation enforces the following rules:

- The requesting organisation is identified by a `ura` and `facility_type`
- The requesting organisation has been authenticated successfully
- The requesting health care professional is identified by a `identifier` and a `role`
    - These attributes are locally defined by the requesting organisation
    - No further verification (cryptographically or content-wise) is performed

A FHIR capability statement is provided for this use case. The source will verify whether the request conforms to the capability
statement. In doing so, the source at least verifies the following properties:

- The interaction is allowed
- The request parameters are allowed
- The search includes are allowed
- The search reverse includes are allowed
- The data request is part of this specification

The zorginzage specification requires a patient context to be present, meaning that a patient identifier must be derived
from the request.

- /Patient/_search requests **MUST** contain a BSN identifier as specified in [Volume 3 of the Zorginzage-specification](https://nuts-foundation.github.io/nl-zorginzage-ig/vol3.html#patient-context).
- All other requests must be checked for a literal reference to the patient resource.
    - The rego policy for the specification will clarify which fields to use for each ZIB

The data holder organisation **MUST** verify the legal basis of the data exchange in at least one of these ways:

- Consent has been registered in Mitz
- The requesting organisation is part of the locally registered CareTeam
- The exchange has another non-technical legal basis (e.g. a GDPR data processing agreement between the requesting organisation and the data holder organisation)
