# Genus-two rank-four theta divisors and active connections

ID: `genus_two_rank_four_theta`. Version2.

Let C be a smooth projective genus-two curve over an algebraically
closed field of odd characteristic p. Write K=omega_C.

A stable rank-four degree-zero bundle E satisfying

    H⁰(C,E⊗A) != 0 for every A∈Pic¹(C)

is, after a degree-zero line twist, one of Pauly's normalized Raynaud
bundles R_kappa. In particular, on a finite étale cover it is the
direct sum of four equal degree-zero lines, and E is strongly semistable.
The definition of [R_kappa](../../../Definitions/theta_cartier.md) uses
the multiplication-by-two map on J(C).

There is also a general theta-multiplicity bound. Let F be rank four
with a perfect alternating pairing F⊗F→K, a proper generalized theta
divisor D_F on J(C), and F⊗tau≅F for a nonzero tau∈J(C)[2].
If h⁰(F)=1, then

    m=mult_0(D_F) is 2 or 4.

If J(C) is ordinary and p>=5, at least p+1−m of its p+1 geometric
connected cyclic-p étale covers h:T→C satisfy

    h⁰(T,h^*F)=m<p.                                      (1)

Thus at least p−3 such covers have fewer than p sections.
This is a statement about entire mu_p character schemes.

In characteristic five, every regular admissible active nilpotent
projective connection r has a proper theta divisor D_(E_r), numerically
4Theta, for its [actual tangent bundle E_r](../../projective_connections/tangent_bundle_cyclic_refinements.md).
This includes split and connected canonical doubles, with no
Jacobian-ordinarity or tangent-dimension assumption.

When the double is connected, J(C) is ordinary, and h⁰(E_r)=1,
at least two of the six cyclic-five covers satisfy h⁰(E_(h^*r))<5.
Each kills every intrinsic higher Hodge obstruction in the
one-dimensional cokernel, by
[the p-cover obstruction theorem](../../deformations/etale_p_witt_obstruction.md).
If the original obstruction is nonzero, a repaired next Hodge lift
cannot extend the original C-leg.

The last conclusions concern one source and do not supply matching
connections or simultaneous lifts on two endpoints.
[Proof and literature](../../../Proofs/jacobians/theta_divisors/genus_two_rank_four_theta.md).
