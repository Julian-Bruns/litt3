# The common rank-two locus and its uniform Frobenius boundary

Version4, 3 October2026. The cubic witness and finite locus are
consolidated with the later uniform family theorem. Exact finiteness
and rank certificates retain their original verification scope.

Let \(k=\overline{\mathbf F}_5\), let
\[
Y_a:v^2=u(u-1)(u-2)(u-3)(u-a),\qquad C_a=Y_a^{(1)},
\qquad a\notin\{0,1,2,3\},
\]
and let \(\mathcal V_0,\ldots,\mathcal V_4\) be the five actual
canonical-determinant Bol kernels for the specified relative
Frobenius \(Y_a\to C_a\). Their common section-test scheme in
\(U_{C_a}(2,0)\) is NONEMPTY at EVERY smooth parameter. Every
simultaneous semistable rank-two degree-zero coefficient bundle has
semistable first Frobenius pullback. Equivalently, the common locus
avoids all five first-unstable twist families
\(\{\mathcal V_j\vartheta^{-1}M:M\in J(C_a)\}\).
The exact norm determinant certifying this exclusion is
\[
2\bigl[a(a-1)(a-2)(a-3)\bigr]^{430}.
\]
If Y_a is ordinary, every common bundle is strongly semistable,
and EVERY positive-height Frobenius pullback is STRICTLY semistable.
This assertion has no parameter-degree restriction. It comes from an exact Čech--Koszul identity on
the whole symmetric five-test incidence, not from specialization
of the backup's finite locus.

If
\[
[\mathbf F_5(a):\mathbf F_5]>5280,
\tag{1}
\]
then the following hold over k, with no field-of-definition
restriction on the coefficient bundle or twist.

1. For every semistable rank-two degree-zero E on \(C_a\) with
   \(\det E\in J(C_a)[2]\), some i satisfies
   \(H^0(C_a,\mathcal V_i\otimes E)=0\).
2. For every connected étale double \(\pi:D\to C_a\) and every
   \(L\in J(D)(k)\), some i satisfies
   \(H^0(D,\pi^*\mathcal V_i\otimes L)=0\).

If the parameter degree is greater than248320, there is more:
the common scheme in \(U_{C_a}(2,0)\) of semistable rank-two
degree-zero coefficient bundles is nonempty and finite
of length160, and EVERY point is stable with no nontrivial two-torsion self-twist.
Its determinant D lies
outside both \(J(C_a)[2]\) and \([2]\Theta\), where
\(\Theta=\{\mathcal O(p-O):p\in C_a\}\). Thus
\(\omega_{C_a}D\) has a unique REDUCED effective divisor p+q,
and p,q are not both Weierstrass points. Every one of the five
section dimensions is1 and the actual6-by-6 Bol connecting map
has rank1. Global reducedness is not asserted.

These statements all hold at the cubic backup
\(a=\alpha\), \(\alpha^3+\alpha+1=0\). Consequently they
hold for BOTH selected genus-two endpoints. The main endpoint's
already fixed degree exceeds248320; no endpoint is changed.
Both are ordinary. Consequently EVERY common rank-two coefficient
on EITHER endpoint is stable and strongly semistable, with strictly
semistable pullbacks at every positive height. None is trivializable
by a finite étale cover.

There is a stronger geometric identity. Let R be the actual
symmetric determinant triquadratic and let W_a in
\(\mathbf P^3_b\times\mathbf P^3_c\) be the zero scheme of
the five coefficients of R(z(T),b,c) modulo the dormant quintic.
For every smooth ordinary a,
\[
W_a\ \subseteq\ V(H_{8,a}(b),H_{8,a}(c))
\]
scheme-theoretically, where H8 is the actual first Frobenius
boundary octic. Neither factor of W_a is required to be Kummer.
For the backup and parameters of degree>248320, W_a is a connected
local complete intersection curve with bidegree(320,320) and
arithmetic genus1921. Reducedness is not asserted.

For a stable E with nontrivial two-torsion determinant,
\(\omega_{C_a}\det E\) has unique effective divisor p+q with
p and q distinct Weierstrass points. Thus assertion1 excludes the
entire Weierstrass-pair modification case on both endpoints,
without a Frobenius-semistability hypothesis.

## An explicit reduced cubic witness

Put \(k_0=\mathbf F_{125}=\mathbf F_5[\alpha]/(\alpha^3+\alpha+1)\)
and \(k_1=k_0[\beta]/(\beta^2-2)\). A code \([n]\) means
\(n_0+n_1\alpha+n_2\alpha^2\), where
\(n=n_0+5n_1+25n_2\), \(0\le n_i<5\).
In the actual theta coordinates of the
[backup theta theorem](backup_dormant_theta_divisors.md), take
\[
b=([21]+[55]\beta:[97]+[28]\beta:[39]+[70]\beta:1).
\]
On \(C_\alpha\), define \(M=\mathcal O(D-2O)\) by
\[
U=x^2+([105]+[61]\beta)x+[71]+[116]\beta,\qquad
V=([85]+[38]\beta)x+[124]+[80]\beta.
\]
Then \(E=V_b\vartheta^{-1}M\), \(\vartheta=\mathcal O(O)\),
is an actual bundle over \(k_1\), a reduced point of the length160
common scheme, and \(h^0(C_\alpha,\mathcal V_i\otimes E)=1\)
for all five i. Its strong semistability follows from the uniform
theorem, without a separate orbit computation. Strict semistability
does not assert that a pullback splits into its line factors.

The numerical bound5280 is a sufficient bound; it is not a classification
of the smaller-degree exceptional parameters.

These assertions exclude finite-étale-trivial simultaneous rank-two
coefficients on both endpoints, but do not reduce arbitrary
common-cover monodromy to rank two. Both actual common-cover
candidates remain open. Rank-five character examples already
pass all five tests.

[Proof](../../Proofs/projective_connections/family_dormant_theta_exclusions.md).
[General determinant-cut theorem](genus_two_determinant_cuts.md).
