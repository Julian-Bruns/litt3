# Cartier exactness and the cyclic-seven obstruction

## Status and purpose

**Status: proved.**  Let

\[
                  S_0=\mathbf P^1_k(2,3,62),
                  \qquad k=\overline{\mathbf F}_5.
\]

File 29 reduces a hypothetical common cover to a finite-etale map
\(q:V\to S_0\) and a free order-seven automorphism \(\beta\) such that
\(q\beta\not\simeq q\).  The triangle-specific theorem below proves the
strictly stronger conclusions

\[
 \operatorname{div}\!\left(\frac{d(q\beta)}{dq}\right)
       \notin 5\operatorname{Div}(V),
 \qquad
                 \frac{d(q\beta)}{dq}\notin k(V)^5.       \tag{36.1}
\]

This note tests whether exactness of the two differentials, Cartier theory,
and the cyclic-seven action could force the opposite inclusion.  They do
not do so formally.  Exact differentials
form four copies of the regular \(C_7\)-module over the invariant fifth-power
field.  Descent supplies an invariant frame of that rank-four space, but it
does not make the particular line spanned by \(dq\) invariant.  The latter
line-invariance is *exactly* (36.1) with the opposite sign.

For the triangle profile there is nevertheless a stronger exact conclusion.
The failure of (36.1) is measured by a trace-zero, Cartier-fixed logarithmic
differential.  If that form is regular, the global three-fiber geometry
forces the two maps to be equal.  Hence a nonvertical order-seven symmetry
necessarily produces a genuine logarithmic pole at a point where it changes
the ramification type modulo five.  This makes the remaining obstruction
local and explicit, although exactness and averaging do not eliminate it.

## 1. The exact Cartier normal form

Let \(K/k\) be a one-variable function field and let \(q\in K\setminus K^5\).
Since \([K:K^5]=5\), the elements

\[
                         1,q,q^2,q^3,q^4                 \tag{36.2}
\]

are a basis of \(K\) over \(K^5\).  Thus every \(r\in K\) has a unique
expression

\[
                 r=b_0^5+b_1^5q+b_2^5q^2+b_3^5q^3+b_4^5q^4,
                 \qquad b_i\in K.                       \tag{36.3}
\]

### Proposition 36.4 (Cartier normal form)

If \(r\notin K^5\), then

\[
 \frac{dr}{dq}
   =b_1^5+2b_2^5q+3b_3^5q^2+4b_4^5q^3.                 \tag{36.4}
\]

In particular,

\[
        \frac{dr}{dq}\in K^5
        \quad\Longleftrightarrow\quad
        b_2=b_3=b_4=0.                                  \tag{36.5}
\]

Equivalently, the exact differentials are the four-dimensional
\(K^5\)-space

\[
             dK=K^5dq\oplus K^5q\,dq\oplus
                    K^5q^2dq\oplus K^5q^3dq.            \tag{36.6}
\]

In the standard \(q\)-coordinate formula for Cartier,

\[
 \operatorname{Car}\!\left(
       \sum_{i=0}^4 a_i^5q^i\,dq\right)=a_4\,dq,         \tag{36.7}
\]

so exactness of \(f\,dq\) says only that the \(q^4\)-coefficient of \(f\)
vanishes.  It does not say that \(f\in K^5\).

#### Proof

The degree statement and (36.2) follow because \(k\) is perfect and \(q\)
is separating.  Differentiating (36.3) gives (36.4).  The first four
members of (36.2) are linearly independent over \(K^5\), which proves
(36.5) and (36.6).  Formula (36.7) is the usual one-variable formula for
Cartier.  It also shows directly that its kernel in the rational
differentials is \(dK\). \(\square\)

Thus the fifth-power condition is not a consequence of the fact that
\(dr\) and \(dq\) are exact.  It is the much stronger assertion that the
first line in the four-step power basis (36.6) is the same for \(q\) and
\(r\).

## 2. What cyclic descent does and does not give

Suppose now that \(\beta\) is an automorphism of \(K\) of order seven.  Put

\[
                   L=K^{\langle\beta\rangle},
                   \qquad B=dK.
\]

The action on \(B\) is semilinear over the Galois extension
\(K^5/L^5\).  It is useful also to regard \(B\) as an
\(L^5[C_7]\)-module.

