# A parameterized weighted-grid interval

## Status and purpose

**Status: proved; independent audit pending.**

File 68 shows that a pair with prime genus ratio

\[
 g(Y)-1=r\bigl(g(X)-1\bigr)
\]

has a universal norm-coefficient reduction in every possible diamond
degree \(M\).  This note generalizes the weighted-grid argument of file 66
for one especially rigid row: the coefficient map is quadratic, its
degree-\(2r\) closure is cyclic, and the coefficient normalization has
genus one.

Write

\[
 s=g(X)-1,\qquad g(Y)-1=rs.
\]

If the hyperelliptic branch values of \(Y\) are rational over
\(k_0=\mathbf F_q\), then the relevant elliptic spectral curve is forced
to descend to \(k_0\) throughout the interval

\[
                           r\nmid M,\qquad M<rs.         \tag{70.1}
\]

The resulting point-count inequality is

\[
 \#E(k_0)\geq
 r\left(
   2Ms-2\bigl(\operatorname{Cast}(M,w-1)-1\bigr)
       -\left\lfloor {2M\over r}\right\rfloor
 \right),                                               \tag{70.2}
\]

where \(w\) is the coefficient-space dimension.  If the right side
exceeds \(q+1+2\sqrt q\), the row is impossible.

For the original pair, \((r,s,q)=(7,2,125)\), this recovers file 66.
That special-case file is retained until the present general theorem has
been independently audited.

## 1. Hypotheses and the elliptic spectral cover

Let \(k=\overline{\mathbf F}_p\), with \(p\ne2,r\), and let

\[
 \begin{array}{ccc}
 V&\xrightarrow{a}&Y\\
 \downarrow p_V&&\\[-2mm]
 C&\xrightarrow{c}&X
 \end{array}
 \qquad
 \deg p_V=r,\qquad \deg a=\deg c=M                       \tag{70.3}
\]

be the prime-ratio diamond of file 68.  Assume:

1. \(Y\) is hyperelliptic of genus \(rs+1\), with function
   \(t:Y\to\mathbf P^1\);
2. all \(2rs+4\) branch values
   \(\mathcal A\subset\mathbf P^1\) of \(t\) belong to
   \(\mathbf P^1(k_0)\);
3. the norm-coefficient map \(q_C:C\to B\) has degree two;
4. \(g(B)=1\); and
5. the resulting extension \(k(V)/k(B)\) is Galois with cyclic group
   \(C_{2r}\).

Put

\[
 K=k(V),\qquad F=k(C),\qquad k(E)=k(B)(t).
\]

The general coefficient square gives

\[
 [K:F]=[k(E):k(B)]=r,\qquad
 [K:k(E)]=[F:k(B)]=2,\qquad
 [k(E):k(t)]=M.                                        \tag{70.4}
\]

### Lemma 70.1 (elliptic translation and the marked divisor)

The degree-\(r\) map

\[
                         \pi:E\longrightarrow B
\]

is etale.  Hence \(g(E)=1\), and, after choosing an origin, its generator
is translation

\[
                         \tau=T_Q,\qquad 0\ne Q\in E[r].
                                                               \tag{70.5}
\]

The hyperelliptic square root does not belong to \(k(E)\).  If
\(\Delta=\operatorname{Br}(C/B)\), then

\[
                    \deg\Delta=2Ms,\qquad
                    S:=\pi^*\Delta
\]

is a reduced \(\tau\)-invariant divisor of degree

\[
                              |S|=2rMs.                 \tag{70.6}
\]

For every \(P\in S\),

\[
                  t(P),t(\tau P),\ldots,t(\tau^{r-1}P)
                              \in\mathcal A.             \tag{70.7}
\]

#### Proof

Every inertia subgroup in the cyclic extension \(K/k(B)\) meets
\(\operatorname{Gal}(K/F)=C_r\) trivially, because \(V\to C\) is etale.
The only possible nontrivial inertia is therefore the unique subgroup of
order two.  Its fixed field is \(k(E)\).  Thus \(E\to B\) is etale, and
both curves have genus one.  Its deck generator is translation by a
nonzero \(r\)-torsion point.

If the hyperelliptic square root belonged to \(k(E)\), the factorization
in file 68 would give a finite-etale map from the genus-one curve \(E\)
to the genus-\((rs+1)\) curve \(Y\), which is impossible.  Therefore
\(K=k(E)(z)\), and \(V\) is the normalized pullback of
\(Y\to\mathbf P^1_t\) along \(E\to\mathbf P^1_t\).

