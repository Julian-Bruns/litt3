# Proof: half-genus conductor extensions and the odd block-field norm

Version1, 3 October 2026. [Independent whole audit PASS](../../Research/audits/OCT03_NONSPLIT_LARGER_RESIDUAL_OVERLAP_WHOLE_AUDIT_2026_10_03.md), with no required corrections. See the [statement](../../Theorems/cartier_and_spin/canonical_ten_nonsplit_residual_eleven_through_nineteen_overlap_exclusion.md).

## Actual field data and normalized genera

Put E=k(B′), A=k(Γ), F=k(t), and K=k(T). The actual packet retains K=AE, T/E étale, and T/A degree ten with S10 monodromy. The source degrees and canonical identity give
\[
[E:F]=2r,\quad[A:F]=rm/5,\quad
g(E)=16d+1,\quad g(A)=4dm/5+1.
\]
Consequently
\[
u_E=\frac{2g(E)-2}{2r}=\frac{16d}{r}\ge16,
\qquad
u_A=\frac{2g(A)-2}{[A:F]}=\frac{8d}{r}=\frac12u_E.
\]
Only the normal closure L/F of the SINGLE actual E/F extension is used. Its group M acts faithfully and transitively on2r sheets. The ACTUAL compositum K/A selects an H=Gal(LA/A)-orbit Δ of ten sheets with full S10 induced action.

## Primitive sectors: the same conductor proof applies to the half-genus ratio

The accepted [primitive even-degree theorem](canonical_ten_primitive_even_bridge_twenty_two_through_thirty_eight_exclusion.md) supplies, for every even n=2r between22 and38, the complete primitive-group input and its actual resolvent/étale-normal-closure construction. Specifically a primitive M containing the actual H must be A_n orS_n. Its ten-subset resolvent Z lies ACTUALLY inside A, has degree D=binom(n,10), and its normal closure over E is L. The actual T/E étaleness consequently makes every inertia group and lower subgroup semiregular on the original sheets.

The fixed-subset and termwise wild Artin-conductor proof gives
\[
\frac{\Delta_Z}D\ge\eta\frac{\Delta_E}n,
\qquad\eta\ge\frac{461}{462}.
\]
These group and conductor claims are unchanged when d exceeds r. What changes is the final genus inequality: we use the half-genus ratio rather than uA≤8.

Over any smooth base B with v=2g(B)−2≥−2, the same separating Hurwitz computation would give
\[
\frac{2g(Z)-2}D\ge\eta u_E+(1-\eta)v.
\]
Its dependence on η is increasing, since uE−v=ΔE/n≥0. Thus, using the lower bound461/462,
\[
\eta u_E+(1-\eta)v-\frac12u_E
\ge\frac{230u_E+v}{462}
\ge\frac{3680-2}{462}>0.
\]
But the actual Z⊂A bounds its normalized genus above by uA≤uE/2. This excludes every primitive sector, including all wild possibilities in degree thirty. The present base is P1, but the displayed extension is valid over every base genus. No primitive catalog is rerun and no extra endpoint closure is imposed.

## Every imprimitive system has only the stated block possibilities

Choose a proper M-block system. Its intersections with Δ form an H-invariant partition of the primitive S10 action, so either one block contains all ten sheets of Δ, or ten blocks each meet Δ in one sheet.

In the first case its block size s satisfies10≤s≤r≤19, since a proper block has size at most half the2r sheets. The block containing Δ is H-invariant. Its stabilizer contains both H and the distinguished E-sheet stabilizer, yielding an ACTUAL common field R⊂A∩E with [E:R]=s. Changing the common base from F to R scales both normalized genera by the same positive [R:F], hence preserves the exact half ratio and makes u_(E/R)≥uE≥16. The accepted [arbitrary-base small-complement theorem](canonical_ten_small_complement_arbitrary_base_exclusion.md) excludes s11…19.

The size-ten case requires2r to be a multiple of ten. In the present range it occurs only when r15, with three blocks of size ten. It is handled below.

In the singleton case there are at least ten blocks. Their common size is at most floor(2r/10)≤3, and is greater than one. Size two is excluded by the [pair-block half-genus theorem](canonical_ten_pair_blocks_small_complement_half_genus_exclusion.md), whose actual field and conductor arguments require no disjoint-infinity hypothesis. Size three can occur only at2r30 or36: these are the only multiples of three in22…38 with at least ten three-sheet blocks. Thus no block size or extra imprimitive sector is omitted.

## Three-sheet blocks: large kernels retain the half-genus contradiction

The audited [thirty/thirty-six triple-block proof](canonical_ten_triple_block_thirty_thirty_six_bridge_exclusion.md) establishes the full group dichotomy, the actual partial-transversal resolvent, and the local étale-normal-closure argument. These steps use only the SINGLE bridge, the actual ten-sheet S10 component and T/E étale. In particular they do not use disjoint infinity, the value d=r, or an assumed symmetric-group complement.

