# Vanishing weighted moments and their translation invariants

30 September2026.
[Statement](../../Theorems/cartier_and_spin/split_source_energy_translation_invariance.md).
The argument is symbolic; no enumeration or numerical certificate is
needed. It preserves the separable source algebra rather than replacing
its roots by arbitrary critical values.

Since F'=phi*S' and tau!=0, phi is a unit in B. For any polynomial h,
\[
\operatorname{Tr}_{B/K}(h(w)/\phi(w))
=\sum_{F(\rho)=0}\operatorname{Res}_{W=\rho}
   \frac{h(W)S'(W)}{F(W)}\,dW.
\]
All roots of F are simple, and the equality follows by evaluating the
simple-pole residues. If h=1 or W, the numerator degree is at most
p-2 and the denominator degree is2p. There is no residue at infinity
and there are no other finite poles. Thus
\[
\operatorname{Tr}(1/\phi)=\operatorname{Tr}(w/\phi)=0.
\]

One more identity is needed:
\[
\operatorname{Tr}(w/\phi^2)=0.
\]
Use the rational differential W*S'/(F*phi) dW. It has zero residue
at infinity. At the sole geometric zero of phi, its polar part is
W*S'/(tau*phi) dW, since F=tau+O(phi). Over the algebraic closure
phi=(W-c)^p. The numerator W*S' has degree at most p-2, so its
coefficient of (W-c)^(p-1), and hence its residue, is zero. The
inseparability of this auxiliary denominator is retained in this
order-p pole calculation. Residue reciprocity proves the identity.

Now differentiate Tr(w/phi)=0. The derivation commutes with the
trace of a finite separable algebra, and delta(phi(w))=delta(q).
Therefore
\[
0=\operatorname{Tr}(\delta w/\phi)
 -(\delta q)\operatorname{Tr}(w/\phi^2)
=E_1.
\]
The first trace identity is E_0=0.

For w'=w+a and q'=q-a^p, phi'(w')=phi(w). Since
delta(w')=delta(w)+delta(a), binomial expansion gives the transformation
law in the statement, with no division by a trace degree or a factorial.
In particular, writing b=delta(a),
\[
E'_2=E_2,\qquad E'_3=E_3+3bE_2,\qquad
E'_4=E_4+4bE_3+6b^2E_2.
\]
Substitution cancels the b and b^2 terms in 3E_2 E_4-2E_3^2.
In characteristic five this invariant equals
3(E_2 E_4+E_3^2), proving the normalized formula.

In an integral split source chart, each delta(w) is integral and
each phi(w) is a unit, so all E_m are integral. Invariance transfers
the asserted integrality of E_2 and I across an arbitrary meromorphic
translation. The individual translated E_3,E_4 need not remain integral;
only their displayed combination is claimed to do so.

The [local residue hierarchy](../../Research/experiments/split_source_residue_hierarchy_20260930.md)
expresses these source moments by critical residues and the remaining
polar terms. The quadratic invariant explains why translating from
the integral source coordinate to the short infinity coordinate can
cancel apparent source poles in the total trace. It does not remove
the need to retain the fixed-endpoint and infinity residues in a global
trace computation. For the higher invariant I those global bounds
and its usefulness against any surviving locus remain open.

Focused review: F is used with its full degree2p and actual derivative
phi*S'; the auxiliary phi-pole is of order p; the trace algebra need
not be connected; local integrality is asserted only where the source
coordinate and phi units have the stated properties. No simultaneous
Galois closure of endpoint maps is presumed.
