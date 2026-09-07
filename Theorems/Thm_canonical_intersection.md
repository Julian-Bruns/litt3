# Canonical-ring intersection of a coreless étale span

Let \(k\) be algebraically closed and
\(X\xleftarrow f Z\xrightarrow g Y\) a finite étale span of smooth
projective connected curves of genus at least two. Assume
\(k(X)\cap k(Y)=k\) inside \(k(Z)\). Using actual differential
pullbacks, put
\(A=f^*R(X)\cap g^*R(Y)\subset R(Z)\), where
\(R(C)=\bigoplus_{m\ge0}H^0(C,\omega_C^m)\).

Either \(A=k\), or \(A=k[s]\) for a homogeneous element of uniquely
determined degree \(d>0\), unique up to nonzero scalar. In the second
case, including \(m=0\),
\[
A_m=\begin{cases}ks^{m/d}&d\mid m,\\0&d\nmid m,\end{cases}
\qquad H_A(t)=(1-t^d)^{-1}.
\]
The inherited Poisson bracket on \(A\) is zero; this does not assert
centrality in either endpoint ring.

If \(A=k[s]\), its divisor is \(D=eS\), where \(e>0\) is an integer
and \(S\) is the nonempty reduced finite support, saturated under the
fibers of both maps (a clump). It is the unique nonempty clump. Writing
\(s=f^*s_X=g^*s_Y\), one has
\[
D=f^*\operatorname{div}(s_X)=g^*\operatorname{div}(s_Y),\quad
e|S|=d(2g(Z)-2),
\]
\[
e|f(S)|=d(2g(X)-2),\qquad e|g(S)|=d(2g(Y)-2).
\]
Over \(k=\overline{\mathbf F}_5\), conversely, any nonempty clump
implies \(A\ne k\). Thus in that field \(A\ne k\) is equivalent to
existence of a nonempty clump. Neither alternative is asserted to occur
in a specified positive-characteristic span; this theorem does not
establish existence of a clump or force \(d=1\).

The primitive weight is determined exactly by endpoint torsion. For a
clump with reduced endpoint divisors \(D_X,D_Y\), write
\(r_i=\deg D_i\), \(h_i=2g(i)-2\),
\(m=\gcd(r_X,r_Y)\), \(h=\gcd(h_X,h_Y)\), and
\[
d_0=m/\gcd(m,h),\qquad e_0=h/\gcd(m,h),\qquad
L_i=\mathcal O_i(e_0D_i)\otimes\omega_i^{-d_0}.
\]
These are degree-zero torsion line bundles over \(\overline{\mathbf F}_5\).
If \(q_i\) is their exact order and \(q=\operatorname{lcm}(q_X,q_Y)\),
then the primitive generator has \(d=d_0q\) and \(e=e_0q\).
Each endpoint separately has a regular weight-\(d_0q_i\) tensor \(t_i\)
with divisor \(e_0q_iD_i\), and, up to scalar,
\(s_i=t_i^{q/q_i}\). Such a root is not asserted shared.

If moreover \(\operatorname{Hom}(J(X),J(Y))=0\), then
\(q_X\mid\deg f\), \(q_Y\mid\deg g\). Thus
\(d/d_0\mid\operatorname{lcm}(\deg f,\deg g)\).
This uses the common pullback of the two actual line bundles, not
an independent one-leg Jacobian condition.

Version2,2026-09-07: exact clump-weight and endpoint-root formulas added;
proof consolidated. Author prose; no independent audit claimed.

[Proof](../Solutions/Sol_canonical_intersection.md).
