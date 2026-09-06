# A sharp small positive ramification-tail gap

**Status:** collaborative author proof, self-checked 2026-09-05; not
independently audited. Authors: root and gluing_cohomology_rigidity.

This note proves a local conductor bound and applies it to a genuine
representable finite etale cover of an effective orbifold. It does not
replace such a cover by an unrelated curve, and it never assumes that the
global monodromy group is a \(p\)-group. The local argument complements
[file 13](13_PROOF_LOCAL_RAMIFICATION.md).

## 1. The conductor bound and the sharp gap

Let \(k\) be algebraically closed of odd characteristic \(p\). Let a
nontrivial finite \(p\)-group \(P\) act faithfully on \(k[[z]]\), and write
its lower ramification filtration as \(G_i\). Thus
\(G_0=G_1=P\). Define the tail

\[
                         T=\sum_{i\ge2}(|G_i|-1).
\]

### Theorem 1

If \(0<T<p^2-1\), there is an integer \(1\le t\le p\) such that

\[
 \begin{gathered}
 T=t(p-1),\qquad
 G_2=\cdots=G_{t+1}=N\simeq C_p,\qquad G_{t+2}=1,\\
 \boxed{\quad |P|\le p^{\,1+2v_p(t)}.\quad}                         \tag{1}
 \end{gathered}
\]

Consequently,

\[
 \boxed{\quad
  G_2\ne1,\ P\not\simeq C_p
  \quad\Longrightarrow\quad T\ge p(p-1).
 \quad}                                                           \tag{2}
\]

More precisely, \(0<T<p(p-1)\) forces

\[
 P=C_p,\qquad T=(b-1)(p-1),\qquad 2\le b\le p-1,                   \tag{3}
\]

where \(b\) is the unique lower break. The threshold in (2) is attained
by local actions of groups of order \(p^3\).

#### Proof of the bound

If any \(G_i\), \(i\ge2\), had order at least \(p^2\), its single
contribution would already be at least \(p^2-1\). Therefore every
nontrivial group in the tail has order \(p\). Nestedness gives precisely
the displayed filtration with \(t=T/(p-1)\), and \(t\le p\).
The subgroup \(N\) is normal in \(P\), hence central: conjugation gives a
homomorphism from a \(p\)-group to
\(\operatorname{Aut}(C_p)\), whose order is prime to \(p\).

Put \(m=|P|/p\). Choose a nontrivial complex character
\(\lambda:N\to\mathbf C^\times\), and an irreducible complex
representation \(V\) of \(P\) with central character \(\lambda\). Such a
representation occurs in \(\operatorname{Ind}_N^P\lambda\). Write
\(h=\dim V\).

The central-character summand of the regular representation has dimension
\(m\). Equivalently, Frobenius reciprocity gives

\[
 \operatorname{Ind}_N^P\lambda
   =\bigoplus_{\chi|_N=(\dim\chi)\lambda}
                  (\dim\chi)\,V_\chi,\qquad
 \sum_{\chi|_N=(\dim\chi)\lambda}(\dim\chi)^2=m.
\]

In particular,

\[
                              h^2\le m.                            \tag{4}
\]

On the other hand, \(V^P=V^N=0\). The lower-filtration formula and
integrality of the Artin conductor give

\[
 a(V)=\sum_{i\ge0}\frac{|G_i|}{|P|}
                         \operatorname{codim}V^{G_i}
      =2h+\frac{t}{m}h\ \in\mathbf Z.                              \tag{5}
\]

