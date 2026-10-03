# Proof: the twenty-two-sheet bridge has no monodromy sector

Version1, 3 October 2026. [Independent whole audit PASS](../../Research/audits/OCT03_NONSPLIT_TWENTY_TWO_AND_PARAMETER_DECK_AUDIT_2026_10_03.md). See the [statement](../../Theorems/cartier_and_spin/canonical_ten_nonsplit_twenty_two_bridge_exclusion.md).

Only the normal closure L/F of the SINGLE actual E/F extension is used. Let M=Gal(L/F) in its transitive degree-twenty-two sheet action Ω. The actual compositum AE=T selects an H=Gal(LA/A)-orbit Δ of size ten, with induced action S10. Its complement has size twelve. In particular |H|≥10!. All comparisons below use fields inside the actual A or E; no simultaneous endpoint closure is presumed.

## A fixed H-sheet would give an impossible actual map

If H fixes a sheet p, its conjugate E_p=L^{M_p} lies in L^H=L∩A. Its curve is abstractly isomorphic to the actual B′ and has genus177. Since A/F is separable, Γ→B′ through E_p is separable. Riemann–Hurwitz, divided by the corresponding F-degrees, would give
\[
\frac{2g(B')-2}{22}=16
\le\frac{2g(\Gamma)-2}{[A:F]}=8,
\]
which is impossible. Thus H has no fixed sheet. This conclusion does not assert that the new map is étale; ordinary separable Hurwitz is sufficient.

## Every imprimitive block system is excluded

Intersections of an M-block system with the primitive H-orbit Δ give an H-invariant partition of Δ. They are either one full Δ or ten singleton sets. In the first case the block size is at least ten; its only proper nontrivial divisor of22 is eleven. The block containing Δ is H-invariant, and its one extra point is therefore an H-fixed sheet, already excluded.

In the singleton case there are at least ten blocks, so their size is at most two and is exactly two. But the actual block containing the distinguished E-sheet gives an intermediate F⊂D⊂E with [E:D]=2. The quadratic deck is a nontrivial t-preserving involution. It is excluded by [parameter-deck rigidity](actual_disjoint_infinity_parameter_deck_rigidity.md), which applies to the actual disjoint infinity divisors and the exact index-one field generation. No faithfulness or kernel classification of the pair action is needed.

## The complete primitive degree-twenty-two list

The complete Sims classification in degree at most fifty gives exactly four primitive groups of degree22:
\[
M_{22},\quad M_{22}{:}C_2,\quad A_{22},\quad S_{22}.
\]
Their respective orders are443520,887040,22!/2,22!. The first two are smaller than10! and cannot contain H. Hence the primitive case has M=A22 orS22.

This input is explicitly a finite primitive-group classification, not a claim inferred merely from an arbitrary catalog search. The official [PrimGrp manual](https://gap-packages.github.io/primgrp/doc/chap1_mj.html) states completeness up to permutation isomorphism, including Sims' groups of degrees at most fifty. The installed GAP4.14.0/PrimGrp3.4.4 catalog is queried by the short source [scripts/oct03_primitive_degree22.g](../../scripts/oct03_primitive_degree22.g). Its bounded output and package provenance are preserved in [the certificate](../../../litt3-computation-data/oct03_primitive22/catalog_check.txt). That source verifies the four exact orders, their names and Sims indices; it runs with one ordinary process and performs no endpoint arithmetic replay.

## The actual ten-subset resolvent forces étale normal closure over E

Let K=M_Δ be the setwise stabilizer and R=L^K. Since H≤K, R⊂A. For M=A22 orS22,
\[
D=[R:F]=\binom{22}{10}=646646.
\]
Choose the distinguished E-sheet p in Δ. The point stabilizer M_p is A21 orS21; its orbit of Δ consists of all ten-subsets containing p. Its action on that orbit is faithful, because an element fixing every nine-subset of the other21 points fixes every point. Therefore the core of M_p∩K in M_p is trivial, and the normal closure of ER/E is exactly L.

Since ER⊂AE=T and T/E is étale, ER/E is étale. Its normal closure over E is also étale: finite étale covers of a smooth connected curve are closed under connected fiber products and their connected components. Thus L/E is étale. Normality over F makes the same assertion true over every conjugate E-sheet.

Every inertia group I of L/F consequently intersects every conjugate point stabilizer trivially. It acts semiregularly on the twenty-two sheets. Its order divides22, and every subgroup in its lower filtration does also. Since the residue characteristic is five, the inertia has no nontrivial wild subgroup; no separate semiregularity assumption is being imposed on the original E/F extension.

## Conductor comparison contradicts the genus of Γ

Every nonidentity element of an inertia group has order two, eleven or twenty-two and consists of equal cycles on Ω. Among these only an element of order two can fix a ten-subset. It has eleven two-cycles and fixes exactly
\[
\binom{11}{5}=462
\]
ten-subsets. For any nontrivial semiregular inertia subgroup B of order b, Burnside's formula gives, for Ψ the set of ten-subsets,
\[
1-\frac{\#(\Psi/B)}D
\ge\left(1-\frac1b\right)\left(1-\frac{462}{D}\right).
\]
The normalized orbit-codimension on Ω is1−1/b. Applying this inequality to the usual permutation Artin conductor, equivalently here the tame different, gives
\[
\frac{\deg\operatorname{Diff}(R/F)}D
\ge\left(1-\frac{462}D\right)
\frac{\deg\operatorname{Diff}(E/F)}{22}.
\]
For g(E)=177 and [E:F]=22, Hurwitz yields degDiff(E/F)=396, whose normalized value is18. Hence
\[
\frac{2g(R)-2}D
\ge-2+18\left(1-\frac{462}{646646}\right)>8.
\]
But the actual R⊂A and separability give the opposite Hurwitz inequality
\[
\frac{2g(R)-2}D
\le\frac{2g(\Gamma)-2}{[A:F]}=8.
\]
This contradiction closes the primitive sector, completing the exclusion. The original finite étale X and Y legs have remained on the same actual T throughout.
