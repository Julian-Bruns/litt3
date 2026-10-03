# One phase-pair method for the rank-three endpoint boundaries

30 September 2026.
[Statement](../../Theorems/cartier_and_spin/eight_label_rank3_endpoint_boundary.md).
The accepted [incoming report](../../../litt3-computation-data/september29_evening_replies/rank3/REPORT.md)
proves the coordinate table, independence of at-most-nine distinct xi
powers over F5, and invertibility of T=(pi E,pi C,pi U) at full support.
Below, `evidence/...` denotes retained files beside that report. We have
\[
rank(R)=3\quad\Longleftrightarrow\quad -pi W=(pi D,pi G,-pi V)T^{-1}pi Z.
\tag{1}
\]
All rows are reconstructed from the integer pairs.

## Shared filter, including zero coordinates

Each Q_l involves at most eight phases, so vanishing at xi^n for n!=0
modulo 29 is equivalent to polynomial vanishing. Full support therefore
makes d_3,w_3,z_1,z_2 nonzero.
If a,b are the first two entries of the first row of T^{-1}, the last
row of (1), using z_3=g_3=v_3=0, forces
\[
d_3(a z_1+b z_2)+w_3=0.
\tag{2}
\]
For a fixed second shape put A=-d_3 z_1/w_3, B'=-d_3 z_2/w_3,
u=aA and v=bB'. Move its root i to i+r and translate its phases by s.
Writing q=2^r and z=xi^s, the coordinate weights give
d_3 -> q^3 z^5 d_3, w_3 -> q^3 z^17 w_3,
z_1 -> q z^4 z_1 and z_2 -> q^2 z^4 z_2. Thus (2) becomes exactly
\[
xi^{8s}=q u+q^2v.
\tag{3}
\]
Conjugation bar(x)=x^(5^7) fixes H=F_(5^7) and sends xi to xi^-1.
Put N(x)=x bar(x), Tr(x)=x+bar(x). Since q^4=1, (3) implies
\[
N(u)+q\operatorname{Tr}(u\bar v)+q^2(N(v)-1)=0.
\tag{4}
\]
If a!=0, A!=0 makes the constant coefficient nonzero, giving at most
two q in F5*. If a=0, (3) gives v on even rotations and -v on odd ones.
For v=0 none works; otherwise the odd-order group mu29 cannot contain
both v and -v. Thus at most two rotations work, including an identically
zero norm polynomial. Exponent eight permutes mu29, giving at most one
shift per rotation. This proves the two-candidate bound on every boundary.

The algorithm checks all four norm flags, then exact membership in
{xi^(8s)}, reconstructs the genuine endpoint, and tests (1). Norm one
is insufficient for mu29 membership; (2) is insufficient for rank three.
Report section 20 retains the original-field and zero-coordinate fixtures.

## Normalization is of the pair incidence

Simultaneous root rotation scales both row blocks diagonally; simultaneous
phase multiplication by 25 applies a K-automorphism fixing B. Opposite
translations h,-h give top-column factors z^8,z^5,z^17,z^-4 and common
bottom-row factor z^-13, z=xi^h. Swapping endpoints swaps blocks,
columns 0,1, and columns 2,3 with negation. All preserve rank and support.

Normalize a first endpoint only while transforming its partner accordingly.
Partner *shapes* retain all four root rotations and 29 translations through
(3). Arbitrary phase relabelling is not a rank symmetry.

## Complete phase-span partition

The invertible Fourier change identifies the span of Q_1,Q_2,Q_3 with
the span of P_i-P_0. Three distinct genuine pair polynomials are collinear
exactly when they are {2T^a,T^a+T^b,2T^b}, a!=b: a third line point is
lambda P+(1-lambda)Q, lambda=2,3,4; checking loops and overlapping or
disjoint mixed pairs leaves this triple. Other combinations violate the
coefficient set {0,1,2} or integer total multiplicity two.

Thus a repeated span-two endpoint has three distinct noncollinear pairs,
one occurring twice, in adjacent or opposite positions. Conversely these
triples have full support: their unique affine relation is supported on
the two repeated positions, whereas every Fourier character has four
nonzero weights.

For four distinct pairs, report sections 14 and 19 prove the exhaustive
five-family list. With aa={a,a}, ab={a,b}, and all named phases distinct,
the forms are (aa,ab,P,bb), (P,ab,aa,bb), (aa,ab,bb,P), with
P outside {aa,ab,bb}; the chains (aa,ab,bc,cc), (ab,cc,aa,bc); and
the genuine repartitions P_0+P_1=P_2+P_3. Include all root cycles.
Counts: 1,403,136 per midpoint-type family, 175,392 chains, 1,315,440
repartitions, totaling 5,700,240. The 326,974,536 adjacent and 163,487,268
opposite repeats give 496,162,044 full-support span-two endpoints.
Incoming proofs and orbit certificates retain the classification;
equality patterns alone are not rank representatives.

