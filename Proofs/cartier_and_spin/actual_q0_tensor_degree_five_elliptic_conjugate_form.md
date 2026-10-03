# Proof: the two complete coprime elliptic conjugate families

Version1,3 October2026. New necessary form, pending independent review. This is a coefficient and pole argument; no computation is used.

Use the same actual z and TWO distinct conjugate simple poles as in the [conjugate-pole form](actual_q0_tensor_degree_five_conjugate_pole_form.md). For elliptic B the actual pole bounds give
\[
x_1=A_1/[zJ]+b y/[z^2J],\quad
x_2=A_2/J+c y/J,\quad J=z-a,
\]
where Ai have degree at most TWO, b,c degree at most ONE, c has degree ONE and b(0)≠0. Assume b,c coprime. The odd q-cube coefficient A2 c=A1 b gives A1=cL,A2=bL for a linear L. Normalize c=z+u,b=vz+w by scaling y. The exact even identity is
\[
M(\Phi-zL^2)=D z(z^3-1)(z-a)^2,\qquad M=zc^2-b^2.
\]
M is monic cubic and divides(z³−1)(z−a)². If M has order exactly ONE at a, Φ(a)=aL(a)², so the product of x1's two residues is aL(a)²M(a)=ZERO. At least one actual simple pole cancels, impossible. Thus either M has no root at a, or its multiplicity there is at least TWO. These possibilities give exactly
\[
M=z^3-1,\quad a^3\ne1,
\qquad\text{or}\qquad M=(z-a)^2(z-r),\quad r^3=1.
\]
In the second case a=r is allowed and has multiplicity THREE. Its residue product is nonzero precisely when T_r(a)=a²+ra+r²≠0. Also Φ(a)≠0 is required for TWO distinct points above a. In the first case Φ(a)=aL(a)² forces L(a)≠0.

Center q0=x²+D and scale xi to D=ONE for these necessary local equations only. In the first case compare coefficients:
\[
2u=v^2,\quad u^2=2vw,\quad w^2=1.
\]
If v=ZERO, then u=ZERO. The odd local part of x2 at R1 begins in order THREE, whereas its even part bL/(z−a) would begin in order TWO unless L(a)=ZERO. The only actual indices are ONE/THREE, so L(a)=ZERO is forced, contrary to the two-point-pole condition. Therefore v≠0 and v³=3w. Write v=2wρ,ρ³=ONE, giving u=2ρ². Replace z by ρ²Z, and set Lnew=wL(ρ²Z)/ρ². The equations for y and x2 become the Type I formula; x1 has just the harmless common centered sign w. Thus b=2Z+ONE,c=Z+TWO without losing either w sign or a phase. No fixed-P invariance under these local symmetries is asserted.

For the second case first normalize r to ONE by the same µ3 coordinate change, adjusting y,L and the centered x1 sign as required. Comparing coefficients gives
\[
2u-v^2=-2a-1,\quad u^2-2vw=a^2+2a,\quad w^2=a^2.
\]
Write w=εa,ε=±ONE. Substitution eliminates u and gives the exact factor identity
\[
a(v+\varepsilon)^2=4(v-1)^2(v+1)^2.
\]
If v=−ε, then u=−a and b=−εc, which is proportional and does not meet the current coprime hypothesis. Otherwise cancellation yields a=4(v−ε)². The branch v=ε gives a=ZERO, contradicting distinctness from R1. A centered x1 sign normalizes ε=ONE, giving
\[
a=4(v-1)^2,\qquad u=4v^2+3v+3,\qquad w=a,\qquad v\ne\pm1.
\]
There is no restriction v≠ZERO. In fact a−vu=(v−ONE)(v+ONE)², so the listed exclusions are exactly the coprime/distinctness boundaries of these coefficient solutions. Substitution of the even identity gives Φ=z[L²+z²+z+ONE], with the physical opens in the statement. The case a=ONE, including the triple root of M, remains when these opens permit it.

For either family put A=cL,B=bL and differentiate with δ=y d/dz. Define
\[
U=A'zJ-A(2z-a),\quad
V=(b'\Phi+b\Phi'/2)zJ-b\Phi(3z-2a),
\]
\[
C=B'J-B,\quad W=(c'\Phi+c\Phi'/2)J-c\Phi.
\]
Then δx1=(zyU+V)/(z³J²), δx2=(yC+W)/J². Their exact rational norms have polynomial numerators
\[
N_1=(V^2-z^2\Phi U^2)/z^2,\qquad N_2=W^2-\Phi C^2,
\]
and square pole denominators. Norms are squares because dxi and the regular nonzero elliptic differential dz/y have even local divisors. This is a necessary ramification statement, independent of a chosen derivative class.

Write p=lead(Φ)≠0 and p0=Φ′(0)≠0. N2 has degree EIGHT and leading p². N1 has degree at most EIGHT, and N1(0)=(3ab(0)p0/2)²≠0. Reverse N1 to z8N1(1/z), giving a nonzero square leading coefficient while retaining its permitted degree-SIX edge when v=ZERO in Type II. Matching the top four coefficients of a quartic square divides only by the known nonzero leading square root; its remaining FOUR coefficients give four equations. Together the two norms give EIGHT equations in the three indicated parameters. They are necessary only: no fixed-P cube, actual carrier or Y-map is inferred from their solutions.
