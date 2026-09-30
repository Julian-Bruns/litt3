# Positive primitive traces can be computed entirely at infinity

Version1,29 September2026. Retain the primitive degree140 critical family
and its actual normalized critical curve C. Let a=g2,b=g3,c=g4,e=g5,
S=aW^3+bW^2+cW+e, phi=W^5+Qbar, T=t^3, and
Lambda=-S/phi-T/phi^2. Orient eta by
eta=(3b-aW)/2, so eta^2=b^2+2ac. Put
omega0=dx/(3y^2), delta=d/omega0, v=eta*delta(Lambda), and
B=delta(phi)=3A^2. For f regular on affine X write
\[
\operatorname{Tr}(f\phi v)=\sum_{n=-1}^{N}c_n\ell^n.
\]
Every coefficient is an explicit residue at the two points O4,O7
over O, or a residue on X at O. Define the following differentials
on the critical curve, with the derivation taken there:
\[
\Omega_n=f\eta\phi(\delta\Lambda)^2\Lambda^{-n-1}\omega_0,
\qquad \Psi_1=4f\eta B^2\phi^{-1}\omega_0,
\]
\[
N_0=\delta T+B S,
\quad
\Psi_0=-f\eta\left(
\frac{4TB^2}{\phi^3}-\frac{4(\delta T)B}{\phi^2}
+\frac{N_0^2/T-4B\delta S}{\phi}
\right)\omega_0.
\]
Then
\[
c_n=-\sum_{j=4,7}\operatorname{Res}_{O_j}\Omega_n
\quad(n\ge2),
\]
\[
c_1=\sum_{j=4,7}\operatorname{Res}_{O_j}(\Psi_1-\Omega_1),
\qquad
c_0=\sum_{j=4,7}\operatorname{Res}_{O_j}(\Psi_0-\Omega_0),
\]
and
\[
c_{-1}=-\operatorname{Res}_{O}
\left(f\,b^2\frac{(\delta a)^2}{a}\omega_0\right).
\]
The formulas are rational identities on the parameter base. They
specialize throughout the stated primitive open set, including
normalization jumps and exceptional endpoint charts. Thus positive
primitive traces require no endpoint-content denominators or choice
of a normalization Riemann--Roch basis. The formulas do not assert that
their common geometric zero locus is empty.

[Proof and constructive source](../../Proofs/cartier_and_spin/degree140_infinity_residue_traces.md).
