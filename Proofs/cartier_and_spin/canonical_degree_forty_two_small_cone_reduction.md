# Proof: the cone Cartier differential and primitive separation

Version1. [Statement](../../Theorems/cartier_and_spin/canonical_degree_forty_two_small_cone_reduction.md). Scoped argument passed [independent review](../../Research/audits/CANONICAL_DEGREE_FORTY_TWO_SMALL_CONE_AUDIT_2026_10_03.md). Keep BOTH actual maps and inherited spin data onT. Use the canonical(2,3,7) ring, accepted actual primitive-even obstruction, [cone coefficient ledger](canonical_high_degree_cone_carrier_exclusion.md), and [ordinary degree42 invariant-generator argument](canonical_septic_triangle_ordinary_spin_reduction.md).

Canonical Hurwitz gives K_Y∼2P, so P is Weierstrass. Put Y:y²=Φ(z), Φ monic squarefree of degree FIVE, P=∞, σ=dz/y. The genuine normalized generators F,G,H of weights6,14,21 have exact pole orders6,14,19 when the distinguished order is TWO, and6,12,21 when it is THREE. They satisfy
\[
H^2=\alpha F^7+\beta G^3,\qquad\alpha\beta\ne0.
\]
The divisor of F is the SIX distinct simple order-seven points minus6P, in either case. The finite zeros of G and H are likewise simple and disjoint from these.

## A regular differential and its original-Y Cartier gate

The differential ν=d(FG)/H is regular at H=0 by the exact identity
\[
3\beta G^2d(FG)=2H(F\,dH-H\,dF).
\]
It is regular elsewhere away from P. It is nonzero because FG has a simple zero. For distinguished order THREE, the numerator has pole at most19 while H has pole21, so ν vanishes at least twice at P. For order TWO, the leading pole21 cancels because6+14=20 is divisible by five; numerator pole at most20 and H pole19 leave a possible SIMPLE pole at P only. The residue theorem removes it, so ν is regular.

The same separating Kummer elliptic map ξ6=F, x=G/ξ14, zE=H/ξ21 satisfies zE²=α+βx³ and dx/zE=ξν. Its invariant differential has Cartier zero, so ξ25=ξF4 gives
\[
C(F\nu)=0
\]
on the ORIGINAL Y. If the regular ν had a nonzero nonvanishing-atP component zσ, then Fν would have exact pole SIX, whose Cartier image has unavoidable pole TWO. Thus ν=cσ, c≠0, in the order-two case also; in the order-three case this already follows from its zero at P. Consequently C(Fσ)=0 in both cases.

## Invariant F forces invariant G

Assume F invariant. Then F is a degree-three polynomial with THREE distinct nonbranch roots, giving three actual hyperelliptic zero pairs. For order TWO write G=A7+yB4. The actual norm coefficient CF7+DG3 has exact pole38. Both C,D are nonzero: neither basis vector vanishes at the distinguished order-two cone, while the norm does. A nonzero degree-four term in B gives an uncancellable odd pole41 in DG³, so degB≤3. The identity d(FG)=cHσ gives
\[
cH=y(FA_7)' +\Phi(FB)' +\tfrac12\Phi'FB.
\]
If degB=3, the even term has exact degree10 and pole20, exceeding H's exact pole19. Therefore degB≤2.

For order THREE write instead G=A6+yB3. Here the same formula gives the odd H part y(FA6)' of exact degree8 multiplying y, because H has odd pole21. If degB=3, its even part has exact degree10. Thus H²'s odd coefficient multiplying y has degree18, while G³'s odd coefficient has degree at most15. The invariant F7 cannot cancel it. Again degB≤2.

At any root r of F, evaluation gives cH=yF'G and H²=βG³, hence c²βG=Φ(r)F'(r)². G has the SAME value on each actual hyperelliptic zero pair of F. Thus B vanishes at THREE distinct roots; degree at most TWO forces B=0. G is invariant in both cases. The square relation and H's exact odd pole then make H anti-invariant.

## Primitive separation when multiplier pole orders coincide

Every even characteristic coefficient is a polynomial in F,G. Every odd term is H times one of1,F,F²,F³,G,FG, with some terms already deleted by the cone ledger. Characteristic evaluation and hyperelliptic parity force the total multiplier Q(F,G) to vanish as a function.

There is no need to infer linear independence from their pole orders: for order THREE, F² and G both have pole12. Instead use the ACTUAL primitive different coefficient a over Γ. Choose a rational frame of N, so normalized invariant functions have the form t_j/a^j with t_j∈k(Γ). The multiplier monomials have distinct WEIGHTS in{0,6,12,18,14,20}. If Q were a nontrivial linear combination, multiply by a^m for the largest occurring weight m≤20. This gives a nonzero polynomial over k(Γ) satisfied by a, of degree at most20<42. That contradicts [k(T):k(Γ)]=42 and the accepted primitivity of a. Therefore Q=0 forces every odd characteristic coefficient individually zero. The resulting primitive even polynomial is forbidden by the actual carrier obstruction. This excludes the entire invariant-F part of both profiles on BOTH endpoints.
