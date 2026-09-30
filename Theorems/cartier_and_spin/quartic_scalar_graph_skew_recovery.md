# Recovering a quartic scalar graph from its skew part

30 September2026. Let L/K be a separable extension of degree four,
with characteristic different from two. Put p0=Tr_(L/K)/4,
V=ker(p0), pi=1-p0, and use the nondegenerate pairing
<u,v>=p0(uv) on V. For a K-linear map M:V->V let M* denote its
adjoint. A scalar graph means epsilon in L\K and a K-linear form
a:V->K such that
\[
M(v)=\pi(\epsilon v)+a(v)\pi(\epsilon)\qquad(v\in V).
\]
If M-M* is nonzero, it has a one-dimensional kernel Kk. Every
scalar graph necessarily has
\[
\epsilon=M(k)/k.
\]
This formula is independent of the generator k. For this candidate,
existence of the graph is equivalent to
\[
M(v_i)-\pi(\epsilon v_i)\in K\pi(\epsilon)
\]
on any basis v1,v2,v3 of V, together with epsilon not in K.
It recovers all shifts without a scalar-coordinate pivot.

Equivalently, if k and M(k) are K-independent, the three elements
\[
kM(v_i)-M(k)v_i
\]
must belong to the same two-dimensional space <k,M(k)>_K.
These are exact denominator-free rank tests.

For L=K(t), t^4=m!=0, in characteristic five and the basis t,t^2,t^3,
write M=(Mij). One may take
\[
k=(M_{23}-M_{12})t+(M_{11}-M_{33})t^2
 +(M_{32}-M_{21})t^3.
\]
Its vanishing is exactly the self-adjoint boundary. On that boundary,
write epsilon=a+b t+c t^2+d t^3 and e=(b,c,d)^T. Every graph has
the form
\[
M=\begin{pmatrix}a&md&mc\\b&a&md\\c&b&a\end{pmatrix}
   +\kappa m\begin{pmatrix}bd&bc&b^2\\cd&c^2&bc\\d^2&cd&bd\end{pmatrix}
\]
for a scalar kappa in K. No conclusion that this boundary is empty
is asserted. In the actual endpoint incidence the shifts, the row
constants, and the SAME two shared moments must still be matched.

[Proof](../../Proofs/cartier_and_spin/quartic_scalar_graph_skew_recovery.md).
