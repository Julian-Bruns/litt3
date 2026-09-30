# Proof: exact models and a specialization invariant

[Combined atlas theorem](../../Theorems/curve_arithmetic/backup_characteristic_zero_atlases.md).
Use the [exact model theorem](triangle245_model_space.md), including
its converse and its independent count of $236$ geometric models.
Its notation $B,C,F,s$ is retained; the source curve is $y^2=xF$.

## Completeness in characteristic zero

On $C_3\ne0$, scale the coordinate so that $C_3=1$. The exact
characteristic-zero parametrization has square-free polynomial of
degree $56$, with irreducible rational factors of degrees
\[
2,3,3,6,42.
\]
For each factor the [number-field verifier](../../scripts/orbifolds/verify_triangle245_parametrization.py)
checks every original differentiated equation, the complete square
identity, and the nonvanishing open condition. The parametrizing
coordinate $C(0)$ separates the points. Four scalings of each model
give $C(0)=1$, and these scalings are distinct because $C_3\ne0$.

On $C_3=0,C(0)=1$, the same exact checks give twelve models in
factors of degrees $2,4,6$. They are disjoint from the first chart.
Thus the verified models account for
\[
4\cdot56+12=236
\]
distinct normalized geometric points, exhausting the independently
proved count. Completeness does not rely on a modular solver, an
asserted characteristic-zero degree of an input ideal, or reducedness
of that ideal. A second rational reconstruction also passes all
original equations after recovering its omitted saturation inverse.

The external verification summaries are
[open chart](../../../litt3-computation-data/triangle245_models_20260921/rational_c0_long/verification_summary.json)
and [boundary](../../../litt3-computation-data/triangle245_models_20260921/rational_c3_zero/verification_summary.json).
The source equations and coefficient conventions are in the verifier
and [equation generator](../../scripts/orbifolds/triangle245_square_factor_models.py).

## An invariant valid at every potentially good place

Use Sage's Igusa--Clebsch normalization. The formulas for $I_4,I_{10}$
have coefficients integral at five, and $I_{10}$ is a power-of-two
multiple of the discriminant. Consequently
\[
j_*:=I_4^5/I_{10}^2
\]
is invariant under scaling and change of hyperelliptic coordinates,
and is integral at a smooth reduction in residue characteristic five.
Its reduction is the same invariant of that smooth curve.
This assertion concerns the curve's good model; the reconstructed
equation need not itself have good reduction.

The [backup calculation](../../scripts/orbifolds/backup_reduction_invariant.py)
gives
\[
j_*(Y)=2\alpha^2+3\alpha+4,\qquad
m_Y(J)=J^3+2J^2+2J+2.
\]
The polynomial $m_Y$ is irreducible. In contrast, the usual
$I_2$-based invariants all vanish here and would not give this test.

For each exact number-field model, compute the minimal polynomial
of $j_*$ and clear denominators and content to get a primitive
polynomial $P\in\mathbf Z[J]$. If any conjugate source had good
reduction $Y$ after extension at five, the integral value of its
$j_*$ would reduce to a root of both $\bar P$ and $m_Y$.
It suffices, therefore, to show their coprimality.

The [exact invariant computation](../../scripts/orbifolds/triangle245_invariant_reduction.py)
gives the following reductions, up to nonzero scalar:

| Chart | Model field degree | Invariant degree | Reduction of $P$ |
|---|---:|---:|---|
|$C_3=1$|2|2|$J^2$|
|$C_3=1$|3|3|$(J+4)^3$|
|$C_3=1$|3|3|$J^3$|
|$C_3=1$|6|6|$(J^2+2J+4)^3$|
|$C_3=1$|42|21|$(J^3+2J+1)(J^3+J^2+3J+4)^2(J^4+J^2+3J+3)^3$|
|$C_3=0$|2|1|$J$|
|$C_3=0$|4|1|$J$|
|$C_3=0$|6|3|$(J+2)^3$|

Each row is coprime to $m_Y$. The full primitive polynomials and
executed gcd checks are saved for the
[open chart](../../../litt3-computation-data/triangle245_models_20260921/rational_c0_long/invariant_reduction.json)
and [boundary](../../../litt3-computation-data/triangle245_models_20260921/rational_c3_zero/invariant_reduction.json).
Thus every source represented by this complete model locus is excluded.

An [independent residue-field check](../../scripts/orbifolds/check_triangle245_reduction.py)
also reduces the reconstructed quartic coefficients directly at five,
without recomputing any invariant minimal polynomial. They are all
integral in the displayed power basis, and their discriminants are
units in every factor of the reduced defining polynomial. The degree42
factor has residual factors of degrees $3,6,8$, of multiplicities
$2,2,3$; direct substitution of each resulting invariant into $m_Y$
is nonzero. The same test passes for all other open families. These
checks cover every place over five, even if the power basis is not an
integral basis: each residue of its integral generator is a root of
the reduced defining polynomial. The
[executed records](../../../litt3-computation-data/triangle245_models_20260921/rational_c0_long/independent_mod5_check.json)
therefore confirm the exclusion independently of the characteristic-zero
minimal-polynomial computation.

One boundary family has ordinary good reduction at five. This proof
does not replace the invariant calculation by a claim that every
triangle245 reduction is supersingular. Nor does a matching value
of a single invariant imply isomorphism: only the necessary direction
is used.
