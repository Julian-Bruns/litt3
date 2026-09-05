# The degree-46 generalized profile is empty

## Status

**Status: proved, with an exact four-dimensional kernel certificate.**

This note eliminates the endpoint \(m=15\) in the generalized-profile table
of file 16. In fact it proves the stronger one-leg statement below, directly
in characteristic \(5\); no lifting theorem is needed.

**Theorem 27.1.** Over \(k=\overline{\mathbf F}_5\), there is no separable
degree-\(46\) map

\[
                         h:\mathbf P^1\longrightarrow\mathbf P^1
\]

which is unramified away from \(0,1,\infty\) and whose fiber above each of
those three values consists of one point of ramification index \(31\) and
fifteen unramified points.

Consequently, a minimal non-visible self-correspondence of degree below
\(62\) cannot lie in the \(m=15\) row.

## Normal form

Assume such a map exists. Its three index-\(31\) points are distinct. After
permuting the target markings and applying a source coordinate, suppose that
they are \(0,1,\infty\) and map respectively to \(0,1,\infty\). The three
fibers then give

\[
 h(t)=\frac{t^{31}A(t)}{C(t)},\qquad
 t^{31}A(t)-(t-1)^{31}B(t)=C(t),                       \tag{27.1}
\]

where

\[
                    \deg A,\deg B,\deg C\leq15.         \tag{27.2}
\]

For the asserted degree and fiber shape, \(A,B,C\) would in fact have degree
\(15\), and the three relevant homogeneous forms would have no common
factor.

## The characteristic-five Padé kernel

**Lemma 27.2.** Over any field of characteristic \(5\), all solutions of
(27.1)--(27.2) are

\[
\boxed{
 A=(t-1)^6P,\qquad B=t^6P,\qquad
 C=t^6(t-1)^6P,\qquad \deg P\leq3.}                    \tag{27.3}
\]

### Proof

Every triple in (27.3) is a solution, since

\[
\begin{aligned}
t^{31}A-(t-1)^{31}B
 &=t^6(t-1)^6P\bigl(t^{25}-(t-1)^{25}\bigr)\\
 &=t^6(t-1)^6P,
\end{aligned}
\]

using \((t-1)^{25}=t^{25}-1\) in characteristic \(5\).

It remains to prove that there are no other solutions. Write

\[
 A=\sum_{i=0}^{15}a_it^i,\qquad B=\sum_{i=0}^{15}b_it^i.
\]

Killing the coefficients of degrees \(16,\ldots,46\) on the left side of
(27.1) gives a \(31\)-by-\(32\) linear system in

\[
                  a_0,\ldots,a_{15},b_0,\ldots,b_{15}. \tag{27.4}
\]

Over \(\mathbf F_5\), this matrix has rank \(28\). For a compact exact rank
certificate, take rows

\[
\begin{split}
R={}&\{0,1,2,3,4,5,9,10,11,12,13,14,15,16,17,18,19,20,\\
    &\hspace{35mm}21,22,23,24,25,26,27,28,29,30\}
\end{split}
\]

and columns

\[
S=\{0,1,\ldots,21,26,27,28,29,30,31\}.
\]

The corresponding \(28\)-by-\(28\) minor has determinant \(1\) in
\(\mathbf F_5\), so the rank is at least \(28\). The four independent
solutions obtained by taking \(P=1,t,t^2,t^3\) show that the kernel has
dimension at least \(4\), so the rank is at most \(28\). They therefore form
the whole kernel. The nonzero minor and these four basis vectors remain so
after scalar extension from \(\mathbf F_5\) to any field of characteristic
\(5\), proving (27.3). The short script
27_DEGREE46_PADE_CERTIFICATE.py checks the matrix, minor, and four spanning
vectors exactly. \(\square\)

## Proof of the theorem

Apply Lemma 27.2 to the normal form (27.1). Since \(h\) is a map, the
resulting polynomial \(P\) is nonzero. It gives

\[
             h(t)=\frac{t^{31}(t-1)^6P(t)}
                            {t^6(t-1)^6P(t)}
                  =t^{25}                                      \tag{27.5}
\]

after cancellation. This is purely inseparable and has degree \(25\), not a
separable map of degree \(46\).

Equivalently, homogenize \(P\) to a cubic \(P_h(T,U)\), allowing powers of
\(U\) if \(\deg P<3\). The purported homogeneous degree-\(46\) numerator and
denominator have the common factor

\[
                  T^6U^6(T-U)^6P_h(T,U)
\]

of degree \(21\), and after cancellation they are \([T^{25}:U^{25}]\).
Thus they do not even define the required finite degree-\(46\) morphism.
This contradiction proves Theorem 27.1. \(\square\)

## Consequence for searches

The low-degree search is now reduced to

\[
                            m=0,1,\ldots,14.
\]

This endpoint failure is invisible from cycle types alone: Proposition 26.2a
gives a transitive triple of passport \((31,1^{15})^3\), so Riemann
existence gives a characteristic-zero cover. In characteristic \(5\), the
entire Padé kernel instead collapses through the \(25\)-power Frobenius.
