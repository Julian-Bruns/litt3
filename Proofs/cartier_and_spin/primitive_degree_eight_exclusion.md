# Proof of complete exclusion of the actual primitive degree-eight quotient

Version1,2 October2026. One focused independent review passed; no computation was required. The result closes the m=1 primitive quotient in the actual simultaneous character sector, including EVERY nongalois degree-eight second leg. It does not produce that sector on an arbitrary span or resolve the unmarked common-cover problem.

## Exact inputs and claim

Work over an algebraically closed field k of characteristic5. On a smooth genus-two Y fix a Weierstrass point O, another Weierstrass point W, and a non-Weierstrass point P_s with hyperelliptic conjugate P_s^- such that
\[
D_s=[P_s-O],\quad 5D_s=[O-W],\quad A=4D_s.
\]
Thus D_s has exact order10 and A exact order5. Fix ell with divisor5A and dlog ell=-beta, where beta is a nonzero regular differential. In the universal family V^2=(x^4-1)(x-S), these are the audited exceptional character data with W=W_S, P_s the selected character point, A=O(4(P_s-O)), ell=h_s^2 and beta=-2sx dx/V. BOTH signs are allowed.

Let q:S->Y be connected finite etale of degree8 and chi a primitive generator k(S)=k(Y)(chi) satisfying
\[
div_infty(chi)=5G,\qquad dchi=q^*eta+chi\,q^*beta
\]
for one point G and a regular eta on Y. Put lambda=q^*A^3(-2G). Require the further ORIGINAL finite etale pi:T->S and h:T->X with equality pi^*lambda=h^*lambda_X and omega_X=lambda_X^-8. These are supplied, in the actual m=1 primitive quotient, by the audited character normal form and square-root calibration. No identification S=X is assumed.

The claim is that these inputs are impossible.

## The canonical norm excludes three endpoint pole points

M=omega_S tensor lambda^8 is trivialized by the actual pi, so it has prime-to5 finite order. Indeed a trivialization on the etale Galois closure over S descends by a finite character into k^*, which has prime-to5 order. Writing P=q(G), norms give
\[
O_Y(16P)=omega_Y^8\otimes A^2\otimes Nm_q(M)^{-1},\qquad
16[P-O]=2A-Nm_q(M).
\]
The second equality uses omega_Y=O(2O). In particular P cannot be any of W,P_s,P_s^-:

- For W, 16[W-O]=0, while 2A has order5.
- For P_s, 16D_s-2A=8D_s has exact order5.
- For P_s^-, 16(-D_s)-2A=-24D_s has exact order5.

None can equal a prime-to5 torsion class. This retains the actual first-leg condition; it does not hold for arbitrary one-leg q.

## All homogeneous character functions of pole at most five vanish

For each i=1,2,3,4 suppose a nonzero g in L_Y(5P) satisfies dg=i beta g. It cannot be constant. Regularity of dlog g implies all orders of g are divisible by5. Its only possible pole consequently has exact order5 at P and its zero divisor is5Q for one point Q. Since dg=i beta g and dlog ell=-beta, g ell^i=a^5 in k(Y), and therefore
\[
[Q-P]=-iA.
\]

Here is a genus-two divisor lemma requiring no intersection certificate. If distinct U,V satisfy [Q-P]=[U-V], then Q+V is linearly equivalent to P+U. A noncanonical degree-two divisor has a unique effective representative, giving P=V,Q=U. In the canonical case the hyperelliptic pencil gives P=U^-,Q=V^-. These are the only possibilities, and can coincide.

Use 5D_s=O-W and P_s+P_s^- equivalent to2O. Then
\[
A=[P_s^- -W],\quad -A=[P_s-W],\quad
2A=[P_s^- -P_s],\quad -2A=[P_s-P_s^-].
\]
The lemma gives the complete possible pole supports:

| Character class [Q-P] | Possible P |
| --- | --- |
| A | W or P_s |
| -A | W or P_s^- |
| 2A | P_s |
| -2A | P_s^- |

Every possibility was excluded by the actual canonical norm. Thus for i=1,2,3,4 the ONLY g in L_Y(5P) with dg=i beta g is zero.

## A forced factorization of the actual degree-eight minimal polynomial

Write the actual monic minimal polynomial
\[
F(Z)=Z^8+c_1Z^7+c_2Z^6+c_3Z^5+c_4Z^4+c_5Z^3+c_6Z^2+c_7Z+c_8.
\]
EVERY c_i is in L_Y(5P). Away from P all eight local roots are integral. At P, etaleness identifies the eight sheets with unramified local rings, and exactly ONE chi root has pole5, the other seven being regular. Each elementary symmetric coefficient therefore has pole at most5. This argument neither assumes Galois q nor substitutes a formal root for the actual chi.

The affine ODE for every conjugate gives, with c_0=1,
\[
dc_i=i\,beta c_i-(9-i)\,eta c_{i-1}.
\]
For i=4 the forcing coefficient is5, so dc_4=4 beta c_4. The preceding homogeneous-function exclusion gives c_4=0. For i=5, dc_5=-4 eta c_4=0. Hence c_5 is a fifth power on Y. A fifth root could have at most one simple pole at P, impossible on a genus-two curve, so c_5 is constant.

Now put d_6=c_6-c_5c_1, d_7=c_7-c_5c_2, d_8=c_8-c_5c_3. These functions still lie in L_Y(5P). The recurrence gives
\[
dd_6=beta d_6,\qquad dd_7=2beta d_7-2eta d_6,\qquad
dd_8=3beta d_8-eta d_7.
\]
Successively the homogeneous-function exclusion gives d_6=d_7=d_8=0. Consequently
\[
F(Z)=(Z^5+c_5)(Z^3+c_1Z^2+c_2Z+c_3).
\]
This contradicts the irreducibility of the actual degree-eight minimal polynomial, regardless of the value of the constant c_5. The source hypotheses are therefore impossible.

## Scope and verification needs

The changed proof uses the genus-two degree-two divisor lemma, the all-sheet coefficient pole bound, the differential recurrence and exact canonical norm. It needs no numerical replay, group classification, theta multiplicity argument or assumption that chi is Galois over the projective line. It covers all actual residual degrees deg(T/S) and every monodromy type of the primitive degree-eight q.

The remaining original character sector has m>=2. Extraction of this sector on an arbitrary unmarked common cover, actual X-field descent through the primitive quotient, and the full unmarked problem remain open.

[Statement](../../Theorems/cartier_and_spin/primitive_degree_eight_exclusion.md). [Independent audit](../../Research/audits/RECIPROCAL_PRIMITIVE_DEGREE_EIGHT_AUDIT_2026_10_02.md).

The actual-sector transfer uses [universal character normal form](../../Theorems/cartier_and_spin/actual_two_map_twisted_cartier_characters.md), [intrinsic character plane](../../Theorems/cartier_and_spin/genus_two_intrinsic_character_plane.md), [square-root calibration](../../Theorems/cartier_and_spin/actual_character_square_root_trace.md), and [the fixed positive plane](../../Theorems/cartier_and_spin/positive_cartier_plane_orbits.md). The ratio defining the square-root line depends only on chi and the original Y-field, so it descends to this actual intermediate source. Equivalently psi=chi^3/ell^2 satisfies dpsi=(chi^2/2ell^2)qeta; the original primitive differs by a fifth-power factor, preserving its embedded saturated line under etale pullback.

