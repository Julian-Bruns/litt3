# Cartier and geometric-kernel methods for supported functions

[Statement](../../Theorems/cartier_and_spin/supported_norm_geometric_methods.md).
Use the fixed curve and marking in the
[exact relation-lattice statement](../../Theorems/cartier_and_spin/marked_divisor_relation_lattice.md).
These arguments preserve the reusable content of the former low-pole
proofs. Their fixed-pole searches are unnecessary for the present
marking: the exact lattice gives the stronger sharp result.

## Cartier and cubic characters

The [uniform infinity criterion](uniform_admissible_norm.md) says that
a Cartier-fixed differential in omega_X(R_X) with no constant dt term,
t=x^3/y, belongs to k(x)dx. This scalar criterion does not assume a cover.
For a supported g of pole order less than40, write g=a+by+cy^2.
Its polynomial degrees satisfy deg b<=9, deg c<=6. At a root r of P,
a(r)=g(r,0) is nonzero, so gcd(a,P)=1. Character comparison in
dg=g*dlog(g), when dlog(g) belongs to k(x)dx, gives
\[
3P(ab'-ba')+P'ab=0,\qquad 3P(ac'-ca')+2P'ac=0.
\]
Since P is squarefree, P divides b and c. Their degree bounds force
b=c=0. Logarithmic differentials are Cartier-fixed and have poles
only in R_X, so the constant-term hypothesis suffices.

At poles3,6,9,12,15,18, the monomial basis has a unique leading
x-power and no term of pole order one smaller. Cubic invariance of
that x-power's expansion gives g=t^-d(u_0+O(t^2)), u_0!=0.
Thus dlog(g)=-d dt/t+O(t)dt, proving polynomial invariance without
support enumeration, including5|d. The
[original focused audit](../../Research/audits/CUBIC_RETURNS_BOUNDARY_2026_09_24.md)
records this independent argument; its old pole10/12 search component
is superseded by the exact lattice.

## Content removal and complete geometric kernels

Write g=U+Vy+Wy^2. If all three points above alpha are zeros, the
invertible cubic Fourier matrix forces U(alpha)=V(alpha)=W(alpha)=0.
Dividing by x-alpha removes one zero on each sheet and lowers the pole
by three. A root of common polynomial content away from A would give
a forbidden zero. Repetition leaves a primitive function occupying
at most two sheets of each marked fibre.

Let V be a geometric section subspace of L(nO), of dimension k,
and seek supported functions of exact pole n. Enumerate effective
degree-(k-1) marked subdivisors and compute their complete jet kernels;
every degree-n zero divisor contains one if n>=k-1. Monomial pole
orders3i+10j are distinct, so a zero top coefficient rejects exact pole n.
A line is checked by computing its actual pole and all marked orders.

For a larger kernel, its common marked base divisor has degree less
than n: otherwise two independent sections would trivialize the same
degree-zero line bundle. A supported section must therefore increase
one of its marked orders. Branch over the twelve next-jet hyperplanes;
each strictly decreases dimension. This finite recursion exhausts the
remaining possibilities, including repeated zeros. Orbit representatives
under marking-preserving automorphisms are allowed, but all multiplicity
distributions outside those orbits must be retained.

All matrices over a field containing the marked points compute the
full geometric kernel by scalar extension. Column scaling to a smaller
field is valid only after proving the scaling factors and checking the
marked jets. This is linear algebra on geometric section spaces, not
enumeration of finite-field-valued functions.

The [original Hermite audit](../../Research/audits/DOUBLE_ROOT_AND_HERMITE_2026_09_27.md)
records two independent implementations at20..28; the
[actual-pole57 audit](../../Research/audits/ACTUAL_NORMS_FIFTY_SEVEN_2026_09_29.md)
records the later phase-packet tests. Their searches are replaced by
the exact marked and actual congruence lattices. No numerical replay is
needed to use this geometric argument, and no old threshold certificate
is an input to it.

Integer phase equality through57 now follows from actual norm invariance
and the per-root mass<=19 corollary of the
[unbounded modular phase theorem](unbounded_modular_phase_balance.md).
The retained [phase-cost method](actual_comparison_norm_phase_cost.md)
uses these same geometric kernels on smaller horizontal spaces.
