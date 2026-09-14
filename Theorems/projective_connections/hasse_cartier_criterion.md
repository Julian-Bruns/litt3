# Hasse–Cartier tests for ordinary connections and eigenform tangents

Version1,2026-09-14.

Let \(X/k\) be smooth projective connected of genus \(g\ge2\), with
\(k\) algebraically closed of odd characteristic \(p\). Let
\(\mathcal P\) be an active admissible regular nilpotent indigenous
connection, with square Hasse invariant
\(h\in H^0(X,\omega_X^{p-1})\) and supersingular divisor \(E\),
so \(\operatorname{div}(h)=2E\), with \(E\) reduced.
Use \(X^F\) for the scalar Frobenius twist.

The connection is ordinary exactly when the relative Cartier map
\[
 C:H^0(X,\omega_X^{p+1}(-2E))
       \longrightarrow H^0(X^F,(\omega_X^F)^2)
\]
is an isomorphism. After multiplication by \(h\), this is
Mochizuki's infinitesimal Verschiebung
\[
 \Phi^\omega_{\mathcal P}:H^0(X,\omega_X^2)
       \longrightarrow H^0(X^F,(\omega_X^F)^2).
\]
Its kernel is the fixed-curve nilpotent tangent space.

Suppose \(p\ge5\). Put \(p^\circ=(p-1)/2\), take
\(d\in\{p^\circ,p-1\}\), and suppose
\(h=-s^{(p-1)/d}\), \(s\in H^0(X,\omega_X^d)\).
On any connected component \(\pi:P\to X\) of the normalized root
cover \(\eta^d=\pi^*s\), let \(G\) be the actual deck group and
\(\chi\) the character of \(\eta\). Then
\[
 I:H^0(X,\omega_X^2)\xrightarrow{\sim}H^0(P,\omega_P)_{\chi^{-1}},
 \qquad t\longmapsto\pi^*t/\eta.
\]
This identifies the ordinary test with Cartier on the inverse-character
block, of dimension \(3g-3\), and identifies their kernel dimensions.
One may always take \(d=p-1\), \(s=-h\).
The root form need not be assumed Cartier-fixed.

In characteristic five, let \(d=2\) or \(4\), \(e=d/2\), \(r=5-4/d\),
and let a nonzero normalized eigenform satisfy
\[
 C_{d-1}(s^r)=s,\qquad \operatorname{div}(s)=eE,\quad E\text{ reduced}.
\]
It determines such an admissible connection with \(h=-s^{4/d}\).
Let \(\mathcal E_d\) be the finite normalized eigenform scheme and
\(\mathcal S_e\) the stratum of divisors \(e\) times a reduced divisor.
Then
\[
 T_s(\mathcal E_d\cap\mathcal S_e)
 \simeq\ker(C_P|H^0(\omega_P)_\chi),\qquad
 u\longmapsto\pi^*u/\eta^{d-1}.
\]
The \(\chi\) and \(\chi^{-1}\) Cartier kernels have equal dimensions.
Thus ordinariness is equivalent to reducedness of
\(\mathcal E_d\cap\mathcal S_e\) at \(s\). For \(d=2\) this tests
\(\mathcal E_2\); for \(d=4\) it tests the equimultiple intersection.
All connection tests commute with actual étale pullback; ordinariness
of a pullback still requires the test on that source.

[Proof and exact literature](../../Proofs/projective_connections/hasse_cartier_criterion.md).
