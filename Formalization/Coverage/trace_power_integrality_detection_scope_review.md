# Full source-scope review: weighted power-trace integrality

The root read the complete canonical Version3 statement and human proof,
then checked the actual exports and their mathematical types. Statement
SHA256: `4e6b332700408f644b684e87d20759783b78893c4f1af25cbb9a6e9acf2d72cf`.
Proof SHA256: `e0f0506c68f7855d2b5c6961975735d76855b6f76649f13cd3a88a48ad24fff9`.
The owner's detailed declaration mapping is
`Coverage/trace_power_integrality_detection.md`.

1. The weighted integrality criterion uses the actual valuation ring,
   its actual fraction field and residue map, and counts only maximal-pole
   residue cohorts. There is no additional total-degree or other-cohort
   restriction. Actual Vandermonde separation and Newton identities yield
   the conclusion. The arbitrary valuation-ring formulation contains the
   source's DVR scope and its stated d,r bounds.
2. The cohort restriction is sharp in the actual power-series DVR and
   Laurent fraction field. The p equal poles have every weighted moment
   integral and an actual entry outside the original ring.
3. The reciprocal criterion below degree 2p, and the exhaustive p/p
   boundary at degree 2p, are proved from actual unit norm and actual
   forward/reciprocal trace membership. The normalized boundary bridge
   constructs the actual DVR maximal-ideal height-one valuation, proves
   that its integer ring is precisely the original DVR, and normalizes an
   actual irreducible uniformizer to order one. Its integer order agrees
   with the actual additive valuation-order hom on every nonzero field unit.
   The outcome has an actual positive integer M, all entries nonzero,
   exactly p orders -M and p orders M, their exhaustive partition, actual
   scaled integral representatives with residue one, and the literal
   equality ord(e_p)=-pM with e_p nonzero. Thus the source's integer-order
   assertions are checked, rather than translated only in prose.
4. The full arbitrary-degree carry criterion and the shortened 2p+r
   criterion are necessary and sufficient. The induction takes place in
   the actual ring and requires residue characteristic only, preserving
   mixed characteristic. The degree-eleven/characteristic-five statement
   is an exact specialization, with e5 and the sixth power trace.
5. Actual power-series/Laurent tuples prove the carry indispensable even
   when every forward and reciprocal trace is retained. For each
   1<=i<=r<p, a genuine primitive-root orbit gives the individual omitted
   trace counterexample, retaining the carry and every other listed trace.
   Primitive-root existence and the actual pole are derived, not supplied
   as extra witness hypotheses. The tuple formulas and coefficient
   identities are symbolic; no coefficient enumeration is used.
6. The characteristic-five cubic model uses its actual split root family,
   unit v and tau, q, S, U, the actual polynomial identity, separability,
   S-degree bound and nonzero residue derivative. Factor units,
   nonzero denominators, residue cohort bounds and automatic first traces
   are derived. There is no distinct-residue-root assumption and no unit
   leading-coefficient assumption on D. The exact nine higher tests are
   equivalent to actual descent. Arbitrary integral numerator degree
   strengthens the stated degree-less-than-ten scope.
7. The genuine monic polynomial quotient embeds into the actual integral
   product algebra. Its image is the actual singly generated order.
   Lagrange interpolation and monic remainders prove Mathlib's actual
   conductor formula. The cubic unit factors give exactly the stated
   equivalence with the quotient class lying in that conductor.

All statements are local algebra. The actual-source disk application
requires exactly its supplied integral coordinate, unit v,t and nonzero
residue D inputs; tau=t^3 is a unit on that open. No conclusion about the
excluded endpoint charts, zero v, zero residue D, or global source
existence is included. No actual common-cover leg is replaced or inferred.

Every canonical clause is covered. No project conclusion or literature
axiom is introduced. The focused final root build and transitive audit
checked 226 Litt3 declarations, using only `Classical.choice`, `Quot.sound`
and `propext`, with zero forbidden dependencies and zero source changes.
Evidence:
`../../../litt3-computation-data/formalization-20261003/verification/20261003T011428Z/report.json`.
