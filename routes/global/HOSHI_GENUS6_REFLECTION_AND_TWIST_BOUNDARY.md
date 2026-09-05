# Reflections of the ten-Tango genus-six curve and an étale twist boundary

**Status:** author proof and exact Sage certificate, 2026-09-05; not
independently audited. No twists or additional curves were searched.
The fixed pair in file 76 is unchanged.

Use the curve, differential basis, constants and connection coordinates
of [the exact ten-Tango calculation](HOSHI_GENUS6_EXACT_TANGO_COUNT.md):

\[
 E:y^2=x^3+3x+2,\quad P=(1,1),\quad
 Y:w^6=f=(x+3)y+4x^2+4x+3.
\]

All curves below mean their smooth projective models over
\(\overline{\mathbf F}_5\). The new
[certificate](HOSHI_GENUS6_REFLECTION_CERTIFICATE.py) reruns the ten-point
certificate and verifies the additional identities and permutations.

## 1. Six involutive lifts, in two conjugacy classes

For the elliptic involution \(\iota(Q)=P-Q\), direct substitution gives

\[
                         f(\iota Q)=4/f(Q).             \tag{1}
\]

In the earlier explicit coordinates \((x',y')=(x,y)-P\), one has
\(\iota(x,y)=(x',-y')\). Thus all six lifts are

\[
 \tau_a:(Q,w)\longmapsto(P-Q,a/w),\qquad a^6=4.
                                                               \tag{2}
\]

They square to the identity. With \(\lambda^2=3\) as in the earlier
certificate, put \(\zeta=\lambda+3\), a primitive sixth root of unity.
The six parameters are \(a=2\zeta^j\), \(j\in\mathbf Z/6\mathbf Z\).
Conjugation by \(w\mapsto\zeta^m w\) changes \(a\) to
\(\zeta^{2m}a\). Hence there are exactly two conjugacy classes under the
Kummer group, represented by

\[
 \tau_{\rm even}: w\mapsto2/w,\qquad
 \tau_{\rm odd}: w\mapsto2\zeta/w.                    \tag{3}
\]

The different fixed-point counts below also prevent these two classes
from becoming conjugate under the full automorphism group.

## 2. Fixed points and quotient genera

The elliptic involution has four geometric fixed points \(2Q=P\).
None is \(P\) or \(O\), so the degree-six cover is étale above all four.
One is \((2,4)\), with \(f=2\). The other three have

\[
 x^3+3x^2+2=0,\qquad y=3x^3+x^2+x+4,\qquad f=3.
                                                               \tag{4}
\]

The cubic is separable and irreducible over \(\mathbf F_5\); these
statements, including the two values of \(f\), are checked exactly.
A point over \(Q\) is fixed by \(\tau_a\) precisely when
\(w^2=a\). There are exactly two such points if \(f(Q)=a^3\), and none
otherwise. Points over \(P,O\) are exchanged, not fixed.

| Lift representative | \(a^3\) | Fixed points on \(Y\) | Genus of \(B=Y/\tau_a\) | p-rank of \(B\) |
|---|---:|---:|---:|---:|
| \(a=2\) | 3 | 6 | 2 | 1 |
| \(a=2\zeta\) | 2 | 2 | 3 | 2 |

Indeed the quotient is a separable tame double cover and
\(10=2(2g(B)-2)+\#\operatorname{Fix}(\tau_a)\).
The p-ranks follow from the invariant Cartier-fixed differential spaces
in Section 3; their dimensions are respectively one and two. For a tame
double quotient, invariant regular differentials descend regularly, and
Cartier commutes with pullback. In particular these are actual smooth
positive-genus quotients, not formal function-field candidates.

## 3. Affine action on every dormant connection and the ten Tango points

Let \(\nabla_0\) declare \(dw\) horizontal, and write
\(\nabla=\nabla_0+\sum c_i b_i\), with the Cartier-fixed basis

\[
 (b_0,b_1,b_2,b_3)
   =(\beta,\eta_2-\eta_4,\lambda(\eta_2+\eta_4),\mu\eta_3).
\]

Both reflections send \(\beta\) to \(-\beta\). Crucially their action
on connections is **affine**, not just their linear action on forms:
since \(\tau_a^*dw=-aw^{-2}dw\), one has

\[
                   \tau_a^*\nabla_0=\nabla_0+2\beta.
\]

Exact substitution gives

\[
\begin{aligned}
 \tau_{\rm even}^*(c_0,c_1,c_2,c_3)
   &=(2-c_0,c_1,-c_2,-c_3),\\
 \tau_{\rm odd}^*(c_0,c_1,c_2,c_3)
   &=(2-c_0,2c_1+3c_2,4c_1+3c_2,c_3).
\end{aligned}                                             \tag{5}
\]

The linear parts have invariant dimensions one and two, as used above.
An invariant connection must satisfy \(c_0=1\), whereas all ten Tango
points have \(c_0\in\{0,2,3,4\}\). Consequently **neither reflection
fixes any maximal Tango structure**.

For both reflections, two of the five transpositions are

\[
 (0,0,0,0)\leftrightarrow(2,0,0,0),\qquad
 (3,0,0,0)\leftrightarrow(4,0,0,0).
\]

For \(\tau_{\rm even}\) the remaining three are

\[
\begin{aligned}
 (3,2,0,0)&\leftrightarrow(4,2,0,0),\\
 (3,4,2,0)&\leftrightarrow(4,4,3,0),\\
 (3,4,3,0)&\leftrightarrow(4,4,2,0).
\end{aligned}
\]

For \(\tau_{\rm odd}\) they are

\[
\begin{aligned}
 (3,2,0,0)&\leftrightarrow(4,4,3,0),\\
 (3,4,2,0)&\leftrightarrow(4,4,2,0),\\
 (3,4,3,0)&\leftrightarrow(4,2,0,0).
\end{aligned}
\]

## 4. The twist mechanism is available, but does not yet exclude Tango

For either reflection let \(B=Y/\tau\). Its positive genus guarantees
nontrivial connected étale double covers \(B'\to B\), corresponding to
nonzero two-torsion line bundles. Fix any one, with free deck involution
\(\delta\), and form

\[
                         Z=Y\times_B B'.
\]

The map \(Z\to Y\) is finite étale of degree two. This fiber product is
already smooth, since it is étale over smooth \(Y\). It is connected:
the distinct quadratic extensions \(k(Y)/k(B)\) and \(k(B')/k(B)\) are
linearly disjoint, as the first is ramified and the second unramified.
The commuting involutions \(\tau\times1\) and \(1\times\delta\) act
on it. Their product is free, because \(\delta\) has no fixed points.
Therefore

\[
 X=Z/\langle\tau\times\delta\rangle
\]

is smooth projective and connected, and both maps \(Z\to Y\) and
\(Z\to X\) are actual finite étale double covers. Riemann--Hurwitz gives
\(g(Z)=11\) and \(g(X)=6\). Equivalently \(X\to B\) is the unramified
quadratic twist of \(Y\to B\), with the same branch locus.

The ten Tango structures pulled back from \(Y\) remain distinct on
\(Z\), and \(\tau\times\delta\) permutes them as in (5), with no fixed
point. Thus **none of these ten pulled-back structures descends to
\(X\)**. This is not a proof that \(X\) has no maximal Tango structure:
the étale cover \(Z\to Y\) may acquire additional Tango structures,
some possibly invariant under \(\tau\times\delta\). Excluding these
would require a further calculation or theorem, not supplied here.
No unrestricted étale-descent counterexample is claimed.
