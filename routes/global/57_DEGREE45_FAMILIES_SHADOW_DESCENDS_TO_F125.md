# The degree-45 families shadow descends to a finite field

## Status and purpose

**Status: proved; independent audit pending.**

File 50 shows that the mod-31 shadow of the recent
families-preserving rigidity theorem already proves visibility for all
minimal generalized profiles of degrees 32 through 44.  Its argument stops
at degree 45 because the source curve then has genus one and can have two
different degree-two pencils.

This note makes that endpoint finite.  If the same mod-31 shadow holds for
a minimal non-visible degree-45 pair, its two degree-two pencils define a
smooth \((2,2)\) model containing at least 44 points of
\(\mu_{31}^2\).  Frobenius intersection then forces the model, both maps,
and all six high ramification points to descend to \(\mathbf F_{125}\).
The second high triple is a common nonzero 28-torsion translate of the
first.

Thus the degree-45 endpoint under families preservation is an exact finite
classification problem over \(\mathbf F_{125}\), not a moduli problem over
\(\overline{\mathbf F}_5\).  This result does not prove that an arbitrary
algebraic correspondence has the families-preserving shadow.

## 1. Setup

Let \(E/\overline{\mathbf F}_5\) be an elliptic curve and let

\[
                 x,r:E\rightrightarrows\mathbf P^1
\tag{57.1}
\]

be a minimal non-visible generalized-profile pair of degree 45.  After the
normalization of Proposition 50.2, write

\[
\begin{aligned}
 x^{-1}(i)&=31P_i+E_i,\\
 r^{-1}(i)&=31Q_i+E_i,
       \qquad i\in\{0,1,\infty\},
\end{aligned}                                             \tag{57.2}
\]

where each \(E_i\) is reduced of degree 14 and all three residual divisors
are disjoint.  The mod-31 families shadow supplies functions \(A,B\) with

\[
 \frac r x=A^{31},\qquad
 \frac{r-1}{x-1}=B^{31},                                  \tag{57.3}
\]

and

\[
\begin{aligned}
 \operatorname{div}(A)&=Q_0+P_\infty-P_0-Q_\infty,\\
 \operatorname{div}(B)&=Q_1+P_\infty-P_1-Q_\infty.
\end{aligned}                                             \tag{57.4}
\]

Minimality means

\[
                            k(E)=k(x,r).                  \tag{57.5}
\]

### Theorem 57.1

Under (57.1)--(57.5), there is a choice of origin on \(E\) and a nonzero
point

\[
                         T\in E[28]                       \tag{57.6}
\]

such that

\[
                         Q_i=P_i+T
               \qquad(i=0,1,\infty).                    \tag{57.7}
\]

The map

\[
                  (A,B):E\longrightarrow\mathbf P^1\times\mathbf P^1
\tag{57.8}
\]

is an isomorphism onto a smooth curve \(\Gamma\) of bidegree \((2,2)\).
If

\[
 G=\gcd\bigl(\operatorname{div}_0(A^{31}-1),
              \operatorname{div}_0(B^{31}-1)\bigr),       \tag{57.9}
\]

then

\[
                 \deg G=48,qquad
                 |\operatorname{Supp}G|\ge44,             \tag{57.10}
\]

and every point of its support maps into
\(\mu_{31}\times\mu_{31}\).

Moreover \(\Gamma\), its normalization \(E\), the functions \(A,B,x,r\),
all six points \(P_i,Q_i\), and \(T\) admit simultaneous models over
\(\mathbf F_{125}\).  In particular,

\[
                         T\in E(\mathbf F_{125})[28].       \tag{57.11}
\]

## 2. The common torsion translate

### Lemma 57.2

The functions \(A,B\) both have degree two, generate \(k(E)\), and the
three relations (57.7) hold for one common \(T\ne0\).  This point satisfies
\(28T=0\).

#### Proof

If either \(A\) or \(B\) is constant, the argument in Theorem 50.3 makes
the pair visible.  A nonconstant function of degree at most two on an
elliptic curve has degree exactly two.

If \(k(A)=k(B)\), then (57.3) gives

\[
              x=\frac{1-B^{31}}{A^{31}-B^{31}},
              \qquad r=xA^{31}.                         \tag{57.12}
\]

The denominator cannot vanish identically: otherwise (57.12) would force
\(B^{31}=1\), contrary to nonconstancy.  Thus \(x,r\in k(A)\), contradicting
(57.5).  The two quadratic subfields are therefore different.  Since
\(k(E)/k(A)\) has prime degree two, they generate \(k(E)\).

Choose an origin on \(E\) and identify \(\operatorname{Pic}^0(E)\) with
\(E\).  The first principal divisor in (57.4) gives

\[
                         Q_0-P_0=Q_\infty-P_\infty.
\]

The second gives the same identity with the index 1.  Put
\(T=Q_\infty-P_\infty\); this proves (57.7).

It remains to obtain the exact order bound.  The differential-divisor
formula of file 34 and the equality of the residual pole divisors give

\[
 \operatorname{div}\!\left(\frac{dr}{dx}\right)
   =30(Q_0+Q_1-P_0-P_1)-32(Q_\infty-P_\infty).          \tag{57.13}
\]

