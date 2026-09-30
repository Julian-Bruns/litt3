# A twisted square removes the cubic endpoint poles uniformly

30 September2026, version2. In characteristic five let
\[
F=(W^5+q)H+\tau,\qquad \tau\ne0,
\]
be separable of arbitrary degree N>=5. In its source algebra put
phi=w^5+q, and let gamma be the W^3 coefficient of H mod(W^5+q).
Then the quadratic differential
\[
\mathcal Q^\sharp=
\operatorname{Tr}\frac{dw^2}{\phi}
+dq\,d(\gamma/\tau)
\]
has the exact source expression
\[
\mathcal Q^\sharp
=\operatorname{Tr}\frac{(dw+3w\,dq/\phi)^2}{\phi}
=\operatorname{Tr}\frac{d(w\phi^3)^2}{\phi^7}.
\]
Suppose locally all source roots belong to k[[r]] and q has order
exactly three. Then Qsharp has at most a simple pole. No condition
on the order of tau, on the number of small roots, on a critical
discriminant or on the degree of H is needed.

If the W^4 coefficient of H mod phi is zero, Qsharp is invariant
under every meromorphic source translation w'=w+b, q'=q-b^5.
It is also independent of multiplying the defining polynomial F by
a nonzero base function. No affine scaling covariance is asserted.

More generally, in odd characteristic p, let F=(W^p+q)H+tau be
separable, put phi=w^p+q, and let gamma be the W^(p-2) coefficient
of H mod phi. Then
\[
\operatorname{Tr}\frac{dw^2}{\phi}-4dq\,d(\gamma/\tau)
=\operatorname{Tr}\frac{(dw-2w\,dq/\phi)^2}{\phi}
=\operatorname{Tr}\frac{d(w\phi^{p-2})^2}{\phi^{2p-3}}.
\]
If the source roots are integral and q has exact order (p+1)/2,
this differential has pole order at most (p-3)/2. Translation
invariance holds when the W^(p-1) remainder coefficient vanishes.
The global section statement below remains specific to the fixed
characteristic-five degree-ten families.

For every actual remaining constant or linear trace-zero degree-ten
profile, in the notation of
[the global energy theorem](degree_ten_global_corrected_source_energy.md),
\[
t\mathcal Q^\sharp\in H^0(X,\omega_X^2(4O)).
\]
Its scalar coefficient relative to (dx/(3y^2))^2 thus belongs to
the same twenty-eight-dimensional L_X(36O). This gives a shorter
proof and an alternative formula for a uniform necessary condition,
not a new exclusion or a sufficiency assertion.

[Proof](../../Proofs/cartier_and_spin/source_twisted_square_energy.md).
