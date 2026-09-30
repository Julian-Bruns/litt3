# Proof of trace survival and quartic contact

The exact conventions and all finite constants are in
[the accepted trace theorem](quartic_trace_obstruction.md). The new
[full report](../../../litt3-computation-data/actual_frontier_trial_replies_20260925/extracted/quartic_quotient/REPORT.md)
and its finite-field, endpoint, auxiliary-cover and jet certificates
have been preserved and checked locally.

## Exact nonempty trace locus

Put q=5^7, E=F_q, F=F_(q^2), and bar(x)=x^q. The primitive29th root
zeta satisfies bar(zeta)=zeta^-1. Nonzero exponents modulo29 form the
two5-power orbits of2 and6, each of length14. Fourier inversion gives
a bijection from F5^29 to F5 x F x F, with coordinates(S_0,S_2,S_6).
Explicitly, choose S_0 arbitrarily and propagate X=S_2,Y=S_6 by
S_(5j)=S_j^5; then d_j=4 sum_r S_r zeta^(-rj) lies in F5 and
recovers the moments. Its fifth power is itself by reindexing the sum.

Choose at each end labels(0,0),(1,0),(2,0),(3,0). The accepted tables
give C=[5], M=[22], a=[8]. Write gamma=C/a=[13] and
delta=gamma-bar(gamma)=[23]. Direct field arithmetic gives M/a=-1,
delta^2=2, gamma^2=3gamma+2 and delta!=0. The trace equations become
\[
\epsilon(-1+\bar X)=\gamma+\bar Y,\qquad X-1=\epsilon(\gamma+Y).
\]
Set x=X-1,y=Y+gamma. Then x=epsilon y and
epsilon bar(x)=bar(y)+delta. Necessarily y!=0, so epsilon=x/y is in F.
Substitution shows(N(epsilon)-1)bar(y)=delta. All solutions are therefore
\[
\epsilon\in F^*,\quad N=\epsilon\bar\epsilon\ne1,\qquad
X=1-\epsilon\delta/(N-1),\quad Y=-\gamma-\delta/(N-1).
\]
They are distinct as epsilon varies. The norm has q+1 elements per
nonzero fiber, so the number of epsilon values is q^2-q-2. Fourier
inversion adds five choices of S_0, giving5(q^2-q-2)=30,517,187,490.

For a constant-except-one profile, X=eta c^2,Y=eta c^6 with eta in F5,
c^29=1. The eliminated equation gives
gamma(3+eta U)+(1+eta V)=0, where U=c^6+c^-6,V=c^2+c^-2 are in E.
Since gamma is not in E, eta!=0,V=-1/eta,U=-3/eta. But U=V^3-3V
forces eta^2=1 and V=+/-1. This would give c^2 order dividing3 or6,
contradicting its29th-root condition. No such profile occurs.
Canonical weights0..4 thus give14<=12+sum d_j<=128. Also
epsilon c^4!=1 for every c^29=1, since that equality would give
N(epsilon)=1. Each weight can be placed on distinct unramified
coefficient-one points of a quartic fiber, at the level of local budgets.

At epsilon=2,S_0=0, Fourier inversion gives d_j=2 for
j in{0,1,2,3,7,11,14,16,17,19,20,21,23,24,25} and0 otherwise.
Thus n=42; the two trace equalities are checked exactly. The rational
parameter t=(z^4+z+1)/(z^4+z^3+2z+3) on P1 is a connected separable
quartic cover unramified over0,infinity and all29th roots. Its critical
value polynomial is2T^6+2T^5+3T^4+3T^3+4T^2+4, squarefree and
nonzero at1; a nontrivial29th root has degree14 over F5, so cannot
be a root. Gcd and resultant identities were checked. Choosing the
required points constructs only the parameter and divisor, not u,v.

## Contact at a common-pole point

Fix c^29=1, ell=epsilon c^4!=1, and put w=t-c,z=1/u. At a simple
common pole, both w,z have order1. The quartic A-identity gives a
unique formal Laurent function v=V(u,t)=L(t)u+B(t)+O(u^-1), with
L(c)=ell and L^4=epsilon^4t^-13. Let F(u,t) be the cube root of
epsilon^-17 t^48(P(V)/P(u))^2 with leading H(c)=ell. Actual branches
satisfy dv/du=F and du/dt=V_t/(F-V_u). Characteristic5 gives
L'/L=3/t and H'/H=1/t. Since deg P=10,
\[
P(V)/P(u)=L^{10}(1+P_9(L^{-1}-1)z+O(z^2)).
\]
The B-contribution vanishes because10=0. Clearing the denominator in
the equation for z gives a vector field with linear part
\[
(A_0w+B_0z)\partial_w-A_0z\partial_z,
\quad A_0=3\ell/c,\quad B_0=4P_9(1-\ell),
\]
both nonzero. Every graph z=s w+... must satisfy B_0s=-2A_0.
If two distinct graphs first differ by d w^m, m>=2, subtracting their
invariance equations in degree m gives
(-A_0m+B_0s)d=-A_0d. Therefore m=4 mod5. They are distinct branches
of the image since k(S)=k(u,t), so their intersection multiplicity is m.
For ell=1 the index4 rule allows at most one simple common pole.

## Global genus consequence

The(u,t)-image has arithmetic genus3(n-1). At(infinity,infinity), its
four smooth branches have orders(3,1), so contribute at least18 to
delta. Common-pole points are different image points. The previous
calculation contributes4 binom(s_c,2) there. Subtracting these delta
contributions gives the first bound.

The local fiber types give the second bound. Weight2 is a simple pair,
cost4. Weight3 can be one singular coefficient-three branch, cost>=1.
Weight4 can be that branch plus a simple branch, with intersection>=2,
cost>=3. Weight5 is one order(2,3) branch and two simple branches:
cost at least1+4+2+2=9. Weight6 is two order(2,3) branches, each of
delta>=1 and mutual intersection>=6, hence cost>=8. The last intersection
bound follows by substituting one branch into the other's monic
Weierstrass equation: z^2, w^2 z and w^3 all have order at least6.
All-simple alternatives cost more. Weight0,1 cost0. The exceptional
ell=1 cases satisfy the same minima. These are normalization and
intersection calculations; the bounded jet example is only a check.

The full report also gives a lossless affine-linearization over F_(5^7)
of the trace equation for any endpoint pair, followed by one norm
quadric. Its tested instances are retained as computational tools.
They cannot yield an empty global trace locus in view of the family
proved above, and are not used as a substitute for actual reconstruction.
