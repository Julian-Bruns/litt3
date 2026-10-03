# Proof: a seven-degree Wronskian cuts the actual row ramification

Version2,3 October2026. The canonical-target genus and product delta bound are corrected; scope unchanged. Whole-scope review PASS. See the [exact statement](../../Theorems/cartier_and_spin/canonical_ten_rank_three_adjoint_row_ramification_reduction.md). No computation is used, and both original endpoint maps remain upstairs on T throughout. [Root whole-scope audit](../../Research/audits/CANONICAL_TEN_RANK_THREE_RAMIFIED_ROWS_AUDIT_2026_10_03.md).

## The genuine quotient retains a presentation, not a splitting

Use the accepted original module V and its integral evaluation V⊗L²→q*K. Its Frobenius adjunction is the injective complete row V^[5]→H0(T,L⁶). The accepted row argument gives no base point and the embedded joint field with the primitive degree-TEN carrier. Put H=ker(G→PGL(V)), R=G/H and N=|R|. The coefficient image has no nontrivial prime-to-FIVE quotient, since G has none.

On H the coefficient action is scalar. Absorb that scalar into the paired L² action. The resulting action on L² is genuine: the genuine native action on q*K and its surjective presentation force the scalar composition defects to be ONE. H is free on T, so this line descends to an actual line P on C^(1), where C=T/H. The integral presentation descends to
\[
P\otimes V\twoheadrightarrow q_C^*K.
\tag{1}
\]
Its rank is THREE, whereas dimV≥EIGHT. Equality of these bundles is neither asserted nor used. The adjoint row consists of sections of A=ω_C⊗(F_C*P)⁻¹ and pulls back to the original row on T. Thus
\[
g(C)-1=N,\qquad\deg P=N/4,\qquad\deg A=3N/4.
\tag{2}
\]
The row remains basepoint free and its constant sections independent. Its finite projective R-action is faithful on D: an element fixing the nondegenerate irreducible row curve pointwise would force that curve into one proper eigenspace unless the element were scalar.

The accepted kernel quotient gives the actual canonical target Γ_R, a degree-TEN C→Γ_R with different q_C*P₀ and C=Γ_R D as EMBEDDED fields. Hurwitz gives 2N=20(g(Γ_R)−ONE)+N, hence g(Γ_R)−ONE=N/TWENTY. No X-map on C is supplied by this quotient.

## The nonzero rank-three Wronskian on the original Y

Frobenius adjunction gives the actual evaluation F_Y*K→ω_Y. In a separating parameter t, horizontal evaluation coefficients lie over k(Y)^5 in the FOUR-dimensional space spanned by ONE,t,t²,t³. Its rank is THREE because K→B_Y is generically injective and the complete positive presentation generates K.

The zero-through-second Wronskian induces an injective map on the third exterior power of this FOUR-dimensional space. On its four standard wedges, its values in characteristicFIVE are
\[
\operatorname{Wr}(1,t,t^2)=2,\quad
\operatorname{Wr}(1,t,t^3)=t,\quad
\operatorname{Wr}(1,t^2,t^3)=t^2,\quad
\operatorname{Wr}(t,t^2,t^3)=2t^3.
\]
They are independent over k(Y)^5. Hence the determinant Wronskian of THREE horizontal generators is nonzero. Changing a K-frame changes it by the FIFTH power of that determinant, since derivatives kill the frame coefficients; changing a parameter supplies the canonical jet factor. It defines a regular nonzero section of
\[
\omega_Y^6\otimes(F_Y^*\det K)^{-1}.
\]
Its zero divisor W_K therefore has degreeTWELVE−FIVE=SEVEN. Étale pullback gives the same divisor on C, namely q_C*W_K.

Locally write the row sections of A in a horizontal P-frame. Equation(1), after Frobenius pullback, expresses them as combinations of a THREE-element horizontal K-frame with coefficients that are FIFTH powers. Thus every THREE-row Wronskian minor factors as the same K-Wronskian times a THREE-minor of the Frobenius-pulled presentation. These Plücker minors have no simultaneous zero because (1) is an integral surjection. The COMMON divisor of all second-Wronskian minors is consequently EXACTLY q_C*W_K. In particular each local common order is at mostSEVEN. This argument does not require a complete linear series, an embedding into projective space, or saturation of K in B_Y.

The row is separating. Otherwise all ratios of its coordinate sections would be FIFTH powers in k(C), and all of their differential evaluations in the locally exact bundle would span ONE dimension over k(C)^5. That contradicts their actual rankTHREE. Equivalently the nonzero second-Wronskian already rules out such a ratio dependence.

## The row normalization has positive genus

