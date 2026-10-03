# Proof: the saturated target plane removes the nontrivial marks

Version1, 3 October2026. [Statement](../../Theorems/cartier_and_spin/canonical_ten_constant_source_trivial_quotient_and_tame_exclusion.md); [fresh independent five-task static review: PASS](../../Research/audits/OCT03_GRAM_FOUR_CONSTANT_MARKED_CLASS_AND_TAME_STATIC_REVIEW.md). The reviewed derivation is recorded in [the research note](../../Research/notes/oct03_ten_hour/gram_four_constant_marked_class_and_tame_exclusion.md). No computational certificate is needed.

## Use the same original splitting and saturated plane

The [original quotient-splitting theorem](canonical_ten_gram_four_original_kernel_quotient_splitting.md) gives
\[
E/B=(\omega_YT_0)\oplus\omega_Y,\qquad
T_0=(H/B)\omega_Y^{-1}.
\]
Projection to the ωY summand is the ORIGINAL quotient evaluation. The [marked quotient theorem](canonical_ten_gram_four_degree_one_marked_quotient.md) restricts T0 to O, O(R+−P) or O(R−−P).

The [constant osculation theorem](canonical_ten_constant_jet_osculation_constraints.md) gives S2/B=O and original evaluation on it equal to a nonzero multiple of η, divη=2P. Its inclusion
\[
O_Y=S_2/B\longrightarrow E/B
\tag{1}
\]
is a subbundle: its cokernel is E/S2, locally free because S2 is saturated in E.

Suppose T0=O(R−P) for one of R±. Since ωY=O(2P), its complementary quotient is ωYT0=O(P+R). This degree-two line has h0=1. Riemann–Roch gives h0=1+h0(O(P−R)), and the last degree-zero line is nontrivial because P≠R. Thus any nonzero section of O(P+R) has its unique divisor P+R and vanishes at P. The first component of (1) therefore vanishes at P, whether it is nonzero or zero; its second component η also vanishes there. A subbundle injection cannot have zero fiber. Both nontrivial marked classes are excluded, proving T0=O.

Now (1) is given by two sections of ωY, the second equal to η. They must be linearly independent, because dependent components share the zero P. They consequently form the complete base-point-free canonical pencil.

## Identify the ordinary bundle and Wronskian class

The [horizontal stability/universal-extension theorem](genus_two_horizontal_rank_three_split_quotient_stability.md) supplies an independent extension pair
\[
0\longrightarrow O(P)\longrightarrow E\longrightarrow\omega_Y^{\oplus2}\longrightarrow0.
\]
The [dual-span theorem](genus_two_universal_extension_dual_span.md) identifies its ordinary bundle with M_{O(5P)}*. In particular detE=O(5P). The target Wronskian belongs to detE B−3 ωY3=O(8P) and has the exact divisor 2P+D, with P outside D. Therefore D∼6P.

Since detE=F_Y*(detK), the determinant result is only F_Y*(detK O_Y1(−P1))=O. No choice of Frobenius preimage or exclusion of fifth torsion follows from this equality.

## Exclude the whole constant-chart tame alternative

The constant osculation theorem restricts D2Γ to zero or one reduced native tame orbit. In the latter case D=Ftame+S, where Ftame is the complete five-point fiber w=−b, Ftame∼5P, and S is effective of degree one. Combining with D∼6P gives S∼P. Because h0(O(P))=1, its unique effective divisor is P. Hence S=P, contradicting P outside D. This proves D2Γ=0.

Every step uses the ACTUAL original unit splitting, marking and saturated constant osculation conclusions. There is no d=0 restriction or use of Nm(D)=U, D=ιR, semireduced graphs, Cramer pivots or gauge-independence charts. The earlier [d-zero tame gate](canonical_ten_constant_dzero_cartier_divisor_and_tame_gate.md) remains a separately verified special case; its calculation is not replayed. Both original endpoint maps remain on the SAME T, and the surviving zero-defect source compatibility is unresolved.
