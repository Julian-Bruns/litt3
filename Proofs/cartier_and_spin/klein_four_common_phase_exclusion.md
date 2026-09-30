# Proof: all common-phase type multiplicities

[Statement](../../Theorems/cartier_and_spin/klein_four_common_phase_exclusion.md).
The [fourth endpoint lemma](klein_four_fourth_endpoint_trace.md) applies
to repeated labels and arbitrary free local coefficients. Use its
unaveraged U,V and the established C,E endpoint sums.

## Complete finite reduction

Normalize the zero phase to1 with t_new=a t, a in mu29. Each
endpoint type multiset is a four-tuple of nonnegative integers
summing to four; there are35. The automorphism sigma fixing K=F_(5^14)
cycles the four types simultaneously at both endpoints. Thus the
first tuple has ten representatives under cyclic rotation, while
all35 second tuples are retained.

Coefficient25^4-Frobenius fixes the canonical labels in F_(5^8)
and all F25 constants. On mu29 it generates the same group of
order seven as coefficient25-Frobenius. Thus the relative phase
has five representatives zeta^j, j=0,1,2,4,8. This reduces the
complete problem to10*35*5=1750 cases. The normalization and
Frobenius actions preserve every necessary identity; they are not
assumptions on the arithmetic of the unknown curve.

For each endpoint pair, use the established seven-by-four linear
system over K+=F_(5^7), followed by its scalar norm quadric.
The variables are the two K+ coordinates each of x=M2 and y=M6.
Retain all zero-coefficient cases and recover a nonzero epsilon only
when the original two moment vectors are proportional. The exact
complete outcome is:

| Rank and outcome | Number |
| --- | ---: |
| rank4, inconsistent linear equations | 1421 |
| rank3, inconsistent linear equations | 58 |
| rank2, inconsistent linear equations | 45 |
| rank4, nonzero scale impossible | 200 |
| rank3, nonzero scale impossible | 15 |
| rank4, scalar quadric inconsistent | 1 |
| rank3, nonsquare scalar discriminant in K+ | 2 |
| rank3, isolated moment points | 3 |
| rank1, retained affine quadric | 5 |

The five positive-dimensional moment loci are exactly the balanced
endpoint pairs. They are excluded by the separate complete
[balanced theorem](klein_four_balanced_endpoint_exclusion.md), not
by a point sample. The three isolated cases have two points each.
They are precisely the six previously retained complementary-double
moment points (with equivalent phase representatives). Substitution
of each into both actual fourth traces rejects every point.

Nothing in this classification bounds unknown free branch
coefficients or turns an isolated moment solution into a curve.
The trace identities are necessary for all permitted actual data,
so their failure suffices for the stated sector exclusion.

## Exact reconstruction and independent check

The [generator](../../scripts/arithmetic/klein_four_uniform_phase_fourth.py)
uses the previously verified elementary F_(5^7)-tower arithmetic
and linear/quadric reduction, then the
[general fourth-trace routine](../../scripts/arithmetic/klein_four_general_fourth_traces.py).
Its [complete1750-case record](../../../litt3-computation-data/degree40_reply_20260926/uniform_phase_fourth.json)
includes every orbit case and all retained points and affine loci.

The [independent verifier](../../scripts/arithmetic/verify_klein_four_uniform_phase.py)
uses Sage's polynomial quotient arithmetic in a separate implementation.
It constructs the actual moment determinant directly, obtains its
seven nonconstant coordinate equations by evaluation at the coordinate
vectors, solves the resulting affine linear system, and reconstructs
the scalar quadratic from0,+1,-1. It checks all1750 cases and the
complete retained roots, then evaluates the new traces directly.
It does not call the producer's matrix, field arithmetic or solving
routines. Both sets of phase/type representatives are generated
independently and checked for exact coverage.

The [independent receipt](../../../litt3-computation-data/degree40_reply_20260926/verify_uniform_phase_fourth.log)
passes every case, identifies exactly five balanced loci and six
other moment points, and rejects those six by the fourth traces.
Run python3 on the generator with --output and an external JSON
path; run sage -python on the verifier with that path. The earlier
six-point check alone is retained in
[its receipt data](../../../litt3-computation-data/degree40_reply_20260926/complementary_double_fourth.json).
