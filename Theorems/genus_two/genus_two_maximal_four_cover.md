# A finite torsion certificate excludes unbounded abelian-four monodromy

Version1,2026-09-09. Author proof, not independently audited.
Let k=bar(F5), Y_t:v²=u(u-1)(u-2)(u-3)(u-t). If

    [F25(t):F25] > 2^100000,

then the maximal abelian exponent-four etale cover of Y_t is ordinary.
It is connected of degree4^4=256 and genus257. Equivalently, every
connected abelian exponent-dividing-four etale cover of Y_t is ordinary.

Consequently, for ANY nonordinary curve X/k, there is no actual finite
etale span X←Z→Y_t whose Y-leg Galois closure has group

    1→P→G→A→1,   P a5-group, A abelian of exponent dividing4.

This includes unbounded5-group extensions and NON-GALOIS original legs.
No common connection, clump, core, trace division, or lifting is assumed.
The ALREADY selected parameter in bounded_atlas_partner_finiteness meets
this bound. The fixed genus-nine X is nonordinary by the preceding
maximal-two-cover theorem, so the exclusion applies to our current pair.

More precisely, there is a nonzero polynomial E in F25[T], of degree
less than2^100000, such that E(t)!=0 implies the asserted ordinariness.
It has a finite norm/straight-line description in the proof; its expanded
coefficients are not computed or needed for the high-degree conclusion.

The certificate checks ALL240 exact-order-four Jacobian points, not a
sample of line bundles. The remaining16 classes are covered by the exact
maximal-two theorem. A single degree-three specialization proves the
relevant bounded-degree functions nonzero; it is NOT assumed that the
selected parameter has the same finite-field coordinates.

Scope: arbitrary2-groups, exponent8, nonabelian prime-to-five quotients,
and arbitrary common covers remain open. This does not solve AP or A18.

[Proof](../../Solutions/genus_two/genus_two_maximal_four_cover.md) ·
[Exact small certificate](../../scripts/genus_two/verify_genus_two_four_torsion.sage).
