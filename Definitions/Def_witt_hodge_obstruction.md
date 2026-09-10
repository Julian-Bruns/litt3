# The one-endpoint higher Hodge obstruction

Work over k=bar(F5). Let (C,r) be a smooth projective curve with a
regular admissible ACTIVE nilpotent projective connection. Use the
canonical first marked W2 curve lift from the normalized FL dictionary,
with inverse Witt-Frobenius transport as in
[marked deformations](Def_marked_curve_deformations.md).

Choose a theta realization. Retain the actual previous filtered flat
object, graded identification, and its square-trivial periodicity twist.
For a marked curve lift C3 of that C2, higher inverse Cartier gives a
bundle H2 on C2 reducing to H1. The obstruction to lifting the ORIGINAL
Hodge line N1 is

    rho(C3) in V_C=H1(C,Hom(N1,H1/N1))=H1(C,T_C).

The second fundamental isomorphism specifies the last identification.
If Psi_C is the Frobenius-semilinear Hodge-projection map, then

    rho(C3+xi)=rho(C3)-Psi_C(xi),
    epsilon(C,r)=[rho(C3)] in coker(Psi_C).

Thus epsilon is independent of C3. It vanishes exactly when SOME C3
permits the specified Hodge lift. This is stronger than lifting the
curve, but weaker than lifting an actual two-leg diagram. All kernels,
cokernels and dual pairings retain the relative Frobenius twists;
linearization over the perfect field may be used to compute their ranks.

This definition at later levels requires an already existing compatible
previous flow. A mod-five connection alone does not define an arbitrary
all-level sequence of obstruction classes. See
[the higher construction](../Solutions/Sol_forced_canonical_witt_endpoint.md).
