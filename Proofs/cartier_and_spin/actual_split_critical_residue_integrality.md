# A source-root residue calculation replaces critical collision cases

30 September2026.
[Statement](../../Theorems/cartier_and_spin/actual_split_critical_residue_integrality.md).
This is an algebraic argument, with no numerical certificate or
assumption on the discriminant multiplicities of the critical cover.

Write F' and F'' for W derivatives. Since phi and tau have W derivative
zero, F'=phi*S' and F''=phi*S''. Consider the formal rational differential
\[
\Omega=-\frac{f(\phi\delta F-2F\delta\phi)^2}
                  {\phi^3FF'}\,dW.
\]
At a simple critical root c its residue is
\[
-\frac{f(c)(\phi\delta F-2F\delta\phi)^2(c)}
       {\phi(c)^3F(c)F''(c)}
=\frac{f(c)(\delta\Lambda(c))^2}
       {S''(c)(\Lambda(c)-\lambda)}.
\]
Indeed Lambda-lambda=-F/phi^2 and
delta(Lambda)=-(phi*delta(F)-2F*delta(phi))/phi^3. The denominators
are nonzero generically: F has distinct roots, and the critical roots
are generically distinct. No division by a ramification index occurs.

At a source root rho in rR, differentiation of F(rho)=0 gives
delta(F)(rho)=-F'(rho)*delta(rho). Its residue is therefore
\[
\operatorname{Res}_{W=\rho}\Omega
=-\frac{f(\rho)(\delta\rho)^2}{\phi(\rho)}\in R.
\]
The derivative preserves R and phi(rho) is a unit. Thus every source
residue is integral, even when several roots have coincident reduction.

It remains to control the sum of the source and critical residues.
Weierstrass preparation writes F=U*P and F'=V*Q, where U,V are units
in R[[W]], and P,Q are monic distinguished polynomials of degrees
m and m-1. The second degree follows because m is a unit in k.
Consequently Omega=J/(PQ)*dW with J in R[[W]]. Divide J by the monic
distinguished polynomial PQ. The polynomial remainder J_0 belongs
to R[W] and has degree at most 2m-2. The discarded power-series part
has no pole at any of the roots in this formal cluster.

The sum of the residues of J_0/(PQ)*dW over all roots of PQ is its
coefficient of W^(2m-2): the denominator is monic of degree2m-1,
and the coefficient of W^-1 at infinity gives the assertion. In
particular this sum lies in R. Subtracting the integral source residues
proves the claimed integrality of the critical trace. This argument
may be performed over a finite splitting extension of Frac(R); the
resulting sum is the base-field trace, so no choice of critical root
or root ordering survives.

For the degree140 application, a finite nonzero actual critical fibre
has a unit phi and a source-root cluster of size two or three. The
actual etale map supplies distinct integral roots in the completion.
The critical quadratic is generically separable in the retained chart.
The relation S''=-2*eta converts the displayed expression, up to a
nonzero constant, to the critical trace of
f*(delta_0 Lambda)^2/(eta*(Lambda-lambda)). Its base differential is
omega_0. The residue-trace formula therefore gives zero for the local
constant term of the inverse-eta trace. Summing the local clusters
proves actual-scale vanishing.

This can replace the case distinction in the actual-vanishing part of
[the divided-trace proof](degree140_inverse_discriminant_quadratic_traces.md).
Its separate proof of global polynomiality and the pole bound remains
necessary. In particular the short coordinate of pole4 is not an
affine-regular multiplier; this local lemma does not erase its poles
at the cubic branch points. The original regular coordinate has pole17.

Focused review: the source roots, not the critical roots, are assumed
integral and split; generic simplicity is used only for the residue
formula; preparation retains all critical roots in the cluster; and
the argument works with the actual completed etale source, without
replacing either endpoint map by a separable surrogate.
