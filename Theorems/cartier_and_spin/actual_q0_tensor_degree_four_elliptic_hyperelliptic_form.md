# Two normal forms for the elliptic degree-four tensor branch

Version1,3 October2026. Independently accepted in the [elliptic normal-form and Weierstrass audit](../../Research/audits/Q0_FOUR_ELLIPTIC_WEIERSTRASS_AUDIT_2026_10_03.md). This record is a necessary form, not an exclusion or computation.

In the actual degree-FOUR cubic-index-THREE tensor self-span, suppose the joint x-curve B has genus ONE. Center q0(X)=X²+D with D≠0. The two maps have poles3Ri+Q, with common Q and distinct Ri, and div(z)=2R1−2R2. Put a=z(Q)≠0. The odd numerators in its cubic hyperelliptic model are either coprime or proportional.

In the COPRIME case, after multiplying z by a cube root of unity, there are constants a,u,v,w,L0,L1 and ω²+ω+1=0 such that
\[
y^2=\Phi(z)=z\bigl(L(z)^2+D(z-\omega^2)(z-a)\bigr),\qquad L=L1z+L0,
\]
and the actual functions are
\[
X_1=\frac{(z+u)L(z)}{z(z-a)}+\frac{(vz+w)y}{z^2(z-a)},\qquad
X_2=\frac{(vz+w)L(z)}{z-a}+\frac{(z+u)y}{z-a}.
\]
The coefficient relations are
\[
w^2=a\omega,\quad 2u-v^2=-a-1-\omega,\quad
u^2-2vw=a(1+\omega)+\omega.
\]
In particular a,w,(a+u),(va+w) are nonzero. Also L1²+D≠0 and L0²+Dω²a≠0, and Φ is squarefree. If Q is not Weierstrass, L(a)≠0; if it is Weierstrass, L(a)=0 and a≠ω².

Thus the coprime subcase has a single normalized partition type and a necessary three-dimensional coefficient family: a,u can be eliminated from the first two equations, leaving one relation in v,w and the two coefficients of L.

In the PROPORTIONAL case there are κ,b1∈k× and e∉{0,a}, with a=κ⁻², such that
\[
X_1=\frac{A(z)}{z(z-a)}+\frac{b1(z-e)y}{z^2(z-a)},\qquad
X_2=\frac{A(z)}{\kappa(z-a)}+\frac{\kappa b1(z-e)y}{z-a},\qquad\deg A\le2,
\]
and
\[
b1^2(z-e)^2\Phi(z)=az\bigl(A(z)^2+D(1-z^3)(z-a)\bigr).
\]
The right side must have the indicated double factor and yield a squarefree cubic Φ. This subcase is retained explicitly; it has not been excluded.

Both normal forms still require the actual pure-three ramification, selected P-branch set and P-cube/differential identities. No original Y-leg is replaced or asserted to descend.

[Proof](../../Proofs/cartier_and_spin/actual_q0_tensor_degree_four_elliptic_hyperelliptic_form.md).