### Proposition 36.8 (four regular representations)

There are canonical numerical identities

\[
       B^{C_7}=dL,\qquad \dim_{L^5}dL=4,
\]

and a noncanonical module isomorphism

\[
                     B\simeq L^5[C_7]^{\oplus4}.         \tag{36.8}
\]

Consequently the invariant part has \(L^5\)-dimension \(4\), while the
moving part has dimension \(24\).  Equivalently, semilinear Galois descent
gives an invariant \(K^5\)-basis of \(B\), but it does not make an
arbitrarily specified \(K^5\)-line in \(B\) invariant.

For a separating \(q\in K\), put \(r=\beta(q)\).  Then

\[
       \frac{dr}{dq}\in K^5
       \quad\Longleftrightarrow\quad
       \beta(K^5dq)=K^5dq.                              \tag{36.9}
\]

#### Proof

The derivation gives an exact sequence of \(L^5[C_7]\)-modules

\[
                 0\longrightarrow K^5\longrightarrow K
                    \xrightarrow{d}B\longrightarrow0.    \tag{36.10}
\]

Since seven is invertible in characteristic five, taking \(C_7\)-invariants
is exact.  The invariants of the first two terms are \(L^5\) and \(L\),
respectively.  Hence

\[
                       B^{C_7}=dL,
\]

which has dimension four over \(L^5\).  Galois descent now identifies

\[
                 B\simeq K^5\otimes_{L^5}dL
\]

as a semilinear \(C_7\)-space.  The normal-basis theorem identifies
\(K^5\) with the regular \(L^5[C_7]\)-module, proving (36.8).

Finally, \(d\beta(q)=\beta(dq)\).  It is a \(K^5\)-multiple of \(dq\)
exactly when the displayed line is invariant, proving (36.9). \(\square\)

In the power basis in (36.6), the change from \(q\) to \(\beta(q)\) is a
matrix \(M\in\operatorname{GL}_4(K^5)\) satisfying the semilinear cocycle
identity

\[
                 M\,\beta(M)\cdots\beta^6(M)=1          \tag{36.11}
\]

up to the harmless choice of left-versus-right convention.  Hilbert 90
trivializes this full matrix cocycle.  Condition (36.9), however, says that
its distinguished first basis line is stable.  Matrix descent does not
imply that line-stability.  This is the Cartier analogue of the distinction
in file 32 between an invariant abstract lifting and the particular lifting
selected by a covering map.

## 3. A free-action counterexample once the triangle profile is removed

The failure above is not merely a dimension-counting possibility.

### Proposition 36.12 (freeness and exactness do not suffice)

There exist a smooth projective curve \(V/k\), a fixed-point-free
automorphism \(\beta\) of order seven, and a separating function
\(q\in k(V)\) such that, for \(r=q\beta\),

\[
                        \frac{dr}{dq}\notin k(V)^5.      \tag{36.12}
\]

The two functions have the same degree and the same ramification profile,
transported by \(\beta\).

#### Proof

Choose a genus-two curve \(C/k\) and a line bundle of exact order seven in
\(\operatorname{Pic}^0(C)\).  The associated connected \(\mu_7\)-torsor

\[
                             V\longrightarrow C
\]

is finite etale.  A generator \(\beta\) of its deck group acts freely, and
etale Riemann--Hurwitz gives \(g(V)=8\).

Choose \(P\in V(k)\) and put \(Q=\beta(P)\ne P\).  In the vector space
\(H^0(V,\mathcal O_V(21P))\), choose \(q\) which has an exact pole of order
\(21\) at \(P\) and satisfies \(dq(Q)\ne0\).  Such a choice exists.  The
first condition is the complement of a proper linear subspace.  For the
second, the restriction to the first infinitesimal neighborhood of \(Q\)
is surjective because

\[
 \deg(21P-2Q)=19>2g(V)-2=14,
\]

so the derivative-at-\(Q\) functional is nonzero.  The two nonempty linear
open conditions meet because \(k\) is infinite.

The function \(q\) is separating.  At \(P\), its differential has a pole
of order \(22\), since \(21\ne0\) in \(k\).  On the other hand,
\(r=q\circ\beta\) is regular with nonzero differential at \(P\), by the
choice at \(Q\).  Therefore

