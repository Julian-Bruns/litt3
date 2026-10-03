# Pointed genus-two extensions under Frobenius

Version8,3 October2026. The dormant normal form holds in every
odd characteristic; the family computations below retain $p=5$.
The elliptic incidence theorem supplies the exact first-height locus;
the later fourth-height certificate supplies all earlier-height
nonvanishing through the exact polynomial cohomology criterion.

Let $k$ be algebraically closed of odd characteristic $p$, let
$C$ have genus two, and let
$0\to\mathcal O_C\to E\to\omega_C\to0$ be a nonsplit pointed
extension. For a regular dormant projective connection $r$,
let $V_r$ be the canonical-determinant Cartier descent of its
scalar jet oper on $J^1(\omega_C^{(p-1)/2})$, with prescribed
quotient $\omega_C^{(p-1)/2}$; see the
[intrinsic Bol construction](../projective_connections/dormant_bol_complex.md).
At $p=5$ this is precisely the dormant tangent bundle.

If h is the first unstable pullback index and \(b=p^{h-1}\), then
at the last relative Frobenius step there are a regular dormant
connection r and a two-torsion line \(\tau_1\) such that
\[
F^{(h-1)*}E\simeq V_r\otimes\omega^{(b-1)/2}\otimes\tau_1.
\]
This is Cartier descent of an isomorphism of the actual connections.
The earlier scalar twists are retained. At h=1 the nonzero section
of \(V_r\otimes\tau_1\) is nowhere zero and unique up to scalar,
and its quotient is \(\omega\). At \(h\ge2\), the displayed
bundle has \(2(p^{h-1}-1)\) sections. Those sections must still
come from the original pointed extension; their dimension alone
does not exclude instability.

Now specialize to $p=5$. For \(C_t:v^2=u(u-1)(u-2)(u-3)(u-t)\), with smooth parameter
\(t\notin\{0,1,2,3\}\), the first-height criterion is exact.
At t=4 some nonsplit pointed extension is unstable after pullback.
For \(t\ne4\), put
\[
z=(t+1)^{-1},\qquad A=(z^5-z)^4.
\]
Some such extension is unstable after the first pullback if and
only if \(A^3+3A^2+4=0\). These are exactly sixty ordinary
parameters, all in \(\mathbf F_{125}\setminus\mathbf F_5\).
Ordinariness alone therefore does not give this semistability.

Every nonsplit pointed extension stays semistable through index h
under the following sufficient large-degree conditions:

| h | Sufficient degree \([\mathbf F_5(t):\mathbf F_5]\) |
| --- | --- |
| 2 | greater than 16,380 |
| 3 | greater than 8,124,480 |
| 4 | greater than 4,829,577,480 |

The same conclusion through index four holds for ALL sixty cubic
parameters passing the first-height test. They are branch-set
isomorphic to coefficient twists of the backup
\(\alpha^3+\alpha+1=0\). In particular the previously selected
main and backup endpoints both qualify; no parameter is reselected.

All32 fourth-height blocks pass, including projective infinity
and every geometric extension parameter. They use the entire
polynomial row module. Semistability through height four implies
all earlier-height tests; separate Laurent or interpolation runs
are unnecessary. At \(P=5^h\) the
[polynomial cohomology matrices](genus_two_pointed_polynomial_test.md)
give the coefficient-resultant degree bound
\[
B(P)=\frac{(P^2-1)(P+3)(P+5)}{32}.
\]
Nonvanishing at the backup proves these resultants are nonzero
polynomials, giving the large-degree transfer independently of
any theta-coordinate model.

For an actual coreless bi-étale span with either selected endpoint,
any nonzero [joint curve tangent](pointed_bundle_instability.md)
has first Frobenius-instability index at least five. The
[extension-spectrum criterion](two_leg_negative_extensions.md)
therefore forces the unique simultaneous W2 lift for exceptional
clump sizes4,24,124,624 with primitive multiplicity1 or2.
Any nonzero joint tangent requires clump size at least3,124.
No all-height geometric semistability or common-cover exclusion
is asserted.

[Proof and evidence](../../Proofs/deformations/pointed_extensions_frobenius.md).
The general dormant quotient-jet identification uses the intrinsic
jet construction; the finite-height cohomology criterion and native
row engine retain their independent audit scopes.
