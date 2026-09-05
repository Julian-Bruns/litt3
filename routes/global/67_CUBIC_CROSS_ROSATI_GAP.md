# The global Rosati gap for cubic cross correspondences

## Status and consequence

**Status: proved.**  The exact lattice calculation is reproduced by
[`67_CUBIC_CROSS_ROSATI_GAP_CERTIFICATE.sage`](67_CUBIC_CROSS_ROSATI_GAP_CERTIFICATE.sage).

Let

\[
 Y:\ z^2=1-t^{31},\qquad J=\operatorname{Jac}(Y),
\]

and retain the cyclic-algebra notation of files 40 and 49:

\[
 K=\mathbf Q(\zeta_{31}),\qquad E=K^{\langle5\rangle},
 \qquad \mathscr D=\operatorname{End}^0(J)
       =K\oplus KF\oplus KF^2,
\]

\[
 F xF^{-1}=\sigma(x),\quad \sigma(\zeta_{31})=\zeta_{31}^5,
 \quad F^3=\pi\in E,\quad F^\dagger F=5.
\tag{67.1}
\]

This note resolves the integral endomorphism-lattice gap left in files 48,
49, and 54.  Although the completed endomorphism order at \(31\) is the
full matrix order rather than the coefficientwise crossed order, its extra
divided operators are still too long in the global Rosati lattice.  More
precisely, every nonzero integral endomorphism in the two noncommutative
cyclic summands has Rosati norm at least

\[
                              106.                       \tag{67.2}
\]

Proposition 49.7 gives the incompatible upper bound \(102\) for an
effective etale bidegree-\((3,3)\) correspondence.  Hence no such
correspondence exists on \(Y\times Y\), and the formerly conditional
birationality hypothesis in Theorem 48.5 is automatic.

## 1. The global coefficient envelope

For a prime \(\mathfrak P\) of \(K\) over \(5\), put

\[
                    m_{\mathfrak P}=v_{\mathfrak P}(\pi).
\]

The extension \(K/E\) is unramified cubic at \(5\), and the ten values of
\(m_{\mathfrak P}\), one over each prime of \(E\) above \(5\), are

\[
                    0,0,1,1,1,2,2,2,3,3.               \tag{67.3}
\]

Let \(\mathfrak D_{K/E}\) be the relative different and, for \(s=1,2\),
define the fractional ideal

\[
 \mathcal I_s=
 \mathfrak D_{K/E}^{-1}
 \prod_{\mathfrak P\mid5}
       \mathfrak P^{-\lfloor s m_{\mathfrak P}/3\rfloor}.
\tag{67.4}
\]

Since \(K/E\) is tamely totally ramified of degree three at \(31\) and
unramified elsewhere, if \(\lambda=1-\zeta_{31}\), then

\[
                 \mathfrak D_{K/E}=(\lambda^2).         \tag{67.5}
\]

### Proposition 67.1 (coefficient containment for the full order)

If

\[
       v=xF+yF^2\in\operatorname{End}(J),\qquad x,y\in K,
\tag{67.6}
\]

then

\[
                         x\in\mathcal I_1,
              \qquad    y\in\mathcal I_2.              \tag{67.7}
\]

This statement concerns the full geometric endomorphism ring.  In
particular, it does not assume the false equality between that ring and
the coefficientwise crossed order at \(31\).

#### Proof

We first record the coefficient-extraction lemma which handles every
prime away from the characteristic, including \(31\).  Let \(L/M\) be a
cyclic extension of degree three with generator \(\sigma\), and let
\(S/R\) be the corresponding rings of integers after completion.  If

\[
          A=a_0+a_1\sigma+a_2\sigma^2\in\operatorname{End}_M(L)
\]

maps \(S\) into itself, then

\[
                       a_s\in\mathfrak D_{S/R}^{-1}
                       \quad(s=0,1,2).                  \tag{67.8}
\]

Indeed, for \(u\in S\), the \(R\)-linear operator

\[
                         uA\sigma^{-s}:S\longrightarrow S
\]

has integral matrix trace.  The trace of
\(a\sigma^j:L\to L\) is zero for \(j\ne0\), while multiplication by
\(a\) has trace \(\operatorname{Tr}_{L/M}(a)\).  Consequently

\[
          \operatorname{Tr}_{L/M}(u a_s)\in R
          \quad\hbox{for every }u\in S,
\]

which is precisely (67.8).

Now fix a rational prime \(\ell\ne5\).  The Tate module
\(T_\ell J\) is locally free of rank one over
\(\mathcal O_K\otimes\mathbf Z_\ell\): it is torsion-free over that
product of discrete valuation rings, and both sides have
\(\mathbf Z_\ell\)-rank thirty.  Relative Frobenius is an automorphism
of this lattice and is \(\sigma\)-semilinear.  After identifying each
rank-one local lattice with \(\mathcal O_K\), it therefore has the form

