# Audit: the genus-two joint-tangent conic exclusion

Verdict: PASS. No blocking objection.
Auditor: /root/audit_joint_tangent_conic.
Date: 2026-09-09.

Scope: version 1 of
[the theorem](../../Theorems/Thm_genus_two_joint_tangent_conic.md) and
[its proof](../../Solutions/Sol_genus_two_joint_tangent_conic.md).
This is a bounded prose audit of the new conic argument, not Lean
verification or a fresh audit of the finite-projective-frame theorem.
Section 2 of
[joint tangent clump dormancy](../../Solutions/Sol_joint_tangent_clump_dormancy.md)
is taken as the separately audited input, as requested.

## Checked mathematical steps

1. For N=omega(-Q), both omega^-1 and N^-1 have negative degree.
   The exact cohomology sequence therefore identifies the kernel of
   H^1(omega^-1) -> H^1(N^-1) with the one-dimensional skyscraper fiber.
   Serre duality identifies the dual map with the inclusion
   H^0(omega^2(-Q)) -> H^0(omega^2). Thus this kernel is exactly the
   projective evaluation class, with no chosen fiber trivialization needed.

2. Vanishing of the pulled-back extension class gives a lift N -> E.
   Its composite with E -> omega is the nonzero inclusion N -> omega,
   so the lift is injective as a sheaf map. A nonzero original extension
   is nonsplit. Any saturated line of degree at least two in E maps
   nontrivially to omega; degree greater than two is impossible, while
   degree two makes this map an isomorphism and splits the original
   extension. Therefore E is semistable of slope one. Saturating the
   lifted degree-one line cannot increase its degree, proving that the
   quotient is a line bundle. The determinant gives that quotient as
   O(Q), exactly as claimed.

3. Twisting this short exact sequence by any inverse theta characteristic
   gives an extension of two degree-zero line bundles. Frobenius pullback
   preserves its exactness (the terms are locally free), and both line
   bundles still have degree zero at every iterate. Such an extension is
   semistable: a positive-degree line can map nontrivially to neither
   the subline nor the quotient. This proves strong semistability at all
   stages, rather than merely semistability at finitely many stages.

4. A nonzero shared tangent supplies matching pointed extensions on both
   actual endpoints, with their identification on the given common source.
   Strong semistability is preserved and reflected along each finite
   etale leg, separately at every Frobenius iterate. Normalization changes
   slopes by line twists and does not require the two theta characteristics
   to agree upstairs. Hence strong semistability of the evaluation
   extension on Y meets exactly the hypotheses of the established
   two-leg obstruction. Neither original map nor embedded endpoint field
   is replaced, and no simultaneous finite Galois closure is presumed.

5. In genus two, multiplication Sym^2 H^0(omega) -> H^0(omega^2)
   is an isomorphism: both dimensions are three, and the three products
   are independent since the ratio of two independent canonical sections
   is nonconstant. The canonical degree-two map is surjective onto P^1,
   so its bicanonical image is precisely the Veronese conic, and all
   geometric points of that conic occur as evaluation lines. Every
   projective line in P^2 meets this conic over the algebraically closed
   field. A joint tangent space of dimension at least two therefore
   contains an excluded evaluation class. The conclusion dim T_joint<=1
   follows.

## Consequences and limits

The quotient-of-W(k)[[z]] consequence correctly applies the canonical
etale-refinement deformation theorem's parameter bound. Nilpotence of 5
for the selected main pair correctly uses the existing nonliftability
result. These previously established deformation and nonliftability
inputs are not independently re-audited here; their existing evidence
status is not upgraded by this audit.

The proof explicitly leaves a lone off-conic projective tangent possible.
It supplies no length or Witt-height bound and does not eliminate a
positive-dimensional characteristic-five component. It does not prove
the unmarked common-cover problem solved. The finite-field hypothesis is
retained exactly where the two-leg projective-frame input requires it.
