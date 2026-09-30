# Completion of the repeated-pair span-two sectors

The accepted [distinct-pair result](eight_label_rank3_span_two_distinct.md)
excludes span one, every four-distinct/span-two pair, and opposite-repeat
versus opposite-repeat pairs. The remaining sectors have the first
endpoint of the form (P,P,Q,R), with three distinct noncollinear pair
polynomials, and the second of either that form or (P,Q,P,R).

Normalize the repeated pair to {0,d},0<=d<=14 by simultaneous phase
translation and choose its adjacent repeated positions by cyclic rotation.
There are exactly2,818,746 first bases. Simultaneous phase25-Frobenius
acts in free orbits of size7, leaving402,678 representatives. The two
second-endpoint lists have2,818,746 adjacent bases and1,409,373 opposite
bases; the opposite list uses Q<R to remove its remaining half-turn.
Pairs with union of phases of size at most two are omitted precisely
because they are collinear and already excluded by the span-one theorem.

For each first representative and second base, use the accepted quadratic
norm filter, retaining all four root rotations and all29 translations.
It produces at most two possible relative symmetries. Test actual mu29
membership, reconstruct the endpoint rows, and test the full stacked
rank on every survivor. No inference from norm one alone is used.

The new exhaustive run processed1,702,570,502,682 base pairs. All32,244
necessary-row survivors have rank four; there are ZERO rank-three
survivors. Every interval is complete. This proves the two remaining
sectors, and hence the statement when both phase spans are at most two.

New source:
[enumerator](../../scripts/arithmetic/rank3_repeated_pair_continuation_20260929.cpp)
and [interval runner](../../scripts/arithmetic/run_rank3_repeated_pairs_20260929.py).
It uses the accepted finite-field and row construction in the incoming
rank-three archive. The independent new domain, exact representative
counts, interval counts, and every necessary-row survivor are retained in
[the external evidence directory](../../../litt3-computation-data/seventeen_hour_continuation_20260929/rank3/).
The final `progress.json` records all402,678 representatives and every
completed interval. This was a new continuation calculation, not a replay
of the incoming certificate.