\[
                              F=c\sigma
\]

with \(c\) a unit.  The two coefficients of (67.6), when it is written
in the basis \(1,\sigma,\sigma^2\), consequently differ from \(x,y\)
only by local units.  Apply (67.8).  We obtain

\[
             x,y\in\mathfrak D_{K/E}^{-1}
             \quad\hbox{at every prime away from }5.    \tag{67.9}
\]

At \(31\), this argument uses the whole lattice

\[
 \operatorname{End}_{\mathcal O_{E,31}}(\mathcal O_{K,31})
       \simeq M_3(\mathcal O_{E,31})
\]

from Theorem 54.1.  Thus the factors \(\lambda^{-2}\) allowed in
(67.9) include, rather than discard, the divided ramification operators
which made the crossed-order argument fail.

It remains to obtain the sharper bounds at \(5\).  The ten central
factors are indexed by the primes \(\mathfrak P\mid5\), and
\(K_{\mathfrak P}/E_{\mathfrak p}\) is unramified of degree three.  If
\(m=m_{\mathfrak P}\) is \(1\) or \(2\), then

\[
          \mathscr D\otimes_EE_{\mathfrak p}
\]

is the degree-three division algebra of invariant \(m/3\).  Its unique
maximal order is its nonnegative-valuation ring, and the local image of
\(\operatorname{End}(J)\) is contained in that order.  Normalize the
division valuation to restrict to the ordinary valuation on
\(E_{\mathfrak p}\).  Then

\[
 v_D(xF)=v_{\mathfrak P}(x)+\frac m3,
 \qquad
 v_D(yF^2)=v_{\mathfrak P}(y)+\frac{2m}{3}.             \tag{67.10}
\]

The two numbers have different fractional parts.  They therefore cannot
cancel in their sum.  Integrality of \(v\) gives

\[
 v_{\mathfrak P}(x)\ge-\left\lfloor\frac m3\right\rfloor,
 \qquad
 v_{\mathfrak P}(y)\ge-\left\lfloor\frac{2m}3\right\rfloor.
\tag{67.11}
\]

For \(m=0\), use the etale height-three factor of the \(5\)-divisible
group.  Its \(5\)-adic Tate module is free of rank one over the
unramified cubic ring \(\mathcal O_{K,\mathfrak P}\), while \(F\) is a
\(\sigma\)-semilinear automorphism.  The same trace-extraction argument,
now with trivial different, gives

\[
                    v_{\mathfrak P}(x),
                    v_{\mathfrak P}(y)\ge0,             \tag{67.12}
\]

which is again (67.11).

Finally suppose \(m_{\mathfrak P}=3\).  Complex conjugation carries
\(\mathfrak P\) to a prime \(\overline{\mathfrak P}\) with
\(m_{\overline{\mathfrak P}}=0\), because

\[
                             \pi\overline\pi=5^3.
\]

The Rosati adjoint of (67.6) is

\[
 v^\dagger=
 25\pi^{-1}\sigma(\overline y)F
 +5\pi^{-1}\sigma^2(\overline x)F^2.                  \tag{67.13}
\]

It too is an integral endomorphism.  Apply (67.12) at
\(\overline{\mathfrak P}\).  Since
\(v_{\overline{\mathfrak P}}(\pi)=0\), and since \(\sigma\) fixes the
unique prime of \(K\) over each prime of \(E\) at \(5\), (67.13) gives

\[
                  v_{\mathfrak P}(x)\ge-1,
             \qquad v_{\mathfrak P}(y)\ge-2.           \tag{67.14}
\]

These are exactly (67.11) for \(m=3\).  Combining (67.9),
(67.11), (67.12), and (67.14) over all finite primes gives (67.7).
\(\square\)

## 2. Exact minima of the two coefficient lattices

Complex conjugation on \(K\) is denoted by a bar.

### Proposition 67.2 (the two minima are 106)

The positive integral trace forms on the ideals (67.4) have exact
minima

\[
 \min_{0\ne x\in\mathcal I_1}
       5\operatorname{Tr}_{K/\mathbf Q}(x\overline x)=106,
\tag{67.15}
\]

and

\[
 \min_{0\ne y\in\mathcal I_2}
       25\operatorname{Tr}_{K/\mathbf Q}(y\overline y)=106.
\tag{67.16}
\]

#### Proof

This is a finite exact calculation in two positive-definite integral
lattices of rank thirty.  For completeness, the certificate performs the
following steps.

First it constructs the central \(125\)-Frobenius as the Jacobi sum

\[
 \pi=-\sum_{a\in\mathbf F_{125}}
          \chi(a)\phi(1-a),                            \tag{67.17}
\]

