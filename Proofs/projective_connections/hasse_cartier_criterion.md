# Proof: the Hasse–Cartier test and root characters

[Statement](../../Theorems/projective_connections/hasse_cartier_criterion.md).
Write \(X^F\) for the scalar Frobenius twist and
\(p^\circ=(p-1)/2\), following Hoshi.

## 1. The published ordinary criterion

For the given admissible connection, conditions(1),(3) of
[Hoshi, *On the supersingular divisors of nilpotent admissible
indigenous bundles*, Theorems3.9–3.10, pp17–18](https://www.jstage.jst.go.jp/article/kodaimath/42/1/42_1/_pdf/-char/ja#page=17)
already hold for its supersingular divisor \(E\). Condition(2′) is
exactly the Cartier isomorphism in the statement, with marking divisor
\(D=0\). Since \(\operatorname{div}(h)=2E\), multiplication by \(h\)
identifies its domain with \(H^0(X,\omega^2)\).

More precisely,
[Mochizuki, II, Lemma2.11, Proposition2.12 and Theorem2.13](https://www.kurims.kyoto-u.ac.jp/~motizuki/A%20Theory%20of%20Ordinary%20p-adic%20Curves.pdf#page=73)
identify this map with his \(\Phi^\omega_{\mathcal P}\), the dual of
the induced Frobenius on \(H^1(\tau_X)\), and with the differential
of \(V_X:S(X)\to Q(X)\). Thus its kernel is the nilpotent tangent
space. These results hold in every odd characteristic.

## 2. A single valuation calculation gives the root test

Put \(a=p^\circ\), and let \(d=a\) or \(2a\). The root cover is tame.
On a connected component its stabilizer in \(\mu_d\) is the actual
deck group \(G\); the root character \(\chi\) is faithful and
\(\mathbf F_p\)-valued. Since \(\operatorname{div}(s)=(d/a)E\),
the ramification index over \(E\) is \(a\), and
\(\operatorname{ord}_Q(\eta)=a\). For a rational quadratic \(t\),
\[
 \operatorname{ord}_Q(\pi^*t/\eta)
       =a\,\operatorname{ord}_{\pi(Q)}(t)+a-2.                 \tag{1}
\]
For \(a\ge2\), this is nonnegative exactly when \(t\) is regular.
Away from \(E\), the cover is étale and \(\eta\) is nonvanishing.
Conversely, multiply an inverse-character differential by \(\eta\):
the invariant rational quadratic descends, and (1) proves regularity.
This proves the isomorphism \(I\) and its dimension \(3g-3\).

The identity \(\eta^{p-1}=-\pi^*h\) and Cartier's projection formula
intertwine \(I\) with \(-\Phi^\omega_{\mathcal P}\), using the
corresponding \(I\) on \(X^F\). Characters are preserved because
they are \(\mathbf F_p\)-valued. No Cartier-fixedness of \(\eta\)
is required for this part.

## 3. Inverse character kernels have equal dimensions

This holds for any smooth proper curve \(P\) with a cyclic action of
order dividing \(p-1\). Use its polarized BT1
\(H=H^1_{\mathrm{dR}}(P)\), with
\(\operatorname{im}V=\ker F=H^0(\omega_P)\),
\(\operatorname{im}F=\ker V\), and \(V|H^0(\omega_P)=C_P\);
see [Cais–Ulmer, §§2,4, equations(2.1),(4.2)](https://arxiv.org/html/2307.16346v2).
Put \(A=\ker F\), \(B=\ker V\). On each character block,
\(\dim A_\rho+\dim B_\rho=\dim H_\rho\), so
\[
 \dim(A_\rho\cap B_\rho)=\dim H_\rho/(A_\rho+B_\rho).
\]
Polarization pairs \(\rho\) with \(\rho^{-1}\), and Frobenius–Verschiebung
adjointness makes the dual quotient \(A_{\rho^{-1}}\cap B_{\rho^{-1}}\).
These intersections are the respective Cartier kernels.

## 4. Characteristic-five eigenform tangents

For \(d=2\), the quadratic datum gives the quartic \(s^2\); for \(d=4\)
use \(s\). The [scalar dictionary](nilpotent_scalar_model.md) constructs
the active admissible connection, with \(h=-s^{4/d}\).
This uses the direct regular scalar model.

Let \(e=d/2\) and \(r=5-4/d\).
In coordinates the normalized eigenform scheme has equations
\(x_i^5-P_i(x)=0\), with \(P_i\) homogeneous of degree \(r<5\).
Their coprime leading monomials prove finiteness. Differentiating these
polynomial equations gives
\[
 T_s\mathcal E_d=\{u:C_{d-1}(s^{r-1}u)=0\}.                  \tag{2}
\]
The reduced-divisor stratum has tangent
\(H^0(\omega_X^d(-(e-1)E))\): for \(e=1\) it is open; for \(e=2\),
locally write \(s=q^2\), with
\(q\in H^0(\omega_X^2\otimes L)\), \(L^2=\mathcal O_X\).
The two-torsion label is étale, and the free sign quotient gives
the tangent \(2q\,H^0(\omega_X^2\otimes L)\).

For \(u\) of order \(b\) at \(E\), the form
\(J(u)=\pi^*u/\eta^{d-1}\) has order \(2(b-e+1)\).
Hence \(J\) identifies this tangent ambient space with
\(H^0(\omega_P)_\chi\). Cartier's projection formula gives
\[
 \pi^*C_{d-1}(s^{r-1}u)=\eta^{d-1}C_P(J(u)).
\]
Combine this with (2) and Section3. A finite local algebra is reduced
exactly when its tangent space is zero, proving the last equivalence.