For every large ternary kernel, that proof gives an ACTUAL Z⊂A with
\[
\frac{\Delta_Z}D\ge\eta\frac{\Delta_E}{2r},
\qquad\eta\ge\frac{80}{81}.
\]
Its hidden own-triple C2 stabilizer kernel is explicitly removed by intersection with ALL conjugate E-sheet stabilizers; thus all inertia is genuinely semiregular before applying this inequality. The permutation Artin argument covers every lower wild group, including characteristic five.

Replacing only its final fixed-genus comparison by the half-genus ratio gives, over every base genus v≥−2,
\[
\eta u_E+(1-\eta)v-\frac12u_E
\ge\frac{79u_E+2v}{162}
\ge\frac{1264-4}{162}>0.
\]
The actual Z⊂A again contradicts this. Every large ternary kernel is excluded without changing or replaying the settled group proof.

For the small ternary kernels, the same audited group result supplies a system of THREE blocks of size b, where b10 at2r30 and b12 at2r36. The size-twelve case gives an actual R⊂A∩E with [E:R]=12, already excluded by the arbitrary-base theorem. The size-ten case is the remaining actual cubic field treated next.

## Three blocks of ten: actual cubic field and genus bound with overlap

Here r15 and15≤d≤19. The [three-ten-block proof](canonical_ten_three_ten_blocks_disjoint_infinity_exclusion.md) gives the actual and unique cubic field R⊂E∩A over F. Its proof of uniqueness uses only the actual primitive ten-orbit: Δ must be one full block because ten singleton intersections cannot fit three blocks; the block system is precisely all M-translates of Δ. Hence every cubic F-subfield of E is this R.

The free involution σ of E/C0, sending t to−t, preserves F and therefore preserves R. Its restriction is nontrivial since t∈R. Thus
\[
Q=R^\sigma\subset C_0,\quad
[Q:k(z)]=3,\quad[C_0:Q]=10,\quad[R:Q]=2.
\]
Also [A:R]=m, because [A:F]=3m. The actual Γ→R gives
\[
g(R)\le\frac45d+1.
\]
Zeros and poles of t on E are simple, including with overlap: div(t) is the pullback of the residual divisors D1−D2, and the common divisor J lies at finite nonzero t. Therefore R/F is unramified above t0 and t∞; each of these fibers contains three distinct points. The involution σ_R acts on each odd-cardinality fiber and has at least one fixed point in each. It can have fixed points only there. If a is its fixed-point count, a≥2 and tame Hurwitz gives
\[
g(R)=2g(Q)-1+a/2,
\qquad g(Q)\le\frac12g(R)\le\frac25d+\frac12<9.
\]
The fixed J(X) is absolutely simple of dimension nine, so both Jacobian Hom groups between X and Q vanish. No map Q→X is asserted.

## A special uniform double fiber is finite for the opposite actual leg

Choose a σ_R-fixed point above t0 and write A0 for its image on Q. The R/F index there is one, the F/k(z) index is two, and the tame R/Q fixed-point index is two. Hence Q/k(z) has index one at A0.

Every source C0 point above z0 belongs to the residual first infinity divisor D1 and has z-index two. Thus the actual π:C0→Q has at A0 a uniform quadratic fiber
\[
\pi^*A_0=2E_0,\qquad\deg E_0=5,
\]
with E0 supported on D1. This uses only indices of actual maps; it does not require a semiregularity assumption on E/F.

The actual correspondence (h2)_*π*:J(Q)→J(X) vanishes. Pick any Q-point A∞ above z∞. Its π-fiber is wholly supported on the residual second infinity divisor D2, so
\[
(h_2)_*\pi^*A_\infty=10O.
\]
Norm classes are therefore10O for every π-fiber. Meanwhile EVERY point of E0 is finite for h2: it lies in D1=I1−J, disjoint from the entire I2=D2+J. The common J lies at finite nonzero z and causes no exception at z0. Thus E_X=(h2)_*E0 is an effective finite divisor of degree five and
\[
2E_X\sim10O.
\]
The two-torsion line O_X(E_X−5O) has a section after twisting by5O and hence7O. The accepted [fixed-X norm obstruction](../../Theorems/jacobians/isogeny_sieves/trigonal_constant_norm_obstruction.md) forces that line to be trivial, so EX∼5O. But a finite effective EX of degree five would give a function with exact pole order five at O, excluded by the semigroup <3,10>. Equivalently L(5O)=span{1,x} forces every degree-five effective divisor in this class to contain O. This is a contradiction.

The three-ten-block case is excluded with every overlap allowed by15≤d≤19. All primitive and imprimitive cases have now been exhausted. Both original endpoint maps have remained on the same actual T; all auxiliary fields are genuine subfields of the single actual bridge or its actual companion. Nothing here supplies the comparison hypotheses for an arbitrary common source.
