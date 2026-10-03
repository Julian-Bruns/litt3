# Proof: bounded elliptic maps specialize and have finite coefficient support

Version2,3 October2026. [Statement](../../Theorems/quotient_geometry/main_small_elliptic_map_exclusion.md). [Version1 degree-SIX review: PASS](../../Research/audits/MAIN_SMALL_ELLIPTIC_MAP_EXCLUSION_AUDIT_2026_10_02.md); the uniform bound and degree-SIXTEEN extension passed [focused whole-scope review](../../Research/audits/JOINT_SPIN_KUMMER_SOURCE_AUDIT_2026_10_03.md). Work over k=bar(F5), fix any integer N≥TWO, and let U=A1 minus{0,1,2,3}. Write Φ_t(u)=u(u−1)(u−2)(u−3)(u−t). Nonconstant maps in the bound need not be separating.

## Bounded equations for every actual map

Let f:Y_t→E have degree n≤N. Take f(O) as elliptic origin, where O is the unique infinity point of Y_t. Since the hyperelliptic involution acts by−1 on J(Y_t), the Abel-map description gives fι=−f, also for an inseparable map. In a short elliptic Weierstrass equation z²=x³+αx+β, the x pullback is therefore even and the z pullback is odd. Write
\[
x f=A(u)/B(u),\qquad z f=vC(u)/B(u)^2.
\]
Here A,B are coprime polynomials of degree at most n: the induced map P1_u→P1_x has degree n, by taking degrees of the two hyperelliptic double quotients.

The displayed C is a polynomial. At a finite pole away from a Weierstrass point, an elliptic ramification index e gives ordB=2e, ord(z f)=−3e, and v is a unit. Thus B²(z f)/v is regular. At a finite Weierstrass pole, ord_Y B=2e, ord(z f)=−3e and ord_Y v=1; the resulting order is e−1≥0. Elsewhere it is regular as well: at a finite Weierstrass point not mapping to elliptic infinity, oddness makes z f vanish at least to order one. Thus C has no finite pole. Substitution gives the exact polynomial identity
\[
\Phi_t C^2=B(A^3+\alpha AB^2+\beta B^3).
\]
Since degΦ_t=5 and the right side has degree at most4n, one has degC≤2n−THREE; we harmlessly allow degC≤2N−TWO. This bound holds for inseparable maps as well because the displayed polynomial identity and valuation inequalities use total ramification indices.

For EACH exact degree n=1,...,N separately, introduce the coefficients of A,B of degrees≤n, of C of degree≤2N−TWO, α,β and t. There are2n+2N+FOUR≤4N+FOUR variables. Equating coefficients of the preceding identity gives equations of total degree at most FIVE. Their affine zero set V_n is defined over F5. Its open subset V_n,actual is obtained by requiring t∈U, a nonzero elliptic discriminant, B≠0, max(degA,degB)=n, and a NONZERO homogeneous degree-n resultant of A and B. The last two conditions guarantee that their degree-n homogenizations have no common point ofP1, including infinity. They are genuinely open in this exact-degree coefficient space. Every point gives an actual degree-n morphism to the smooth projective elliptic target: a rational map between smooth proper curves extends across its poles, and its induced map of hyperelliptic bases has degree n. Every actual map under discussion occurs in one of these N open strata. We do not use coprimality as an open condition in a padded maximal-degree space.

## Bounded elliptic maps form a closed locus on U

Consider a smooth genus-two family over a DVR, with its infinity section, and a generic-fiber map to an elliptic curve of degree n≤N. It extends after finite base change to a map between the good-reduction models, with the SAME total degree. Here are the required details.

The induced quotient J(Y_generic)→E is nonzero and surjective. The Jacobian has good reduction. For an auxiliary prime ℓ≠5, its Tate module is unramified, and the Tate module of E is its quotient over Qℓ. It is therefore unramified as well. The good-reduction criterion for abelian varieties gives good reduction of E. After finite base change needed to realize the chosen map and origin, both Jacobian and E are abelian schemes; their homomorphism extends uniquely by the Néron mapping property. Composing with the relative Abel map based at the infinity section extends f to the entire smooth genus-two family.

Pull back the relative elliptic-origin divisor. Its line bundle has degree n on the generic genus-two fiber; flat properness makes that degree n on the special fiber as well. A constant special map would have pullback degree zero, so it is nonconstant, and its total degree is still n. No separability of the special map is needed or inferred. This is the only change to the old specialization clause needed at larger N.

This proves closedness of the locus of nonconstant maps of total degree at most N, also when their elliptic targets vary. Equivalently, any dominant parameter component of V_n meeting its OPEN V_n,actual would yield such a map at EVERY smooth specialized parameter: its generic point lies in that open; choose a closed point above the generic parameter over a finite extension, then a valuation over the desired parameter and apply the preceding argument.

## One accepted simple fiber gives the finite bound

The [BACKUP](../../Definitions/backup_genus_two_curve.md) occurs in this SAME family at t=α, α³+α+1=0. Its [geometrically simple Jacobian](../../Theorems/curve_arithmetic/backup_curve_arithmetic.md) has dimension two, and consequently no nonconstant map to an elliptic curve: such a map would give a nonzero elliptic quotient of its Jacobian. Therefore NO irreducible component of any V_n meeting V_n,actual can dominate the parameter line. Its projection to that line is a single algebraic value.

The general affine Bézout component-degree bound for equations of degree at most five in2n+2N+FOUR variables gives sum of component degrees at most5^(2n+2N+4), and in particular at most that many irreducible components. One may obtain this bound by successively intersecting with generic linear combinations of the defining equations and applying ordinary projective Bézout, retaining lower-dimensional components when they first become components; projective boundaries do not increase this total bound. Summing over the N exact-degree strata bounds all actual parameter values byΣ_(n=1)^N 5^(2n+2N+4)≤N·5^(4N+4).

Their set is F5-Frobenius stable because all N spaces V_n and V_n,actual are defined over F5. A parameter in this finite set has F5-orbit length at mostN·5^(4N+4). For N=SIXTEEN the bound is16·5^68, below the selected MAIN prime degree. Indeed the already used three-branch threshold exceeds(42!)², while (42!)²>20^42=2^84·5^42>16·5^68; the last inequality follows from2^78>5^26. Thus MAIN has no map of degree≤SIXTEEN to any elliptic curve. This is a bounded-map statement and does not claim that J(MAIN) is simple. N=SIX recovers the prior bound6·5²⁸.

For the [actual elliptic spin carrier](../cartier_and_spin/actual_elliptic_spin_isogeny_carrier.md), a=1 gives Y′=Y and a separating elliptic map of degree m∈{3,6} in the only remaining MAIN k=3 profiles; k=1 was already excluded. The preceding bounded-map theorem excludes these two actual profiles. BACKUP excludes them directly by its accepted geometric Jacobian simplicity. This closes the ENTIRE a=1 carrier branch without replacing either original endpoint map.