If D is rational, the action of R on D has a two-dimensional projective lift with cocycle of order at mostTWO, by determinants. Its action on O_D(ℓ), and hence on the invariant complete row subspace V^[5], also has multiplier of order at mostTWO. Pullback to G contradicts the retained coefficient multiplier of orderFOUR orEIGHT. This requires no irreducibility of V.

If D is elliptic, its finite faithful group R has an abelian translation subgroup and cyclic linear quotient of order ONE,TWO,THREE,FOUR orSIX. The latter is prime toFIVE, so the absence of prime-to-FIVE quotients forces it to be trivial. R is therefore abelian; that same absence forces it to be a FIVE-group. But a finite FIVE-group has no nontrivial scalar projective obstruction with coefficients k×: its group cohomology is annihilated by a FIVE-power whereas that power map on k× is an automorphism. This contradicts the retained multiplier pulled from R to G. Thus
\[
g(D)\ge2.
\tag{3}
\]

## Exact jet chain rule and the sole possible orbit

Let c∈C lie over z∈D under ρ, with local index j and different δ. Let w_z be the common zero-through-second row Wronskian order at z. It is finite and nonnegative because the row is separating and these minors are regular. The jet chain matrix has diagonal ONE,ρ′,(ρ′)². Its determinant is (ρ′)³, so taking the common order of every THREE-minor gives
\[
\operatorname{ord}_c(q_C^*W_K)=j w_z+3\delta.
\tag{4}
\]
The row line is literally pulled from O_D(1); there is no extra fixed divisor. Formula(4) is valid for a separating wild local map as well, where ordρ′ is its different. It gives δ≤TWO. Every ramification is therefore tame of indexTWO orTHREE.

The actual R-action on C is free. Ramification points occur in complete R-orbits of N points. An indexTHREE orbit contributes TWO N to the different, whereas Hurwitz and (3) give
\[
\deg\operatorname{Diff}_\rho=2N-e(2g(D)-2)<2N.
\]
IndexTHREE is impossible. At mostONE indexTWO orbit can remain. If none remains ρ is étale. If one remains, it is exactly q_C⁎S for ONE Y-point, with all its N points simple tame ramification and no other ramification. Hurwitz then gives
\[
e(2g(D)-2)=N.
\tag{5}
\]

## Elementary genus bounds from the actual row

Put n=g(D)−ONE and M=O_D(1). Its basepoint-free row has dimV≥EIGHT and is birational onto its specified image. In the étale alternative, en=N and degM=3n/FOUR. This is a special line by Riemann–Roch; Clifford gives EIGHT≤3n/EIGHT+ONE. Integrality gives FOUR|n, hence n≥TWENTY and g(D)≥TWENTY ONE.

In the ramified alternative, (5) gives degM=3n/TWO and TWO|n. If n≤TEN, h0(M)≥EIGHT and Riemann–Roch make M special. Clifford excludes n=TWO,FOUR,SIX,EIGHT. For n=TEN, g(D)=ELEVEN, degM=FIFTEEN, h0(M)=EIGHT, and the residual line E=ω_D M⁻¹ has degreeFIVE and h0(E)=THREE.

Remove E's fixed divisor. Its nondegenerate plane map has degree at mostFIVE. If birational, the plane genus bound gives genus at mostSIX, contradictory. Otherwise its image is a conic and its covering degree is TWO, so D is hyperelliptic. Write H for its hyperelliptic degree-TWO pencil. Necessarily E=2H+Z for ONE point Z, while ω_D=10H. Thus M=8H−Z. Every section of 8H comes from the rational hyperelliptic quotient; vanishing at Z also vanishes at its conjugate. Subtracting Z therefore leaves a base point (at Z itself in the Weierstrass case). This contradicts the basepoint-free original row. Hence n≥TWELVE, giving g(D)≥THIRTEEN and e=N/(2n)≤N/TWENTY FOUR.

## The possible row branch point cannot equal the canonical one

Suppose the ramified-row point S were P₀. The retained joint field C=Γ_R D makes the map C→Γ_R×D birational onto its integral image. At each of the N points over P₀ both projections have ramification indexTWO. Each corresponding normalized image branch has no order-ONE local coordinate and is singular, contributing at leastONE to its delta invariant. The total delta is at leastN, even if several branches meet at the same image point.

The product arithmetic-genus bound (or the intersection proof of Castelnuovo–Severi) gives
\[
p_a(\mathrm{image})\le1+10(g(\Gamma_R)-1)+e(g(D)-1)+10e
=1+N+10e.
\]
Subtracting g(C)=N+ONE bounds total delta by TEN e. Thus N≤TEN e, so e≥N/TEN. This contradicts e≤N/TWENTY FOUR. Hence S≠P₀.

The proof establishes only these actual row alternatives. It neither descends K's connection to D nor identifies a finite rankTHREE constant module. The étale case and the distinct-branch tame double case still require a new source-compatible argument.
