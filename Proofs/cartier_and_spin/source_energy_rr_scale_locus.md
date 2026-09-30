# Multiplication and a univariate cokernel

30 September2026.
[Statement](../../Theorems/cartier_and_spin/source_energy_rr_scale_locus.md).
The coefficient set is finite, so a space W as in the statement
exists. For example choose an effective divisor containing the
poles of all listed differentials and use its Riemann--Roch space.
This choice is made after fixing the source coefficients; a
relative family requires retaining its coefficient denominators
or making a covering by integral coefficient charts.

For each scalar lambda with Delta(lambda)!=0 in K, multiplication
by Delta(lambda) is injective on the K-space of rational quadratic
differentials and hence on U. The first r columns are therefore
k-independent. Membership of P in their span is exactly vanishing
of the augmented maximal minors. In each determinant one column
has degree at most d+1 and r columns have degree at most d, giving
the claimed degree bound. On a line over k a proper ideal is
principal; its generator divides every nonzero minor. Localizing
at allowed scales cannot increase its degree or scheme length.

Let A be the matrix of the first r columns. Over k[lambda], which
is a principal ideal domain, choose unimodular row and column
operations taking A to its Smith diagonal block with zeros below.
Apply the row operations also to P. At any scalar where the r
diagonal entries are units, its last dim(W)-r coordinates vanish
exactly when P is in the span of A. The first r entries impose no
further condition at that scalar; they solve uniquely for the
coefficients in U. Inverting all diagonal entries therefore makes
the tail entries generate the same determinantal membership ideal.

Finally, rank A drops at a scalar if and only if Delta at that
scalar is identically zero as a rational function: injectivity
proved one direction, while zero multiplication proves the other.
Thus this localization removes only a proved impossible parameter
for a separable source when Delta is its critical resultant. It
does not invert the discriminant of the critical polynomial, and
it retains repeated critical roots.

The source-energy numerator theorem supplies P=Delta*Q with the
stated degree after any scale-independent correction. The global
degree-ten theorem supplies U of dimension28. Substitution gives
2*28+3=59. Constructing a nonzero minor, eliminating geometric
coefficient parameters and deciding actual etaleness are separate
tasks not completed by this linear algebra statement.
