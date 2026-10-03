# Proof: the affine transversal resolvent has too much different

Version1, 3 October2026. Independent whole review PASS in Research/audits/CANONICAL_TEN_PAIR_BLOCK_TWENTY_BRIDGE_AUDIT_2026_10_03.md. Use the SINGLE actual bridge normal closure L/F and M, with H=Gal(LA/A), as in the [primitive-sector proof](canonical_ten_primitive_twenty_bridge_exclusion.md).

H has a TEN-element orbit Δ on which it induces S₁₀, and preserves its TEN-element complement Q. Under the stated pair-block system, Δ is a transversal: its intersections with blocks give an H-stable partition of Δ, and S₁₀ primitivity rules out intersections of sizeTWO. H's action on Δ is faithful, since an element fixing its chosen point in each pair fixes the partner too. Thus H is the diagonal S₁₀ on the matched pairs. The block quotient of M is S₁₀, split by H, and
\[
M=K\rtimes S_{10},\qquad K\le\mathbf F_2^{10}.
\]
K is a nonzero S₁₀-submodule, since K=ZERO would make M=H intransitive. Its only possibilities are the constant line, the even-weight hyperplane, or the full space. Indeed any vector not constant, subtracted from a transposition of itself, gives a coordinate-pair difference; these differences generate the even-weight space. An odd vector then gives the full space.

The constant line gives the stated central C₂×S₁₀ case. Suppose instead dimK=NINE orTEN. The K-orbit Ψ of Δ consists of its even-weight or arbitrary flips, respectively. Its set stabilizer is exactly H. Therefore R=L^H lies INSIDE A and [R:F]=D=512 or1024.

Fix the distinguished E-sheet in Δ. Its stabilizer in M is K₀⋊S₉, where K₀ consists of the vectors in K with that coordinate ZERO. Its orbit of Δ in Ψ is precisely the transversals still containing that sheet. This action is faithful: translations act faithfully on K₀; S₉ acts faithfully on its even-weight nine-coordinate space or its full nine-coordinate space. Thus the normal closure of ER/E is L. Since ER⊂AE=T and T/E is étale, L/E is étale.

It follows as before that every inertia subgroup and every lower ramification subgroup acts semiregularly on the original TWENTY sheets. Let σ be a nonidentity such element. If it fixes a transversal, its restriction to that transversal is semiregular, of order d dividingTEN. Its underlying block permutation consists of TEN/d cycles of length d. The affine fixed-transversal set is then a translate of K's fixed space and has at most TWO^(TEN/d) elements. Hence the fraction of Ψ fixed by σ is at most
\[
\frac{32}{512}=\frac1{16}.
\]
An element fixing no transversal satisfies the same bound. Burnside, followed termwise by the wild Artin-conductor formula, consequently gives
\[
\frac{\Delta_R}{D}\ge\frac{15}{16}\frac{\Delta_E}{20}.
\]
Here Δ_E=360. Therefore
\[
\frac{2g(R)-2}{D}\ge-2+18\cdot\frac{15}{16}=\frac{119}{8}>8,
\]
contrary to R⊂Γ and (2g(Γ)−TWO)/deg(t|Γ)=EIGHT. Both large binary kernels are excluded. The constant-line kernel has a nonfaithful stabilizer action on the two transversal choices, so the actual étale-normal-closure step fails there; it has not been silently excluded.

For completeness, the remaining imprimitive block sizes in the actual TWENTY-sheet problem are onlyTWO andTEN. A block system restricts on Δ to an H-stable partition. Its induced S₁₀ action is primitive, so every nonempty intersection is a singleton, or one block contains all of Δ. In the first case there are at leastTEN blocks, hence their common size is at mostTWO. In the second a proper block has size at leastTEN, hence exactlyTEN. In the supported A₁₀ case pair blocks are impossible, since that subgroup fixes Q. This reduction is useful, but it does not remove two TEN-element blocks.