Riemann--Hurwitz for the double cover \(C\to B\) gives

\[
 \deg\Delta=2g(C)-2=2Ms.
\]

Its pullback \(S\) is the branch divisor of \(V\to E\).  In the normalized
hyperelliptic pullback it is exactly the reduced divisor of index-one
points of \(t:E\to\mathbf P^1\) over \(\mathcal A\).  This proves
(70.6)--(70.7).  \(\square\)

## 2. The translated pair and finite-field descent

Assume now that

\[
                              r\nmid M.                 \tag{70.8}
\]

### Lemma 70.2 (the translated pair is birational)

The map

\[
      \Phi=(t,t\tau):E\longrightarrow\mathbf P^1\times\mathbf P^1
                                                               \tag{70.9}
\]

is birational onto an integral curve \(\Gamma\) of bidegree \((M,M)\).

#### Proof

Let \(D\) be the normalization of \(\Gamma\), let
\(u:E\to D\) have degree \(f\), and note that \(f\mid M\).  The map is
separable, and Riemann--Hurwitz gives \(g(D)\leq1\).

If \(D\simeq\mathbf P^1\), then both coordinate functions factor through
degree-\(M/f\) functions on \(D\).  Hence

\[
             t^*\mathcal O(1)\simeq\tau^*t^*\mathcal O(1).
\]

Translation by \(Q\) fixes a degree-\(M\) line bundle on an elliptic curve
only if \([M]Q=0\), contrary to (70.8).

If \(g(D)=1\), then \(u\) is an isogeny after choosing origins, and its
deck group \(H\) consists of \(f\) translations.  It fixes \(t,t\tau\);
since translations commute, it fixes every \(t\tau^i\).  It therefore
fixes all coefficients of

\[
                       \prod_{i=0}^{r-1}(T-t\tau^i).
\]

Those coefficients generate \(k(B)\).  The group \(H\) descends to
\(B=E/\langle\tau\rangle\), and its descended action is nontrivial when
\(f>1\), because \(\gcd(f,r)=1\).  This contradicts coefficient-field
generation.  Thus \(f=1\), proving the lemma. \(\square\)

We use the weighted grid lemma from file 66: an integral bidegree-
\((n,n)\) curve in \(\mathbf P^1\times\mathbf P^1\), whose normalization
has more than \(2n^2\) marked branches over a \(k_0\)-rational grid, is
defined over \(k_0\).  Its proof counts local intersection multiplicities
with the Frobenius conjugate, so collisions among marked branches do not
weaken the conclusion.

### Proposition 70.3 (the general descent interval)

If

\[
                              r\nmid M,\qquad M<rs,
                                                               \tag{70.10}
\]

then \(E,t,t\tau,Q,\tau,\pi\), and \(\Delta\) all descend to \(k_0\).

#### Proof

By Lemma 70.1,

\[
                         \Phi(S)\subset\mathcal A^2
               \subset(\mathbf P^1\times\mathbf P^1)(k_0).
\]

The marked set has size \(2rMs\), while \(\Gamma\) has bidegree
\((M,M)\).  The weighted grid lemma applies precisely when

\[
                         2rMs>2M^2,
\]

which is \(M<rs\).  Thus \(\Gamma\), its normalization \(E\), and both
coordinate functions descend.

The Weil lower bound supplies a \(k_0\)-point on \(E\); choose it as
origin.  The two rational degree-\(M\) pole divisors satisfy

\[
 [ (t\tau)^{-1}(\infty)-t^{-1}(\infty) ]=-[M]Q
                         \quad\text{in }J(E)=E.         \tag{70.11}
\]

If \(F_0\) is \(q\)-power Frobenius, then
\([M](F_0Q-Q)=0\).  Also \([r](F_0Q-Q)=0\).  Assumption (70.8) gives
\(F_0Q=Q\).  Hence \(Q,\tau\), and the quotient \(\pi\) descend.
Finally \(S\) is intrinsically the reduced index-one divisor of the
descended function \(t\) over \(\mathcal A\), so \(S\) and
\(\Delta=\pi(S)\) descend as well. \(\square\)

## 3. The point-count inequality