These standard conductor facts apply to the finite Galois extension
\(k((z))/k((z))^P\); finite residue field is not required. A primary
reference is Serre, *Local Fields*, Chapter VI, section 2,
[Artin Representation](https://link.springer.com/chapter/10.1007/978-1-4757-5673-9_7).

Equation (5) says \(m\mid th\), so
\(m/\gcd(m,t)\mid h\). Together with (4), this implies

\[
                     m\le\gcd(m,t)^2\le p^{2v_p(t)},
\]

which proves (1). If \(0<T<p(p-1)\), then \(1\le t\le p-1\), so (1)
forces \(m=1\), or \(P=C_p\). Its break is \(b=t+1\).
A cyclic degree-\(p\) extension in equal characteristic has break prime
to \(p\): an Artin--Schreier equation in reduced Laurent form has a
largest pole order not divisible by \(p\). Thus \(b=p\), corresponding
to \(t=p-1\), is impossible. This proves (2) and (3).
\(\square\)

The assumption \(T>0\) matters: weakly ramified noncyclic \(p\)-groups
have \(T=0\), and are not excluded by (2).

### Sharpness calculation

Consider the smooth Hermitian curve

\[
                             y^p+y=x^{p+1}.
\]

For \(a,b\in\mathbf F_{p^2}\) with \(b^p+b=a^{p+1}\), the transformations

\[
                 (x,y)\longmapsto(x+a,\ y+a^p x+b)                  \tag{6}
\]

form a group \(P\) of order \(p^3\). They preserve the equation, and
there are \(p\) choices of \(b\) for every \(a\).
The unique point at infinity is fixed. At that point,

\[
           v(x)=-p,\qquad v(y)=-(p+1),\qquad z=x/y
\]

is a uniformizer. These valuations also follow directly from the
projective equation \(Y^pZ+YZ^p=X^{p+1}\) in the chart \(Y=1\).
For the transformation \(\sigma=\sigma_{a,b}\),

\[
       \sigma(z)-z=
       \frac{ay-a^p x^2-bx}{y(y+a^p x+b)}.
\]

If \(a\ne0\), the numerator has valuation \(-2p\), so
\(v(\sigma(z)-z)=2\). If \(a=0\) and \(b\ne0\), that valuation is
\(p+2\). Therefore

\[
 G_0=G_1=P,\qquad
 G_2=\cdots=G_{p+1}=\{\sigma_{0,b}:b^p+b=0\}\simeq C_p,
 \qquad G_{p+2}=1.
\]

Thus \(T=p(p-1)\), proving sharpness of the local threshold. This
calculation is a local realization, not an assertion that every
numerically allowed orbifold atlas below exists.

## 2. Uniform one-point orbifolds

Let \(\mathcal S\) be a smooth proper effective DM orbifold over \(k\),
with coarse curve \(\mathbf P^1\), exactly one stacky point, and inertia
the \(p\)-group \(P\). Suppose a smooth connected curve \(X\) of genus
\(g\ge2\) admits a representable finite etale map

\[
                    X\longrightarrow\mathcal S
\]

of degree \(n\). Set \(r=n/|P|\).

### Proposition 2

There are exactly \(r\) points of \(X\) over the stacky point. At each
one the completed coarse map is the same local \(P\)-Galois extension,
up to isomorphism, and hence has the same different exponent

\[
                           d=2(|P|-1)+T.
\]

The coarse map is unramified elsewhere, and

\[
                    \boxed{\quad 2g-2=r(T-2).\quad}                \tag{7}
\]

In particular \(T>2\) and \(T\le2g\). If \(2g<p(p-1)\), necessarily

\[
 \begin{gathered}
 P=C_p,\quad 2\le b\le p-1,\quad
 (p-1)(b-1)>2,\\
 r=\frac{2g-2}{(p-1)(b-1)-2}\in\mathbf Z_{>0},\qquad n=pr.          \tag{8}
 \end{gathered}
\]

#### Proof

After completion at the stacky point, the orbifold is
\([\operatorname{Spec}k[[z]]/P]\). Pulling the etale cover back to
\(\operatorname{Spec}k[[z]]\) gives \(n\) copies of that strictly
henselian trait. Since the source is a scheme, \(P\) acts freely on the
set of copies. Each orbit has size \(|P|\); its quotient contributes
one completed local trait of \(X\), with coarse map
\(k[[z]]^P\subset k[[z]]\). This proves both the divisibility and the
uniformity assertion, including the full filtration, not just the
ramification index.

The different formula is the usual lower-group sum. Riemann--Hurwitz
for the coarse map now gives

\[
 2g-2=-2n+rd
      =r\bigl(-2|P|+2(|P|-1)+T\bigr)=r(T-2).
\]

As \(r\ge1\), this gives \(2<T\le2g\); Theorem 1 yields (8).
\(\square\)

### Characteristic five, genus nine

Here \(T\le18<20\). The three possible cyclic breaks in (8) are
\(b=2,3,4\), giving \(T=4,8,12\). Only \(T-2=2\) divides
\(2g-2=16\). Consequently the only profile is

\[
 \boxed{\quad
 P=C_5,\quad G_0=G_1=G_2=C_5,\quad G_3=1,\quad
 d=12,\quad r=8,\quad n=40.
 \quad}                                                           \tag{9}
\]

In the original conductor check, \(N=G_2=C_5\) is central also directly
from \([G_1,G_2]\subseteq G_3=1\), and (5) reads
\(a(V)=2h+5h/|P|\). No assertion about the global Galois closure is
needed. Formula (9) is a necessary profile, not an existence result.

## 3. Why an ordinary atlas excludes the profile

The stronger, independent observation recorded in
[Ordinary atlas local different bound](ORDINARY_ATLAS_LOCAL_DIFFERENT_BOUND.md)
excludes every hyperbolic one-point orbifold with an ordinary atlas,
without first classifying its inertia.

For completeness, if an ordinary smooth proper curve \(Y\) maps
representably etale to such an orbifold with coarse curve \(\mathbf P^1\),
write \(q:Y\to\mathbf P^1\) for the coarse map, and let \(e,d\) be the
uniform local ramification index and different
exponent at any chosen stacky point. Choose a coordinate \(t\) on
\(\mathbf P^1\) whose unique pole is that point. If \(d\ge2e\), then
the nonzero exact differential \(q^*dt=d(q^*t)\) is holomorphic on
\(Y\): at the pole fiber its order is \(d-2e\), and elsewhere all its
orders are nonnegative. This contradicts injectivity of Cartier on
holomorphic differentials of an ordinary curve. Therefore

\[
                                  d<2e.                            \tag{10}
\]

For pure \(p\)-inertia with odd \(p\), (10) and
\(d=2(e-1)+T\) force \(T<2\), hence \(T=0\). More generally a
hyperbolic one-point orbifold requires \(d/e>2\) by
Riemann--Hurwitz, already contradicting (10).

In particular the fixed ordinary genus-25 curve of
[file 76](../../Theorems/Thm_fixed_pair_arithmetic.md) cannot share the
one-point orbifold in (9) with the genus-nine curve. Its p-rank \(25\)
is sufficient; the genus-nine curve's p-rank \(6\) is not used.
This is an exclusion of the specified finite common orbifold, not of
arbitrary common etale sources or of coreless correspondences.
