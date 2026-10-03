# Proof: target osculation and the original native saturation budgets

Version1, 3 October2026. [Fresh independent static audit PASS](../../Research/audits/OCT03_GRAM_FOUR_OSCULATION_AND_GLOBAL_CHARTS_AUDIT_2026_10_03.md), including the five osculation checks and the separate all-strata support argument. See the [statement](../../Theorems/cartier_and_spin/canonical_ten_constant_jet_osculation_constraints.md). No numerical calculation was run or replayed for this argument.

## Local rank and the target first plane

Use the statement's SAME actual fold image C and evaluation r. The coefficients of rC=0 at orders two, three and four give
\[
r_0v_2=r_1v_2=0,\qquad r_0v_4=-r_2v_2=0.
\]
The order-four coefficient of the intrinsic first jet −r dC is −2r₃v₂−4r₁v₄. It vanishes because that jet has order five. The order-five coefficient of rC then gives
\[
r_1v_4=2r_3v_2\ne0,\qquad r_0v_5=2r_3v_2\ne0.
\]
The nonvanishing follows since the independent rows r₀,r₁,r₃ cannot all kill v₂≠0. Applying r₀ and then r₁ to a dependence proves that v₂,v₄,v₅ are independent.

A regular local generator of B₀ is u=ζ⁻²C=v₂+ζ²v₄+ζ³v₅+⋯. Its derivative modulo B₀ has leading 2ζv₄, hence has zero order exactly one at P. Globally all zeros of this first fundamental form lie in the intrinsic jet divisor 3P: composing with the regular evaluation cannot remove a zero. Therefore the fundamental zero divisor is exactly P. Saturating its image gives
\[
S_2/B_0=B_0\omega_Y^{-1}(P)=O_Y,
\qquad0\to O_Y(P)\to S_2\to O_Y\to0.
\]
Evaluation on this quotient is a nonzero multiple of η, because the original constant jet is a nonzero multiple of η².

The nonsplitting has a separate gap argument. Let v be the canonical rational image of 1 in B₀, distinguished from the regular local generator u. It has order one at P and is nowhere zero off P, since its ψ² coefficient is a nonzero constant. The rational quotient lift −(1/2)∇_{η⁻¹}v is regular off P. At P its leading term is a nonzero pole-two term along u. Correcting it by fv requires f to be regular off P and have pole exactly three at P, since v itself has order one. The Weierstrass gap L(3P)=⟨1,x⟩ forbids this. Thus the extension is nonsplit. Riemann–Roch gives h¹(O(P))=1, so all nonzero classes become equivalent upon rescaling the endpoint lines; they are not a single class with both endpoint maps fixed.

## The native first-plane determinant

The original line after tensoring by the flat scalar M¹⁰ is
B₁Γ=ℛM¹⁰=ωΓ⁻¹. The [exact first-fold comparison](canonical_ten_gram_four_exact_first_fold_coefficients.md) and [positive-source calibration](actual_positive_source_relative_scalar_calibration.md) keep its connection and coefficient phases. Tensoring the entire osculating flag by this flat line introduces no derivative correction and does not assume M⁸=ωΓ.

With first fundamental zero divisor D₁Γ, the saturated plane has
\[
B_{2\Gamma}/B_{1\Gamma}=\omega_\Gamma^{-2}(D_{1\Gamma}),
\qquad\det B_{2\Gamma}=\omega_\Gamma^{-3}(D_{1\Gamma}).
\]
The [oper-line theorem, Version2](../../Theorems/cartier_and_spin/canonical_ten_perfect_four_nonhorizontal_oper_line.md) already proves D₁Γ=0 by the actual full-fiber support argument in all p strata. For the present constant branch there is also an independent determinant check, which explains why the fold count is legitimate.

Since deg M=(1/8)deg ωΓ, the determinant injection into ∧²(W₈M¹⁰), a sum of copies of M²⁰, gives
\[
\deg D_{1\Gamma}\le\tfrac{11}{2}\deg\omega_\Gamma=11N/20<N.
\]
The genuine paired action makes D₁Γ invariant. Thus it has no free orbit and specifically no fold orbit over the extra value A, where Γ/G is unramified. This excludes a saturation contribution there before counting the raw determinant.

