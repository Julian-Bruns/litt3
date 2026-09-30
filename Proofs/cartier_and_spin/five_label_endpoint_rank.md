# Proof: complete five-label rank computation

[Statement](../../Theorems/cartier_and_spin/five_label_endpoint_rank.md).
The four alpha-coordinate rows of c(alpha^(25^i)) are
\[
(22,7,9,23),\ (15,11,10,2),\ (21,17,6,23),\ (2,20,5,12),
\]
and those of e(alpha^(25^i)) are
\[
(1,3,8,15),\ (0,23,3,0),\ (16,24,14,5),\ (5,10,10,5).
\]
Since 1,alpha,alpha^2,alpha^3 is a K0-basis, rank at most2 is
equivalent to vanishing of all three2-by-2 minors of the nonconstant
coordinates of C_L and E_L. Rank1 includes the pure fivefold sum,
which vanishes in characteristic five.

Index(i,j) by4j+i. Simultaneously translating every j by s multiplies
the two columns by zeta^(5s) and zeta^(8s), preserving their rank.
Every phase orbit has a representative with phase0, and therefore with
smallest sorted index below4. Enumerating all sorted five-tuples with
that property covers every multiset, without assuming the action free:
\[
\binom{120}{5}-\binom{116}{5}=30,188,536.
\]
The [exact C++ source](../../scripts/arithmetic/quintic_endpoint_rank.cpp)
checks the three minors for every tuple. Exactly four are deficient,
namely five copies of(0,0),(1,0),(2,0),(3,0). Every other tuple has
rank3. Common phase translation recovers all116 pure multisets.

The arithmetic uses the previously verified K0 presentation from the
[quartic coefficient proof](quartic_endpoint_moment_exclusion.md):
F5[t]/(4,4,2,3,3,2,2,1), extended by beta^2=beta+3. Its lookup tables
are built by exact polynomial multiplication; the complete multiplicative
cycle is checked. Before enumeration all232 full C/E label values are
also reconstructed in the independent theta basis
alpha=[7]+[21]theta^2+4theta^3, theta^4=[20], and compared with the
established quartic label table. Thus type, phase and coordinate
transcription are checked before using the nonconstant alpha rows.

The complete enumeration was run locally, including these cross-checks
and the asserted final counts. Its compact output is
[quintic_endpoint_rank.txt](../../../litt3-computation-data/two_sheet_quintic_replies_20260927/quintic_endpoint_rank.txt).
Regenerate by compiling the source as C++17 with assertions enabled and
passing the desired output filename as its only argument. No discarded
tuple data is needed: the loops and exact arithmetic reproduce every
rank check. No floating-point calculation or bounded point sample is
used in the exclusion.
