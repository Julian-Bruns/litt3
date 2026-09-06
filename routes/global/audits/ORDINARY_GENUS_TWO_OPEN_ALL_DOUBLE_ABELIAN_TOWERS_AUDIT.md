# Focused audit: a genus-two open for all double-abelian towers

Date: 2026-09-05.
Auditor: `/root/gluing_cohomology_rigidity`.
Verdict: **PASS**, with no breaking objections and one nonbreaking
étale-local stack clarification below.

Target: [A genus-two open with proper theta for every double-abelian tower](../AN_ORDINARY_GENUS_TWO_OPEN_HAS_PROPER_THETA_FOR_ALL_DOUBLE_ABELIAN_TOWERS.md).

## Exact scope

The auditor read the complete consolidated theorem and checked the
interfaces among its all-coset Lemma 2.1, Frobenius example, moduli
closedness and irreducibility, arbitrary abelian degrees, and actual
refinements/intermediates. This record consolidates the checks already
delivered during author discussion. The auditor also coauthored the
companion example proof and certificate; their verification is not
misrepresented as a new independent audit of that author's own work.

The previously checked Prym polarization, mandatory Raynaud-theta
contribution, symmetry, and p-group refinement support theorem are
inputs, not newly audited primary foundations.

## Mathematical checks

1. **All cosets, without a torsion restriction.** Two distinct bad
   fibers each restrict to a reduced degree-four divisor on the
   elliptic Prym, and their restrictions are disjoint. They exhaust
   the total degree eight. In the supersingular case both miss the
   compulsory multiplicity four at zero, since the zero fiber is
   good. In the ordinary case each contains at most one point of
   the Verschiebung kernel: its intersection with a translate of
   Prym two-torsion has size at most one. At least two compulsory
   nonzero five-torsion points consequently remain outside the two
   restrictions. Both cases contradict degree eight. Symmetry then
   makes the unique possible bad quotient point nonzero two-torsion.
   Exact-order-four Prym tests therefore detect every bad translate.

2. **Arithmetic descent and the exact example.** The restriction
   from the Prym to the quotient by the base Jacobian factors as
   multiplication by two followed by an isomorphism over the field
   of definition. Thus their two-torsion Frobenius representations
   agree. A unique bad fiber would be rational over that field.
   The supplied example has Hasse determinant four, elliptic Hasse
   invariant one, and a three-cycle on nonzero Prym two-torsion.
   These assertions were independently hand-checked and verified by
   the saved Sage certificate. The diagonal involution is free.
   The other, ramified double induces an injective Jacobian pullback
   and identifies its elliptic Jacobian with the Prym, not merely
   up to an uncontrolled even-degree isogeny. This proves one good
   pair; it does not prove all fifteen doubles of that particular
   finite-field base are good.

3. **Closedness and irreducibility.** After choosing the double and
   an exact-order-four Prym point on étale charts, the vanishing
   locus for sections is open by semicontinuity. Projection from
   the relative base Jacobian is smooth and hence open. Therefore
   the locus where the whole translate is bad is closed, and its
   finite image is the closed bad-pair locus. The genus-two
   double-character stack is irreducible: ordered six-point branch
   configurations with a distinguished pair dominate it. Its
   ordinary part is a nonempty open. One good pair makes the bad
   locus proper, of dimension at most two. The finite degree-fifteen
   map to the ordinary genus-two stack has closed image of that
   same dimension bound. Its complement is consequently a nonempty
   finite-type open containing actual algebraic-closure points.

4. **All abelian degrees.** Prime-to-five covers have a finite
   character decomposition, so a finite intersection of good opens
   suffices. For an arbitrary finite abelian group, quotient by its
   Sylow five-subgroup first. The remaining cover has degree prime
   to five, and the original cover is an actual Galois five-group
   refinement. The existing filtration theorem preserves vanishing
   along that refinement; no modular character splitting is used.

5. **The actual maps are retained.** Further Galois five-group
   refinements satisfy the same filtration argument. Pullback of
   sections along an actual finite étale intermediate map is
   injective, including in characteristic-divisible degree. Thus
   every stated intermediate inherits the good axis, and an actual
   second étale leg is handled on its original source by setting
   its line parameter to the trivial bundle. The group formulation
   permits an abelian subgroup of index at most two in the quotient
   by a normal five-subgroup, with no inversion assumption. No
   second map is assumed to descend to the intermediate double.

## Nonbreaking stack clarification

The rigidified character stack has a universal double only
étale-locally. Its deck involution acts as minus one on the Prym,
so a global Prym and its twelve-point exact-order-four scheme need
not descend to that rigidification. The target's explicit
étale-local qualification is sufficient: perform the finite-point
and smooth-projection construction on charts, then descend its
closed bad-pair locus, which is invariant under all isomorphisms of
the double. Equivalently, work on the gerbe of actual doubles and
descend the resulting locus. Global descent of the entire Prym is
not needed. No assertion that the coarse moduli map is étale is used.

## Scope boundaries and reviewed snapshots

The line-parameter good open may depend on the finite cover. The
argument does not take an infinite intersection of such opens,
control arbitrary finite monodromy or arbitrary iterated abelian
depth, establish cofinality, or prove a common-cover exclusion.
It supplies an auxiliary nonempty open family, not a replacement
for the fixed pair in file 76.

SHA-256 values before subsequent status/link or clarification edits:

- Main theorem:
  `28a51be8868d7118df05f05e2b77112a458d408688d7b1d571434b6369d95939`.
- Companion example:
  `af02ecec36c75064db6100185c5cbc397ab6d3f0e080ac43ae898b96343e951c`.
- Exact Sage certificate:
  `e6b24c6d0c7a55fec4d684f86c65284fbd3f1d7627152ff94ec727ab27750afc`.

No theorem text was edited in this audit.
