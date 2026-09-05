# A simple Jacobian forbids bidegree-two bi-etale self-correspondences

## Status and purpose

**Status: proved; independently audited (PASS).**

[Independent audit record](audits/SIMPLE_JACOBIAN_BIDEGREE_TWO_AUDIT.md).

The result below upgrades the graph exclusion in the nonscalar
cross-image route.  On a curve with simple Jacobian, two etale double
covers from the same connected curve cannot define a reduced integral
self-correspondence of bidegree \((2,2)\).  The proof is intrinsic: two
distinct free deck involutions generate a finite dihedral group, whose
rotation quotient would give a nontrivial etale double cover of
\(\mathbf P^1\).

Throughout, the ground field is algebraically closed.
No restriction on its characteristic is needed: a connected finite etale
cover of degree two is Galois, including in characteristic two, and its
nontrivial deck transformation is fixed-point-free.

## 1. The dihedral obstruction

### Theorem B.1 (two etale double presentations coincide)

Let \(X\) be a smooth projective curve of genus at least two whose
Jacobian \(J(X)\) is simple.  Let \(D\) be a smooth connected curve with
two finite etale maps

\[
                         u_1,u_2:D\longrightarrow X
\]

of degree two.  Then their deck involutions coincide.  Consequently there
is an automorphism \(\sigma\in\operatorname{Aut}(X)\) such that

\[
                              u_2=\sigma u_1.           \tag{B.1}
\]

#### Proof

Let \(\tau_i\) be the nontrivial deck involution of \(u_i\).  Both
\(\tau_i\) act freely.  Suppose for contradiction that
\(\tau_1\ne\tau_2\), and put

\[
                         \rho=\tau_1\tau_2,\qquad
                         G=\langle\tau_1,\tau_2\rangle.
\]

The curve \(D\) has genus \(2g(X)-1\geq3\), so
\(\operatorname{Aut}(D)\) is finite.  If \(m\) is the order of \(\rho\),
then \(m\geq2\) and \(G\) is the dihedral group

\[
                         G=\langle\rho,\tau_1:
                              \rho^m=\tau_1^2=1,\
                              \tau_1\rho\tau_1=\rho^{-1}\rangle
\]

of order \(2m\).  Let

\[
                              Q=D/G.
\]

Since \(D/\langle\tau_i\rangle\simeq X\), either presentation gives a
finite separable map

\[
                              X\longrightarrow Q
\]

of degree \(m\).

We claim that \(g(Q)=0\).  If \(g(Q)>0\), pullback along \(X\to Q\)
has finite kernel, because norm followed by pullback is multiplication
by \(m\).  It therefore has a positive-dimensional image in \(J(X)\).
Simplicity forces that image to be all of \(J(X)\), so
\(g(Q)=g(X)\).  Riemann--Hurwitz, with effective different even when
the quotient is wildly ramified, would then give

\[
 2g(X)-2\geq m\bigl(2g(Q)-2\bigr)
             =m\bigl(2g(X)-2\bigr),
\]

which is impossible for \(m\geq2\).  Thus \(Q\simeq\mathbf P^1\).

Now let

\[
                         E=D/\langle\rho\rangle.
\]

The normal rotation subgroup has index two in \(G\), so \(E\to Q\) has
degree two.  It is etale.  Indeed, if the induced involution fixed the
\(\langle\rho\rangle\)-orbit of a point \(P\in D\), then

\[
                         \tau_1(P)=\rho^j(P)
\]

for some \(j\).  The reflection \(\rho^{-j}\tau_1\) would fix \(P\).
When \(m\) is odd all reflections form one conjugacy class; when \(m\)
is even they form two classes, represented by
\(\tau_1\) and \(\tau_2=\rho^{-1}\tau_1\).  Both representatives are
free, so every reflection is free.  This is a contradiction.  In
characteristic two the same argument applies: the acting quotient is the
constant etale group \(C_2\), and a fixed-point-free action is a finite
etale torsor.

We have produced a connected etale cover

\[
                              E\longrightarrow\mathbf P^1
\]

of degree two, which is impossible over an algebraically closed field.
Therefore \(\tau_1=\tau_2\).

Both \(u_i\) are then categorical quotients of \(D\) by the same
involution.  The two identifications of that quotient with \(X\) differ
by a unique automorphism \(\sigma\), proving (B.1). \(\square\)

### Corollary B.2 (no reduced integral bidegree-\((2,2)\) image)

There is no reduced integral curve

\[
                         \Gamma\subset X\times X
\]

of bidegree \((2,2)\) whose normalization \(D\) is etale of degree two
over \(X\) by both projections.

#### Proof

Theorem B.1 makes the two normalization maps satisfy
\(u_2=\sigma u_1\).  Hence

\[
                         (u_1,u_2):D\longrightarrow X\times X
\]

has the graph of \(\sigma\) as its reduced image and has generic degree
two onto that graph.  It therefore cannot be the normalization map of a
reduced integral curve of bidegree \((2,2)\). \(\square\)

## 2. Consequence for the nonscalar cross-image sieve

In the notation of file 80_NONSCALAR_CROSS_IMAGE_TRACE_SIEVE.md, the
normalization \(D\) of the reduced cross-image has two etale maps to
\(X\), both of degree \(n=M/f\).  If \(J(X)\) is simple, Corollary B.2
excludes

\[
                              n=2.                     \tag{B.2}
\]

If in addition \(X\) is nonhyperelliptic and the coefficient involution
\(\delta\) is ramified, Lemma 80.2 excludes the graph case \(n=1\).
Consequently the reduced cross-image degree satisfies the uniform bound

\[
                              \boxed{n\geq3}.           \tag{B.3}
\]

This bound uses no scalarity assumption and no explicit endomorphism-ring
calculation.
