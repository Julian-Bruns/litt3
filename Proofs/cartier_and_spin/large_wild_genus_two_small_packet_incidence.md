# Proof: global differential factors and elimination of the small wild-fiber values

Version1,3 October2026. [Statement](../../Theorems/cartier_and_spin/large_wild_genus_two_small_packet_incidence.md). Pending independent review. Use the existing actual Frobenius packet, the corrected factor FOUR in the leading relation, and [the exact finite Hermitian recognizer](large_wild_hermitian_finite_jet_recognition.md). Both original endpoint maps remain unchanged on the SAME T.

## A new pole-five global differential factor

At a simple F-zero, use t=F and σ=f(t)dt. Exactness of dH0=t³σ kills f1. Since D=1/f(t), this makes dD vanish at that point. All finite F-zeros are precisely these unramified wild points; in the distinguished-wild case the remaining F-zero is P itself. Thus E=dD/(Fσ) is regular off P.

Ordinarily/tamely F has pole7. Its derivative has pole≤8, so D=dF/σ has pole≤10; the pole10 term differentiates to zero, making dD's pole≤10. The denominator Fσ has pole5, giving E∈L(5P). In the distinguished-wild case F has pole5. Its leading term differentiates to zero, so dF has pole≤5, D has pole≤7 and dD has pole≤8. The denominator now has pole3, again giving E∈L(5P).

For the coefficient claim write F=A3+yB1, y²=Φ(z),σ=dz/y. Direct differentiation gives
\[
D=yA_3'+\Phi B_1'+\tfrac12\Phi'B_1,
\quad \frac{dD}{\sigma}=\Phi A_3''+\tfrac12\Phi'A_3'
+y\left(\Phi B_1'+\tfrac12\Phi'B_1\right)'.
\]
Write E=A2+v y. In the invariant part of dD/σ=FE the coefficient of z⁶ is lc(A3) on the left and v·lc(B1) on the right: Φ is monic quintic, its leading derivative vanishes, and A3'' has leading coefficient6lc(A3)=lc(A3). This proves the claimed relation. No vanishing of v is inferred.

## Eliminating the local K0 and R1 values

The corrected leading packet says \(\mathcal R(R)\)f0⁵=4c/λ⁵=A. Since D(R)=1/f0, this is exactly \(\mathcal R(R)=A D(R)^5\). The fourth-jet relation is \(\mathcal T(R)^5\)f0¹⁰=3cH0(R), giving the second incidence equation.

Write local coefficients with subscripts. The initial J-gap at order20, using J=F²⁰K0+K1⁵, says
\[
K_0(R)=-K_{1,4}^5=\mathcal R_1(R)^5 f_0^5,
\]
because K1,4=4\(\mathcal R_1(R)\)f0 and−4=1. Differentiate \(\mathcal R=\lambda K_1+F^4W\) and divide by F³σ. This gives the displayed global formula for \(\mathcal T\); at R it says \(\lambda\mathcal R_1=\mathcal T+WD\). Thus
\[
K_0(R)=\lambda^{-5}\left(\frac{\mathcal T(R)^5}{D(R)^5}+W(R)^5\right)
=2H_0(R)\mathcal R(R)+\lambda^{-5}W(R)^5.
\]
The final equality uses \(\mathcal T^5=3cH_0D^{10}\), \(\mathcal R=4c\lambda^{-5}D^5\), and3/4=2. This proves Q(R)=2H0(R)\(\mathcal R(R)\). Since W⁵ has zero differential, dQ=dK0=\(\mathcal R\)dH0 globally.

## Eliminating the remaining overlap coefficients

Use the local coefficients rj of \(\mathcal R\) and fj of σ/dF. The already established r1=r2=r3=f1=0 gives J29=4(r0f5+r5f0). The exact finite recognizer's overlap equation, after substituting G145=cH0,5+J29⁵, G149=4cf5, G125=J25⁵ and G120=J24⁵, is
\[
cH_{0,5}+(4r_5f_0)^5=\frac{cJ_{25}}{r_0}.
\]
Multiply by r0 and use the CORRECT relation r0f0⁵=4c/λ⁵. This gives J25=r0H0,5+λ⁻⁵r5⁵. Meanwhile
\[
J_{25}=K_{0,5}+K_{1,5}^5,
\qquad r_5=\lambda K_{1,5}+W_1.
\]
Cancelling K1,5⁵ gives K0,5−λ⁻⁵W1⁵=r0H0,5. The left side is exactly Q5, proving the final incidence condition. No choice of the invisible fifth coefficient of H0 is imposed; all primitives and their gauges are retained.

## Why the compact incidence is also sufficient locally

For this converse assume the same global differential and decomposition identities, including d\(\mathcal R\)=F³\(\mathcal T\)σ, \(\mathcal R=\lambda K_1+F^4W\), J=F²⁰K0+K1⁵ and G=cF¹⁴⁰H0+J⁵, with the stated nonzero values on the simple F-zero fiber. Exactness gives f1=0 and the differential identity for \(\mathcal R\) kills r1,r2,r3; then the same holds for the first three K1 coefficients. The first incidence equation supplies the leading Hermitian relation and common fixed-base scalar. The second gives cH0+(2r4f0)⁵=0, hence the third ratio identity; the other two ratios follow from r2=r3=0. Combining the second and third incidence equations reverses the K0-value calculation and recovers K0(R)=−K1,4⁵, hence the missing J-gap coefficient20. The derivative identity for K0 kills coefficients1,2,3, completing J's gap1,…,23 and G's gap1,…,119. The Q5 incidence reverses the last calculation and supplies exactly the overlap equation.

All hypotheses of the exact finite recognizer now hold, so the full completed-local extension is Hermitian with the correct filtration. This sufficiency is LOCAL ONLY. It does not extend the local models to an actual global carrier or replace either original finite étale endpoint map.
