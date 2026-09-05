# An explicit failure of unrestricted étale descent for maximal Tango structures

**Status:** author proof with reproducible exact certificate, 2026-09-05.
The final zero computation has been independently rerun by
`/root/gluing_cohomology_rigidity`; the
[focused audit](audits/HOSHI_GENUS6_TWIST_WITH_NO_MAXIMAL_TANGO_AUDIT.md)
records **PASS**, with no breaking objection, 2026-09-05.
This theorem concerns **auxiliary curves**
\(Y_{\rm Hoshi},X_{\rm twist},Z\), not the fixed pair in file 76.
It disproves unrestricted maximal-Tango descent, **not Litt's conjecture**.

## Theorem

Over \(k=\overline{\mathbf F}_5\), put \(r^2=3\) and

\[
\begin{aligned}
 F(t)&=2t^6+2t^4+3t^2+4,\\
 A(t)&=2t^8+4t^6+2,\qquad B_0(t)=t^2+4,\\
 q(t)&=t^2+rt+1.
\end{aligned}
\]

Let the following equations denote smooth projective normalizations:

\[
\begin{aligned}
 B &: v^2=F(t),\\
 Y_{\rm Hoshi} &: v^2=F(t),\quad h_Y^2=A(t)+B_0(t)v,\\
 X_{\rm twist} &: v^2=F(t),\quad h_X^2=q(t)(A(t)+B_0(t)v),\\
 Z &: v^2=F(t),\quad h_Y^2=A(t)+B_0(t)v,\quad s^2=q(t).
\end{aligned}                                                     \tag{1}
\]

Then:

1. \(Y_{\rm Hoshi}\) and \(X_{\rm twist}\) have genus six, and \(Z\)
   has genus eleven.
2. The maps \(Z\to Y_{\rm Hoshi}\) and \(Z\to X_{\rm twist}\), the
   second given by \(h_X=sh_Y\), are connected finite étale double covers.
3. \(Y_{\rm Hoshi}\) has ten maximal Tango structures, and hence \(Z\)
   has a maximal Tango structure by étale pullback.
4. \(X_{\rm twist}\) has **no maximal Tango structure**.

Consequently existence of a maximal Tango structure does not descend
through arbitrary connected finite étale covers in characteristic five.

The p-ranks are \(4,5,8\) for \(Y_{\rm Hoshi},X_{\rm twist},Z\),
respectively. Thus there is no contradiction with positive-p-rank-preserving
descent in file 115.

## 1. The curves and the actual étale maps

The earlier [quotient-model certificate](HOSHI_GENUS6_GENUS2_QUOTIENT_MODEL_CERTIFICATE.py)
identifies \(Y_{\rm Hoshi}\) with the smooth Kummer curve

\[
 E:y^2=x^3+3x+2,\qquad
 w^6=(x+3)y+4x^2+4x+3.
\]

Its involution \((Q,w)\mapsto(P-Q,2/w)\), \(P=(1,1)\), has quotient
\(B\). The exact invariant generators and \(h_Y=t^5(w-2/w)\) are given
in the [quotient-model proof](HOSHI_GENUS6_GENUS2_QUOTIENT_MODEL.md).
The [ten-Tango certificate](HOSHI_GENUS6_EXACT_TANGO_COUNT_CERTIFICATE.py)
exhaustively proves the stated count. For the present theorem, even the
previously exhibited nonzero maximal Tango structure on that curve suffices.

The factor \(q\) selects two distinct roots of \(F\). On \(B\), if
\(W_a,W_b\) are their Weierstrass points and \(I_+,I_-\) are the two
geometric points at infinity, then

\[
 \operatorname{div}_B(q)=2W_a+2W_b-2I_+-2I_-.
\]

