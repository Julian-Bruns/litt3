# Proof: global Hermite interpolation of the actual two infinity jets

Version2,3 October2026. Versions1 and2 independently accepted in the [nonreal and jet-budget audit](../../Research/audits/Q0_DEGREE_SIX_NONREAL_AND_JET_BUDGET_AUDIT_2026_10_03.md). Version2 adds the common-triple value comparison and strengthened overlap restrictions. See the [statement](../../Theorems/cartier_and_spin/actual_q0_tensor_all_degree_infinity_second_jet_budget.md).

Retain TWO original finite étale maps from the SAME source to the fixed genus-nine X and proportional original q0 tensors. In the accepted cubic-index-THREE coarse reduction retain the actual fields C0, B and Bx, with B=Bx(z), [B:Bx] equal to ONE or THREE, and z³=(x2²+ONE)/(x1²+ONE) after the permitted common centering and scaling. Put d=[B:k(xi)]. The poles of either xi have orders ONE or THREE. The simple infinity points of the two functions are the SAME set of size u. Let each function have r triple infinity points, let c of these points be common to both, and put r′=r−c. Thus d=u+THREE r.

If u>ZERO, the first jet is either ordinary at ALL shared simple points, meaning z−z(Q) is a genuine uniformizer, or critical at ALL of them. We first treat the ordinary sector and then retain the critical sector directly without dividing by dz. If u=ZERO, use the same global leading ratio ρ determined by the tensor scalar and the constants below; no local parameter at a nonexistent simple point is required. The common-triple zeros will still contribute to the budget.

Retain the independent centered sign ε and the fixed p²=ν. Write ρ for the global leading coefficient ratio, K=ερ−ONE, and a=z(Q). The ordinary condition gives K≠ZERO. The exact jets give
\[
a^3=\rho^2,
\qquad \xi(Q)=\xi_0,\qquad
l_1=\frac{aKp}{3\rho},
\qquad \xi=x_2-\rho x_1.
\]
Here ξ0 is ONE global constant, and l1 is the actual residue of x1 in the parameter z−a. The normalized second asymptotic coefficient is B1=B2=−ν, independently of the two centered signs. Consequently
\[
\left.\frac{d\xi}{dz}\right|_Q
=\frac{B_2-\rho^2B_1}{2\rho l_1}
=\frac{C}{a},
\qquad C=\frac{3(B_2-\rho^2B_1)}{2Kp}.
\]
This statement does not require z to have degree TWO. It only uses its actual ordinary local parameter at each original shared simple pole.

Let R1,R2 be the reduced residual triple pole divisors of x1,x2 respectively, each of degree r′. The cube identity gives div(z)=TWO R1−TWO R2. At a common triple point, the accepted triple jet makes ξ regular; no inverse-cube local coordinate is used. Thus ξ has no poles except R1,R2, where its pole orders are exactly THREE. If r′=ZERO then z is constant and B=Bx; the quadratic q identity gives d≤TWO. Hence for d>THREE the residual divisors are nonempty.

The additional triple-pole coefficient fixes its finite value. In an actual uniformizer write x=l u^-3+m u^-2+n u^-1+k0+…. Direct multiplication in characteristic FIVE gives the normalized target tensor
\[
T(x)(dx)^3=\frac3l\left[1+3(m/l)u+2(n/l)u^2+
\left(\frac{k_0+A}{l}+2(m/l)^3+(m/l)(n/l)\right)u^3+\cdots\right](du)^3.
\]
Indeed x^-4 contributes ONE+(m/l)u+(n/l)u²+(k0/l)u³, the cubed derivative contributes ONE+TWO(m/l)u+((n/l)+THREE(m/l)²)u²+(FOUR(m/l)³+THREE(m/l)(n/l))u³, and A/x first enters at degree THREE. The common leading and TWO preceding coefficients already identify l2=ρl1,m2=ρm1,n2=ρn1. Hence the third coefficient gives k0,2−ρk0,1=ρA1−A2=ξ0 at EVERY common triple point. Its z-value still has a³=ρ². The [standalone overlap proof](actual_q0_tensor_common_triple_value_and_overlap_bound.md) records the full multiplication and critical-index check.

Define the globally rational function
\[
F(z)=\xi_0+\frac{C}{3\rho^2}(z^3-\rho^2).
\]
At every shared simple point F(a)=ξ0 and F′(a)=Ca²/ρ²=C/a. Therefore ξ−F vanishes to order at least TWO at ALL u shared simple points, including different sheets of the same z-fiber. At each of the c common triple points both ξ and F equal ξ0, giving at least ONE additional zero there.

