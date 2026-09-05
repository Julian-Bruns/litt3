# Plane coefficient curves are forced to have classical Gauss map

## Status and consequence

**Status: proved.**

This note treats the characteristic-five issue in the plane
coefficient-map route.  It applies simultaneously to the original
\((r,s,M)=(7,2,9)\) diamond and to the prospective
\((r,s,M)=(3,8,6)\) row of the order-three redesign.  Here

\[
 g(X)=s+1,\qquad g(Y)=rs+1,
\]

\(p:V\to C\) is a cyclic etale cover of prime degree \(r\), and the two
horizontal etale maps have degree \(M\).  Thus

\[
                         g(C)=Ms+1.                    \tag{P.1}
\]

Suppose the norm-polynomial coefficient space has dimension three and
defines a birational map

\[
                  q:C\longrightarrow B\subset\mathbf P^2
\]

with coefficient line bundle \(L\) of degree \(2M\).  The theorem below
proves that the Gauss map of \(B\) is separable and the generic tangent has
ordinary contact order two.  In particular, none of the failures of the
uniform-position principle caused by a Frobenius-nonclassical plane curve
can occur here.

This does not yet exclude a classical plane coefficient curve.  It removes
the principal positive-characteristic loophole from any subsequent
Pluecker, dual-curve, or tangent-line argument.

## 1. A plane Gauss lemma

We use the following standard form of the plane Gauss-map theorem.

### Lemma P.1 (plane Gauss map)

Let \(D\) be a smooth curve over an algebraically closed field of
characteristic \(p>2\), and let a base-point-free three-dimensional linear
series of degree \(d\) define a birational map

\[
                         \phi:D\longrightarrow\mathbf P^2.
\]

Let \(\mathfrak R_\phi\) be the common zero divisor of the three
Wronskians

\[
                         s_i,ds_j-s_j,ds_i
\]

and put \(b=\deg\mathfrak R_\phi\).  Then the moving Wronskians define
the Gauss map \(\gamma:D\to(\mathbf P^2)^\vee\), and

\[
          \deg\gamma^*\mathcal O(1)=2d+2g(D)-2-b.      \tag{P.2}
\]

The separable degree of \(\gamma\) is one.  If \(\gamma\) is inseparable,
its inseparable degree is a power \(p^e\geq p\), the normalization of the
dual curve has genus \(g(D)\), and the generic tangent-contact order is at
least \(p\).  At every point where \(\phi\) is immersive, the local
tangent-contact order is at least the generic one.

#### Proof

The Wronskians are sections of
\(L_\phi^2\otimes\omega_D\).  Removing their common divisor gives (P.2).

For completeness, the remaining assertions are the plane case of the
Monge--Segre--Wallace Gauss-map theorem.  They can also be seen directly
on an affine chart.  Choose a separating coordinate \(x\) and write the
map as \((x,y)\).  The tangent line is determined by

\[
                 m={dy\over dx},\qquad b_0=y-mx.
\]

If \(dm\ne0\), then \(db_0=-x\,dm\), so
\(x=-db_0/dm\) and then \(y=b_0+mx\) belong to the Gauss function field.
Thus its separable part is birational.  If \(dm=0\), the Gauss map factors
through relative Frobenius; iterating gives a purely inseparable degree
\(p^e\), followed by the same birational separable part.  Relative
Frobenius preserves the genus.  Finally, in a local expansion, vanishing
of the derivative of the tangent slope kills every possible tangent term
of order \(2,\ldots,p-1\).  Hence nonclassical tangent contact is at least
\(p\).  Upper semicontinuity of the order sequence gives the last
assertion.  \(\square\)

## 2. The generalized special-collision budget

Let

\[
 P(T)=\operatorname{Nm}_{V/C}(T-t)
\]

be the degree-\(r\) norm polynomial.  The hyperelliptic map
\(t:Y\to\mathbf P^1\) has

\[
                         2rs+4                        \tag{P.3}
\]

branch values.  For each such value \(\alpha\), write

\[
                  \operatorname{div}(P(\alpha))=2D_\alpha,
                  \qquad \deg D_\alpha=M,
\]

and put \(n_{\alpha,x}=\operatorname{mult}_xD_\alpha\).

### Lemma P.2 (cyclic spectral collision bound)

One has

\[
 \boxed{
  \sum_{\alpha}\sum_{x\in C}
          n_{\alpha,x}(n_{\alpha,x}-1)
                    \leq 2M(r-1).}                    \tag{P.4}
\]

#### Proof

The map \((p,t):V\to C\times\mathbf P^1\) is birational onto its spectral
image: the orbit of \(t\) under the order-\(r\) deck transformation has
size \(r\).  Etale-locally on \(C\), its branches are the graphs of
\(t,t\beta,\ldots,t\beta^{r-1}\).  Its conductor divisor on \(V\) is

\[
                  \sum_{j=1}^{r-1}(t,t\beta^j)^*\Delta_{\mathbf P^1}.
\]

Each summand has degree \(4M\), because both functions have degree
\(2M\).  Hence the full conductor has degree \(4M(r-1)\).

