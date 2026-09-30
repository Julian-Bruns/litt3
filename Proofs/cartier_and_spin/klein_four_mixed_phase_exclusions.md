# Proof: mixed-phase endpoint sectors

[Statement](../../Theorems/cartier_and_spin/klein_four_mixed_phase_exclusions.md).
The proof uses complete finite endpoint orbits and the established
linear/quadric moment reduction. It searches no unknown curve or
branch coefficients. Every resulting geometric scale and moment
point is recovered before applying the necessary fourth traces.

## One phase against two

Normalize the common zero-endpoint phase to1. A balanced first
endpoint is already excluded. The remaining35 type-count tuples
have nine cyclic-rotation representatives after removing the
balanced tuple. At infinity choose two distinct phases. There are
406 unordered phase pairs, partitioned into58 orbits by coefficient
25^4-Frobenius, which fixes root types. For each representative,
distribute four labels between the two nonempty phase groups.
The number of type-count distributions is
4*20+10*10+20*4=260. If Frobenius exchanges the phases, exchanging
the two count groups is available in this same complete list.

Thus9*58*260=135720 cases suffice. The exact old moment tests give
135488 inconsistent linear systems,116 nonsquare scalar quadratics
and116 isolated cases with two nonzero-scale points each. There
are no retained positive-dimensional loci. All232 points fail the
fourth traces. Each of these exceptional endpoint pairs is invariant
under square root-type rotation, so its nonlinear exclusion is also
covered by the independent complete calculation in the next section.

The [complete generator](../../scripts/arithmetic/klein_four_one_vs_two_phase.py)
uses the already verified elementary field and seven-by-four
linear/quadric routines. Its
[compact exact receipt](../../../litt3-computation-data/degree40_reply_20260926/one_vs_two_phase.json)
retains all232 points, aggregate counts, phase representatives and
a deterministic case digest. Every linear rejection is reproducible
from source; bulky row-operation outputs are not stored. This
135720-case linear stage was not replayed by a second full engine.
Its arithmetic routine and determinant formula were independently
checked on the preceding complete1750-case theorem. The new
case-orbit coverage is the explicit count above. The independent
nonlinear check below covers all232 exceptions, not a sample.

The [common-phase theorem](klein_four_common_phase_exclusion.md)
handles a common phase at both ends. Endpoint interchange covers
the opposite orientation, proving assertion1.

## All opposite-pair multisets

An invariant endpoint consists of two pairs
\[
\{(i,\xi),(i+2,\xi)\},\quad i=0\text{ or }1.
\]
There are58 possible pairs and1711 multisets of two of them. When
the zero endpoint has different phases, normalize one pair to type0,
phase1 by root rotation and the allowed parameter rescaling.
The other pair has either parity and relative phase zeta^j, with
j=1,2,4,8 representing all nonzero Frobenius orbits. Keep every
one of the1711 infinity multisets. This gives8*1711=13688 cases.
The elementary [producer](../../scripts/arithmetic/klein_four_opposite_pair_fourth.py)
finds13284 nonzero-scale moment points, no positive-dimensional
moment loci and no fourth-trace survivor. Its
[complete summary](../../../litt3-computation-data/degree40_reply_20260926/opposite_pair_fourth.json)
retains the counts separately for all eight families and a case digest.

Here an independent calculation can be substantially smaller than
the general eight-coordinate implementation. Put
\[
J=\pi_4(c),\qquad J^2=3\beta.
\]
All opposite-pair sums belong to K+[beta,J], with
beta^2=beta+3. This has degree four over K+, since both quadratic
steps are genuine. In the next two rows subscripts1,4 denote sigma
eigenprojections, not root-type indices. Direct canonical arithmetic gives
\[
(c_1,e_1,f_1,g_1)=([20],[8],[12],4),
\]
\[
(c_4,e_4,f_4,g_4)=(J,[12]J,[17]J,[7]J).
\]
For a pair of parity i and phase xi, its four sums are therefore
\[
2([20]+(-1)^iJ)\xi^5,\quad
2([8]+(-1)^i[12]J)\xi^8,
\]
\[
2([12]+(-1)^i[17]J)\xi^{17},\quad
2(4+(-1)^i[7]J)\xi^4.
\]
The [independent verifier](../../scripts/arithmetic/verify_klein_four_opposite_pair_fourth.py)
uses this four-coordinate presentation and native Sage K+ arithmetic.
It constructs the actual moment determinant by evaluation, giving
three affine linear coordinate equations and a scalar quadratic.
It solves the latter by its discriminant, retains all zero-vector
and repeated-root cases, reconstructs epsilon, and directly checks
both fourth identities. It shares neither field arithmetic nor
matrix construction with the elementary producer.

It checks all13688 mixed-first-endpoint cases and independently
recovers exactly13284 valid old moment points. Every one fails
the new traces. It additionally checks1711 cases with the first
endpoint equal to two copies of the type0 opposite pair, phase1.
These give1666 old moment points, all rejected. The only other
common-phase invariant first endpoint is balanced, already excluded.
Thus all invariant endpoint configurations are covered, proving
assertion2. There is no implication here that an arbitrary scalar
in F_(5^28) forces invariant endpoint multisets.

The [full independent receipt](../../../litt3-computation-data/degree40_reply_20260926/verify_opposite_pair_fourth.json)
and [executed output](../../../litt3-computation-data/degree40_reply_20260926/verify_opposite_pair_fourth.log)
record all15399 cases and14950 nonzero-scale points, with no
survivor or omitted affine family. The small
[canonical projection verifier](../../scripts/arithmetic/verify_klein_four_fourth_eigen.py)
independently reconstructs the displayed coefficient identities.
Run the linked producers with python3 and --output FILE. Run the
independent verifier with sage -python, the opposite-pair producer
JSON path, and --output FILE. Run the projection verifier with
sage -python. All data paths may be outside the repository.