Taking its Abel--Jacobi sum and using (57.7) yields

\[
                            60T-32T=28T=0.              \tag{57.14}
\]

If \(T=0\), both divisors in (57.4) are trivial, so \(A,B\) are constant.
Thus \(T\ne0\). \(\square\)

## 3. Forty-eight common cyclotomic zeros

### Lemma 57.3

The map (57.8) is an isomorphism onto a smooth integral \((2,2)\) curve.
For the divisor \(G\) of (57.9), one has

\[
\begin{aligned}
 \operatorname{div}_0(A^{31}-1)&=G+E_1,\\
 \operatorname{div}_0(B^{31}-1)&=G+E_0.                \tag{57.15}
\end{aligned}
\]

Consequently (57.10) holds.

#### Proof

Lemma 57.2 says that \(A,B\) generate the function field, so (57.8) is
birational onto its image.  Its two projection degrees are two, hence the
image \(\Gamma\) has bidegree \((2,2)\).  Such an integral curve has
arithmetic genus one.  Its normalization is the genus-one curve \(E\), so
its total delta invariant is zero.  Therefore \(\Gamma\) is smooth and the
birational map is an isomorphism.

Put \(F_A=A^{31}-1\) and \(F_B=B^{31}-1\).  Equations (57.3) give the
exact identity

\[
                         \frac{F_A}{F_B}=\frac{x-1}{x}. \tag{57.16}
\]

Both \(F_A\) and \(F_B\) have zero divisors of degree 62.  Their pole
divisors, read from (57.4), are

\[
       31(P_0+Q_\infty),\qquad31(P_1+Q_\infty),        \tag{57.17}
\]

respectively, with the displayed point divisors understood with their
possible multiplicities.  On the other hand, (57.2) gives

\[
 \operatorname{div}\!\left(\frac{x-1}{x}\right)
       =31(P_1-P_0)+E_1-E_0.                           \tag{57.18}
\]

Canceling the greatest common zero divisor in (57.16), and comparing
(57.17)--(57.18), gives (57.15).  In particular
\(\deg G=62-14=48\).

At a zero of \(A^{31}-1\), its multiplicity is the ramification index of
the degree-two map \(A:E\to\mathbf P^1\), because \(31\ne0\) in
characteristic five and the relevant value is nonzero.  Riemann--Hurwitz
gives total ramification four for this map.  Hence the total excess of the
multiplicities in the sub-divisor \(G\) is at most four:

\[
       \deg G-|\operatorname{Supp}G|\le4.              \tag{57.19}
\]

This proves the lower bound 44.  Finally, a point in \(G\) satisfies
\(A^{31}=B^{31}=1\), so its image lies in
\(\mu_{31}\times\mu_{31}\). \(\square\)

## 4. Frobenius forces descent

#### Proof of Theorem 57.1

Only the descent assertion remains.  Since

\[
                         31\mid(125-1),                 \tag{57.20}
\]

all points of \(\mu_{31}\times\mu_{31}\) are rational over
\(\mathbf F_{125}\).  Let \(\Gamma^{(125)}\) be the image of \(\Gamma\)
under 125-power Frobenius in \(\mathbf P^1\times\mathbf P^1\).  Every one
of the at least 44 distinct points supplied by Lemma 57.3 belongs to both
curves.  If the two integral \((2,2)\) curves were distinct, their proper
intersection number would be

\[
                    (2,2)\cdot(2,2)=2\cdot2+2\cdot2=8,\tag{57.21}
\]

a contradiction.  Hence \(\Gamma^{(125)}=\Gamma\).

The smooth curve \(\Gamma\) and its two coordinate projections therefore
give simultaneous \(\mathbf F_{125}\)-models of \(E,A,B\).  Formula
(57.12) then gives \(\mathbf F_{125}\)-models of \(x,r\).  In each of the
three fibers of either map, the high point is characterized as the unique
point having multiplicity 31, while all residual points have multiplicity
one.  Frobenius consequently fixes each \(P_i,Q_i\).  Thus all six high
points are \(\mathbf F_{125}\)-rational, and (57.7) makes \(T\) rational as
well.  Lemma 57.2 supplies (57.11) and completes the proof. \(\square\)

## 5. Finite endpoint left to check

After translating the elliptic origin so that \(P_\infty=0\), all data are
now finite:

\[
 T\in E(\mathbf F_{125})[28]\setminus\{0\},\qquad
 P_0,P_1\in E(\mathbf F_{125}),                           \tag{57.22}
\]

and, up to constants, (57.4) determines \(A\) and \(B\).  The constants
are also in \(\mathbf F_{125}\), because the normalized relation curve and
coordinate functions are.  One may therefore enumerate elliptic curves
over \(\mathbf F_{125}\), the finite choices (57.22), and the two scaling
constants, then test (57.12) for the three exact fiber profiles (57.2).

Such an enumeration would decide the degree-45 endpoint **under the
families-preserving shadow**.  It would not prove that every algebraic
self-correspondence satisfies that shadow; file 50 explains why this is a
separate and much stronger input.