In t=(f−A)/B=ζ²+O(ζ⁵), one has dt/dζ=2ζ(1+O(ζ⁵)). Horizontality sends the Γ derivative of C to v₂+2ζ²v₄+⋯. Its wedge with C has exact order four. The saturated target plane is q*S₂: their rational spans agree and q*S₂ is saturated in q*E. The determinant map has total defect
\[
\deg q^*\det S_2-\deg\phi^*\det B_{2\Gamma}
=4N-10\deg D_{1\Gamma}.
\]
The N folds contribute 4N already. Effectivity again forces D₁Γ=0, and the complete first-plane defect is exactly 4q*P.

## The global third Wronskian and raw triple

In a regular flat frame, the local determinant of u,∇∂ζu,∇∂ζ²u starts with
\[
(2-6)\zeta^2\det(v_2,v_4,v_5)
=\zeta^2\det(v_2,v_4,v_5).
\]
It is nonzero and has order exactly two at P. The regular global triple Wronskian belongs to det E⊗B₀⁻³⊗ωY³, whose degree is 5−3+6=8. Hence its divisor is 2P+D with deg D=6 and P outside its support.

The original domain q*O(−P) maps to q*B₀ with zero divisor 2q*P. Scaling all three columns therefore adds 6q*P. Replacing Y derivatives by Γ derivatives subtracts 3q*P, from derivative orders zero, one and two and the actual different. The retained flat M¹⁰ frame is essential to this chain rule. The raw source triple therefore has divisor exactly
\[
q^*(D+2P+6P-3P)=q^*(D+5P).
\]
This statement is about the raw triple before native saturation. It does not identify D pointwise with any other degree-six divisor merely from a line-class comparison.

## Second saturation, weak inertia and the tame alternative

The independent target vectors guarantee generic rank three. Since D₁Γ=0, the second incremental quotient is ωΓ⁻³(D₂Γ), and
\[
\det B_{3\Gamma}=\omega_\Gamma^{-6}(D_{2\Gamma}).
\]
The determinant injection into copies of M³⁰ bounds
\[
\deg D_{2\Gamma}\le(6+15/4)\deg\omega_\Gamma
=39N/40<N.
\]
Removing the native saturation from the raw triple gives φ*D₂Γ≤q*(D+5P). As a degree check, the saturated triple map into q*E has defect 11N−10deg D₂Γ. The invariant divisor has no free orbit by the strict bound, including no fold orbit.

There is no wild support either. Fix the weak coordinate σ(t)=t/(1+t). The original flat M¹⁰ multiplier is 1 modulo t⁵. In the retained semilinear convention the native ωΓ⁻¹ relation satisfies
\[
\sigma_Wc(\sigma t)=(1+t)^2c(t)\pmod {t^5}.
\]
Writing c=c₀+c₁t+c₂t²+⋯ and Δ=σ_W−1 gives
\[
\Delta c_0=0,\qquad\Delta c_1=2c_0,\qquad
\Delta c_2=3c_1+3c_0,\qquad\Delta^2c_2=c_0\ne0.
\]
These equations include the action on coefficients and cannot be replaced by a bare substitution in t. Applying Δ² and then Δ to a dependence proves c₀,c₁,c₂ independent. Since 2! is invertible, c,c′,c″ have independent fibers; the triple is saturated at every wild point. Another consistent transported convention may change the scalar equations but must preserve this independence consequence.

Only the single native tame orbit remains. Its φ-pullback is q* of the complete five-point reduced fiber w=−b over f=0; φ is unramified there. This is not the extra fold fiber over A. Since D has degree six, it can contain that five-point divisor once and cannot contain it twice. Thus D₂Γ is zero or exactly one reduced native tame orbit. In the latter case D is that fiber plus one residual point; div(w+b) identifies the fiber's line class with 5P. Neither alternative is ruled out by this proof.

The audit reviewed the original derivation in [the osculation note](../../Research/notes/oct03_ten_hour/gram_four_constant_osculation_lemma.md), its local/source inputs and all five checks. Its input hashes are recorded in the report; the present canonical records organize those same reviewed implications. The all-strata D₁Γ result is separate from the present saturated constant-jet plane and triple assertions. Both actual endpoint maps remain on their original SAME T throughout.
