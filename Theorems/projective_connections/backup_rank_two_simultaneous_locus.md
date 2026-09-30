# A nonempty simultaneous rank-two obstruction locus

Version4, 19 September 2026. The actual triquadratic reply and the
geometric globalization passed bounded independent review. Global
finiteness and first-boundary containment use the retained exact
Sage/Singular calculation; see the proof for its verification scope.

Use the backup curve \(C=Y^{(1)}\) and the five actual bundles
\(\mathcal V_i\) in the
[theta theorem](backup_dormant_theta_divisors.md). On the projective
moduli space \(\mathcal U=U_C(2,0)\) of semistable rank-two
degree-zero bundles, let \(\mathcal D_i\) be the actual determinant
divisor for \(H^0(C,\mathcal V_i\otimes E)\), and set
\[
\mathcal Z=\bigcap_{i=0}^4\mathcal D_i.
\]
Then:

1. \(\mathcal Z\) is nonempty. Thus simultaneous vanishing on all
   fifteen double-cover pushforward families does NOT extend to all
   semistable rank-two coefficient bundles.
2. Every point of \(\mathcal Z\) is stable, has determinant
   outside \(J(C)[2]\cup[2]\Theta\), and satisfies \(E\otimes\kappa\not\simeq E\) for
   every nontrivial \(\kappa\in J(C)[2]\).
   Here \(\Theta=\{\mathcal O_C(p-O):p\in C\}\). Thus the unique
   effective divisor of \(\omega_C\det E\) is reduced p+q,
   with p,q not both Weierstrass points.
3. \(\mathcal Z\) is finite of scheme length exactly160.
   Reducedness of the entire scheme is not asserted.
4. EVERY point E of \(\mathcal Z\) has strictly semistable first
   Frobenius pullback. Consequently no E in \(\mathcal Z\) is
   trivializable by a finite étale cover.

Writing \(\vartheta=\mathcal O_C(O)\), the first-Frobenius-unstable
rank-two degree-zero locus is exactly the union of the five families
\[
\{\mathcal V_j\otimes\vartheta^{-1}\otimes M:M\in J(C)\},
\qquad 0\le j\le4,
\tag{1}
\]
for the specified relative Frobenius \(\Phi:Y\to C\).
In fact, \(\mathcal Z\) is DISJOINT from (1). Thus every point of
\(\mathcal Z\) has semistable first pullback.

There is an explicit point over \(k_1=\mathbf F_{125}[\beta]/(\beta^2-2)\).
Use the base field codes of the theta theorem and put
\[
b=([21]+[55]\beta:[97]+[28]\beta:[39]+[70]\beta:1).
\]
Let \(V_b\) be the corresponding stable canonical-determinant
bundle, and define \(M=\mathcal O_C(D-2O)\) by the Mumford data
\[
\begin{aligned}
U&=x^2+([105]+[61]\beta)x+[71]+[116]\beta,\\
V&=([85]+[38]\beta)x+[124]+[80]\beta.
\end{aligned}
\]
Then \(E=V_b\vartheta^{-1}\otimes M\) is defined over \(k_1\),
and
\[
h^0(C,\mathcal V_i\otimes E)=1\quad(0\le i\le4).
\]
This E is strongly semistable at EVERY Frobenius height. Nevertheless,
its first pullback is strictly semistable. Consequently E is NOT
trivialized by any finite étale cover. Strict semistability here
does not assert that the actual pullback splits into its line factors.

The explicit point is reduced in \(\mathcal Z\). The global
finite-monodromy exclusion above concerns rank two only. In rank
five, a direct sum of actual tame torsion lines passes all five
tests, by the [cyclic refinement theorem](../jacobians/ordinary_covers/prime_avoiding_section_growth.md).
No actual common-cover witness or unrestricted exclusion follows.

[Proof](../../Proofs/projective_connections/backup_rank_two_simultaneous_locus.md).
