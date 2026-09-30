# Separate squarefulness from the finite collision values

30 September2026.
[Statement](../../Theorems/cartier_and_spin/degree140_base_curve_ramification_filter.md).
The normalized local-index theorem, the base-curve linear test, and
the three-value bound are accepted inputs from Sections8.1,4.3 and5.2
of the [incoming report](../../../litt3-computation-data/september29_evening_replies/actual_ramification/REPORT.md).
They are not new exclusions and their verifiers are not replayed.
The formulation below makes its remaining local tests independent of
the candidate scale.

At a zero p of E_lambda, put m=ord_p(E_lambda). Primitivity identifies
m with the sum of the Lambda ramification indices of the normalized
points over p belonging to that fibre. If d2(p)=0, or Delta(p)!=0,
or ord_p(Delta) is odd, exactly one normalized point belongs to the
finite fibre. Its index is m. Thus squarefulness is exactly the desired
condition at all these points.

Otherwise d2 is a unit and ord_p(Delta)=2r>0. In the two completed
normalized branches the values are
\[
\Lambda_+=a+b,\quad\Lambda_-=a-b,\qquad
b=\sqrt\Delta/(2d_2),\quad\operatorname{ord}_p b=r.
\]
Their common residue is a(p). Consequently this point matters only
at the ONE value lambda=a(p). Both branch indices are at least two
exactly when r>=2 and ord_p(a-lambda)>=2. The derivation delta0 is
nowhere zero on the affine smooth curve, so the latter condition is
equivalent to delta0*a(p)=0. Hence the forbidden values are exactly
those listed in the statement. Higher cancellation, including a
split of total order four into indices1 and3, is retained: r=1 is
forbidden regardless of delta0*a.

At each selected point both a and its derivative are regular because
d2 is a unit. The construction is invariant under coefficient Galois
action, so the product B is in k0[ell]. The discriminant has pole
order at most272 at O: d1 has pole at most136, while d0*d2 has pole
at most269. Its affine zero divisor therefore has degree at most272.
Every point entering B has multiplicity at least two in that divisor;
there are at most136 such geometric points, proving the bound. Multiple
points with the same value merely repeat a root of B and do not change
the exclusion condition.

For completeness, squarefulness of E_lambda is equivalent to divisibility
by E_lambda of its squared delta0 derivative. In a local parameter z,
a zero of order one gives a derivative unit; a zero of order m>=2
gives derivative order at least m-1, also when5 divides m. These local
conditions are exactly divisibility in the affine Dedekind ring.
The incoming pole-order argument gives the uniform identity
\[
E_\lambda J=(\delta_0E_\lambda)^2,
\qquad J\in L(172O),
\]
with164 quotient coefficients and304 scalar rows. Its multiplication
pivots are fixed by pole order and have unit leading coefficients, so
elimination leaves140 consistency polynomials without an omitted pivot
boundary. Their common geometric zero set is the zero set of their gcd.

Saturation of that principal ideal by B removes precisely the forbidden
scale values. Taking its radical and removing zero then gives the exact
root-set test asserted. This is a fixed-ratio construction; global
stratification of the discriminant and computation of the parameter
locus are still required. The accepted different bound limits the
resulting nonzero root set to three. No assertion about the scheme
multiplicities of the original actual-cover locus follows.
