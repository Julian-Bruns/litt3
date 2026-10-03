# Proof: a fourth-torsion annihilator contradicts cyclic-cover ordinarity

Version1,3 October2026. Whole-scope review PASS; see the [exact statement](../../Theorems/cartier_and_spin/canonical_ten_rank_three_ramified_zero_quotient_exclusion.md). This proof uses no computation and retains both original actual maps upstairs on T. [Root whole-scope audit](../../Research/audits/CANONICAL_TEN_RANK_THREE_RAMIFIED_ROWS_AUDIT_2026_10_03.md).

## Local row data and the single exceptional source point

The first section of the [nonzero-quotient proof](canonical_ten_rank_three_ramified_nonzero_quotient_exclusion.md) does not use ℓ(q1)≠ZERO. It supplies the same local rank-TWO K-image at S, omitting the intrinsic fourth exact-jet line F₄. The saturation E=Sat_B K has degreeTWO and E/K has exactly lengthONE at S, nowhere else. Its annihilator A has degreeZERO and E=A^⊥, so detE=ω_Y⊗A. The degree-TWO divisor W_E is exactly the zero divisor of the adjunction F_Y*A→ω_Y. At a point outside S where that adjunction is nonzero, E's rank-THREE fiber image omits F₄.

Now W=kerℓ=span(q0,q1). Its saturation in the original B_X gains THREE at infinity, since the two independent primitive orders ELEVEN,EIGHT reduce to ONE,THREE after dividing by their two and one Frobenius-target uniformizer powers. The [complete all-geometric plane bound](first_section_contact_strictness.md) limits its degree toFOUR. At mostONE finite cubic branch of X can therefore have deficient W-image, meaning rank at mostONE. Its pullback under any retained degree-d original X-leg gives at most d such exceptional source points in total.

At a finite cubic source branch I has rank-TWO fiber image containing F₄. If it maps to S and W has rankTWO there, W-image equals I-image and cannot fit into K's rank-TWO image omitting F₄. Thus only exceptional finite source branches can map to S.

Outside the determinant defect D_J, J=B. The fiber kernel of the actual constant map I→J is then precisely the deficient kernel of I→B; the constant quotient row ℓ annihilates it. Hence every finite cubic source branch outside D_J is exceptional. Consequently at least NINE d of the TEN d actual finite cubic source branches lie over D_J away from S.

## The other two defect points are forced adjoint zeros

The K-rank loss already puts S in D_J. The total degree of D_J isTHREE. If its support away from S consisted of at mostONE point, at most EIGHT d source points could lie there, less than NINE d. Therefore
\[
D_J=S+Z_1+Z_2
\]
with all THREE points distinct and reduced.

At Z₁ and Z₂ the bundle K is saturated and equals E integrally; its fiber has rankTHREE. Because J has a simple determinant loss there and contains K, its fiber image equals that same rank-THREE E-image. If the adjoint evaluation of A were nonzero at either Z_i, that E-image would omit F₄, forbidding ALL finite cubic source branches at that point. Only one remaining q-fiber could then hold the NINE d nonexceptional finite source branches, again impossible. Both Z_i are therefore adjoint zeros of A. Since their total degree isTWO, they exhaust W_E:
\[
F_Y^*A\simeq\omega_Y(-Z_1-Z_2).
\tag{1}
\]

## The determinant gives fourth torsion, not merely an unspecified line

The actual quotient J/K=O_Y gives detJ=detK. Its computed determinant defect and the ONE-unit saturation at S give
\[
\det E=\det K(S)=\det J(S)=\omega_Y^2(-Z_1-Z_2).
\]
Since detE=ω_Y⊗A, this yields
\[
A\simeq\omega_Y(-Z_1-Z_2).
\tag{2}
\]
With the usual Frobenius identification of these Cartier line conventions, (1)–(2) say A⁵=A, hence A⁴=O_Y. The line A cannot be trivial, because it injects into B_Y and the selected Y is ordinary, so H0(Y,B_Y)=ZERO. Its exact order is therefore TWO orFOUR.

Take the connected cyclic finite étale cover Y′→Y attached to this prime-to-FIVE torsion line. It trivializes A. Étale base change of the Cartier bundle turns its original nonzero inclusion A→B_Y into
\[
O_{Y'}\hookrightarrow B_{Y'}.
\]
Hence H0(Y′,B_{Y′}) is nonzero, and Y′ is not ordinary. This contradicts the [stipulated selected cyclic-cover ordinarity](../../../Theorems/jacobians/ordinary_covers/selected_cyclic_two_four_ordinarity.md).

This auxiliary cover is used only to test ordinarity; it is not substituted for the common source or asserted to carry the original X-map. The argument closes this zero-q1 ramified-row branch. Together with the complementary nonzero-q1 proof, it leaves only the étale normalized row, with the scalar-line descent and common-cover questions still unresolved.
