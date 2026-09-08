# Inertia refinement audit

Verdict: PASS, with nonbreaking presentation clarifications below.
Auditor: /root/audit_inertia_refinement_medium. Date: 2026-09-08.
Scope: version 1 of
[the theorem](../../Theorems/Thm_inertia_generated_core_preserving_refinement.md)
and [its proof](../../Solutions/Sol_inertia_generated_core_preserving_refinement.md),
especially the new inertia/disjointness argument, perfect-group root
descent, and fixed degree168 construction. This is a bounded independent
prose audit, not Lean verification or a new audit of all dependencies.

The actual original inclusions K,L into M are retained throughout.
An intermediate field of the original finite etale curve cover gives
an etale intermediate curve cover, even when the original cover is
not Galois. Normal generation by inertia therefore forces K' intersect
M=K and L' intersect M=L. The auxiliary Galois hypotheses then give
linear disjointness and surjective restriction from Gal(MK'L'/M).
Its fixed fields on K' and L' are the original K and L. The finite
group orbit polynomial on their intersection proves the asserted
corelessness. No simultaneous Galois closure of the original legs
is used or required.

The local argument is valid for normalized components: original etale
maps identify completed base fields, and matched auxiliary completed
fields have the same compositum. Thus both upper maps are etale on
the same source. Auxiliary Galois normality makes the matching
independent of conjugate embedding choices. In the tame case over an
algebraically closed residue field, the prescribed index determines
the local subfield. Equal indices alone would not justify a wild
extension of the corollary; the theorem explicitly avoids that error.

Perfectness correctly prevents a primitive-weight drop. If s=t^m
upstairs, m divides the original prime-to-characteristic weight.
The coefficient root in either auxiliary field generates a cyclic
Galois intermediate extension, since all m-th roots of unity are in k.
This extension is trivial for a perfect auxiliary group. The descended
rational tensor is regular because its m-th power is the original
regular tensor; regularity is not incorrectly inferred from ramified
pullback alone. The two descended roots agree on the actual Z up to
a scalar root of unity, contradicting primitivity if m>1.

I independently read [SGA1 XIII Corollary2.12 and its proof](https://arxiv.org/pdf/math/0206203),
printed pages290--292, PDF indices305--307. It supplies the required
prime-to-five finite quotient with the specified inertia-generator
images and surface relation. The two-handle construction applies
because the construction assumes genus at least two. The nine frozen
matrix identities cover every positive branch-support size modulo
each chosen index. The stdlib checker replayed successfully in0.018s
on one core: group order, generators, exact inertia orders, their full
normal closures, commutator normal closure/perfectness, and all nine
surface identities. No heavy computation was run.

The Riemann--Hurwitz formula and both leg-degree bounds are correct.
The local Cartier-zero regularization was checked against the retained
audited transverse-reduction proof, without opening its audit body.
The choices (E,n)=(1,3),(2,2),(3,4) make e'=n(e+d)-d divisible by five;
the regular logarithmic derivative and unit first coordinate of the
saturated horizontal solution jet give regularity and transversality.
Both identifications commute with the actual upper etale legs.

Nonbreaking clarifications: in the E=0 case the endpoints are unchanged,
so the later formula for e' may be read with n=1. The canonical-generator
parts use the existing genus-at-least-two canonical-intersection input;
repeating that standing convention near those claims would make the
statement easier to read. Neither point invalidates the construction
in its intended hyperbolic scope.

No breaking mathematical objection was found. The result changes
endpoints, does not bound their genera or clump sizes, and does not
force a clump or exclude transverse dormant data. It does not solve
the original unmarked common-cover problem. The optional
Biswas--Das--Parameswaran citation was not independently audited:
the elementary Galois inertia argument suffices here.
