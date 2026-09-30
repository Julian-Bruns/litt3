# Proof: the complete sextic endpoint sets have no common-moment match

27 September2026. Use the actual comparison hypothesis of
[the statement](../../Theorems/cartier_and_spin/pole_eighteen_complete_exclusion.md).
The established [pole18 descent theorem](pole_eighteen_cubic_descent.md)
gives the actual degree-six quotient retaining both original maps.
The [scalar restriction](sextic_comparison_scalar_restriction.md)
normalizes epsilon into E=F_(5^8). The
[intermediate-field exclusion](sextic_quartic_scalar_exclusion.md)
excludes epsilon in E4=F625. We must treat EVERY scalar in E minus E4;
no cube assumption is imposed in this last step.

## The exact finite endpoint problem

Write B=F25, beta^2=beta+3, with ascending code[a+5b]=a+b beta.
Set K0=F_(5^14), choose xi of order29, and take
\[
\alpha_0^4+[7]\alpha_0^3+[6]\alpha_0^2+[2]\alpha_0+[5]=0,
\qquad\alpha_i=\alpha_0^{25^i}.
\]
The E and K0 extensions are linearly disjoint over B. For each six-label
multiset L of(i,j), i modulo4 and j modulo29, define
\[
C_L=\sum c(\alpha_i)\xi^{5j},\quad E_L=\sum e(\alpha_i)\xi^{8j},\quad
U_L=\sum f_0(\alpha_i)\xi^{17j},\quad V_L=\sum f_1(\alpha_i)\xi^{4j},
\]
using c=(22,7,9,23), e=(1,3,8,15), f0=(20,12,13,8), f1=(21,21,20,2).
Put eta=[22], bar(z)=z^(5^7) on K0. Every actual comparison satisfies
\[
\epsilon(E_0-\eta\bar X)=C_\infty-\eta\bar Y,\qquad
\epsilon(C_0-\eta Y)=E_\infty-\eta X,
\tag{1}
\]
\[
\epsilon U_0+V_0=\eta(\epsilon X^{625}-\bar Y^5),\qquad
U_\infty+\epsilon V_\infty
=\eta(\bar X^{625}-\epsilon Y^5).
\tag{2}
\]
The SAME X,Y in K0 occur throughout. We even allow arbitrary such X,Y,
so rejecting this enlarged finite problem rejects the actual common-pole
moments. Neither ramification indices nor cardinalities are reduced
modulo five before the integer six-label multisets are formed.

## A complete one-endpoint filter

For L write S_l(k)=sum_(i,j in L)2^(li)xi^(kj). The five K0 vectors
\[
S_1(17),S_2(17),S_3(17),S_1(4),S_2(4)
\tag{3}
\]
must have B-rank at most three if epsilon U_L+V_L belongs to
K0+epsilon K0. To see this, project E to E/(B+B epsilon), of dimension
two. The three nonconstant Fourier components a1,a2,a3 of f0 form
a basis of E/B. Their products epsilon a_i span the quotient, because
epsilon B already maps to zero. Thus the coefficient map from the five
vectors in(3) onto that quotient has rank two. Its two independent
B-linear relations prove the required rank bound.

Also U_L cannot belong to K0. Otherwise all three nonconstant root
components S_l(17) vanish. Any six phases are F5-independent, so at
each phase the four integer root multiplicities agree modulo five.
Their total would have the form4a+5b with a,b nonnegative, impossible
for cardinality six. This argument uses prime-field independence;
six-phase B-independence would be false.

Expand U=sum U_j xi^j and V=sum V_j xi^j in the fixed seven-dimensional
B basis of K0. At any coordinate U_k outside B, all possible scalars
satisfying the membership condition occur among
\[
\epsilon=(b-V_k)/(U_k-a),\qquad a,b\in B.
\tag{4}
\]
The denominator never vanishes. Each proposed scalar is tested for
membership in E minus E4 and in ALL seven coordinates. Thus the625
proposals are exhaustive, not sampled. The reciprocal implementation
instead uses a nonconstant V coordinate when available and tests
epsilon inverse; it has a checked fallback if V has none.

## Exhaustive counts and the new six-phase exceptions

Encode a label as4j+i. Root rotation i->i+s is induced by an automorphism
of E K0 fixing K0 and B; it changes epsilon to epsilon^(25^s) and leaves
the phase coordinate fixed. Every endpoint/scalar orbit has a representative
whose smallest label is4h. NO phase translation is used. Enumerate
\[
(4h,b,c,d,e,f),\qquad4h\le b\le c\le d\le e\le f<116.
\]
The exact number is sum_(h=0)^28 binom(120-4h,5)=1,034,820,920.
The direct and transposed rank algorithms both give

| rank of(3) | number of normalized multisets |
| ---: | ---: |
|0|0|
|1|364|
|2|1,611,253|
|3|1,845,076|
|at least4|1,031,364,227|

