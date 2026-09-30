# Small trace conditions detect normalized critical-fibre ramification

Version1,29 September2026. Accepted incoming Pro result, without local
verification replay. Retain the complete constant degree140 family and
its original open chart from degree140_constant_compact_norm and
degree140_constant_a0_boundary. Let E(ell)=d0+d1*ell+d2*ell^2 be its
primitive scale quadratic on X. Let C be its smooth critical quadratic
curve and Lambda:C->P1 its degree140 critical-value map.

In the translated primitive coordinates put
d=g3^2+2g2*g4, eta^2=d, phi=W^5+Qbar, and
delta0=3y^2 partial_x+P' partial_y. Choose eta with the prescribed
leading coefficient epsilon at the infinity point O4, where Lambda has
pole4; the other infinity point O7 has pole7. Define
\[
v=\eta\delta_0(\Lambda),\qquad
T_f=\operatorname{Tr}_{k(C)/k(\Lambda)}(fv),\qquad
Q_f=\operatorname{Tr}_{k(C)/k(\Lambda)}(fv/\phi).
\]
For affine regular f with poles at most p at each infinity these are
polynomials, with
\[
\deg T_f\le\max(2,\lfloor(37+p)/4\rfloor,\lfloor(40+p)/7\rfloor),
\]
\[
\deg Q_f\le\max(5,\lfloor(17+p)/4\rfloor,\lfloor(33+p)/7\rfloor).
\]
Every nonzero entirely ramified Lambda-fibre annihilates all such traces.
In the incoming K=F_(5^8) coding,
\[
[\ell^9]T_1=\langle103636\rangle wh^{-24}\ne0,\qquad
[\ell^{10}]T_x=\langle104299\rangle h^{-27}\ne0.
\]
Thus P9=h^24*T1/(<103636>w) is a uniform monic degree-nine necessary
scale polynomial. The three Q1,Qx,Qx2 have degree at most five.

The normalization correction is exact. Set Gamma=floor(div0(d)/2),
r=deg(Gamma)<=16. Then
\[
\pi_*\mathcal O_C=\mathcal O_X\oplus\eta\mathcal O_X(\Gamma)
\quad\text{on affine }X,\qquad g(C)=33-r.
\]
Using bases of U=L((121-2r)O+Gamma) and
W=L((105-2r)O+2Gamma), the210-r polynomials
Tr(a v/phi), Tr(b eta v/phi), for a in U and b in W, have degree at
most floor((138-2r)/4)<=34. For a nonzero scale their simultaneous
vanishing is EQUIVALENT to the whole normalized fibre being ramified.
This includes all multiple discriminant zeros and wild indices.

The affine discriminant quotient has rank32, with a monomial basis
independent of parameters. It admits a cover by497 cyclic-coordinate
charts, retaining its nilpotents. Squarefree factorization in a chosen
chart gives the section spaces above, including multiplicities divisible
by five. A concrete implementation is in the incoming report.

The global simultaneous trace/square locus is still undecided. Five
specified ratios were excluded in the incoming computation; these are
not a geometric exhaustion. The criterion is necessary for the original
actual cover and constructs neither leg of a common cover.

[Proof and exact family](../../Proofs/cartier_and_spin/degree140_normalized_critical_trace.md).
