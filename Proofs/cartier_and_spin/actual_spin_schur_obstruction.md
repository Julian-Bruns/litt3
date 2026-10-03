# Proof: actual orbit divisors, Picard obstruction and Sylow restriction

Version2. [Statement](../../Theorems/cartier_and_spin/actual_spin_schur_obstruction.md). The full universal obstruction and orbit-space determinant consequences passed [root whole-scope review](../../Research/audits/ACTUAL_SPIN_SCHUR_OBSTRUCTION_AUDIT_2026_10_03.md). No computation. The invariant spin-line hypothesis refers to the actual sixteen-spin refinement and its genuine projective action; it is not asserted for an arbitrary initial common-source group.

## Linearized degrees and the exact obstruction divisibility

For any genuinely G-linearized line onC, its generic fiber is a one-dimensional semilinear k(C) representation. Multiplicative Hilbert90 over the ACTUAL Galois extension k(C)/k(C/G) supplies a nonzero invariant rational section. Its divisor is a sum of full point orbits. Orbit sizes are |G|/|G_c| and their greatest common divisor is
\[
\gcd_c(|G|/|G_c|)=|G|/\operatorname{lcm}_c|G_c|=D.
\]
Thus D divides the degree of every genuinely linearized line. This includes wild stabilizers; no replacement by inertia orders in a tame model is made.

For an invariant Picard classA choose isomorphisms g*A≅A. Their scalar cocycle is a classα(A)∈H²(G,k*) because invertible functions on the proper connected curve are constants. Finite-group cohomology kills this class by |G|, so it has finite ordero. The tensor power A⊗o has zero obstruction and is genuinely linearizable. Therefore D dividesom, equivalently D/gcd(D,m) divideso.

## The source spin and canonical target cases

On the actual sixteen-spin source the free action has D=|G|=8d, while degL=d. Thus8 divides the obstruction order. The class is pulled fromM whenever L=φ*M equivariantly as Picard classes: pulling the chosen isomorphisms throughφ leaves their scalar cocycle unchanged. Hence α(L)=α(M) in the same group cohomology. This is compatible with the original projective spin action; no genuine M orL linearization has been assumed.

The actual isomorphism L16≅ωT transports the canonical genuine G-linearization toL16, so16α(L)=0. Combining the lower divisibility gives exact obstruction order EIGHT or SIXTEEN. On a canonical target the same upper bound also follows directly from M16≅ωΓ² and the canonical target G-linearization.

If W is a nonzero G-invariant actual section space of dimensionr, the chosen line isomorphisms give projective operators onW with the same scalar cocycleα(L). Taking their determinants makes its rth power a coboundary. Thus rα(L)=0 and the exact obstruction order dividesr. The actual orbit span of original infinity sections is such a space. No irreducibility or semisimplicity of this projective representation is needed.

For the accepted positive full-trace decomposition q*J≅L²⊗V4, the determinant of the genuinely linearized q*J is isomorphic toL8 as a line. It supplies a genuine linearization ofL8, so8α(L)=0; the source lower bound makes its order exactly EIGHT. The constant coefficient space V4 has the inverse multiplier ofL² because their tensor product is genuinely linearized. Its class is therefore−2α(L), of exact order FOUR. This conditional addition uses the actual decomposition and is not imported into arbitrary carrier branches.

For a faithful canonical target, |G|=8nδ anddegM=δ. If its actual stabilizer lcm isn, then D=8δ and the same conclusion follows directly on the target. Here are the lcm checks for the accepted tame list:
\[
(4,4,4),(2,2,2,4):4;
\quad(2,2,2,3),(3,3,6),(2,6,6):6;
\quad(2,4,8):8;
\]
\[
(2,3,12),(2,4,6),(3,3,4):12;
\quad(2,3,9):18;
\quad(2,3,8):24;
\quad(2,3,7):42.
\]
For each wild row the only nontrivial stabilizer orders aree,m, and n=lcm(e,m)=em/gcd(e,m). The ELEVEN pairs are
\[
(5,2),(10,4),(20,2),(20,8),(20,3),(20,7),
(30,3),(40,6),(60,6),(1000,7),(3000,21).
\]
Their least common multiples are respectively10,20,20,40,60,140,30,120,60,7000,21000, exactly the actual canonical degrees. These are arithmetic identities for the accepted table, not new finite-group computations.

## Sylow restriction and abelian invariant factors

Let P2 be a Sylow two-group. Restriction followed by corestriction on H²(G,k*) is multiplication by the odd index[G:P2]. It is an automorphism on the two-primary subgroup, so restriction is injective there. Thus H²(P2,k*) has an element of order at least EIGHT.

When P2 is abelian, divisibility of k* removes the symmetric extension contribution and
\[
H^2(P_2,k^*)\simeq\operatorname{Hom}(\bigwedge^2P_2,k^*).
\]
If its cyclic invariant factors have orders2^a1≤⋯≤2^ar, this group has exponent2^a(r−1) forr≥2 and is zero forr=1. Indeed an alternating pairing between two cyclic factors has order at most the smaller factor, and that order is attained by the two largest factors. An exponent at least EIGHT therefore needs TWO cyclic factors of order at least EIGHT.

## The actual Humbert refinement consequence

For the Galois Humbert refinement Γ′/H, the quotient group is Q=C2⁴⋊C5. If its kernelJ has odd order, the Sylow two-group maps isomorphically to C2⁴. Its Schur cohomology has exponent TWO, contradicting the universal eight-primary requirement. ThusJ has even order. This special case requires no ordinarity assumption; the original author derivation is retained in the [experiment note](../../Research/experiments/oct02_global_extraction/HUMBERT_SPIN_SCHUR_OBSTRUCTION.md).

If the Sylow two-group is abelian, its quotient C2⁴ needs at least FOUR cyclic generators. Combining this with TWO factors of order at least EIGHT and two further factors of order at least TWO gives order at least8·8·2·2=256. The quotient's Sylow group has order16, so the kernel's two-part has order at least16.

These conditions leave arbitrary larger even kernels and their character packets unresolved. They do not identify either target with the original X endpoint, and they do not turn a ramified composed source map into an étale map.
