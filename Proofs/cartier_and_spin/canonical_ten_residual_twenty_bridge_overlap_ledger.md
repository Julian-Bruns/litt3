# Proof: actual quadratic descent and the exhaustive overlap partitions

Version2, 3 October2026. [Independent whole overlap audit PASS](../../Research/audits/OCT03_RESIDUAL_TEN_OVERLAP_EXTENSION_AUDIT_2026_10_03.md). See [the statement](../../Theorems/cartier_and_spin/canonical_ten_residual_twenty_bridge_overlap_ledger.md). The original Y-leg and one-fold packet are now explicit in the statement, as requested by the synthesis scope review. This consolidates the audited overlap argument without additional mathematical claims or numerical replays.

## Actual hypotheses

Retain the canonical faithful BACKUP packet q:T→Y, group G, φ:T→Γ of degree ten with S10 monodromy, ωT=φ*ωΓ², reduced index-two different q*P0 and the accepted ordinary quotient image of P0. Two original actual finite étale X-maps generate their joint normalization C0; its projections have degree d, so g(C0)=8d+1. Retain index-one C0=k(x1,x2,z), q0(x2)=z³q0(x1), θ1=κz8θ2. Let I1,I2 be the reduced degree-d infinity fibers, F∞ their common reduced divisor of degree c, and D_i=I_i−F∞. Require residual degree d−c=10 and the nonsplit connected étale double B′=C0(t), t²=z. Then div z=2D1−2D2 and div t on B′ is its simple-zero/simple-pole pullback, of degree twenty. Put m=[T:B′] and retain ΓB′=T and [T:Γ]=10. Consider 10≤d≤19.

From the actual degrees and canonical comparison,
\[
N=16md,\quad g(B′)=16d+1,\quad g(\Gamma)=\frac45md+1.
\]
The original descended infinity sections satisfy M16=ωΓ² and deg M=md/5. Their common divisor has degree mc/5 because their simple infinity zeros pull to the original shared divisor through the degree-ten φ. Thus t, proportional to their ratio, has Γ-degree m(d−c)/5=2m.

## The same actual quadratic block field exists

The group and faithful-resolvent normal-closure steps of the accepted [quadratic-resolvent reduction](canonical_ten_twenty_bridge_quadratic_resolvent_reduction.md) use only the twenty-sheet single bridge, its ten-sheet S10 component and T/B′ étale. They are unaffected by the changed genus. Their conductor bounds give actual Γ-subfields of degrees D with
\[
\frac{2g(\text{resolvent})-2}{D}
\ge-2+\eta\left(\frac85d+2\right),
\]
where η=1−252/184756 in the primitive sector and η=15/16 for the two large pair kernels. A Γ-subfield is bounded above by
\[
\frac{2g(\Gamma)-2}{[\Gamma:k(t)]}=\frac45d.
\]
Both lower bounds exceed this for every integer d≥1. For the pair bound the difference is7d/10−1/8>0; the primitive bound is even larger. Hence the unchanged group reduction supplies the same actual R⊂Γ∩B′ with [R:k(t)]=2, [B′:R]=10, [Γ:R]=m and connected whole base change. Its three block kernels are unchanged, so R is again the unique quadratic t-subfield.

The free t→−t involution therefore descends to R, giving the actual hyperelliptic Q=R^σ⊂C0 with [Q:k(z)]=2, [C0:Q]=10. Hurwitz bounds
\[
g(R)\le\frac45d+1,\qquad g(Q)\le\frac25d+1.
\]
Thus g(Q)≤8 for d≤19 and both Hom(JX,JQ) and Hom(JQ,JX) vanish by absolute simplicity of JX of dimension nine.

## R→Q remains étale, but overlap can support uniform fibers

For π:C0→Q and either original h_i, the norm class of π*A is independent of A. At any A above z=0, Norm_h1 π*A=10O as an actual divisor; at any A above infinity the analogous h2 identity holds. Therefore all norm classes are10O.

At a uniform π-fiber π*B=eD_B, e=2,5,10, write E_B=(h1)_*D_B and k_B=mult_O(E_B). The norm gives eE_B∼10O. Away from z=0,∞, points mapping to O under h1 or h2 are EXACTLY the common infinity points; hence k_B counts them.

The accepted [fixed-X norm obstructions](../../Theorems/jacobians/isogeny_sieves/trigonal_constant_norm_obstruction.md) give these exhaustive possibilities.

- **e=2:** E_B has degree five. Its two-torsion class E_B−5O is zero by h0(L(7O))=0, hence E_B∼5O. Since L(5O)=span{1,x}, its effective divisor is either5O, or2O plus the reduced/multiple degree-three x-fiber. Thus k_B=5 or2, respectively.
- **e=5:** E_B has degree two. If k_B=0, the accepted mixed norm P+g³=H²J³ excludes5E_B∼10O as in the audited degree-ten proof. If k_B=1, cancellation gives5P∼5O for one finite P, excluded by the semigroup gap5. Therefore E_B=2O and k_B=2.
- **e=10:** E_B has degree one. If finite, the degree-five two-torsion/gap argument applied to5E_B excludes it. Hence E_B=O and k_B=1.

