# A scalar involution and cross-image sieve

## Status and purpose

**Status: proved; self-check complete; independent audit pending.**

This note develops a reusable obstruction for a curve carrying both an
etale map and a ramified involution.  If the involution compresses to a
scalar correspondence on the target Jacobian, then two elementary pieces
of geometry constrain that scalar in opposite directions:

1. every fixed point of the involution contributes to the intersection of
   the cross-image with the diagonal; and
2. adjunction bounds the genus of the cross-image in the product surface.

The resulting finite divisor-and-integer sieve is valid in arbitrary
degree.  For a prime degree it becomes one explicit inequality.  We also
record two complementary cubic-coefficient tools: the odd-degree extension
of the discriminant-double-plane bound from file 78, and a uniform genus
obstruction to an \(S_3\) cubic closure.

For the explicit order-three pair in file 76, an exact maximal-order
calculation proves the required scalar-window hypothesis at \(M=7\).  The
general sieve then eliminates the entire degree-seven row.  Together with
files 76 and 78, any prime-ratio diamond for that pair has degree at least
eight.

Throughout, the ground field is algebraically closed of characteristic
different from two.  All intersection formulas may be read in
\(\ell\)-adic cohomology for an auxiliary prime \(\ell\).

## 1. Odd curves on a cubic-discriminant double plane

Retain the three plane types and notation \(S_\Pi,H\) of Lemma 78.8.

### Lemma 79.1 (odd-degree discriminant-splitting bound)

Let \(\Gamma\subset\Pi\) be an integral plane curve of odd degree \(n\),
not contained in the binary-cubic discriminant.  Suppose that the cubic
discriminant is a square in \(k(\Gamma)^*\).  If \(\Pi\) is of type 1 or
2 in Lemma 78.8, then

\[
                      g(\Gamma^\nu)\leq{(n-1)^2\over4}.              \tag{79.1}
\]

If \(\Pi\) is of type 3, then

\[
                      g(\Gamma^\nu)\leq{(n-1)(n-3)\over4}.          \tag{79.2}
\]

In particular, for a plane septic the bounds are respectively nine and
six.  Equality in the first bound forces its lifted strict transform \(D\)
to be smooth and to satisfy

\[
             H\cdot D=7,\qquad D^2=23,\qquad
             (2D-7H)^2=-6,\qquad H\cdot(2D-7H)=0.                \tag{79.3}
\]

#### Proof

As in Lemma 78.9, the square root gives a birational lift of
\(\Gamma^\nu\) to the appropriate resolved or normalized double plane.
In types 1 and 2 this is a smooth surface with

\[
                         H^2=2,\qquad K=-H,\qquad H\cdot D=n.
\]

Hodge index gives \(D^2\leq n^2/2\).  Adjunction says that
\(D^2-n\) is even.  Since \(n\) is odd, \(D^2\) is odd; the largest odd
integer not exceeding \(n^2/2\) is \((n^2-3)/2\).  Therefore

\[
 g(\Gamma^\nu)\leq p_a(D)
 \leq1+{(n^2-3)/2-n\over2}={(n-1)^2\over4}.
\]

For type 3, the normalized double plane has \(H^2=2\) and \(K=-2H\).
Now adjunction makes \(D^2\) even.  Since \((n^2-1)/2\) is even for odd
\(n\), Hodge and adjunction give

\[
 g(\Gamma^\nu)\leq1+{(n^2-1)/2-2n\over2}
                  ={(n-1)(n-3)\over4}.
\]

For \(n=7\), equality in (79.1) forces the maximal allowed integral
self-intersection: \(D^2=23\) and
\(g(D^\nu)=p_a(D)=9\).  Thus \(D\) is smooth.  The last two identities in
(79.3) are immediate from \(H^2=2\) and \(H\cdot D=7\). \(\square\)

## 2. A uniform obstruction to the nonabelian cubic closure

Use the prime-ratio notation of file 68 with \(r=3\):

\[
 g(X)=s+1,\qquad g(Y)=3s+1,\qquad g(C)=Ms+1.
\]

Suppose the coefficient map \(q:C\to B\) has degree two and belongs to
case B of Theorem 68.5.  Put \(b=g(B)\), \(K=k(V)\), and
\(E=k(B)(t)\).  Since the quadratic-core parameter is then \(m=1\), one
has

\[
 [K:k(B)]=6,\quad [K:k(C)]=[E:k(B)]=3,\quad [K:E]=2.             \tag{79.4}
\]

