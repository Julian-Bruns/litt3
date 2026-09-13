# Recovering an endpoint from descending Cartier-generating differentials

Let k be algebraically closed of odd characteristic p. Let q:T->C and
phi:T->S be finite separable maps of smooth projective curves, g(C)>=2.
All function fields and differential spaces below use these ACTUAL maps
into k(T). Suppose a collection A of regular differentials on C has
Cartier iterates spanning H0(C,omega_C), and q^*A is contained in
phi^*H0(S,omega_S). Then q factors through phi. If q and phi are etale,
the resulting map S->C is etale too. Neither map must be Galois.

In particular, let C=C_t: y^2=x(x-1)(x-2)(x-3)(x-t), t^5-t!=0, in
characteristic five. Let L_C be any of its SIX effective spin lines.
Suppose q and phi are finite etale, M is a spin line on S, and

    phi^*M = q^*L_C

compatibly with their squares being omega_T. If the pullback of a
nonzero section of L_C descends to a section of M, then q factors
through phi. The descent condition holds in particular when
H0(S,M)->H0(T,q^*L_C) is onto.

Consequently, in spin_series_etale_reduction, if the genus-two endpoint
has effective spin, its embedded field lies in k(S_n) for every n>=8.
The ten ineffective spins and the other endpoint are NOT addressed.
This does not exclude a common cover or assert descent of the other leg.

Version1,2026-09-08. Author proof. No independent audit or Lean claim.
[Proof](../../Solutions/connections/cartier_endpoint_recovery.md).
