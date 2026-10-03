# Proof of the actual primitive degree-eight abelian quotient exclusion

[Statement](../../Theorems/cartier_and_spin/primitive_degree_eight_abelian_quotient_exclusion.md). Version1,2 October2026.

## The norm condition retains the actual first leg

Put M=omega_S tensor lambda^8. Etaleness and the actual embedded-line equality give pi^*M=omega_T tensor h^*lambda_X^8=O_T. A line trivialized by finite etale pullback has prime-to5 finite order: in the etale Galois closure over S, descent of a trivial line is a character into k^*, whose finite subgroups have prime-to5 order. This uses a closure over S only. Hence M and Nm_q(M) are tame torsion.

Since lambda^-8=q^*A tensor O_S(16G), writing P=qG and taking norms gives
\[
O_Y(16P)=omega_Y^8\otimes A^{-8}\otimes Nm_q(M)^{-1}
=omega_Y^8\otimes A^2\otimes Nm_q(M)^{-1}.
\]
This condition uses the ORIGINAL further X-map, rather than a hypothetical identification S=X.

## A nonzero trace-evaluation condition

Let e be E's nonzero extension class in H1(Y,A^-1). Twisting the pulled-back extension by q^*A^-4 and using L gives a lift of O_S(-G). Thus q^*e dies in H1(S,q^*A^-1(G)). The class q^*e is nonzero because trace composed with pullback is multiplication8, a unit. The same argument shows q^*A is nontrivial.

Consequently the principal-part boundary at G is a nonzero line containing q^*e. Under Serre duality its functional is evaluation at G on H0(S,omega_S tensor q^*A), while the functional of q^*e is, up to a nonzero scalar,
\[
Tr_q:H0(S,omega_S\otimes q^*A)\longrightarrow H0(Y,omega_Y\otimes A).
\]
The target has dimension1, and trace is surjective since its composition with pullback is multiplication8. Therefore evaluation at G is a NONZERO scalar multiple of trace. Every trace-zero form vanishes at G, but the full twisted canonical system does not vanish there.

## Two character sections contradict the norm

Suppose q factors through a connected abelian etale cover r:Z->Y of degree4 or8. Its character lines occur as direct summands of q_*O_S: for an upper degree-two map the pullback summand splits by normalized trace, and for degree-one there is nothing to prove. They have order dividing8. There are two distinct nontrivial characters B,C with B C^-1 nontrivial of order2. For C4 take a generator and its inverse; for C2 times C2 take any two distinct nontrivial characters; every abelian group of order8 has the same sort of pair. Reversing the character convention inverts both lines and changes no assertion.

Each of H0(Y,omega_Y tensor A tensor B) and H0(Y,omega_Y tensor A tensor C) has dimension1, since A B and A C are nontrivial degree-zero lines. Their induced eigenforms on S have total trace zero. The character trivializations are nowhere zero, so vanishing at G implies vanishing at P=qG of the corresponding Y-form. Hence there are effective points Q_B,Q_C with
\[
O_Y(Q_B)=omega_Y\otimes A\otimes B(-P),\qquad
O_Y(Q_C)=omega_Y\otimes A\otimes C(-P).
\]
They are distinct and O_Y(Q_B-Q_C)=B C^-1 has order2. A rational function with divisor2Q_B-2Q_C is a degree-two map. Uniqueness of the hyperelliptic pencil in genus2 implies both points are Weierstrass and O_Y(2Q_B)=omega_Y. Squaring the first identity yields
\[
O_Y(2P)=omega_Y\otimes A^2\otimes B^2.
\]
Raising to the eighth power, B^16 is trivial and A^16=A, so
\[
O_Y(16P)=omega_Y^8\otimes A.
\]
Comparison with the actual norm identity forces Nm_q(M)=A, contradicting prime-to5 order on the left and exact order5 on the right. Every group of order8 has an abelian quotient of order at least4, so the Galois consequence follows.

The generalized two-character assertion uses exactly this last paragraph whenever the specified summands and trace-zero eigenforms are available.

## Transfer to the original primitive quotient

The [universal character normal form](../../Theorems/cartier_and_spin/actual_two_map_twisted_cartier_characters.md) gives dchi=qeta+chi*qbeta and dlog ell=-qbeta on the original T. Its field S=k(Y)(chi) is an intermediate field of the ORIGINAL etale second leg, so T->S->Y remains finite etale. If m=1, chi has degree5 on S with pole divisor5G for one point G, and deg(S/Y)=8.

The [square-root calibration](../../Theorems/cartier_and_spin/actual_character_square_root_trace.md) defines L by the horizontal ratio -2s(chi+b)/a in the pulled-back complement frame. It therefore descends to this S, with class q^*A^4(-G) and exact quotient contact G. Its square pulls back to the ORIGINAL embedded h^*lambda_X. Equivalently the explicit primitive psi=chi^3/ell^2 on S satisfies dpsi=(chi^2/2ell^2)qeta; the original primitive differs from psi by a fifth-power factor, so the embedded saturated line agrees after etale pullback. Thus this actual sector satisfies the hypotheses proved above.

All statements concern the same original h,q on T and their actual intermediate quotient. No abstract isomorphism of line classes replaces an embedded-line equality. The original problem remains open outside this scoped sector.

## Verification

One [independent focused review](../../Research/audits/RECIPROCAL_PRIMITIVE_ABELIAN_GATE_AUDIT_2026_10_02.md) passed the extension-class orientation, nonzero evaluation distinction, character summands through an upper degree-two map, hyperelliptic step and exact norm exponent. No programs or certificates were required. The exploratory [branch note](../../Research/experiments/oct02_reciprocal_primitive_degree_eight_abelian_gate.md) preserves an unnecessary alternative and the corrected even-theta shortcut; neither is used here.
