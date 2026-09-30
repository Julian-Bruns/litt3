# Proof: keep the finite Cartier kernel inside the rational packets

[Statement](../../../Theorems/jacobians/isogeny_sieves/cartier_endomorphism_packet_bound.md).
We use the established
[endomorphism-packet inequality](../../../Theorems/jacobians/isogeny_sieves/etale_endomorphism_packets.md).
The additional point is that its rational idempotents act integrally
away from \(|G|\), so an actual nonzero Cartier-kernel form cannot
be hidden entirely in packets whose characteristic-p dimensions
are too large.

Put \(K_C=\ker(\operatorname{Cartier}:H^0(C,\omega_C)
\to H^0(C^{(1)},\omega_{C^{(1)}}))\), so \(\dim K_C=a(C)\).
Since \(f\) is separable, pullback of differentials is injective,
commutes with Cartier, and sends a nonzero element of \(K_X\)
to a nonzero element \(v\in K_Z\).

For a rational character orbit \(\mathcal O\), its central
idempotent in \(\mathbf Q[G]\) is
\[
e_{\mathcal O}=\sum_{\chi\in\mathcal O}
\frac{\chi(1)}{|G|}\sum_{g\in G}\chi(g^{-1})g.
\tag{1}
\]
The orbit sum of the character values is an integer. Consequently
\(e_{\mathcal O}\in\mathbf Z[1/|G|][G]\subset\mathbf Z_{(p)}[G]\).
These mutually orthogonal idempotents act on differentials, on
\(K_Z\), and on \(J(Z)\) up to prime-to-p denominators, and sum
to the identity. Some \(e_{\mathcal O}^*v\) is therefore nonzero.

Let \(A_{\mathcal O}\) be the corresponding rational isogeny
factor of \(J(Z)\). On differentials, \(f^*\) is the cotangent
map of \(\operatorname{Nm}_f:J(Z)\to J(X)\). The nonzero
composition \(e_{\mathcal O}^* f^*\) shows that
\(\operatorname{Nm}_f\circ e_{\mathcal O}\) is a nonzero rational
homomorphism from \(A_{\mathcal O}\) to \(J(X)\). Since \(J(X)\)
is simple, it is an isogeny factor of \(A_{\mathcal O}\).
The orbit cannot be trivial: that packet is isogenous to \(J(Y)\),
whose dimension \(h\) is less than \(d\).

For any \(\chi\in\mathcal O\), the endomorphism-packet theorem
therefore gives
\[
d\le(h-1)[F_\chi\cap K:\mathbf Q]\,
\chi(1)/e_K(\chi).
\tag{2}
\]
Hence \(\chi\in\mathcal I\).

Finally use \(p\nmid|G|\). The characteristic-zero irreducible
representations and their reductions over an algebraically closed
field of characteristic \(p\) have the same dimensions, through a
choice of compatible roots of unity of order dividing \(|G|\).
Equivalently, a splitting unramified characteristic-zero coefficient
ring makes the group algebra a product of matrix algebras, and
reduction preserves those matrix sizes. The reduction of (1) is
the sum of precisely the irreducible characteristic-p blocks coming
from its rational orbit; every one has dimension \(c_\chi\).
Since \(e_{\mathcal O}^*K_Z\ne0\), semisimplicity gives
\(a(Z)\ge c_\chi\). Minimizing proves the assertion.

All character fields are cyclotomic subfields, so
\([F_\chi\cap K:\mathbf Q]\le\kappa\), and the Schur index is
at least one. Equation (2) yields the stated uniform bound.
For the fixed \(X\), the audited arithmetic gives \(d=9\),
\(a(X)=3\), and \(\kappa=2\). With \(h=2\) this gives five.
If \(3\nmid|G|\), its character fields cannot contain
\(\mathbf Q(\zeta_3)\), so their intersection with \(K\) is
\(\mathbf Q\), and (2) gives nine.

This proof uses the actual genus-two Galois leg and the actual
separable map to \(X\). It does not Galois-close both legs.
For p-divisible \(|G|\), the idempotents (1) need not act on
the finite Cartier kernel and modular dimensions can decrease;
the argument makes no claim in that case.