The direct scalar test examines2,142,823,887 permitted proposals; the
reciprocal test examines2,142,883,857. They produce exactly the same
205,649 scalar-labelled surviving records, with no duplicates in either
file. Their byte-identical data have SHA256
2fe8a5b878ff9b81c18c0f0759e47632f16cdd1a641c20d879e82d0efaae544b.

Reducing each label multiplicity modulo five only AFTER enumeration
gives102,826 records supported at phase zero,50,400 supported at one
nonzero phase,52,416 consisting of a balanced four-root block plus
two phase-zero labels, and seven genuinely six-phase records. Those
seven records are preserved in endpoint_shape_summary.json. They are
why the quintic endpoint-shape proof cannot simply be reused for six
labels. The subsequent match uses every surviving record, regardless
of shape. Restoring all four root rotations and deduplicating gives
536,300 endpoints with their scalars.

## Solve the common moments before comparing endpoints

For a zero endpoint use its accepted scalar epsilon. For an infinity
endpoint use the inverse of its accepted one-endpoint scalar, since
the second equation of(2), divided by epsilon, has that membership form.

Choose a nonconstant coordinate epsilon_k in the basis1,alpha,alpha^2,
alpha^3 of E/B. Write
\[
W=(\epsilon C_0-E_\infty)/\eta=\sum_{i=0}^3 W_i\alpha^i.
\]
The second equation of(1) requires
\[
Y=W_k/\epsilon_k,\quad X=\epsilon_0Y-W_0,\quad
W_i=\epsilon_iY\quad(i\ne0,k).
\tag{5}
\]
Here all W_i,X,Y belong to K0. The two remaining coordinate conditions
and the other three traces give98 B coordinates, additive in the two
endpoint records. The implementation computes a fixed explicit
F5-linear projection to20 prime-field coordinates and sorts endpoints
by(scalar,projected vector). The infinity vector is negated. Any genuine
match MUST have the same projected vector. In the entire comparison
there are ZERO projected matches. Consequently there are no genuine
solutions of(1)--(2).

A second complete calculation solves instead from the FIRST equation:
\[
W'=(\epsilon E_0-C_\infty)/\eta
=\epsilon\bar X-\bar Y.
\]
It compares its nonconstant coordinates, then applies bar to recover
X,Y, and tests the second trace and both fourth traces. It uses a
different explicit rejection projection and the separately enumerated
reciprocal endpoint file. It too gives zero projected matches among
all536,300 endpoints. Thus the conclusion is not an artefact of choosing
one moment equation or one rejection projection.

The projection is not a probabilistic assertion: extra collisions would
only cause exact full-coordinate checks. Absence of a projected match
is a deterministic necessary-condition certificate.

## Executed checks and scope

[sextic_full_scalar_endpoints.cpp](../../scripts/arithmetic/sextic_full_scalar_endpoints.cpp)
contains the entire integer domain, rank filter and625-proposal test.
The two runs use different row/column eliminations and direct/reciprocal
scalar formulas, sharing established exact field arithmetic. They are
not claimed to be independent arithmetic implementations.

[sextic_two_endpoint_match.cpp](../../scripts/arithmetic/sextic_two_endpoint_match.cpp)
implements both common-moment reconstructions and explicit projections.
Its field and Frobenius operations are the finite polynomial operations
specified above. The E multiplication table was built by reduction modulo
the displayed quartic and checked against independent multiplication;
the supplied phase polynomial is
(4,22,7,20,21,7,24,1) over B. The F625-sector proof additionally checks
all its paired coordinates in an independent Sage tower.

The [separate literal trace verifier](../../scripts/arithmetic/verify_sextic_trace_reconstruction.py)
also reconstructs328 new syndromes in a Sage degree56 field tower from
the four equations themselves. It covers both choices of moment equation,
both endpoint roles, EVERY exceptional six-phase record after root
rotation, and systematic samples of the remaining records. All32,144
field coordinates agree. These are explicitly bounded implementation
checks, supplementary to the exhaustive native comparisons; they use
neither native field tables nor its precomputed Frobenius matrices.

Exact candidates, counts, command outcomes, timings and rejected-pair logs
are in [the complete sextic evidence directory](../../../litt3-computation-data/sextic_full_endpoints_20260927/).
The two endpoint files are2,056,490 bytes each; the two matched-pair files
are empty. The complete native endpoint runs took about193 and191 seconds
on this machine with assertions enabled. The initial trial had an incorrect
EXPECTED domain-count assertion (an off-by-one in a binomial expression);
that bookkeeping error was corrected, and BOTH complete enumerations
were then rerun successfully. No mathematical record relies on the
aborted trials or a truncated output file.

All hypothetical actual pole18 comparisons satisfy the previously proved
cubic descent, normalized scalar bound, and equations(1)--(2). F625 is
excluded separately, and its complement is excluded above. This proves
the statement in every possible covering degree. The extraction of a
shared line/tensor from an arbitrary unmarked common cover remains a
different, unresolved assertion.
