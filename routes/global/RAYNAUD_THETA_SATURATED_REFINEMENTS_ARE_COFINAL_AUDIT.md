# Independent audit: theta-saturated refinements

Auditor: /root/raynaud_cofinal_refinement_major_audit.
Date: 2026-09-06.
Verdict: PASS. No proof-breaking objection found.

Scope: the exact theorem and proof in
[the audited note](../../Solutions/Sol_raynaud_cofinal_saturation.md).
No unrelated frontier or audit records were consulted.

## Primary-source check

Read Raynaud, *Revetements des courbes en caracteristique p>0 et
ordinarite*, Compositio 123 (2000), 73--88, definitions on p74,
Proposition1(4)--(5) on p75, Theorem2 on p76, and its necessary
construction and proof on pp83--86, including Lemma16, Theorem17,
Corollary18 and Remark20(1), in the
[primary PDF](https://www.cambridge.org/core/services/aop-cambridge-core/content/view/16AB72912D3CE32BFC5D012B1025A8E4/S0010437X00000440a.pdf/revetements-des-courbes-en-caracteristique-pandgt0-et-ordinarite.pdf).

Theorem2 supplies the connected Galois cover and a no-theta
representation through its prime-to-p solvable group, uniformly in
the characteristic and genus. Proposition1(5) gives precisely the
claimed Jacobian-image containment. The proof constructs a bundle
with sections after every degree-zero twist using a divided
polarization, tensors a suitable line subsheaf of B, and induces
after a cyclic cover satisfying the numerical conditions. Remark20(1)
also explicitly identifies the regular representation as no-theta.
This is an every-curve assertion. Lemma16 invokes an external
vector-bundle existence result; this audit checks Raynaud's argument
as a cited theorem, not a new proof of that underlying result.

## Independent checks of the corollary

All bundles in the relevant cohomology calculation live on C^(1).
The finite etale cover has its corresponding twist q^(1), and the
relative-Frobenius square is Cartesian. Flat base change of the
defining exact sequence yields B_W = q^(1)*B_C. The descended
regular-representation bundle is q^(1)_*O_(W^(1)); no identification
of C with C^(1), or of their Jacobian points, is required.

Because p does not divide |G|, the representation category is
semisimple. If every simple constituent of the bad representation
had a nonempty vanishing open subset, their finite intersection in
the irreducible Jacobian would be nonempty. Consequently one
constituent is nonvanishing generically. The closed locus h^0 >= 1
is then the whole Jacobian. That constituent occurs in k[G], so
projection formula proves the asserted nonvanishing for every old
Jacobian parameter. Multiplicities and left/right regular conventions
do not affect this conclusion.

For an arbitrary connected finite etale r:T->W, faithful flatness
makes pullback on global sections injective. This does not require
an invertible degree or a trace splitting. Combined with the same
base-change identity for B, it proves upward closure even for
refinements whose degree is divisible by p.

Every connected component of V times_C W maps finitely etale and
surjectively to both connected curves V and W: its nonempty image
is open and closed. Pulling the already nonzero section from W to
that component therefore proves cofinality. Alternatively, applying
assertion1 to V proves the stronger stated choice of a prime-to-p
solvable Galois refinement over V. The resulting composite over C
is not asserted to retain prime-to-p degree or to be Galois.

The two endpoint pullbacks tensor to a degree-zero line bundle on
C^(1). Assertion1 therefore applies simultaneously to every pair
(L,M), irrespective of relations or kernels between the endpoint
Jacobian maps. Further refinement preserves both maps from the same
source and the nonzero sections. A cofinal family must contain an
object dominating a saturated object; that member cannot have
generic vanishing on the fixed endpoint parameter space.

## Non-breaking precision notes

1. In assertion3, explicitly saying "connected finite etale
   refinement V->C" would align its wording with assertion2.
   If disconnected covers are intended, the construction can instead
   be applied componentwise, with disconnected total source.
2. The notation E_S in the explicit proof means the associated
   bundle on C^(1). Adding this phrase would prevent confusion with
   the bundle on C used earlier in some conventions.
3. The uniform degree bound is for assertion1 at fixed genus.
   A refinement constructed above a varying V has a bound depending
   on g(V), and its total degree over C also includes deg(V/C).
   The note already avoids claiming a uniform cofinal degree bound.

These are clarity points, not missing hypotheses under the note's
connected-curve convention. The note correctly separates this
refinement obstruction from the jointly minimal two-leg claim.
