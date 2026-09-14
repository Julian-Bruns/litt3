# Etale covers adding no defect preserve nonlinear germs and compatible Witt towers

Let h:T→C be an actual connected finite etale cover of smooth projective
curves of genus at least two over an algebraically closed field k of
odd characteristic p, with degree prime to p.
Let r be a regular nilpotent projective connection on C.
Write d(C,r)=dim T_r N(C) for its fixed-curve nilpotent tangent defect.
Assume

                         d(T,h*r)=d(C,r).                 (D)

1. Pullback identifies the entire completed fixed-curve nilpotent germs:

                 N(C)^hat_r ≅ N(T)^hat_(h*r).

   Thus their local lengths and all infinitesimal nilpotent deformations
   agree, not merely their tangent dimensions. Neither active
   admissibility nor ordinariness is required.

2. Assume now k=bar(F5) and r is admissible active. At every N>=2,
   pullback identifies the marked filtration-compatible
   W_N curve lifts of the initial canonical W2 data on C and T. Here
   compatibility includes the full previous projective filtered flow,
   its graded identification and its square-trivial periodicity twist;
   the flow extends through W_(N-1). EVERY such upper lift admits a
   unique lift of the ORIGINAL map h, to a compatible lower lift.
   Consequently the same assertion holds for compatible full Witt
   towers. Smooth proper full towers and the map algebraize.

   Neither endpoint nor source is required to be indigenous-ordinary.
   The conclusion does not assert that these towers exist. It descends
   an already existing upper tower using(D).

## The Galois defect-one branch

Fix a hyperbolic X over k=bar(F5). Consider the genus-two family of
[active twists](../projective_connections/genus_two_active_twists.md) on
its established high-degree parameter range. The parameters admitting
an actual CORELESS span

                         X ←f− Z −g→ Y_t

with matched admissible active connections, g Galois, and d(Z,r_Z)=1,
form a finite set. There is no bound on the two original map degrees.
The connection on X may vary.

More precisely, if g=g(X), the number of such parameters is less than

                      60 * 5^(3g-3) * 2^80000000.       (B)

If X is defined over F_q, every such t therefore has degree over F_q
less than(B), since its full Frobenius orbit consists of such parameters.
No assumption that J(Y_t) is simple is needed.

For the prescribed Litt3 main pair, g=9 and(B)<2^80000062<K,
where K is its existing parameter-selection bound. Therefore there is
NO actual coreless matched admissible-active span whose Y_t-leg is
Galois and whose source nilpotent defect equals ONE.

The proof descends the canonical X-source tower to a genus-three
intermediate C, giving an actual characteristic-zero span
X^can←Z_f^can→C^lift. The map C→Y_t need not lift.
For the current main pair the ordinary source stratum was already
excluded, so every Galois Y_t-leg active
match must now have source defect at least TWO. Non-Galois defect-one
witnesses, higher defects, dormant matches and spans with no matching
connection are not excluded. The full common-cover problem is open.

Version5,2026-09-14: Part1 holds in every odd characteristic, using
Mochizuki's Verschiebung and trace elimination; bounded medium audit
PASS. The Witt and counting applications retain their earlier scope.
[Proof](../../Proofs/deformations/defect_preserving_etale_descent.md) ·
[Scoped audit](../../Research/audits/DEFECT_PRESERVING_ETALE_DESCENT_AUDIT_2026_09_10.md).
