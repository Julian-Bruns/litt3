# Proof: generate the universal extension and dualize its full evaluation

Version1, 3 October2026. [Statement](../../Theorems/cartier_and_spin/genus_two_universal_extension_dual_span.md); [fresh five-task independent static review: PASS](../../Research/audits/OCT03_GENUS_TWO_UNIVERSAL_EXTENSION_DUAL_SPAN_STATIC_REVIEW.md). No computational certificate is needed.

Write the supplied independent extension pair as
\[
0\longrightarrow O(P)\longrightarrow E
\longrightarrow\omega_Y^{\oplus2}\longrightarrow0.
\tag{1}
\]
The line O(P) has h0=1 and h1=1, while ωY has h0=2. Its two extension classes are independent Serre-dual functionals κ1,κ2 on H0(ωY(P))=H0(ωY). Choosing a nonzero generator of H0(O(P)), Serre duality identifies the boundary H0(ωY)²→H1(O(P)) with the nonzero functional
\[
\delta(v_1,v_2)=\kappa_1(v_1)+\kappa_2(v_2),
\]
up to a common nonzero scalar. Multiplication by that generator identifies H0(ωY) with H0(ωY(P)). Hence δ has rank one and h0(E)=1+(4−1)=4.

## Generate the fiber at P

Twisting (1) by O(−P) gives
\[
0\longrightarrow O_Y\longrightarrow E(-P)
\longrightarrow O(P)^{\oplus2}\longrightarrow0.
\tag{2}
\]
The boundary H0(O(P))²→H1(O) is given by the images of the two original extension classes under H1(O(−P))→H1(O). This last map is an isomorphism: in the exact sequence 0→O(−P)→O→kP→0, evaluation H0(O)→kP is an isomorphism. Consequently the boundary in (2) is an isomorphism and h0(E(−P))=1. Evaluation H0(E)→E|P therefore has rank 4−1=3, the full fiber dimension.

## Generate every other fiber

At S≠P the distinguished section of O(P) is nonzero and supplies the kernel fiber in (1). The images of global sections of E in H0(ωY)² are kerδ. The canonical bundle is base-point-free. If evaluation of kerδ into ωY|S² were not surjective, a nonzero functional on that two-dimensional fiber would vanish on its image. Pulling that functional back to H0(ωY)² gives a nonzero multiple of δ. Both κ1 and κ2 would then be scalar multiples of the single evaluation functional H0(ωY)→ωY|S. This contradicts their independence. The quotient fiber is therefore generated, and the O(P) section supplies the remaining fiber. Thus E is globally generated at every point.

## Identify the complete dual-span sequence

Put V=H0(E), dimV=4. Its evaluation is a bundle surjection with line kernel N:
\[
0\longrightarrow N\longrightarrow V\otimes O_Y\longrightarrow E\longrightarrow0.
\]
Determinants give N=O(−5P), because detE=O(P)ωY²=O(5P). Dualizing yields
\[
0\longrightarrow E^*\longrightarrow V^*\otimes O_Y
\longrightarrow O(5P)\longrightarrow0.
\tag{3}
\]
The dual of (1) has outside terms ωY−1² and O(−P), both with no global sections, so h0(E*)=0. Thus V* injects into H0(O(5P)). Riemann–Roch gives h0(O(5P))=4, so the injection is an isomorphism. Sequence (3) is the FULL evaluation sequence for O(5P); its kernel is M_{O(5P)}. This proves E=M_{O(5P)}*.

The original source application uses only the independent pair supplied by the [audited horizontal stability/universal-extension theorem](genus_two_horizontal_rank_three_split_quotient_stability.md). The argument neither constructs nor compares connections, Frobenius roots, Cartier embeddings or original endpoint maps.
