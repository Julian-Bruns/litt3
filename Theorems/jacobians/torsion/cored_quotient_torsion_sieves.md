# Coprime quotient and canonical-torsion sieves for actual cored spans

Work over an algebraically closed field. All orbifolds below are smooth,
proper, connected, effective Deligne--Mumford curves. All asserted atlases
are actual representable finite etale maps.

## 1. Disjoint inertia gives a genus inequality

Suppose \(T_1\to S\) and \(T_2\to S\) are finite étale of degrees
\(a,b\), with \(S\) hyperbolic. Write \(c,d\) for the genera of their
coarse curves and \(\kappa=\deg\omega_S>0\). If every stabilizer
order on \(T_1\) is coprime to every stabilizer order on \(T_2\), then
\[
\kappa\le 2+\frac{2(c-1)}a+\frac{2(d-1)}b. \tag{1}
\]
In particular, if both coarse curves are \(\mathbf P^1\), then
\(\kappa\le 2-2/a-2/b\).

The proof uses the ACTUAL stack fiber product, whose stabilizers are
trivial, and the arithmetic genus of its full reduced joint image.
It allows disconnected fiber products and wild inertia on S.

To apply this to endpoints X,Y with specified finite Galois quotients
X->T_1=[X/A], Y->T_2=[Y/B], one must prove that their actual maps to S
factor through these quotients. Equality of the coarse maps under A,B
is sufficient, because S is effective and separated. Low-degree pencil
bounds can establish this factorization; it is NOT automatic.

## 2. Uniform tame fibers carry bounded torsion classes

Let \(C\to S\) be an atlas of degree \(N\), with coarse
\(S=\mathbf P^1\) and tame stabilizer orders \(e_i\). Suppose
\(K_C\sim hO\), where \(h=2g(C)-2\).
Let \(H\) be the pullback of a degree-one divisor on \(\mathbf P^1\), and let \(D_i\) be
the reduced fiber at the i-th stacky point, so e_i D_i is linearly
equivalent to \(H\). Put \(E=\operatorname{lcm}(e_i)\) and \(A=Eh/N\).
Then \(A\) is a positive integer and, in \(\operatorname{Pic}^0(C)\),
\[
A[H-NO]=0,\qquad
Ae_i[D_i-(N/e_i)O]=0. \tag{2}
\]

Thus low-degree torsion-exclusion results for W_r(C,O) apply to the
actual branch fibers whenever A e_i has the relevant prime support.
For example, if W_r(C,O) has no nonzero ell-primary torsion and
A e_i is an ell-power, every such fiber of size <=r is linearly
equivalent to (N/e_i)O. If that size is greater than one and less than
the gonality of C, reducedness makes it impossible.

This is a tame-fiber criterion, not a wild ramification assertion.

Version2,2026-09-24.
[Proof](../../../Proofs/jacobians/torsion/cored_quotient_torsion_sieves.md).