### Proposition 79.2 (the \(S_3\)-incidence inequality)

If \(K/k(B)\) has Galois group \(S_3\), then necessarily

\[
                         b\geq {M(s-2)\over2}+1.                    \tag{79.5}
\]

This conclusion is independent of the dimension of the coefficient
linear system.

#### Proof

The three conjugates of \(t\) over \(k(C)\) lie in \(K\), and their
minimal polynomial has coefficients generating \(k(B)\).  Its splitting
field over \(k(B)\) is either its cyclic cubic field or all of \(K\).
Thus \(K/B\) is Galois of group \(C_6\) or \(S_3\).

Assume the latter.  The cover \(V\to C\) is etale, so every inertia group
of \(K/B\) is a transposition and lies over a branch point of \(q\).
Riemann--Hurwitz for the ramified double cover gives

\[
             R_q=2Ms-4b+4.                                          \tag{79.6}
\]

In the degree-three action a transposition has cycle type \((2,1)\), so
the different of \(E/B\) has degree \(R_q\).  Hence

\[
                         g(E)=b+Ms.                                  \tag{79.7}
\]

On the other hand, \(E\) normalizes the integral spectral incidence curve
in \(B\times\mathbf P^1\).  Its class has coefficient-line degree \(M\)
and cubic degree three, so adjunction gives arithmetic genus

\[
                         3b+2M-2.                                   \tag{79.8}
\]

The normalization genus cannot exceed (79.8).  Combining (79.7) and
(79.8) is exactly (79.5). \(\square\)

## 3. The general scalar-involution sieve

Let \(X\) be a smooth curve of genus

\[
                              g=s+1\geq2,
\]

let \(c:C\to X\) be finite etale of degree \(M\), and let
\(q:C\to B\) be a ramified double cover with involution \(\delta\).  Its
ramification divisor is reduced and has degree

\[
                              R=2Ms-4g(B)+4.                         \tag{79.9}
\]

Define the Rosati-self-adjoint endomorphism

\[
                 u=c_*\delta^*c^*\in\operatorname{End}(J(X)).       \tag{79.10}
\]

Recall from file 71 that \(J(X)\) satisfies \(\mathrm{SW}_M\) if every
integral Rosati-symmetric \(v\) for which \([M]\pm v\) are
Rosati-positive semidefinite is scalar.

### Theorem 79.3 (scalar involution and cross-image sieve)

Assume that \(X\) is nonhyperelliptic and that \(J(X)\) satisfies
\(\mathrm{SW}_M\).  Then there are an integer \(\lambda\) and a proper
divisor \(f\) of \(M\) such that

\[
\begin{gathered}
 u=[\lambda],\qquad -M<\lambda<M,\qquad f\mid\lambda,             \tag{79.11}\\
 R\leq2M-2g\lambda,                                                \tag{79.12}\\
 g\lambda^2\leq M^2+Msf.                                          \tag{79.13}
\end{gathered}
\]

More precisely, \(f\) is the generic degree of

\[
             (c,c\delta):C\longrightarrow X\times X                \tag{79.14}
\]

onto its reduced image.  Thus (79.11)--(79.13) are a finite, explicit
sieve over the proper divisors of \(M\).

#### Proof

Since \(\delta^*=\delta_*\), the endomorphism \(u\) is self-adjoint.  Also

\[
 [M]\pm u=c_*(1\pm\delta^*)c^*\succeq0.                            \tag{79.15}
\]

The scalar-window hypothesis gives \(u=[\lambda]\), with
\(-M\leq\lambda\leq M\).  Equality \(\lambda=-M\) makes
\((1+\delta^*)c^*=0\); signed pullback rigidity (Lemma 71.1) would make
\(X\) hyperelliptic.  Equality \(\lambda=M\) makes \(c\delta=c\), so
\(c\) factors through the ramified map \(q\), impossible because \(c\) is
etale.  This proves the strict inequalities in (79.11).

Let \(\Gamma_0=(c,c\delta)_*[C]\).  Its two projection degrees are \(M\),
and the induced correspondence on \(J(X)\) is \(u\).  Since
\(c\delta\ne c\), its intersection with the diagonal is proper.  The
correspondence Lefschetz formula gives

\[
        \Gamma_0\cdot\Delta_X
          =2M-\operatorname{Tr}(u\mid H^1(X))
          =2M-2g\lambda.                                            \tag{79.16}
\]