The same method closes this partition in three retained pieces:

* Section 13 excludes any span-one endpoint against any full-support
  partner: three genuine first families force a pair-difference evaluation
  from (2), looked up among actual pair differences. First-pair forms
  {0,0},{0,1},{0,2} and all 435 choices for each other partner pair cover
  246,938,625 configurations. Complete coverage and independent survivor
  certificates: `evidence/line_scans/summary.json` and
  `evidence/line_partner_verification.json`.
* Sections 14,21,22 exclude opposite/opposite and every four-distinct/span-two
  pair. The linked certificate and fourteen later jobs cover every required
  family pair; the later 93 intervals retain 430 genuine row survivors,
  all with independent nonzero four-by-four minors. Certificates:
  `evidence/linked_verification.json` and
  [the fourteen-job verification](../../../litt3-computation-data/september29_evening_replies/rank3/evidence/fifth_verification.json).
* The local repeated-pair continuation completes adjacent/adjacent and
  adjacent/opposite, as follows.

Normalize an adjacent repeat to (P,P,Q,R), P={0,d}, 0<=d<=14,
with P,Q,R distinct and at least three phases in their union (excluding
precisely the collinear triples). The 2,818,746 first bases have free
seven-element phase-25 Frobenius orbits after translation renormalization,
giving 402,678 representatives; transform the partner accordingly.
Partners have 2,818,746 adjacent bases and 1,409,373 opposite bases
(P,Q,P,R), with Q<R removing half-turn duplication. Equation (3) retains
every relative root rotation and translation. Swapping handles the reverse
adjacent/opposite order.

The [enumerator](../../scripts/arithmetic/rank3_repeated_pair_continuation_20260929.cpp)
and [interval runner](../../scripts/arithmetic/run_rank3_repeated_pairs_20260929.py)
processed 1,702,570,502,682 base pairs; all 32,244 row survivors have
rank four. The
[terminal progress record](../../../litt3-computation-data/seventeen_hour_continuation_20260929/rank3/progress.json)
has all 402,678 representatives in 51 completed intervals, with actual
survivors in the compressed chunks. These pieces prove clauses 1 and 2.

## All-partner endpoint slices

Four doubled pairs with at most two phases have span at most one.
Otherwise normalize the first endpoint to (00,aa,bb,cc) by simultaneous
root rotation, phase-25 Frobenius and opposite translation. Three and
four distinct phases give 162 and 702 representatives: the pre-quotient
counts are binomial(28,2)*12=4,536 and 28*27*26=19,656, divided by 28.

Retain every partner base with first pair {0,d}, 0<=d<=14, and all
435 choices for each other pair: 1,234,693,125 bases, with 1,234,647,596
of full support. The orientation chooses the nonzero difference in
{1,...,14}; d=0 retains loops. Equation (3) retains all relative rotations
and translations, without a partner phase-span restriction.

The [streamed all-partner source](../../scripts/arithmetic/rank3_all_loop_partners_20260929.cpp)
retains actual row-equation hits and tests (1) exactly. Its complete runs are:

| Distinct first phases | First representatives | Processed base pairs | Actual row hits | Rank-three hits |
|---|---:|---:|---:|---:|
| Four | 702 | 866,722,612,392 | 16,204 | 0 |
| Three | 162 | 200,012,910,552 | 4,004 | 0 |

Terminal receipts `all_loop_run.jsonl` and `three_distinct_loop_run.jsonl`
in the [continuation directory](../../../litt3-computation-data/seventeen_hour_continuation_20260929/rank3/)
each reach index 1,234,693,125, retaining six-thread and two-thread
metadata. This proves clause 3 also against span-three partners.

Clause 4 retains report sections 10--11: (u_3/c_3)^29 in B means
u_3/c_3 in B*mu29, uniquely translated to B*. Its genuine four-sum
classification gives nine root/Frobenius representatives, each checked
against all 435^4 partners. All 52 full-support row survivors have
[independent rank-four minors](../../../litt3-computation-data/september29_evening_replies/rank3/evidence/ratio_partner_verification.json).
This separate slice does not assume every kernel is B-rational.

## Provenance, verification and limit

Absorbed: `eight_label_rank3_span_two_distinct` v1,
`eight_label_rank3_span_two_complete` v1,
`eight_label_rank3_doubled_pairs_exclusion` v2. Their accepted Pro inputs,
essential sources and certificates are preserved. This edit reviews partition,
normalization and terminal metadata without replay. Incoming independent
checks cover survivors and coverage, not every large-domain rejection.
Local continuations have exact source and complete receipts, without a
new independent full-domain audit.

The [quartic skew-kernel theorem](../../Theorems/cartier_and_spin/quartic_scalar_graph_skew_recovery.md)
tests a scalar graph after rank drops. It does not replace genuine pairs,
actual constants or SAME moments. The 2/3 and 3/3 sectors remain open.