\[
             \operatorname{ord}_P\!\left(\frac{dr}{dq}\right)=22,
\]

which is not divisible by five.  The ratio cannot be a fifth power.
Precomposition by \(\beta\) transports every ramification index of \(q\),
so the last assertion is automatic. \(\square\)

This example does not have the uniform \((2,3,62)\) three-fiber profile.
It shows precisely that any proof for that profile must use its global
three-fiber geometry; it cannot follow from exactness, freeness, or the
order-seven relation alone.

## 4. The logarithmic obstruction for the triangle profile

Return to a representable finite-etale map \(V\to S_0\), with coarse
function \(q\) of degree \(186N\).  Write

\[
 q^*(0)=2A_2,\qquad q^*(1)=3A_3,
 \qquad q^*(\infty)=62A_{62}.                            \tag{36.13}
\]

Let \(\beta\) act freely with order seven, set \(r=q\beta\), and put

\[
             f=\frac{dr}{dq}=\frac{\beta^*(dq)}{dq},
             \qquad \vartheta=d\log f=\frac{df}{f}.     \tag{36.14}
\]

### Proposition 36.15 (the logarithmic obstruction)

The following statements hold.

1. The multiplicative norm and logarithmic trace vanish:

   \[
       \prod_{i=0}^6\beta^{i*}f=1,
       \qquad
       \sum_{i=0}^6\beta^{i*}\vartheta=0.               \tag{36.15}
   \]

2. The form \(\vartheta\) is logarithmic and Cartier-fixed.  Moreover,

   \[
                  \vartheta=0\quad\Longleftrightarrow\quad f\in K^5.
                                                                  \tag{36.16}
   \]

3. Color the points of \(V\) by

   \[
     c(P)=
       \begin{cases}
       1,&P\in A_2,\\
       2,&P\in A_3\cup A_{62},\\
       0,&\text{otherwise},
       \end{cases}
       \qquad c(P)\in\mathbf F_5.                       \tag{36.17}
   \]

   Then

   \[
               \operatorname{res}_P(\vartheta)
                         =c(\beta P)-c(P).               \tag{36.18}
   \]

   In particular, \(\vartheta\) is regular if and only if \(\beta\)
   preserves \(A_2\) and \(A_3\cup A_{62}\) setwise.

#### Proof

The product in (36.15) telescopes because \(\beta^7=1\).  Taking
\(d\log\) proves the second equality.  Cartier fixes logarithmic
differentials, and the kernel of \(d:K\to\Omega^1_{K/k}\) is \(K^5\),
which proves (36.16).

The triangle differential divisor is

\[
                    \operatorname{div}(dq)
                          =A_2+2A_3-63A_{62}.             \tag{36.19}
\]

The coefficient of \(\operatorname{div}(\beta^*dq)\) at \(P\) is the
coefficient of (36.19) at \(\beta P\).  The residue of \(d\log f\) is
\(\operatorname{ord}_P(f)\), viewed in \(k\).  Since \(-63\equiv2\pmod5\),
this gives (36.18).  A logarithmic differential has no pole at a point
exactly when this residue is zero.  The three residues \(0,1,2\) are
distinct, proving the setwise criterion. \(\square\)

The apparent regular alternative in Proposition 36.15 is in fact impossible
unless the two triangle maps coincide.  The next theorem does not require
the maps to differ by an automorphism.

### Theorem 36.20 (divisorial fifth-power rigidity)

Let \(q,r:V\to\mathbf P^1\) be any two maps with the uniform triangle
profile

\[
\begin{aligned}
 q^*(0)&=2A_2,&q^*(1)&=3A_3,&q^*(\infty)&=62A_{62},\\
 r^*(0)&=2A'_2,&r^*(1)&=3A'_3,&r^*(\infty)&=62A'_{62}.
\end{aligned}                                             \tag{36.20}
\]

The following conditions are equivalent:

\[
\begin{array}{ll}
\textup{(a)}&
 \operatorname{div}(dr/dq)\text{ is divisible by }5;\\
\textup{(b)}&
 A'_2=A_2\text{ and }A'_3+A'_{62}=A_3+A_{62};\\
\textup{(c)}&r=q.
\end{array}                                                \tag{36.21}
\]