Every one of the \(R\) fixed points of \(\delta\) maps to the diagonal.
At such a point, a tame anti-invariant local parameter and etaleness of
\(c\) show that the local intersection multiplicity is one.  In
particular (79.16) is at least \(R\), proving (79.12).

Let \(\Gamma\) be the reduced image of (79.14), let \(D\) be its
normalization, and let \(f\) be the generic degree \(C\to D\).  Both
projection degrees of \(\Gamma\) are

\[
                              m=M/f,                                 \tag{79.17}
\]

so \(f\mid M\).  The induced integral correspondence \(v:J(X)\to J(X)\)
obeys \(fv=u=[\lambda]\).  A rational scalar which is an integral
endomorphism is an integer, so \(f\mid\lambda\).

The first projection factors the etale cover \(c\) as

\[
                       C\longrightarrow D\longrightarrow X
\]

with degrees \(f,m\).  Both factors are etale.  Therefore

\[
                              g(D)=ms+1.                             \tag{79.18}
\]

The Künneth decomposition and the Rosati intersection pairing give

\[
 \Gamma^2=2m^2-\operatorname{Tr}(v^\dagger v\mid H^1(X))
          ={2M^2-2g\lambda^2\over f^2},                             \tag{79.19}
\]

while

\[
                         K_{X\times X}\cdot\Gamma=4ms.              \tag{79.20}
\]

Adjunction and (79.18) now imply

\[
 {Ms\over f}+1=g(D)
 \leq p_a(\Gamma)
 =1+{M^2-g\lambda^2\over f^2}+{2Ms\over f}.
\]

Rearrangement is (79.13).

It remains only to see that \(f\ne M\).  In that case both projections
from \(D\) have degree one, so \(\Gamma\) is the graph of an automorphism
\(\sigma\) of \(X\).  Then \(u=M\sigma_*\).  A scalar automorphism of a
Jacobian is \(\pm1\), forcing \(\lambda=\pm M\), already excluded.
Thus \(f\) is proper. \(\square\)

### Corollary 79.4 (prime-degree numerical test)

If \(M\) is prime under the hypotheses of Theorem 79.3, then the
cross-image is birational and

\[
 R\leq2M+2\sqrt{g(M^2+Ms)}.                                         \tag{79.21}
\]

Consequently a ramified double cover is impossible whenever the reverse
strict inequality holds.

#### Proof

The only proper divisor in Theorem 79.3 is \(f=1\).  Equation (79.13)
gives

\[
                         |\lambda|\leq
                         \sqrt{(M^2+Ms)/g}.
\]

Combine this with (79.12). \(\square\)

The unsquared finite test (79.11)--(79.13) is generally sharper than
(79.21), especially for composite \(M\), because it retains integrality
and the divisibility condition \(f\mid\lambda\).

## 4. The exact scalar window for the explicit genus-nine curve

Let \(X\) be the curve (76.1), and let \(\pi\) be its 25-power
Frobenius.  File 76 computes its irreducible degree-18 Weil polynomial
\(P_X\) and proves

\[
                       \mathbf Q(\pi^n)=\mathbf Q(\pi)
                       \quad(n\geq1).                               \tag{79.22}
\]

### Proposition 79.5 (\(\mathrm{SW}_7\) for the explicit \(X\))

The geometric Jacobian of (76.1) satisfies \(\mathrm{SW}_7\).

#### Proof

Put \(K=\mathbf Q(\pi)\).  Since \(P_X\) is irreducible of degree
\(2g(X)=18\) and occurs with exponent one, Honda--Tate gives
\(\operatorname{End}^0_{\mathbf F_{25}}J(X)=K\).  Every geometric
endomorphism is defined over some finite extension.  By (79.22), the
Frobenius over that extension still generates \(K\), again with degree
18 and exponent one.  Tate's theorem therefore gives

\[
                       \operatorname{End}^0_kJ(X)=K.                 \tag{79.23}
\]

Rosati sends \(\pi\) to \(25/\pi\).  Its fixed field is the totally real
degree-nine field \(K^+=\mathbf Q(\theta)\), where

\[
\begin{aligned}
 Q_X(U)={}&U^9-2U^8-254U^7+457U^6+21826U^5-29834U^4\\
          &-703917U^3+354810U^2+6210225U+6613875.                  \tag{79.24}
\end{aligned}
\]

Thus every integral Rosati-fixed geometric endomorphism lies in the full
ring of integers \(\mathcal O_{K^+}\).  If \([7]\pm u\succeq0\), every
real conjugate of \(u\) lies in \([-7,7]\), and hence

