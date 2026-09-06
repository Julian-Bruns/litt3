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

[Proof](../Solutions/Sol_canonical_intersection.md).