Thus \(B'=B(\sqrt q)\to B\) is unramified. It is connected: neither
\(q\) nor \(q/F\) is a square in \(k(t)\), so \(q\) is not a square
in \(k(B)\). The extension \(Y_{\rm Hoshi}/B\) is quadratic and ramified
at six points, so it is linearly disjoint from the unramified extension
\(B'/B\).

Therefore \(Z=Y_{\rm Hoshi}\times_B B'\) is connected and étale of
degree two over \(Y_{\rm Hoshi}\). Since \(h_X=sh_Y\), it is also
\(X_{\rm twist}\times_B B'\), and the map to \(X_{\rm twist}\) is
étale of degree two. These fiber products are already smooth because
they are étale over smooth curves. Equivalently, the product of the
reflection and the free deck involution of \(B'/B\) is free on \(Z\).
Riemann--Hurwitz gives the stated genera.

## 2. A globally regular dormant origin on \(X_{\rm twist}\)

Write \(e=A+B_0v\), and \(Q_0=(0,2)\in B\). The exact norm identity

\[
 \operatorname{Norm}(e)
 =4t^{10}(t^6+4t^4+4t^2+2)
\]

shows, as proved in the [single-twist p-rank note](HOSHI_GENUS6_SINGLE_TWIST_P_RANK.md),
that

\[
 \operatorname{div}_B(e)
   =10Q_0+R_1+\cdots+R_6-8I_+-8I_-.
\]

The six \(R_i\) are distinct and disjoint from \(Q_0,W_a,W_b,I_+,I_-\).
On \(X_{\rm twist}\), consider the nonzero rational differential

\[
                       \xi=q^3\frac{dt}{v h_X}.        \tag{2}
\]

Its divisor has order \(+5\) at each of the four points above
\(W_a,W_b\), order \(-5\) at each of the two points above \(Q_0\),
and order zero everywhere else. Indeed, on \(B\), \(dt/v\) has a
simple zero at each infinity. At each \(R_i\), its pullback has a simple
zero from ramification, canceled by the simple zero of \(h_X\). At
\(W_a,W_b\), the orders of \(q^3\) and \(h_X\) are six and one. At
\(Q_0\), \(h_X\) has order five. At infinity the orders are
\(-6+1-(-5)=0\).

Declaring \(\xi\) horizontal therefore gives a **globally regular
dormant canonical connection** \(\nabla_\xi\): locally the divisor of
its rational horizontal frame is divisible by five, so its logarithmic
connection coefficient is regular, and a rational horizontal frame
gives zero p-curvature. This is a genuine global origin, not merely a
regular expression at the test points.

## 3. The complete geometric set of 3125 dormant connections

Every regular dormant canonical connection is uniquely

\[
                \nabla_\xi+\alpha,\qquad
 \alpha\in H^0(X_{\rm twist},\omega)^{C=1}.
\]

The [scalar-only Cartier certificate](HOSHI_GENUS6_SINGLE_TWIST_P_RANK_CERTIFICATE.py)
constructs the complete holomorphic anti-invariant basis
\((a_i+b_iv)dt/(vh_X)\) using the necessary and sufficient conditions

\[
 \deg a\le6,\quad \deg b\le3,\quad q\mid a,\quad
 a+b(2+2t^2+2t^4)\equiv0\pmod{t^5}.
\]

It directly verifies the Cartier image of each basis vector. Its
anti-invariant Cartier matrix is

\[
 M=\begin{pmatrix}
 1&0&0&3r\\
 2r&3&4r&4\\
 1&4r&4&3r\\
 0&0&3r&3
 \end{pmatrix},
\]

acting inverse-Frobenius semilinearly. It is invertible, so the
anti-invariant Cartier stable dimension is four. The invariant part
has exactly the one-dimensional fixed space generated by \(t\,dt/v\).
Thus the full geometric fixed space has dimension five over
\(\mathbf F_5\).

The final certificate works over the explicitly specified field
\(K=\mathbf F_{5^{120}}\); both its irreducible modulus and the embedding
of \(r\) are recorded as coefficient lists. It expands

\[
                            z^5=M^{(5)}z
\]

into a \(480\)-dimensional linear system over **the prime field**
\(\mathbf F_5\). Its kernel has dimension four. Every returned vector
is directly reconstructed in \(K^4\) and checked against the original
field equation; independence is additionally verified by scalar
elimination. These four fixed forms, together with \(t\,dt/v\), are
the entire geometric fixed space, since its dimension is already known
to be five. No other solutions over larger constant fields are omitted.

Accordingly the certificate tests precisely all \(5^5=3125\) dormant
regular canonical connections, not just connections rational over a
convenient smaller field.

## 4. Finite rejection of every connection

In the local parameter \(t\), write
\(\nabla(dt)=a\,dt\otimes dt\). A horizontal form \(u\,dt\) satisfies
\(u'=-au\), and hence

\[
 u^{(4)}=P_4(a)u,\qquad
 P_4(a)=a^4-a^2a'+3(a')^2+4aa''-a'''.                 \tag{3}
\]

By the Cartier formula, its horizontal line is Cartier-zero exactly
when \(P_4(a)=0\). In particular **one nonzero evaluation excludes a
maximal Tango structure**. This uses only a necessary local condition
on already global regular dormant connections.

The final [zero-Tango certificate](HOSHI_GENUS6_SINGLE_TWIST_TANGO_CERTIFICATE.py)
computes exact Taylor expansions through order four by square-root
Newton iteration in characteristic five. At every test point it checks
\(v^2=F\), \(h_X^2=qe\), and \(v h_X q e\ne0\). Thus \(t\) is a
local parameter, every required denominator is a unit, and the resulting
values of (3) are exact.

Starting with all 3125 tuples, the rejection counts are:

| Test point \((t,v,h_X)\) | Connections remaining |
|---|---:|
| \((1,1,2+2r)\) | 3 |
| \((1,4,2+2r)\) | 1 |
| Six further safe points over \(t=1,4\) | 1 |
| \((0,3,2)\) | 0 |

The sole connection remaining after the second point is
\(\nabla_\xi+t\,dt/v\). At the final point its obstruction is already
visible by hand: its coefficient is \(a=4t+O(t^4)\), with zero cubic
coefficient, so \(P_4(a)(0)=3\ne0\).

The final code asserts `survivors == []`. Every dormant connection is
rejected somewhere, so the zero result requires **no interpolation,
no theorem bounding numbers of zeros, and no assumption that vanishing
at finitely many points implies identical vanishing**. This proves that
\(X_{\rm twist}\) has no maximal Tango structure.

## 5. Computational reliability and exact scope

The focused
[Sage matrix-backend audit](audits/HOSHI_SAGE10_9_CUSTOM_GF25_MATRIX_BACKEND_AUDIT.md)
confirmed a bug in optimized dense matrix operations for the tested
custom \(\mathbf F_{25}\) representation, and found no breaking
objection to the present Hoshi certificates after independent scalar
rechecks. The p-rank computation uses only scalar extension-field
elimination. The final zero computation uses an optimized matrix only
over \(\mathbf F_5\), with direct field verification and independent
scalar checks of its returned solutions. No optimized
extension-field matrix operation is used in the zero theorem.

The final certificate runs in well under a second after Sage startup
in the tested environment. Its output is a finite exact proof of
nonexistence, not a heuristic search.

Finally, \(Z\) inherits a maximal Tango structure from \(Y_{\rm Hoshi}\)
along its actual étale map. Since \(Z\to X_{\rm twist}\) is also actual,
connected, finite and étale, assertion 4 proves the claimed failure of
unrestricted descent. None of the fixed-pair arithmetic, simplicity,
gonality or Jacobian-orthogonality assumptions from file 76 are asserted
for these auxiliary curves. No conclusion about Litt's conjecture is
drawn.
