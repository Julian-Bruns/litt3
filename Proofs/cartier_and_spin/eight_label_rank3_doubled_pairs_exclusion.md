# Completing the doubled-pair endpoint against every partner

An endpoint with at most two distinct phases has span at most one and
is excluded by the accepted endpoint span bound. The remaining cases
have three or four distinct doubled phases. The former require a
separate all-partner continuation: the both-span-two theorem alone does
not exclude them against span-three partners. After phase translation
the four-distinct first endpoints have the form
\[
\{0,0\},\quad\{a,a\},\quad\{b,b\},\quad\{c,c\},
\]
with a,b,c distinct and nonzero in Z/29. Simultaneous root rotation and
phase25-Frobenius give exactly702 representatives. The new continuation
retains all702, without quotienting by a symmetry of only one endpoint.

For the second endpoint, normalize only the translation/root-free shape:
its first pair is {0,d},0<=d<=14; its other three pairs range over all435
unordered pairs in Z/29, including doubled pairs. There are exactly
1,234,693,125 such bases. All29 relative translations and all four root
rotations are tested through the accepted necessary row equation and its
norm filter. Thus the first-shape normalization has not removed any
relative position.

For three distinct phases, the analogous first-endpoint orbit set has
162 representatives. Before dividing by root rotation and phase
Frobenius there are binomial(28,2)*12=4536 translation-normalized
choices; the same root/Frobenius normalization yields162. This case is
processed separately, without replaying the702 completed representatives.

The new
[native continuation](../../scripts/arithmetic/rank3_all_loop_partners_20260929.cpp)
streams the second shapes, rather than storing the entire product.
1,234,647,596 bases have full support. All702 first representatives are
compared with each of them, giving866,722,612,392 processed base pairs.
The norm filter retains44,371,352 relative candidates;16,204 satisfy the
actual root-of-unity row equation. NONE passes the full stacked-rank
test. Both endpoints have their original integer pair multiplicities
throughout; no arbitrary coefficient replacement is used.

The complete interval and all surviving row records are retained in
`all_loop_run.jsonl` in the
[external continuation directory](../../../litt3-computation-data/seventeen_hour_continuation_20260929/rank3/).
The final record reports the prescribed terminal index1,234,693,125 and
zero rank-three survivors. The computation completed in about1889 seconds
on six native CPU threads. It extends the accepted algorithm to a new
sector; the earlier programs were not replayed.

The three-distinct continuation compares its162 representatives with
the same1,234,647,596 full-support second bases. It processes exactly
200,012,910,552 base pairs, retaining4004 actual row-equation hits and
ZERO rank-three survivors. The final terminal-index receipt is in
`three_distinct_loop_run.jsonl` in the same evidence directory. This
continuation used two CPU threads, within the subsequently requested
four-core aggregate cap. Together the two cases process
1,066,735,522,944 base pairs and20,208 actual row-equation hits.

The exhaustive second-shape range makes this an all-partner exclusion.
It does not supply an all-partner exclusion for other span-three shapes.
