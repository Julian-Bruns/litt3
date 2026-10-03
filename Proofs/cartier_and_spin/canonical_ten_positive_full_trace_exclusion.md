# Proof: opposite cyclic branch classes contradict the rigid four-dimensional tuple

Version1,3 October2026. Independent whole-branch review PASS: [audit](../../Research/audits/CANONICAL_TEN_POSITIVE_FULL_TRACE_EXCLUSION_AUDIT_2026_10_03.md). See the [statement and original-source scope](../../Theorems/cartier_and_spin/canonical_ten_positive_full_trace_exclusion.md). No computation, reflection classification, or endpoint descent is used.

Use the actual coefficient quotient Γ_R→P¹. The coefficient kernel acts freely on the original canonical target because every noncyclic coefficient quotient retains both inertia groups. Thus this is an actual connected R-cover with precisely weak cyclic C5 inertia of break ONE and tame cyclic C2 inertia. The finite projective representation V has dimension FOUR, is irreducible, and the tame involution has ONE-plus-THREE eigenspaces. The accepted no-prime-to-FIVE quotient result for G passes to R.

## Prescribe the opposite branch classes in the local lift

The weak cyclic germ can be written y⁵−y=t⁻¹, after a local base-coordinate change. Let ζ be a primitive FIFTH root in mixed characteristic, and let ε=ζ−ONE. Its explicit smooth local lift is the normalization of
\[
Z^5=1+\frac{\varepsilon^5}{T}.
\tag{1}
\]
The substitution Z=ONE+εY reduces (1) to Y⁵−Y=t⁻¹. Its TWO generic branch values are T=ZERO and T=−ε⁵, with respectively a simple pole and a simple zero of the Kummer function. Their total generic different is EIGHT, equal to the special different, so the different criterion makes this normalization a smooth local lift. The prescribed deck generator acts by Z↦ζZ. On local tangent parameters at the zero and pole branch points its eigencharacters are ζ and ζ⁻¹.