For \(d,N\geq2\), let \(\operatorname{Cast}(d,N)\) denote Castelnuovo's
genus bound for a nondegenerate degree-\(d\) curve in \(\mathbf P^N\).
If

\[
 d-1=a(N-1)+b,\qquad0\leq b<N-1,
\]

then

\[
 \operatorname{Cast}(d,N)
   ={a\choose2}(N-1)+ab.                               \tag{70.12}
\]

Let \(w\) be the dimension of the norm-coefficient space.

### Theorem 70.4 (parameterized weighted-grid bound)

Under (70.10),

\[
 \boxed{\quad
 \#E(k_0)\geq
 r\left(
   2Ms-2\bigl(\operatorname{Cast}(M,w-1)-1\bigr)
       -\left\lfloor {2M\over r}\right\rfloor
 \right).\quad}                                        \tag{70.13}
\]

Consequently the cyclic genus-one quadratic row is impossible whenever

\[
 r\left(
   2Ms-2\bigl(\operatorname{Cast}(M,w-1)-1\bigr)
       -\left\lfloor {2M\over r}\right\rfloor
 \right)
       >q+1+2\sqrt q.                                   \tag{70.14}
\]

#### Proof

The descended coefficient morphism maps \(B\) birationally onto a
nondegenerate degree-\(M\) curve

\[
                         B'\subset\mathbf P^{w-1}.
\]

Since \(g(B)=1\), its total normalization defect satisfies

\[
 \delta(B')\leq\operatorname{Cast}(M,w-1)-1.            \tag{70.15}
\]

For every \(b\in\Delta\), the \(r\) roots of its norm form lie in the
rational branch set \(\mathcal A\), so its coefficient image belongs to
\(B'(k_0)\).  If \(N\) geometric points of \(\Delta\) are not rational,
their Frobenius orbits lie over rational singular points of \(B'\).
A normalization fiber containing \(R\geq2\) such points contributes at
least \(R-1\geq R/2\) to the delta invariant.  Hence

\[
 N\leq2\delta(B')
   \leq2\bigl(\operatorname{Cast}(M,w-1)-1\bigr).        \tag{70.16}
\]

At least the first two terms inside the parentheses in (70.13) therefore
count rational points of \(\Delta\).

It remains to bound rational fibers which do not split.  The map

\[
                  (\pi,t):E\longrightarrow B\times\mathbf P^1
\]

is birational onto its image because its generic degree divides both
\(r\) and \(M\).  That image has arithmetic genus

\[
                              (r-1)M+1,
\]

whereas its normalization \(E\) has genus one.  Thus its total delta
invariant is \((r-1)M\).  A fiber on which all \(r\) values of \(t\)
coincide produces \(r\) distinct smooth branches through one image point
and costs at least

\[
                              {r\choose2}
\]

units of delta.  There are therefore at most

\[
             \left\lfloor{(r-1)M\over {r\choose2}}\right\rfloor
                  =\left\lfloor{2M\over r}\right\rfloor             \tag{70.17}
\]

constant-labelled fibers.

For a rational \(b\in\Delta(k_0)\), Frobenius acts on the geometric
\(C_r\)-fiber as \(\tau^j\).  Since \(t,\tau\), and all values in
\(\mathcal A\) are rational, \(j\ne0\) would force all \(r\) labels in
that fiber to be equal.  Every nonconstant-labelled rational fiber
therefore splits completely and contributes \(r\) points to \(E(k_0)\).
Equations (70.6), (70.16), and (70.17) prove (70.13).  The Weil upper
bound proves (70.14). \(\square\)

## 4. Consequences for pair design

The descent interval

\[
                              M<rs=g(Y)-1
\]

gets longer when \(g(X)-1=s\) grows, while the norm polynomial still has
only \(r+1\) coefficients.  This makes a small prime \(r\) and a moderately
large \(s\) attractive, provided one can arrange:

1. an absolutely simple \(J(Y)\);
2. a rational hyperelliptic branch set over a field \(k_0\) small enough
   for (70.14) to beat the Weil bound; and
3. a tractable Rosati-symmetric endomorphism lattice for \(J(X)\).

These are finite, checkable arithmetic design criteria.  They explain
which part of the original \((r,s,q)=(7,2,125)\) calculation is reusable
and give a quantitative test for replacement pairs before attempting the
remaining birational and dihedral rows.