where \(\chi\) has order \(31\) and \(\phi\) is quadratic.  It checks
that \(\sigma(\pi)=\pi\), that the minimal polynomial is

\[
\begin{aligned}
 U^{10}&-10U^9+169U^8-120U^7-4750U^6+278500U^5\\
 &-593750U^4-1875000U^3+330078125U^2\\
 &-2441406250U+30517578125,
\end{aligned}                                           \tag{67.18}
\]

and that the valuations of its principal ideal at the ten primes over
\(5\) are exactly (67.3).  It then forms (67.4) using
\(\mathfrak D_{K/E}^{-1}=(1-\zeta_{31})^{-2}\).

For a \(\mathbf Z\)-basis \(b_1,\ldots,b_{30}\) of \(\mathcal I_s\),
the program constructs the Gram matrix

\[
 G^{(s)}_{ij}=5^s
       \operatorname{Tr}_{K/\mathbf Q}(b_i\overline{b_j}).
\tag{67.19}
\]

It verifies that this matrix is integral and positive definite.  An exact
unimodular LLL change of basis is followed by exhaustive integral
quadratic-form enumeration of every vector of norm less than \(107\).
For each of \(s=1,2\), the only represented positive norm in that range is
\(106\); it is represented by 186 coordinate vectors.  Thus the
enumeration proves both nonexistence below \(106\) and attainment at
\(106\), giving (67.15)--(67.16).  No floating-point decision enters the
calculation. \(\square\)

## 3. The Rosati gap and the cubic-image exclusion

### Theorem 67.3 (integral Rosati gap)

For every nonzero

\[
        v\in\operatorname{End}(J)\cap(KF\oplus KF^2),
\]

one has

\[
                         \langle v,v\rangle\ge106.      \tag{67.20}
\]

If both cyclic components of \(v\) are nonzero, then in fact

\[
                         \langle v,v\rangle\ge212.      \tag{67.21}
\]

#### Proof

Write \(v=xF+yF^2\).  The three cyclic summands are mutually orthogonal
for the Rosati form, and (67.1) gives

\[
 \langle v,v\rangle
   =5\operatorname{Tr}_{K/\mathbf Q}(x\overline x)
    +25\operatorname{Tr}_{K/\mathbf Q}(y\overline y).  \tag{67.22}
\]

Proposition 67.1 places \(x,y\) in \(\mathcal I_1,\mathcal I_2\), and
Proposition 67.2 applies separately to every nonzero component.  This
proves both assertions. \(\square\)

### Corollary 67.4 (no cubic etale self-correspondence)

There is no reduced irreducible effective correspondence

\[
                         \Gamma\subset Y\times Y
\]

of bidegree \((3,3)\) whose normalization projections to both copies of
\(Y\) are etale.

#### Proof

Let \(v\in\operatorname{End}(J)\) be its correspondence endomorphism.
Because \(3\le g(Y)=15\) is odd, Theorem 45.4 shows that \(v\ne0\).
Proposition 49.7 shows that its \(K\)-component vanishes and that

\[
                            \langle v,v\rangle\le102.
\]

Thus \(v\in KF\oplus KF^2\), contradicting Theorem 67.3. \(\square\)

### Corollary 67.5 (the \(M=9\) cross maps are birational)

In the degree-nine seven-diamond of file 48, every map

\[
        (a,a\beta^j):V\longrightarrow Y\times Y,
        \qquad1\le j\le6,
\]

is birational onto its image.  Consequently Theorem 48.5 is
unconditional: the cyclic orbit span has \(\mathscr D\)-rank \(5\) or
\(7\), and in rank \(5\) its six off-diagonal Rosati norms have sum at
least \(972\).

#### Proof

Proposition 48.1 says that the generic image degree is \(1\) or \(3\).
In the latter case, the normalization of the reduced image has two etale
degree-three projections to \(Y\), contradicting Corollary 67.4.  Thus all
six generic image degrees are one, exactly the hypothesis used in
Theorem 48.5. \(\square\)

## 4. What the calculation does and does not use

The numerical margin is small but strict:

\[
                         106>102.
\]

The two sources of denominators are both essential.  At \(31\), the full
matrix order permits the inverse-different factor \(\lambda^{-2}\).  At
\(5\), the slope-one and slope-two-thirds factors permit the negative
valuations displayed in (67.4).  Enlarging either coefficient ideal
without justification produces much shorter vectors, so the conclusion
cannot be obtained from the \(31\)-adic calculation alone.  Conversely,
Proposition 67.1 shows that these are simultaneous *global* upper
envelopes for coefficients of every actual integral endomorphism; no
claim that every vector in either envelope is itself an endomorphism is
needed.