In particular a uniform fiber containing no common infinity point is impossible. At z=0 or∞, the opposite map's infinity occurs only at the other special value or on F∞ at a finite nonzero z-value. Therefore any uniform e=2 special fiber is finite for that opposite X-map and impossible. Consequently Q/z ramifies at both0 and∞; as before R/Q is étale and g(R)=2g(Q)−1.

The previously suggested stronger statement that ALL uniform fibers are excluded when c>0 is false: the listed divisors with O support are genuine unexcluded possibilities. They must be counted rather than discarded.

## Every common infinity belongs to a uniform fiber

At every original infinity point upstairs on T, the original section u_i has a SIMPLE zero because its X-map is étale. Since u_i=φ*s_i, no folded φ-point can be an original infinity: a vanishing s_i at an index-two point would pull back with zero order at least two. This uses the individual actual original columns, not an arbitrary constant combination.

The accepted [whole-base-change ramification lemma](canonical_ten_whole_bridge_ramification_ledger.md) gives C0/Q only the following profiles: single fold(2,1⁸), or a uniform Galois local field of degree e|10. It applies after R/Q is étale. A folded point in the first profile lifts to an actual φ-fold and so avoids every original infinity.

At any shared infinity point, both x_i have pole order three. The LOCAL first-two-jet argument for the original tensor does not require cubic-root index three. In any actual uniformizer u, write x_i=l_i u⁻³+m_i u⁻²+n_i u⁻¹+O(1). The fixed rational tensor has leading asymptotic q0⁸/P²=x⁻⁴(1+O(x⁻¹)), and
\[
\frac{q_0(x_i)^8}{P(x_i)^2}(dx_i)^3
=\frac3{l_i}\left(1+3\frac{m_i}{l_i}u+2\frac{n_i}{l_i}u^2+O(u^3)\right)(du)^3.
\]
Proportionality forces m2/l2=m1/l1 and n2/l2=n1/l1. Therefore x2−ρx1 is regular, ρ=l2/l1, and q0(x2)/q0(x1)−ρ² has order at least three. Since z is nonzero there and its cube map is étale, ord(z−z(P))≥3.

If π were unramified at that point, Q/z of degree two would give z-index at most two, contradiction. A simple π-fold is already excluded by original infinity avoidance. Thus EVERY common infinity lies in a ramified uniform π-fiber. The numbers k_B above account for all c common points without omission.

## Exact ledger and immediate exclusions

The number of C0/Q single-fold branch values is8d. Indeed B′/R has16d such values from degDiffφ=N=16md and the one-fold count; the free R/Q involution pairs them. Hurwitz then gives uniform different
\[
U=8d+20-20g(Q)=100+8c-20g(Q),
\]
always divisible by four. Uniform contributions and common-point counts are:

| Inertia degree | Uniform different contribution | Number of common infinity points |
|---|---:|---:|
| 2 | 5 | 2 or5 |
| 5, lower break j≥1 | 8(j+1) | 2 |
| 10, lower wild break j≥1 | 9+4j | 1 |

At e=5 the local group is C5. At e=10 its wild subgroup has order five, so the different sum is9+4j regardless of cyclic/dihedral structure. No assertion of realizability of every break is made.

For c=1 (d=11), only one e=10 fiber can account for the common point, whose contribution is odd, contradicting U divisible by four. Thus the entire d11 nonsplit residual-ten class is excluded.

For c=3 (d=13), possible partitions of common points are three e=10 fibers; one e=5 and one e=10; or one e=2 with k=2 and one e=10. Their different sums are respectively odd, odd, and14+4j≡2 mod4. None equals U. Thus the entire d13 nonsplit residual-ten class is excluded.

For c=2 (d=12), the only surviving partition is one e=5 fiber. The other partitions are one e=2 with contribution5, or two e=10 with contribution18+4(j1+j2)≡2 mod4. Therefore exactly ONE C5 uniform branch value exists on Q and contains both shared infinity points. Its break and genus satisfy
\[
8(j+1)=116-20g(Q).
\]
With g(Q)≤5, the only integer positive possibilities are
\[
(g(Q),j)=(5,1),(3,6),(1,11).
\]
These remain UNEXCLUDED actual configurations. The corresponding R-genera are9,5,1. No polynomial search or claim that the local fields exist is used.

The original Y-leg remains on T. No X-map on Q or R and no simultaneous Galois closure of the endpoint maps is inferred. The c=2 list is a necessary reduction, and larger overlap remains outside the exclusions proved here.
