# Proof: theta recognition forbids a quadratic parameter deck

Version1, 3 October 2026. [Independent whole audit PASS](../../Research/audits/OCT03_NONSPLIT_TWENTY_TWO_AND_PARAMETER_DECK_AUDIT_2026_10_03.md). See the [statement](../../Theorems/cartier_and_spin/actual_disjoint_infinity_parameter_deck_rigidity.md).

Write p:B′→C0 and b_i=h_i p. Since every valuation of z is even and char(k)≠2, the connected quadratic cover p is étale. Put I_i=p*D_i. They are disjoint and reduced. The divisor identities are
\[
\operatorname{div}(t)=I_1-I_2,\qquad
\operatorname{div}(b_i^*\theta)=16I_i.
\]
An automorphism rho fixing t preserves its positive and negative divisors separately. Hence rho preserves each I_i, and rho*(b_i*theta)/(b_i*theta) is a rational function with zero divisor. On a smooth projective connected curve it is a nonzero constant.

Apply the unrestricted proportional-theta recognition theorem to the actual étale maps b_i and b_i rho. It gives unique gamma_i(rho)∈Aut(X)=C3 such that
\[
b_i\rho=\gamma_i(\rho)b_i.
\]
Uniqueness follows from dominance of b_i. These assignments are homomorphisms. If both gamma_i are identity, rho fixes the two actual X-fields and therefore fixes their compositum C0. The only automorphisms of B′ over C0 are identity and sigma. Since sigma(t)=−t≠t, rho is identity. Thus rho↦(gamma_1,gamma_2) is injective and the parameter-deck group has order dividing nine.

For the index-one strengthening, every element of Aut(X)=C3 fixes x. Thus every t-preserving rho fixes x1,x2 and z=t². The extra identity C0=k(x1,x2,z) forces rho to fix C0 even without assuming gamma_i identity. The preceding quadratic-deck argument then makes rho identity.

Finally a pair-block system in the single normal closure L/k(t) has the actual intermediate field L^{M_{\{p,p'\}}} inside B′=L^{M_p}, where {p,p′} is the pair containing its distinguished sheet p. Its index in B′ is two, since the pair stabilizer acts transitively on that pair. The resulting separable quadratic extension is Galois and supplies a nontrivial involution of B′ fixing k(t), which the theorem excludes.
