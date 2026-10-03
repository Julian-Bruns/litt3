# A sparse hyperelliptic form for the genus-two degree-four tensor branch

Version1,3 October2026. Scoped necessary form used in the independently accepted [whole genus-two exclusion](../../Research/audits/Q0_FOUR_GENUS_TWO_WHOLE_AUDIT_2026_10_03.md). This record itself is not an exclusion or arithmetic execution.

Use the actual cubic-index-THREE tensor self-span and its joint x-curve B from the [coarse cube-map reduction](actual_q0_tensor_cubic_coarse_curve_reduction.md). Suppose its degree is FOUR and g(B)=2. Center the fixed quadratic as q0(X)=X²+D, D≠0. Then the common simple infinity point Q and the distinct triple infinity points R1,R2 determine a hyperelliptic function z with div(z)=2R1−2R2. The common simple point has z(Q)=a∈k×.

There are constants b,κ∈k× and a polynomial A(z) of degree at most TWO such that, on a smooth model y²=Φ(z) with Φ squarefree of degree FIVE and Φ(0)=0,
\[
X_1=\frac{A(z)}{z(z-a)}+\frac{by}{z^2(z-a)},\qquad
X_2=\frac{A(z)}{\kappa(z-a)}+\frac{\kappa by}{z-a}.
\]
Every actual smooth case, including a Weierstrass Q, satisfies a=κ⁻² and
\[
b^2\Phi(z)=a z\bigl(A(z)^2+D(1-z^3)(z-a)\bigr).
\]
If Q is Weierstrass, A(a)=0 and κ⁶≠1. If Q is not Weierstrass, A(a)≠0 and the displayed formulas have a common cancellation at its conjugate point.

Writing A=A2 z²+A1 z+A0, the actual field k(B)=k(X1,z) is given by the irreducible quartic
\[
z^3(z-a)X_1^2-2z^2A(z)X_1+A(z)^2-Da(1-z^3)=0.
\]
Its leading coefficient in z is (X1−A2)² and its constant coefficient is A0²−Da≠0. Also A2²−D≠0. Its discriminant in z is a square in k(X1), because the actual degree-four monodromy is A4. These are necessary conditions on only a,A0,A1,A2, with the fixed D; they do not certify all required branch values, the P-cube identity, or the differential identity.

The result preserves the two actual étale X-fields on the original source. It does not descend or replace an original Y-leg.

[Proof](../../Proofs/cartier_and_spin/actual_q0_tensor_degree_four_genus_two_hyperelliptic_form.md).