If C≠ZERO, F has pole SIX at every R2 point, whereas ξ has pole at most THREE. Hence ξ−F is nonzero and has exact pole divisor THREE R1+SIX R2. It follows that
\[
2u+c\le9r',\qquad d\le3r+\frac{9(r-c)-c}{2}\le\frac{15}{2}r.
\]
This improves the leading-coordinate bound u≤SIX r′ and the Version1 double-zero budget by the c common-triple value zeros, without a genus assumption on B or a polynomial ansatz for its functions.

If C=ZERO, equivalently ρ²=ONE in this ordinary sector, F=ξ0. Unless ξ is constant, its exact pole divisor is THREE R1+THREE R2 and the same double-zero argument gives
\[
2u+c\le6r',\qquad d\le3r+3(r-c)-c/2\le6r.
\]
If ξ is constant, x2 is affine in x1, so Bx=k(x1) and B=Bx(z) has degree at most THREE over k(x1). Thus d≤THREE. In particular the displayed stronger bound applies to every d>THREE survivor with ρ²=ONE.

Finally retain the critical first-jet sector K=ZERO. Here ρ=ε, so ρ²=ONE. In ANY actual uniformizer u at a shared simple pole, before using z as a parameter, the second jet is
\[
\left.\frac{d\xi}{du}\right|_Q
=\frac{B_2-\rho^2B_1}{2\rho l_1}=0.
\]
The first jet still gives ξ(Q)=ξ0. Hence ξ−ξ0 has a double zero at every shared simple point and a zero at every common triple point. The SAME pole and constant-function arguments prove TWO u+c≤SIX r′ for d>THREE, without assuming a local z-parameter at a simple point.

For the new common-triple local restriction, use
\[
q(x_2)-\rho^2q(x_1)=2\rho x_1\xi+\xi^2+1-\rho^2.
\]
If K≠ZERO then ξ0=THREE Kp≠ZERO and the right side has exact pole THREE at a common triple point, whereas q(x1) has pole SIX. Thus z³−ρ², and z−a, have exact order THREE. If K=ZERO then ρ²=ONE and ξ vanishes there; the right side has pole at mostTWO, giving z-index at leastFOUR. Since deg z=TWO r′, r′=ONE cannot coexist with any common triple point. This excludes the entire c=ONE TWO-triple profile, not merely its former numerical degree bound. The r′=ZERO constant case stays outside the stated scope.

Thus every d>THREE cubic-index-THREE span satisfies TWO u+c≤NINE(r−c), and the entire ρ²=ONE sector satisfies TWO u+c≤SIX(r−c). If common triple points exist then r−c≥TWO. Both original maps and any original Y-leg remain on their SAME source. The function F is constructed INSIDE the actual coarse field; B is not an étale replacement endpoint. The budget leaves many multi-triple profiles possible and does not provide a finite common core. Turning these bounds into tensor-field recognition remains a separate gap.

## The next asymptotic coefficient does not restrict the ratio

This is a failed extension, retained to avoid a false sixth-root claim. Write q0⁸/P²=x⁻⁴(ONE+A/x+B/x²+C3/x³+…). At a shared simple pole x=l/u+m+nu+ku²+…, the coefficient of u³ in its normalized cubic tensor bracket is
\[
\frac{C_3-Bm}{l^3}-\frac{3n(m+A)}{l^2}.
\]
The k term cancels because FIVE=ZERO. Substitute the accepted first and second jet comparisons. The m,n terms also cancel, leaving
\[
(C_3+AB)(1-\varepsilon\rho^3)=0
\]
for the two centered fixed copies. This would restrict the global ratio if C3+AB were nonzero, but on the fixed curve it is identically ZERO.

Indeed, if p,r,s are the normalized coefficients P9,P8,P7, then A=−TWO p, B=THREE+THREE p²−TWO r and C3=p³+p(r−ONE)−TWO s. Hence C3+AB=−TWO(p+s). Before the common √D scaling the centered P7 is FOUR a+ONE and P9=FOUR a+TWO, with D=THREE+FOUR a and a²=a+THREE. Direct substitution gives P9 D+P7=ZERO. After scaling this is s=−p. The third bracket coefficient is therefore automatic; neither ρ⁶=ONE nor any finite ratio list follows from it.
