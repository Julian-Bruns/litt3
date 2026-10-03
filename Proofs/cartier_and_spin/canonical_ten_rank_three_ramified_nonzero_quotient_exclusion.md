# Proof: the original cubic branches and determinant kill the scalar annihilator

Version2,3 October2026. Whole-scope review PASS; see the [exact statement](../../Theorems/cartier_and_spin/canonical_ten_rank_three_ramified_nonzero_quotient_exclusion.md). The newly used determinant equality turns the former fifth-torsion marking into a contradiction. All counts take place on the ORIGINAL common source T, with original conjugates h_i:T→X of degree d and q:T→Y of degree EIGHT d. [Root whole-scope audit](../../Research/audits/CANONICAL_TEN_RANK_THREE_RAMIFIED_ROWS_AUDIT_2026_10_03.md).

## The row branch loses one Cartier direction

The [row reduction](canonical_ten_rank_three_adjoint_row_ramification_reduction.md) gives local row indexTWO, differentONE, and common second-Wronskian order at mostSEVEN. Its chain formula is 2w+THREE≤SEVEN, where w is the common target Wronskian order. The target first three vanishing orders have total weight at mostTWO; a zero leading Wronskian coefficient could only increase the weight. Hence the candidate triples are (0,1,2),(0,1,3),(0,1,4),(0,2,3).

In a horizontal P-frame every source differential coefficient is locally exact, so it cannot have leading order congruent to FOUR moduloFIVE. Pullback doubles the row vanishing orders. This rules out both triples containing TWO. The remaining target triples are (0,1,3) or (0,1,4), giving source triples (0,2,6) or (0,2,8). Their second-Wronskians have orders FIVE orSEVEN respectively. A fourth independent jet coordinate cannot raise the actual fiber rank aboveTWO: a source coordinate with leading orderFOUR is forbidden, and a target coordinate of order belowTHREE would contradict the listed first three orders. Thus K's fiber image in B_Y at S has rankTWO, with first two jet orders ZERO andTWO; it omits the intrinsic highest exact-jet line F₄.

Every saturated rankTHREE Cartier subbundle on Y has degree at mostTWO, by the accepted annihilator-line bound in the [higher-trace inventory](../../Research/reports/HIGHER_POSITIVE_TRACE_AND_SCOTT_BRIDGE_2026_10_03.md). Since degK=ONE, this fiber rank loss forces its saturation E to have degreeTWO, and E/K to have lengthONE precisely at S. Write E=A^⊥ for the canonical alternating pairing B_Y⊗B_Y→ω_Y. Then degA=ZERO and detE=ω_Y⊗A.

The same rank-three Wronskian construction gives
\[
W_K=5S+W_E,\qquad \deg W_E=2.
\tag{1}
\]
Under the alternating pairing, the third exterior Wronskian is the Frobenius adjunction of the annihilator line: detE=ω_Y⊗A gives its line ω_Y⊗(F_Y*A)⁻¹. In the horizontal exact basis ONE,t,t²,t³ this follows directly by comparing the four third-Wronskian minors with the alternating dual basis. Thus W_E is exactly the zero divisor of the adjoint evaluation F_Y*A→ω_Y. At a point where this evaluation is nonzero, E's fiber omits F₄: pairing with F₄ extracts the zeroth evaluation coefficient of A. These are intrinsic statements by the [horizontal third-jet isomorphism](contact_eight_cartier_third_jet_flag.md).

## The constant plane allows at most two finite cubic exceptions

The constant original kernel plane W=kerℓ is contained integrally in every q*K. Because ℓ(q1)≠ZERO and ℓ(q0)=ZERO, its second generator has nonzero q2 coefficient. At infinity its original saturation gains at leastTWO, from the order-TWO B-zero of q0 and the nonvanishing q2 direction. The [all-geometric plane bound](first_section_contact_strictness.md) limits its saturation degree on X toFOUR. Thus at mostTWO finite cubic branch points can have W-image of rank at mostONE in B_X: every such point contributes at leastONE further unit to the determinant gain.

