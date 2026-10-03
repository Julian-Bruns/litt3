# Proof: the actual complement resolvent has too much genus

Version1,3 October2026. Independent whole review [PASS](../../Research/audits/CANONICAL_TEN_SMALL_COMPLEMENT_AND_FULL_BRIDGE_AUDIT_2026_10_03.md). New root extension of the independently accepted degreeTWELVE argument.

Let L/F be the normal closure of E/F, M its transitive permutation group on n sheets, and H=Gal(LA/A). H has a ten-element orbit Ω whose induced action is S10. Let Q be its complementary set, of size d=n−TEN. Commutators of H act as A10 on Ω, but their action on Q need not be trivial when d>2. The restriction kernel H→S(Q) nonetheless contains A(Ω) fixing Q pointwise: its image on Ω is normal in S10, hence either trivial or contains A10. If trivial, the kernel fixes EVERY sheet and is trivial; H would embed in S_d, impossible since d≤EIGHT while H surjects onto S10. Thus this kernel contains A10 on Ω fixing Q.

Every conjugate ten-element support meets every other in at least20−n≥TWO letters. Alternating groups on two supports of size≥FOUR meeting in at leastTWO letters generate the alternating group on their union, by their mixed three-cycles. Transitivity makes the union of all conjugate supports the whole n-set. Therefore M=A_n orS_n.

Let J be the setwise stabilizer of Q and R=L^J. Since H preserves Q,
\[
R\subset L^H=L\cap A\subset A,\qquad [R:F]=D=\binom nd.
\]
For the original distinguished E-sheet i∈Ω, its stabilizer V is A_(n−ONE) orS_(n−ONE). ER/E is its faithful action on d-subsets of the other n−ONE letters. Faithfulness follows because the intersection of ALL d-subsets containing a given letter is that letter, and TWO≤d≤n−THREE. Thus its normal closure is L/E. Since ER⊂K and K/E is étale, L/E is actually étale. Inertia in L/F acts freely on n letters; its order e divides n. For the four stated n, FIVE∤n, so inertia is cyclic tame and is a product of n/e disjoint e-cycles.

For such inertia, let δ_n(e)=n−n/e. Burnside gives the number of orbits on d-subsets as
\[
o_d(e)=\frac1e\sum_{j=0}^{e-1}\begin{cases}\binom{n/h_j}{d/h_j},&h_j\mid d,\\0,&h_j\nmid d,\end{cases}
\qquad h_j=e/\gcd(e,j).
\]
Hence δ_D(e)=D−o_d(e). Direct integer substitution for the divisors e>ONE of each n gives the following minimum normalized ratio; no finite-field or geometric search is involved:
\[
\begin{array}{c|c|c|c}
n&d&D&\min_e\frac{\delta_D(e)/D}{\delta_n(e)/n}\\\hline
12&2&66&10/11\\
14&4&1001&140/143\\
16&6&8008&142/143\\
18&8&43758&2424/2431
\end{array}
\]
Since gcd(n,d)=TWO in all FOUR rows, only the unique involution can fix a d-subset for a nonidentity inertia element. For odd e the ratio isONE; for even e it is ONE−binom(n/TWO,d/TWO)/[(e−ONE)D]. Its minimum is therefore at e=TWO, giving the printed values. All ratios are≥TEN/ELEVEN. This is a direct rational combinatorial identity, not a monodromy classification.

The actual B′ map has total different32r+2n. Summing the local inequality gives
\[
\frac{2g(R)-2}{D}\ge-2+\frac{10}{11}\left(\frac{32r}{n}+2\right)
=\frac{320r}{11n}-\frac2{11}.
\]
Because c≥ZERO, r≥n/2. This bound strictly exceeds16r/n: their difference is144r/(11n)−2/11≥70/11>ZERO. But Γ→R is an actual separable map, so Hurwitz would give
\[
\frac{2g(\Gamma)-2}{[A:F]}=\frac{16r}{n}\ge\frac{2g(R)-2}{D},
\]
a contradiction. Only the SINGLE bridge normal closure is used; neither original X-field is replaced and no simultaneous endpoint closure is assumed.
