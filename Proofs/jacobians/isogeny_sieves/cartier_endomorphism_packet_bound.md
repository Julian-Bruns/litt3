# Proof: separate inherited Cartier kernels from admissible packets

[Statement](../../../Theorems/jacobians/isogeny_sieves/cartier_endomorphism_packet_bound.md).
We use the established
[endomorphism-packet inequality](../../../Theorems/jacobians/isogeny_sieves/etale_endomorphism_packets.md).
The additional point is that its rational idempotents act integrally
away from \(|G|\). The later all-height representation gap suggests
retaining the trivial kernel packet rather than discarding it.
The same projection argument then bounds the excess at every height.

Fix e>=1 and put \(K_{e,C}=\ker(C_C^e)\), so
\(\dim K_{e,C}=a_e(C)\). Since a(X)>0, \(K_{e,X}\) is nonzero at
every height. Scalar Frobenius twists in the target are understood.
Since \(f\) is separable, pullback of differentials is injective,
commutes with Cartier, and sends a nonzero element of \(K_{e,X}\)
to a nonzero element \(v\in K_{e,Z}\).

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
\(K_{e,Z}\), and on \(J(Z)\) up to prime-to-p denominators, and sum
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
Since \(e_{\mathcal O}^*K_{e,Z}\ne0\), semisimplicity shows that
the nontrivial part of \(K_{e,Z}\) has dimension at least
\(c_\chi\). Its trivial part is EXACTLY \(q^*K_{e,Y}\), of
dimension \(a_e(Y)\): invariant regular forms descend along the
actual étale torsor, and Cartier commutes with that descent.
The orthogonal idempotents separate these parts, so
\(a_e(Z)-a_e(Y)\ge c_\chi\). Minimizing proves the assertion.

The coefficients of each rational idempotent reduce to the prime
field, so they preserve every iterated Cartier kernel, not just
the first one. For sufficiently large e these kernels stabilize
at dimensions \(\Delta(C)=g(C)-f_p(C)\), proving the stable bound.

All character fields are cyclotomic subfields, so
\([F_\chi\cap K:\mathbf Q]\le\kappa\), and the Schur index is
at least one. Equation (2) yields the stated uniform bound.
For the fixed \(X\), the audited arithmetic gives \(d=9\),
\(a(X)=3\), and \(\kappa=2\). With \(h=2\) this gives an excess
of five at every height.
If \(3\nmid|G|\), its character fields cannot contain
\(\mathbf Q(\zeta_3)\), so their intersection with \(K\) is
\(\mathbf Q\), and (2) gives an excess of nine.

This proof uses the actual genus-two Galois leg and the actual
separable map to \(X\). It does not Galois-close both legs.
For p-divisible \(|G|\), the idempotents (1) need not act on
the finite Cartier kernel and modular dimensions can decrease;
the argument makes no claim in that case.
