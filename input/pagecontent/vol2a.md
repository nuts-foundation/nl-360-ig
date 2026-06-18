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