At a finite cubic source branch the original I-image has rankTWO and contains F₄, by the actual primitive orders (ONE,FOUR,SEVEN) and the [intrinsic branch-fiber proof](branch_fiber_uniform_contact_gap.md). If such a source point maps to S and W had rankTWO there, W's image would equal I's image and contain F₄. But W lies in the rank-TWO K-image at S, which omits F₄. Therefore all finite cubic source branches over S belong to at mostTWO fixed X-points. On the actual degree-d étale X-leg their number is at mostTWO d.

## The row branch is not wild

Since q1 is nonzero in the constant quotient J/K but its B-image vanishes at EVERY actual infinity point, every original infinity divisor lies over D_J. The [full-carrier-fiber support argument](canonical_ten_nonisotropic_trace_defect_support.md) uses only this inclusion, degD_J=THREE and the actual coarse ledger. It therefore applies here: every infinity divisor is over R_++R_-, with d/TWO points above each. In particular D_J contains both wild points.

Suppose S were one of these points. K has a nonzero kernel in B there, and the original q1 vector contributes an independent J-kernel vector because its quotient value is nonzero. Hence J's fiber image has rank at mostTWO. Any point of the actual q-fiber must then map, under a retained original X-leg, either to a finite cubic branch or to infinity: at every other X-point the original I-image has rankTHREE and could not fit in that target fiber.

The finite cubic points over S number at mostTWO d, and the infinity points over that wild point number d/TWO. This cannot fill the EIGHT d points of the actual étale q-fiber. Therefore S is different from both wild points. Its K-rank loss supplies at leastONE unit of D_J at S; the already marked TWO wild points exhaust the other TWO units. Thus D_J=R_++R_-+S, all reduced. At each wild point E=K and their rankTHREE fiber image equals J's image.

## Both wild points must be adjoint zeros

A finite cubic source branch outside D_J necessarily has its deficient original kernel in W: there J=B, so the constant map I→J has the SAME kernel in the fiber as I→B, and its nonzero constant quotient row annihilates that kernel. Consequently every NONEXCEPTIONAL finite source branch, meaning one whose deficient kernel is not in W, is supported over D_J. Exceptional branches, whose deficient kernel is in W, can occur elsewhere and must remain in the count.

To avoid discarding those exceptions, count them explicitly: at mostTWO fixed finite X-points have deficient W-image, hence at mostTWO d source branches can be exceptions ANYWHERE. At S only such exceptions are possible, as proved above. At a wild point where the adjoint of A is nonzero, J=E omits F₄ and no finite cubic source branch can occur at all. The remaining possible points outside D_J are also only the same at mostTWO d exceptions.

If the adjoint of A were nonzero at either wild point, only ONE wild q-fiber could contain any nonexceptional finite source branches. That fiber has EIGHT d points, of which d/TWO are infinity points, so it contains at most FIFTEEN d/TWO finite cubic source branches. Adding ALL exceptional branches, wherever they occur, contributes at mostTWO d. The resulting maximum NINETEEN d/TWO is less than the actual TEN d finite cubic source branches. This contradiction forces the adjoint to vanish at BOTH R_+ and R_-.

Its total zero degree isTWO, so W_E=R_++R_-. These two points are hyperelliptic conjugates and their divisor is canonical. Equation(1) gives W_K=5S+R_++R_-. Its order at S isFIVE, selecting target vanishing triple (0,1,3).

Finally use the actual quotient J/K=O_Y: detK=detJ. The reduced determinant defect computed above gives
\[
\det J=\omega_Y^2(-R_+-R_--S)=\omega_Y(-S).
\]
Since E/K has precisely lengthONE at S, detE=detK(S)=ω_Y. But E=A^⊥ gives detE=ω_Y⊗A. Therefore A=O_Y. Its nonzero inclusion into B_Y contradicts H0(Y,B_Y)=ZERO on the ordinary selected endpoint. This excludes the entire stated ramified-row branch, without needing an étale trivialization of any fifth-torsion line.

No original X-map on C or D, scalar P descent, or extra target atlas is inferred. The étale row alternative and the ramified branch ℓ(q1)=ZERO require further arguments.
