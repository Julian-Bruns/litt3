# Generation defect and the positive-plane exception for rank-three orbits

Version2,23September2026. Retain the actual genus-nine/genus-two
backup span, its first-Y-Galois closure q:T->Y of degree8d, and the
full conjugate radical orbit ell_i of degree-3d. If its saturation
is q^*E of rank3 and degree e downstairs, then e=-1,0,1,2.
Put A=E-perp, deg A=e-2, and let R_A be its adjunction-zero divisor,
of degree12-5e with multiplicities at most3.

Let I=image(q_*ell_0->B_Y), tau=length(E/I). Then
\[
0\le\tau\le e+1.
\]
Write R_A[j] for the reduced multiplicity-j part. There is a reduced
divisor C on Y such that
\[
\gcd_i h_i^*D_X=q^*C,\quad R_A[3]\le C,\quad \deg C\le3,
\quad \deg(C-R_A[3])\le\tau .
\]
The extra support is over the orbit-generation defect.
All h_i^*D_X avoid q^*R_A[2]. In particular, for e=-1 the gcd
is exactly q^*R_A[3].

For P_i=Sat(q^*A+ell_i), the common degree m obeys
\[
(8e-19)d\le m\le8d(e-1),\qquad m\le3d\ \text{or}\ m=7d.
\]
Thus the upper bounds for e=-1,0,1 are -16d,-8d,0. For e=2
one has -3d<=m<=3d or the isolated value7d.

At that isolated value all P_i are actual pullbacks of the canonical
positive plane P_X. Put V_Y=E/A. Then
\[
\mu_{\min}(F_Y^{r*}V_Y)\ge7\cdot5^r/8 ,
\]
so F_Y^*V_Y is semistable. For R_i=h_i^*R_P,
q^*R_A[2]<=R_i and q^*R_A[1] is disjoint from every R_i.
If R_A=2P, then gcd_i R_i=q^*P. In this case the contact divisor
of q^*A and the canonical second line lambda_i inside P_i has degree9d
and contains q^(1)*F_Y(P). Its effective residual has degree d, and
the residual divisors have empty common support. If R_A=P+Q is split,
the same contact divisors avoid both corresponding complete fibers.

Finally the three actual canonical grades of F_Y^*E are
\[
\omega_Y^3(-D_1-D_2-D_3),\quad
\omega_Y^2(-D_2-D_3),\quad
\omega_Y(-D_3),\qquad D_j=R_A[j].
\]
For e=-1, semistability of F_Y^*E forces deg(R_A)_red>=8.
No full degree row or actual rank-three span is excluded.

[Proof](../../Proofs/cartier_and_spin/rank_three_radical_orbit_constraints.md).