Consequently

\[
 d\log(dr/dq)\text{ is regular}
 \quad\Longleftrightarrow\quad
 d\log(dr/dq)=0
 \quad\Longleftrightarrow\quad r=q.                       \tag{36.22}
\]

#### Proof

The two differential divisors are

\[
\begin{aligned}
 \operatorname{div}(dq)&=A_2+2A_3-63A_{62},\\
 \operatorname{div}(dr)&=A'_2+2A'_3-63A'_{62}.
\end{aligned}                                             \tag{36.23}
\]

At any point their coefficients modulo five belong to the three distinct
classes \(0,1,2\): the class \(1\) marks \(A_2\), while the class \(2\)
marks \(A_3\cup A_{62}\).  This proves that (a) is equivalent to (b).

Assume (b), and put

\[
                         \Delta=A'_{62}-A_{62}.
\]

Then \(A'_3-A_3=-\Delta\).  Taking divisors of two elementary ratios gives

\[
\begin{aligned}
 \operatorname{div}(r/q)&=-62\Delta,\\
 \operatorname{div}\bigl((r-1)/(q-1)\bigr)&=-65\Delta.
\end{aligned}                                             \tag{36.24}
\]

Since \(\gcd(62,65)=1\), the divisor \(\Delta\) is principal.  Choose
\(h\in k(V)^\times\) with \(\operatorname{div}(h)=\Delta\).  There are
constants \(\lambda,\mu\in k^\times\) such that

\[
 \frac rq=\lambda h^{-62},
 \qquad
 \frac{r-1}{q-1}=\mu h^{-65}.
\]

Eliminating \(r\) gives

\[
                         q=\frac{h^{65}-\mu}
                                  {\lambda h^3-\mu}.       \tag{36.25}
\]

Suppose \(h\) is nonconstant.  Choose \(\nu\in k^\times\) with
\(\nu^5=\mu\).  Then

\[
                         h^{65}-\mu=(h^{13}-\nu)^5.
\]

The polynomial \(T^{13}-\nu\) has thirteen distinct roots, while
\(\lambda T^3-\mu\) has at most three.  Choose a root \(\gamma\) of the
first which is not a root of the second.  Surjectivity of the nonconstant
map \(h:V\to\mathbf P^1\) supplies \(P\) with \(h(P)=\gamma\).  Formula
(36.25) makes the zero order of \(q\) at \(P\) a positive multiple of five,
contrary to the fact that every zero of \(q\) has order exactly two.

Thus \(h\) is constant, so \(\Delta=0\).  All three fiber divisors in
(36.20) are equal.  Equality of the zero and pole divisors gives
\(r=\kappa q\) for a constant \(\kappa\), and the common fiber over one
gives \(\kappa=1\).  Hence (b) implies (c); the reverse implications are
immediate.

Finally, \(d\log(dr/dq)\) is regular exactly when
\(\operatorname{div}(dr/dq)\) is divisible by five, by the local formula
\(d\log(t^\nu)=\nu\,dt/t\).  This proves (36.22). \(\square\)

## 5. Resulting bottleneck

For the exceptional \((V,q,\beta)\) forced by file 29, Theorem 36.20 says
that \(\vartheta\) is nonzero and has a logarithmic pole.  Equivalently,
\(\beta\) must move at least one point between the three mod-five colors in
(36.17).  This strengthens the fifth-power statement: even divisibility of
the differential-ratio divisor by five, which is weaker than the ratio being
a fifth power, already forces equality of the two maps.

It still does not produce a contradiction.  Proposition 36.8 explains the
linear reason: cyclic descent fixes the full exact-differential bundle only
after a change of frame and has no mechanism that fixes the \(q\)-selected
line.  This is parallel to the first Witt obstruction in file 32, where
averaging provides an invariant lifting of the abstract source but need not
provide the lifting selected by \(q\).  A successful next step may instead
try to show that the explicit pole forced by Theorem 36.20 makes the first
Witt class nonzero.  Such a step would have to use the global three-point
cover; it cannot follow from Cartier exactness or coprime averaging alone.