This exact order-p construction is [Obus–Wewers, Annals180(2014), §4, equation(4), printed page240](https://annals.math.princeton.edu/wp-content/uploads/annals-v180-n1-p05-p.pdf), specialized to break ONE. Patch THIS prescribed lift and the standard tame C2 lift by the local-global principle, as in [Pop, Annals180(2014), Fact4.13(1)](https://annals.math.princeton.edu/wp-content/uploads/annals-v180-n1-p06-p.pdf). The resulting smooth characteristic-zero R-cover has exactly THREE branch values, two of order FIVE and one of order TWO. This also follows from the genus calculation in the [rigid-field proof](canonical_ten_rigid_field_twenty_five_reduction.md).

After spreading to a finitely generated characteristic-zero field and embedding into C, branch cycles give generators a,b,c of the SAME R, with abc=ONE. The TWO order-FIVE generators are inverse conjugates in R. Indeed their local tangent characters, for the same cyclic deck generator in the prescribed induced local R-cover, are ζ and ζ⁻¹. A positively oriented complex branch cycle is characterized by its primitive tangent eigencharacter. Thus the two branch classes are the conjugacy classes of g^j and g⁻ʲ for one common nonzero j moduloFIVE. Global path choices conjugate these elements separately; they do not alter that inverse-conjugacy statement. We do not assert that a and b lie in the same cyclic subgroup after those global path choices.

## The rigid tuple is over F25 and determinant one

The [rigid-field theorem and its elementary Scott proof](canonical_ten_rigid_field_twenty_five_reduction.md) applies. Let A,B be the unique unipotent lifts of a,b, and put C=(AB)⁻¹. Both A and B are regular J4 blocks, the linear tuple is irreducible and simultaneously conjugate into SL₄(F25). The repeated eigenvalue of AB can be denoted ρ; its other eigenvalue is −ρ, with
\[
\rho^4=-1.
\tag{2}
\]
The entire projective image R is therefore a subgroup of PGL₄(F25). The determinant-mod-FOURTH-powers map has target F25×/(F25×)⁴, cyclic of order FOUR. Since R has no such nontrivial quotient, this image is trivial. Consequently R lies in PSL₄(F25).

The inverse conjugacy of a,b now has a genuine determinant-ONE realization: choose an SL₄(F25) lift H of a conjugating element of R. The projective equality b=H a⁻¹ H⁻¹ implies B=H A⁻¹ H⁻¹ honestly. Both sides have all eigenvalues ONE, so the possible projective scalar is ONE. We next prove that no such H exists.

## A simultaneous companion basis

Write AB=ρ(I−TWO E), where E is the rank-ONE idempotent projecting onto its simple eigenspace. Define
\[
M=\rho B^{-1}.
\]
Then A−M has rank ONE. The two matrices A,M have characteristic polynomials (x−ONE)⁴ and (x−ρ)⁴ respectively, and form an irreducible pair: their invariant subspaces are exactly those of A,B. Everything is over F25.

We give the common companion-basis argument to avoid importing a characteristic-zero matrix theorem. Write M−A=vℓ, with v a nonzero column and ℓ a nonzero row over F25. The A-cyclic span of v is all V, since otherwise it is a proper subspace invariant under both A and M. Similarly ℓ is A-cyclic in V*: otherwise the common kernel of all rows ℓA^j is a nonzero proper subspace invariant under A and M. Thus the FOUR rows ℓ,ℓA,ℓA²,ℓA³ are independent.

Choose a nonzero q in the common kernel of the first THREE rows. Then ℓA³q≠ZERO. The vectors q,Aq,A²q,A³q are independent: applying ℓ, then ℓA, then ℓA², then ℓA³ successively to any dependence kills its coefficients in descending order. Moreover (M−A)A^j q=ZERO for j=ZERO,ONE,TWO. In this basis A and M share their first THREE companion columns, and their last columns are determined by their respective characteristic polynomials. Thus each has its usual companion matrix in the SAME basis.

## The determinant class of the second unipotent

In this companion basis let e be the first basis vector. For M, the basis (e,Me,M²e,M³e) is the standard basis, of determinant ONE. Since B=ρM⁻¹, its cyclic basis has determinant
\[
\det(e,Be,B^2e,B^3e)
=\rho^6\det(e,M^{-1}e,M^{-2}e,M^{-3}e)
=\rho^6(\det M)^{-3}
=-\rho^6=\rho^2.
\tag{3}
\]
The middle equality follows by multiplying all FOUR columns by M³ and reversing their order; the reversal sign is (−ONE)^SIX=ONE. Also det M=ρ⁴=−ONE, giving the last equalities by (2).

The cyclic-basis change in (3) conjugates B to the companion matrix of (x−ONE)⁴, namely A. Any other conjugating matrix differs from it by a centralizer element of A. The centralizer consists of invertible polynomials in A, and their determinants are FOURTH powers: in the single Jordan-block basis the diagonal is one repeated nonzero scalar. Therefore the determinant class of every conjugator between A and B is ρ² modulo FOURTH powers, or its inverse if the conjugacy direction is reversed.

By contrast A and A⁻¹ are conjugate by a determinant-ONE matrix. Their inverse cyclic-basis determinant is (det A)⁻³=ONE, by the same reversal calculation. Thus inverse conjugacy between A and B by SL₄(F25) would force ρ² to be a FOURTH power.

But ρ² has order FOUR, whereas the FOURTH-power subgroup of F25× has order SIX. It contains no element of order FOUR. This contradicts the determinant-ONE conjugator H supplied by the opposite local branch classes.

## Scope of the exclusion

All new reasoning concerns the actual finite coefficient image and its actual weak two-value quotient curve. The original source T and its two actual finite étale endpoint maps remain in place; no map to X has been manufactured on Γ_R or the coefficient curve. The original positive complete rank-FOUR degree-ONE trace and genuine determinant transport supply the irreducibility, no-prime-to-FIVE quotient and tame ONE-plus-THREE hypotheses. Hence that entire canonical-TEN positive full trace branch is excluded. Other trace branches and the original étale-image branch are outside this result.
