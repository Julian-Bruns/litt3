# Proof: a faithful ten-subset resolvent exceeds the actual genus ratio

Version1, 3 October 2026. [Independent whole audit PASS](../../Research/audits/OCT03_PRIMITIVE_RANGE_AND_THREE_TEN_BLOCKS_AUDIT_2026_10_03.md). See the [statement](../../Theorems/cartier_and_spin/canonical_ten_primitive_even_bridge_twenty_two_through_thirty_eight_exclusion.md).

Let L/F be the single normal closure of E/F, with transitive group M on n sheets. The actual compositum K=AE gives H=Gal(LA/A), whose orbit Δ corresponding to K/A has size ten and induced action S10. Therefore10! divides |H| and |M|.

The complete primitive-group lists in the stated degrees have only A_n and S_n with order divisible by10!. This is a Sims classification input, not a conclusion based solely on the existence of catalog entries. Its completeness through degree fifty is stated in the official [PrimGrp manual](https://gap-packages.github.io/primgrp/doc/chap1_mj.html). The installed GAP4.14.0/PrimGrp3.4.4 lists are verified by [the n22 source](../../scripts/oct03_primitive_degree22.g) and [the n24…38 source](../../scripts/oct03_primitive_even_degrees_24_38.g); their outputs are [n22](../../../litt3-computation-data/oct03_primitive22/catalog_check.txt) and [n24…38](../../../litt3-computation-data/oct03_primitive22/even_degrees_24_38.txt). The latter records every group order, structure description and Sims index. The two exceptions of order greater than10!, M24 and the affine degree32 group, still have order not divisible by10!. Thus under primitivity M=A_n orS_n.

Let R=L^{M_Δ}. Since H stabilizes Δ, R⊂A and
\[
D=[R:F]=\binom n{10}.
\]
Choose the distinguished E-sheet p∈Δ. Its stabilizer A_{n−1} orS_{n−1} acts faithfully on the orbit of Δ consisting of ten-subsets containing p. Indeed that is the action on nine-subsets of n−1 points, which detects each permutation. The normal closure of ER/E is therefore L. Since ER⊂AE=K and K/E is étale, ER/E and its normal closure L/E are étale. The same holds over every conjugate E-sheet, by normality over F. Consequently every inertia group of L/F, and every subgroup of it, acts semiregularly on all n sheets.

For n=2d, d=11…19, a nonidentity semiregular element has equal cycles of length e dividing n. It fixes a ten-subset only if e divides ten, so only e=2,5,10 contribute. Their fixed-subset counts are respectively
\[
\binom d5,\qquad\binom{n/5}2,\qquad n/10,
\]
where the last two can occur in this range only for n30 and have values15 and3. Thus the maximum is f=binom(d,5). For any nontrivial semiregular subgroup B of order b, Burnside yields
\[
1-\frac{\#(\Psi/B)}D
\ge\left(1-\frac1b\right)\left(1-\frac fD\right),
\]
where Ψ is the set of ten-subsets. The normalized orbit-codimension on the original sheet set is1−1/b. Applying this term by term to the usual permutation Artin conductor, with its nonnegative lower-ramification weights, gives
\[
\frac{\deg\operatorname{Diff}(R/F)}D
\ge\left(1-\frac fD\right)
\frac{\deg\operatorname{Diff}(E/F)}n.
\]
This argument includes wild inertia in characteristic five, because the permutation conductor is taken in characteristic zero, or auxiliary characteristic prime to the group, and equals the different of the corresponding separable curve extension. It does not take invariants of a characteristic-five permutation module.

Vandermonde's identity gives binom(2d,10)≥binom(d,5)², so
\[
f/D\le1/\binom d5\le1/462.
\]
The assumed genus ratio implies degDiff(E/F)/n≥18. Hence
\[
\frac{2g(R)-2}D\ge-2+18(461/462)>8.
\]
But the actual separable inclusion R⊂A gives by Hurwitz
\[
\frac{2g(R)-2}D\le\frac{2g(A)-2}{[A:F]}\le8.
\]
The contradiction excludes primitive monodromy in every stated degree. No normal closure of an endpoint map or extra étale endpoint leg was presumed.