Above \((x,\alpha)\), the \(n_{\alpha,x}\) relevant branches are distinct
on \(V\), since \(a\) is etale, and \(t-\alpha\) has order two on each.
Every ordered pair of these branches therefore contributes at least two
to the conductor.  Summing gives

\[
 2\sum_{\alpha,x}n_{\alpha,x}(n_{\alpha,x}-1)
                   \leq4M(r-1),
\]

which is (P.4).  \(\square\)

## 3. Excluding Frobenius-nonclassical plane images

Define

\[
 d_0(g)=\min\left\{d\geq1:
             {(d-1)(d-2)\over2}\geq g\right\}.        \tag{P.5}
\]

### Theorem P.3 (quantitative Gauss-classicality criterion)

In the setup of (P.1), suppose the coefficient map is birational and
plane.  If

\[
 \left\lceil {M\bigl(r(2s-1)+5\bigr)\over r}\right\rceil
       >2M(s+2)-5d_0(Ms+1),                            \tag{P.6}
\]

then the plane coefficient curve has separable Gauss map and generic
tangent-contact order two.

#### Proof

Let \(\mathfrak R_q\) be the stationary divisor from Lemma P.1 and put
\(b=\deg\mathfrak R_q\).  Suppose for contradiction that the Gauss map is
inseparable.

First bound \(b\) from below.  The total multiplicity in all special half
divisors is

\[
               \sum_{\alpha,x}n_{\alpha,x}=M(2rs+4).  \tag{P.7}
\]

For a fixed \(x\), the sum of \(n_{\alpha,x}\) over all branch values is
at most \(r\): it counts those roots of the degree-\(r\) polynomial
\(P_x(T)\) which belong to the hyperelliptic branch set.  Since
\(\mathfrak R_q\) has at most \(b\) distinct points, the part of (P.7)
supported at stationary points is at most \(rb\).

At a nonstationary point \(x\), the plane map is immersive.  If
\(x\in D_\alpha\), the line represented by \(P(\alpha)\) has contact
order

\[
                              2n_{\alpha,x}.
\]

Lemma P.1 and inseparability make this order at least five.  Hence
\(n_{\alpha,x}\geq3\), and

\[
                 n_{\alpha,x}(n_{\alpha,x}-1)
                              \geq2n_{\alpha,x}.       \tag{P.8}
\]

Lemma P.2 says that the total nonstationary multiplicity is consequently
at most \(M(r-1)\).  Combining this with (P.7) gives

\[
 rb\geq M(2rs+4)-M(r-1)
       =M\bigl(r(2s-1)+5\bigr).                        \tag{P.9}
\]

This is the left side of (P.6).

For the opposite bound, the Wronskian bundle has degree

\[
 2\deg L+2g(C)-2=4M+2Ms=2M(s+2).                      \tag{P.10}
\]

By Lemma P.1, the inseparable Gauss degree is at least five and the
normalization of the dual plane curve has genus \(Ms+1\).  Its plane
degree is therefore at least \(d_0(Ms+1)\).  Equation (P.2) and (P.10)
give

\[
                         b\leq2M(s+2)-5d_0(Ms+1).      \tag{P.11}
\]

Inequalities (P.9) and (P.11) contradict (P.6).  Therefore the Gauss map
is separable.  The plane Gauss lemma then gives ordinary generic contact
order two.  \(\square\)

### Corollary P.4 (the original degree-nine row)

For \((r,s,M)=(7,2,9)\), every birational plane coefficient curve has
classical Gauss map.

#### Proof

Here \(g(C)=19\), so \(d_0(g(C))=8\).  The two sides of (P.6) are

\[
 \left\lceil{9(7\cdot3+5)\over7}\right\rceil=34,
 \qquad
 2\cdot9\cdot4-5\cdot8=32.
\]

Thus Theorem P.3 applies.  \(\square\)

### Corollary P.5 (the order-three degree-six redesign row)

For \((r,s,M)=(3,8,6)\), every birational plane coefficient curve has
classical Gauss map.

#### Proof

Here \(g(C)=49\), so \(d_0(g(C))=12\).  The two sides of (P.6) are

\[
 \left\lceil{6(3\cdot15+5)\over3}\right\rceil=100,
 \qquad
 2\cdot6\cdot10-5\cdot12=60.
\]

Again Theorem P.3 applies.  \(\square\)

## 4. Exact remaining plane bottleneck

The theorem is deliberately not phrased as an exclusion of the plane
row.  Once the Gauss map is classical, a special line can be simply tangent
at several distinct branches.  Those branches become a singular point of
the dual curve, and the available dual-curve delta invariant is large
enough to accommodate the presently known lower bound on special
tangencies.  Likewise, stationary points of \(q\) can absorb as many as
\(r\) special roots each.

Thus a completion of the plane route needs one further input which is not
contained in Pluecker degrees alone: either a relation between the
\(\mathbf F_2\)-labels and the singularities of the dual curve, or a bound
on stationary full-grid points using the explicit cyclic spectral cover.
The result above ensures that such an argument may work entirely in the
classical/reflexive plane setting; no hidden inseparable Gauss map remains.