\[
                             \operatorname{Tr}_{K^+/\mathbf Q}(u^2)
                             \leq9\cdot7^2=441.                     \tag{79.25}
\]

The exact certificate accompanying this note constructs
\(\mathcal O_{K^+}\), whose discriminant is

\[
       3^3\cdot29\cdot10589\cdot16451926081\cdot24415659240899,
\]

and enumerates its trace lattice through 441.  Besides the scalar vectors,
the only nonzero nonscalar norm levels are

\[
                   387,394,398,419,427,433,440.                    \tag{79.26}
\]

At each of these seven levels, exact real-algebraic root isolation finds a
conjugate outside \([-7,7]\).  Therefore the only elements of the maximal
order with every conjugate in this interval are
\(-7,-6,\ldots,7\).  Enumerating the maximal order is stronger than
enumerating the unknown geometric endomorphism order, so
\(\mathrm{SW}_7\) follows. \(\square\)

The calculation is reproduced by
[`79_M7_CROSS_IMAGE_AND_SCALAR_WINDOW_CERTIFICATE.sage`](79_M7_CROSS_IMAGE_AND_SCALAR_WINDOW_CERTIFICATE.sage).

## 5. Elimination of degree seven for the explicit pair

### Theorem 79.6 (no degree-seven order-three diamond)

For the explicit pair (76.1)--(76.2), no prime-ratio diamond has degree
\(M=7\).  Consequently, after files 76 and 78, every such diamond has

\[
                                M\geq8.                              \tag{79.27}
\]

#### Proof

Here \(r=3\), \(s=8\), \(g(X)=9\), and

\[
                         g(C)=57,\qquad g(V)=169.                  \tag{79.28}
\]

Since seven is prime, Corollary 68.6 leaves coefficient degrees one and
two.  The coefficient space has dimension three or four.

If the coefficient map is birational, its image has degree 14 and
normalization genus 57.  In dimension four, Castelnuovo gives genus at
most 36.  In dimension three, the cyclic cubic extension \(V/C\) makes
the cubic discriminant a square.  Lemma 78.9 bounds the genus of the
degree-14 plane curve by 43 in plane types 1 and 2 and by 36 in type 3.
Both alternatives are impossible.

It remains to take the quadratic case \(q:C\to B\), which is case B of
Theorem 68.5.  If it were unramified, then \(g(B)=29\).  If ramified,
Lemma 74.1 gives \(g(B)\geq9\).  A degree-seven nondegenerate curve in
\(\mathbf P^3\) has genus at most six, so the coefficient image must be a
plane septic.  Its arithmetic genus gives

\[
                              9\leq b=g(B)\leq15,                    \tag{79.29}
\]

and in particular \(q\) is ramified.

The extension \(K/B\) in (79.4) is \(S_3\) or \(C_6\).  In the first
case, Proposition 79.2 gives

\[
                              b\geq{7(8-2)\over2}+1=22,
\]

contradicting (79.29).  In the cyclic case, \(E/B\) is an etale cyclic
cubic extension, so its discriminant is a square on the coefficient
septic.  Lemma 79.1 and (79.29) force

\[
          b=9,\qquad\Pi\text{ of type 1 or 2},\qquad
          \deg\operatorname{Ram}(q)=116-4b=80.                     \tag{79.30}
\]

Proposition 79.5 supplies \(\mathrm{SW}_7\).  Corollary 79.4 would require

\[
 80\leq 14+2\sqrt{9(7^2+7\cdot8)}
          =14+6\sqrt{105}<80,                                      \tag{79.31}
\]

a contradiction.  Thus the final quadratic row is impossible. \(\square\)

## 6. Scope

The reusable output is Theorem 79.3.  It requires neither a coefficient
plane nor a cubic spectral extension: it applies whenever an etale cover
of a nonhyperelliptic curve also admits a ramified involution and the
compressed involution is scalar.  For arbitrary \(M\), the exact survivor
condition is the existence of

\[
 f\mid M,\quad f<M,\quad f\mid\lambda,\quad -M<\lambda<M
\]

satisfying (79.12)--(79.13).  The scalar-window calculation is finite for
each concrete \(X,M\), while (79.12)--(79.13) scale without change.

The cubic results in Sections 1--2 supply the complementary route to a
large ramification number \(R\): the nonabelian closure forces a large
coefficient-base genus, while the cyclic closure forces the coefficient
curve onto a discriminant double plane.  At \(M=7\) these two mechanisms
isolate the equality row (79.30), and the general cross-image sieve then
removes it.
