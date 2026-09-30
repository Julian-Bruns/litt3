# Frobenius periods and bounded scale fibres

[Statement](../../Theorems/cartier_and_spin/square_scale_frobenius_orbit_filter.md).
This deduction uses no new numerical computation. Its inputs are the
[fixed-X binary Frobenius theorem](../../Theorems/jacobians/isogeny_sieves/trigonal_constant_norm_obstruction.md),
the [constant scale bound](../../Theorems/cartier_and_spin/degree140_primitive_scale_geometry.md),
and the [root-nine bound](../../Theorems/cartier_and_spin/degree140_root9_critical_scale_budget.md).

The characteristic polynomial of Frobenius25 on J(X)[2] is irreducible
of degree18, with roots of order171. Identifying the binary vector
space with F_(2^18), Frobenius acts as multiplication by an element of
that order. Every nonzero vector therefore has orbit exactly171.
Over k0=F_(25^(4d)), its orbit is171/gcd(171,4d), which equals
171/gcd(171,d).

The ratio fibre is defined over k0 and has at most12 distinct geometric
square scales. Frobenius over k0 permutes these points, so
\[
r=[k0(\lambda):k0]\le12.
\]
Assume div(e_lambda)=2D. The divisor D is defined over k0(lambda),
because its integral coefficients are obtained by halving the invariant
divisor coefficients. Its class L=O(D) belongs to J(X)[2]. If L is
nonzero, its exact orbit t must divide r. Since r<=12 cannot have a
factor19, the denominator gcd(171,d) must contain19. If19|d and
3 does not divide d, t=9 and r<=12 forces r=9.

If L is zero, choose a rational function z over the algebraic closure
with div(z)=D. Then e_lambda/z2 has divisor zero and is a constant on
the proper connected curve; that constant is a square over bar(F5).
Thus e_lambda is a geometric rational square. This conclusion does
not require its square root to be defined over k0(lambda).

For normalized coordinates (H,q) or (u,q), adjoining w with w3=q
recovers h rationally and changes the field degree by1 or3. Because
19 is prime to3, the same necessary factor19 already occurs in the
normalized ratio field.

For the etale application, the barred degree-ten polynomial is
f=lambda*v*phi2+phi*S+t3, with v=1 or x-r, and f'=phi*D.
The fixed-degree resultant identities give
Res(f,phi)=t15 and Res(f,D)=t5*v*e_lambda. Consequently
disc(f) is (4/lambda)*t20*e_lambda. Passing to a monic polynomial or
changing its rational generator changes this square class only by a
square. The discriminant divisor of an order in an everywhere-etale
field extension is even: its normalized discriminant is a unit and
the order index enters squared. Thus e_lambda has even divisor.
A square norm alone does not give this condition.
No finite field bound is inferred for all geometric ratio points,
and neither actual map of the common-cover problem is discarded.
