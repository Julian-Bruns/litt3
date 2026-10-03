# Proof: the degree-zero determinant torsor replaces a four-dimensional lift

Version1,3 October2026. Whole scoped review [PASS](../../Research/audits/RANK_THREE_SCALAR_TARGET_AND_TAME_IDENTITY_AUDIT_2026_10_03.md); see the [exact scope](../../Theorems/cartier_and_spin/rank_three_etale_row_determinant_torsor_and_even_inertia.md). No computation or presumed simultaneous Galois closure is used.

## Native determinant, coarse genus and the wild branch count

Every stabilizer on D acts freely on the actual étale ρ-fiber in C, so its order divides e. Let ℓ be their lcm. The GENUINE R-linearized determinant of K_D has degree n=N/e. Hilbert90 gives an invariant rational section, whose divisor is a sum of complete point orbits. Their sizes have gcd N/ℓ. Hence N/ℓ divides N/e, and e divides ℓ. Together with ℓ|e this proves ℓ=e, as in the [native determinant constraints](rank_three_etale_row_native_determinant_constraints.md).

Faithfulness on D and the actual Galois C/Y give the embedded equality C=Y D. Indeed the subgroup of Gal(C/Y) fixing D is trivial. Thus Y→B=D/R is the actual representable étale quotient-stack atlas, and its coarse degree is e. It has uniform fibers and uniform full completed Galois local type, equal to those of D→B. These are retained actual local extensions, not merely branch indices.

Genus-two Hurwitz shows g(B)≤TWO. GenusTWO forces e=ONE. GenusONE gives e≤FOUR, since any branch contributes at least e/TWO; the accepted [MAIN small elliptic-map exclusion](../../Theorems/quotient_geometry/main_small_elliptic_map_exclusion.md) and [BACKUP simplicity](../../Theorems/curve_arithmetic/backup_curve_arithmetic.md) exclude that alternative. Hence e>ONE gives B=P¹. If e were odd, all inertia orders would be odd and the accepted [odd uniform genus-two atlas theorem](../../Theorems/quotient_geometry/endpoint_exclusions/odd_uniform_genus_two_atlas_exclusion.md) would force e=ONE. Thus e>ONE is even.

A wild inertia of order i has different at least i+THREE, hence contributes at least ONE+THREE/i to quotient Hurwitz. Two wild branch values contribute area at least SIX/e, exceeding the actual TWO/e. Three or more branch values including a wild one contribute area at least THREE/e, also excessive. There is therefore at mostONE wild value and at mostONE other value. A sole wild value would have order ℓ=e; its different would be TWO e+TWO by area. This is impossible for even e: its zeroth different term e−ONE is odd and all positive terms are even. Thus the wild case has precisely ONE wild and ONE tame value.

## Why the determinant discrepancy is prime-to-FIVE torsion

The degree-ZERO line Λ=(detK_D)²ω_D⁻¹ has its native genuine R-action. An invariant rational section supplies an orbit divisor. Divide its degree by N to write
\[
\sum_b m_b/i_b=0,
\tag{1}
\]
where i_b is the point inertia order and only finitely many orbit coefficients m_b are nonzero. In the tame case all i_b are prime toFIVE. In the wild case there is exactly ONE denominator i_0=w h with w a FIVE-power; all other denominators are prime toFIVE. The degree-ZERO equation (1) itself therefore forces w|m_0.

Let c be the lcm of the PRIME-TO-FIVE parts of the inertia orders. It follows that every coefficient c m_b is divisible by i_b, including the wild coefficient. Hence c times the invariant divisor is pulled back from a degree-ZERO divisor on P¹, which is principal. Thus Λ^c is trivial as an ordinary line and its exact order b is prime toFIVE.

It is essential that there is at mostONE wild value. Trivial wild fiber characters alone would not justify divisibility of orbit coefficients; for example O(z) at a wild fixed point has trivial wild fiber character but multiplicityONE. The degree equality, not that false implication, is used here.

## The actual torsor and connected component

Take the connected cyclic étale degree-b trivializer D′→D of Λ. Each R-automorphism lifts because Λ is natively R-linearized; comparing the multiplication trivialization changes it only by a constant with a bth root in k. The full group of lifts is a finite central extension R̂ with kernel μ_b. Centrality is scalar root multiplication.

Take a connected component C′ of the actual fiber product C×_D D′. Its map to C is a connected cyclic étale cover of degree b′ dividing b. Let G′⊂R̂ be the component stabilizer. It surjects onto R, has kernel μ_b′, and acts freely on C′. This follows either from the fiber-product torsor or from its actual degree: its order is N b′, exactly the degree of the composite étale map C′→Y. It is therefore the Galois group of that map.

The fields satisfy C′=C D′=Y D′. Consequently G′ is faithful on D′. Étale degree comparison gives e′=e b′/b. Both original maps persist on the connected actual étale refinement T′=T D′ above C′. Neither is asserted to descend to D′.

## A genuine determinant comparison detects the full even inertia

On D′ the pulled line Λ is trivial. Its native action compared with a nonzero global trivializing section gives a character χ of G′. It is finite prime toFIVE since the group is finite and k× has no nontrivial FIVE-power torsion. Equivalently χ compares the native action on (detK_D′)² with the canonical action on ω_D′.

Let g fix a point of D′ and have order m=TWO^s. Its tangent/cotangent scalar ζ has exact order m. The native determinant fiber scalar β satisfies β^m=ONE because its action is GENUINE; no coefficient-module dimension is involved. On the discrepancy fiber χ(g)=β²ζ⁻¹, up to the harmless inverse convention for χ. Therefore
\[
\chi(g)^{m/2}=-1.
\]
Its TWO-primary order is exactly m. This is the original determinant-character detection with the actual determinant line replacing a determinant-one FOUR-dimensional coefficient lift.

Put H′=kerχ₂ and a=|χ₂(G′)|. All its target stabilizers have odd order, and their different exponents are even. Quotient Hurwitz gives 2a/e′ as an even integer divided by an odd integer, so e′₂|a. If e′>ONE, the same selected elliptic exclusions make D′/G′ rational. The cyclic tame cover D′/H′→D′/G′ has inertia orders equal to the full TWO-parts of the original stabilizers, each dividing e′₂. They generate its cyclic group, because a nontrivial étale quotient cover of P¹ is impossible. Hence a|e′₂ and a=e′₂.

If a=ONE, e′ is odd. The actual étale stack atlas Y→[D′/G′] and the accepted odd uniform theorem give e′=ONE. This concludes the scoped even-inertia bridge. No depth cutoff in the unbounded coefficient module V is inferred.
