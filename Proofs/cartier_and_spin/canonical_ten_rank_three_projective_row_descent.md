# Proof: second-Wronskian ratios recover the actual Grassmann quotient

Version1,3 October2026. Whole-scope review PASS. See the [exact statement](../../Theorems/cartier_and_spin/canonical_ten_rank_three_projective_row_descent.md). This proof is conceptual and uses no computation or replacement of either original map. [Root whole-scope audit](../../Research/audits/CANONICAL_TEN_RANK_THREE_RAMIFIED_ROWS_AUDIT_2026_10_03.md).

## The two presentations on the actual source

The retained [rank-three row reduction](canonical_ten_rank_three_adjoint_row_ramification_reduction.md) supplies an integral surjection V⊗P→q_C*K on C^(1), with dimV≥EIGHT. Tensor by P⁻¹ to obtain the actual Grassmann quotient
\[
V\otimes O_{C^{(1)}}\twoheadrightarrow E_C,
\qquad E_C=q_C^*K\otimes P^{-1}.
\tag{1}
\]
It defines a regular map γ:C^(1)→Gr(THREE,V), using the quotient convention for the Grassmannian. The tautological quotient pulls back to E_C with precisely (1).

Frobenius pullback of (1), followed by the original integral Cartier evaluation F_C*q_C*K→ω_C and division by F_C*P, is the complete basepoint-free adjoint row
\[
V^{[5]}\otimes O_C\twoheadrightarrow A,
\qquad A=\rho^*M,\quad M=O_D(1).
\tag{2}
\]
The three-row Wronskians are nonzero and, in a rational horizontal frame of q_C*K and P, their ratios are FIFTH powers of the Plücker ratios of (1). This is the exact minor factorization already proved in the row reduction; it does not require K to equal a constant-module tensor product.

## The Plücker coordinates lie on D^(1)

Choose a separating rational parameter x on D. Because ρ is separating, x is separating on C as well, and the derivation ∂/∂x extends to k(C). In a rational M-frame write the coordinate sections of (2) as f_i∈k(D). In the rational horizontal P-frame used for (1), their differential evaluations on C have the form
\[
w f_i\,dx
\]
for a common nonzero rational factor w∈k(C). This factor includes only the comparison of the chosen rational line frames; no regularity assertion about w is needed.

Leibniz's rule gives a triangular transformation of zero-through-second jets, with diagonal w,w,w. Thus every THREE-minor is multiplied by w³. For any nonzero reference minor J,
\[
\frac{\operatorname{Wr}_I(wf)}{\operatorname{Wr}_J(wf)}
=\frac{\operatorname{Wr}_I(f)}{\operatorname{Wr}_J(f)}\in k(D).
\tag{3}
\]
In the horizontal Cartier frame the same ratio is (p_I/p_J)^5, where p_I are the rational Plücker coordinates of (1). It lies in k(C)^5 as well. For a finite separating extension of function fields,
\[
k(D)\cap k(C)^5=k(D)^5.
\tag{4}
\]
Indeed an element of k(D) with a fifth root in the separating extension k(C) cannot acquire a nontrivial purely inseparable minimal polynomial there. Equations(3)–(4) imply that EVERY Plücker ratio belongs to k(D^(1)), under the Frobenius-twist identification. Zero minors cause no problem; choose one nonzero minor, which exists by the rank-three Wronskian argument.

Therefore γ factors rationally through ρ^(1):C^(1)→D^(1). Since D^(1) is a smooth projective curve and the Grassmannian is proper, this rational map extends uniquely everywhere. Its composition with ρ^(1) agrees with γ generically, hence globally. Pulling back the tautological quotient supplies a rankTHREE E_D and its actual quotient V⊗O→E_D, with pullback exactly (1). Uniqueness also makes the construction projectively R-equivariant. The retained multiplier is not discarded, so this does not give a genuine R-linearization.

## The evaluation and projective connection descend

On D the original row gives V^[5]⊗O_D→M. Its restriction to the kernel of the Frobenius-pulled quotient V^[5]⊗O_D→F_D*E_D vanishes: after pullback to C it is the corresponding restriction of the original integral evaluation, which is zero by (1)–(2). The finite separating map ρ between smooth curves is finite flat and surjective, so this vanishing descends faithfully. The original row map therefore factors through
\[
F_D^*E_D\twoheadrightarrow M.
\tag{5}
\]
It is surjective because the complete original row is basepoint free.

The original Cartier connection on F_C*q_C*K is the canonical connection of its Frobenius antecedent. The ACTUAL antecedent identity
\[
q_C^*K=P\otimes\rho^{(1)*}E_D
\]
identifies that connection with the tensor product of the canonical connections on F_C*P and on ρ*F_D*E_D. Projectivization removes the scalar-line connection. Thus the actual projective Cartier connection is the pullback of the regular dormant projective connection on F_D*E_D. This argument uses the antecedent identity rather than merely equality of rational projective rows, so it remains valid at the possible row ramification points.

It does not identify F_C*P with a line pulled from D. In particular (5) is an evaluation into M, not into ω_D; no embedding E_D→B_D or root of ω_D follows.

## Degree and completeness

Because q_C has degreeN, deg(q_C*K)=N. The retained degP=N/FOUR gives
\[
\deg E_C=N-3N/4=N/4.
\]
Its exact pullback from E_D yields degE_D=N/(4e). The complete inclusion module V injects into H0(C^(1),E_C) by its definition as the actual constant inclusion module. Its descended sections therefore inject into H0(D^(1),E_D) as well, since pullback by a finite surjective map is faithful.

In the étale row case en=N, giving degE_D=n/FOUR. In the sole-ramification-orbit case 2en=N, giving degE_D=n/TWO. These are necessary integral degree conditions; no vector-bundle Clifford estimate or scalar-line descent is inferred.
