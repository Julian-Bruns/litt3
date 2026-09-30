# Canonical-ring intersection of a coreless étale span

Let \(k\) be algebraically closed and
\(X\xleftarrow f Z\xrightarrow g Y\) a finite étale span of smooth
projective connected curves of genus at least two. Assume
\(k(X)\cap k(Y)=k\) inside \(k(Z)\). Using actual differential
pullbacks, put
\(A=\bigoplus_{m\ge0}H^0(\Omega^m)=f^*R(X)\cap g^*R(Y)\subset R(Z)\),
where \(\Omega\) is the
[canonical invariant line bundle](../../Definitions/canonical_tensors.md)
and \(R(C)=\bigoplus_{m\ge0}H^0(C,\omega_C^m)\).

Either \(A=k\), or \(A=k[s]\) for a homogeneous element of uniquely
determined degree \(d>0\), unique up to nonzero scalar. In the second
case, including \(m=0\),
\[
A_m=\begin{cases}ks^{m/d}&d\mid m,\\0&d\nmid m,\end{cases}
\qquad H_A(t)=(1-t^d)^{-1}.
\]
The inherited Poisson bracket on \(A\) is zero; this does not assert
centrality in either endpoint ring.

The polynomial-ring and Hilbert-series assertions hold more generally
for the section ring \(\bigoplus_{m\ge0}H^0(L^m)\) of any invariant
line bundle \(L=(L_X,L_Y,\phi)\). The remaining conclusions concern
canonical tensors.

In the positive-generator case the intersection of the RATIONAL canonical
tensor algebras, allowing every integral weight, is exactly k[s,s^(-1)].
Thus a nonzero common rational weight-m tensor exists iff d divides m,
and it is a scalar multiple of s^(m/d). For arbitrary nonzero rational
endpoint one-forms theta_X,theta_Y, put delta=g*theta_Y/f*theta_X in the
actual joint field M=k(X)k(Y). The class of delta in
\(M^*/(k(X)^*k(Y)^*)\) has exact order d.
These assertions do not require gcd(d,e)=1 and do
not assert that the multiplicative quotient vanishes for arbitrary spans.

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
Conversely, over every algebraically closed \(k\), a nonempty clump
implies \(A\ne k\). Thus \(A\ne k\) is equivalent to existence of a
nonempty clump. Neither alternative is asserted to occur
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
Their common pullback makes them a degree-zero invariant line bundle.
They are torsion over \(k\), by the finiteness of
\(\operatorname{Pic}^0(X\leftarrow Z\to Y)\) in
[Krishnamoorthy, Lemma8.9](https://msp.org/ant/2018/12-5/ant-v12-n5-p05-p.pdf#page=34).
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

In characteristic zero, \(A=k\) and there are no clumps, by the same
paper's Corollaries8.13 and9.2.

In characteristic p>0 the primitive weight d is prime to p.
Every shared rational one-form is regular, and their space has dimension
at most one. The exact characteristic-power membership and logarithmic
decomposition criteria belong to
[saturated divisor relations](saturated_divisor_relations.md), which
also determines the root height when no clump exists.

Version8,2026-09-24. The later saturated-divisor theorem subsumes the
former fixed-power test; this statement retains the primitive-ring,
clump and exact-weight results on which that theorem depends.

[Proof](../../Proofs/shared_tensors/matched_section_rings.md).
