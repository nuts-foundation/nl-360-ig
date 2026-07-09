### Relation to the zorginzage-specification

The zorginzage-specification is the foundation for the technical contents of this use case. This part of the guide will
focus only on those parts that divert from, or add to, the zorginzage-specification. Make sure you have read the
relevant implementation guide first.

https://nuts-foundation.github.io/nl-zorginzage-ig/

### Authentication

The 360-specification reuses the authentication specifications of the Zorginzage-specification.

### Localisation

The national reference index ('nationale verwijsindex', 'NVI') is not yet launched at the time of writing. This limits the options for an indexed
pull scenario.

- An undirected BSN broadcast based on addressing information is not allowed
- If a legal basis is established between the data user organisation and a potential data holder organisation for the data exchange, the data user organisation is allowed to search for a patient at that potential data holder organisation.
- If a potential data holder organisation is member of a `CareTeam`-resource or another index registered at the data user organisation, the data user organisation is allowed to search for a patient at that potential data holder organisation

The mechanism of searching and retrieving the patient id is described in the zorginzage specification.

### Addressing

The 360-specification reuses the addressing specifications of the Zorginzage-specification. The following changes or additions are applied:
- The 360-specification uses the following use-case-identifier `360-graden`.
- The 360-specification does not use one fhir base url but two separate fhir base url's:
    - `fhir_base_url_stu3` for FHIR-endpoint that use FHIR version STU3
    - `fhir_base_url_r4` for FHIR-endpoint that use FHIR version R4
- data holder organisations MUST register at least one of `fhir_base_url_stu3` and `fhir_base_url_r4` at the discovery service. This is not checked technically by the Discovery Service.
- Discovery service presentation definitions:
    - Ontwikkel: TO DO URL GITHUB
    - Test: TO DO URL GITHUB
    - Acceptatie: TO DO URL GITHUB
    - Productie: TO DO URL GITHUB

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
  
OAuth presentation definitions:
- Ontwikkel: TO DO URL GITHUB
- Test: TO DO URL GITHUB
- Acceptatie: TO DO URL GITHUB
- Productie: TO DO URL GITHUB

### Performance Considerations

This specification does not impose hard real-time guarantees on the data exchange. The
following performance expectations apply, in line with the functional design:

- A data holder organisation **SHOULD** return a response for a single resource query
  within 4 seconds.
- Retrieving a complete data set **SHOULD** complete within 30 seconds.
- These figures are expectations, not enforced service levels. There is no technical
  enforcement of response times during the data exchange.

Because the data exchange consists solely of read operations, the data holder
organisation can horizontally scale to serve concurrent requests. The data user
organisation **SHOULD** exploit this by issuing the individual requests of a data set
in parallel rather than sequentially.

The data user organisation **SHOULD** apply a timeout of 60 seconds to each individual
request. A data holder organisation that cannot meet these expectations for a given
request **SHOULD** still return a valid FHIR response rather than failing silently.

To protect the data holder organisation against repeated identical requests, the data
user organisation **SHOULD** cache a retrieved response and reuse it rather than
re-requesting the same data. The same resource **SHOULD NOT** be refetched more than
once every 5 minutes **for the same user session**.

Consistent with the principle that the data holder organisation remains the
authoritative source, cached data **MUST NOT** be retained beyond the active viewing
session, and in any case **MUST** be discarded within 15 minutes of retrieval. The data
user organisation **MUST NOT** store the retrieved data as a durable copy.

### Audit Trail

The data holder organisation **MUST** keep an audit trail of the data exchange in
conformance with NEN 7513, the Dutch standard for logging actions on electronic health records.

At a minimum, the data holder organisation **MUST** log the following events:

- Each access token request
- Each access token introspection
- Each data request

For every logged event, the audit record **MUST** capture at least:

- The time of the event
- The requesting organisation, identified by `ura` and `facility_type`
- The requesting health care professional, identified by `identifier` and `role`
- The patient whose data is concerned
- The interaction and resource(s) requested

Together these records **MUST** make it possible to reconstruct who requested what, when,
and on whose behalf.

The data user organisation **MUST** likewise keep an audit trail in conformance with NEN
7513 for its local access to the retrieved data, recording which health care professional
accessed which patient's data and when. This complements the local authorisation of the
health care professional, which is a hard requirement of this specification.

Audit records describe the access, not its content. The clinical content of the exchanged
resources **MUST NOT** be written to the audit trail or to any other operational log; the
audit trail records only references to the resources and the identifiers described above.
Both organisations **MUST** ensure that patient data does not leak through logs, error
messages, or request URLs.

To avoid storing BSNs in the audit trail, both organisations **SHOULD** record the patient
by the FHIR Patient logical id used in the data exchange rather than by BSN. This
identifier is assigned by the data holder organisation and already resolves to the patient
through the existing FHIR store, so all events concerning the same patient can be
correlated, and re-identification remains possible for legitimate audit purposes.

### Lineage

The origin of every resource shown in the 360-overview is required to always be traceable.
For each shown resource, the following **MUST** be available to the data user organisation:

- **The data holder** — the care organisation the resource originates from.
- **The date** — the date on which the resource was registered in the source.
- **The role or persona of the registering health care professional**, when the
  underlying zib supports this.

The following technical specifications are used to convey this lineage:

- **Data holder.** The data holder is identified by the exchange context: each resource is
  attributed to the `ura` of the endpoint it was retrieved from. The data user
  organisation **MUST** preserve this attribution when aggregating data from multiple data
  holders into a single overview.
- **Date.** The registration date of the resource in the source **SHOULD** be used,
  conveyed through the `.meta.lastUpdated` element of the resource. Where a zib provides a dedicated recorded
  date, that element **MAY** be used instead.
- **Role or persona.** For a number of zibs, the registering professional is referenced from the zib (for example via
  `performer`, `recorder`, `author` or `asserter`). Their role **SHOULD** be conveyed
  through the referenced `PractitionerRole.code`, or an equivalent resource-specific role
  element.

For administrative data (such as contact registration or correspondence) a person name —
and where relevant contact details such as an email address or telephone number — **MAY**
be shown. For clinical data, the role or function of the registering professional is
sufficient.

Full traceability to the individual professional who registered a resource is **not** part of
the data availability offered through the 360° specification. It is safeguarded by the NEN7513-conforming
logging in the data holder's source systems. A data user that needs this information can
request it from the data holder.

