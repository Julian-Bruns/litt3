# Proof: determinant transport sees the target tangent sign

Version1,3 October2026. Whole scoped argument PASS by [focused root review](../../Research/audits/CANONICAL_TEN_TAME_COEFFICIENT_GATE_AUDIT_2026_10_03.md); see the [actual-source statement](../../Theorems/cartier_and_spin/canonical_ten_tame_coefficient_involution_gate.md). No computation, source replacement or simultaneous Galois closure is used.

Choose a linear coefficient lift A_g∈SL₄(k) of the projective image of g. The ORIGINAL full trace has a genuine G-action, since it is q*J_Y. Its splitting L²⊗V4 determines a corresponding line lift B_g on L², normalized so that
\[
B_g\otimes A_g=\text{the native action on }q^*J_Y.
\]
Since g²=ONE on T, there is a scalar c with A_g²=cI and B_g²=c⁻¹ on L². This holds also if the coefficient image were projectively trivial. Taking determinants of the displayed splitting and using detA_g=ONE gives
\[
B_g^4=\text{the native action on }q^*\det J_Y.
\]

The line M² on Γ is G-invariant in class and pulls back to L². Choose its g-isomorphism and rescale it so that pullback agrees exactly with B_g; the comparison is a global scalar on connected projective T. Pullback detects all the resulting identities. Thus this line lift still has square c⁻¹, and its fourth power is the transported action on M⁸. The accepted genuinely linearized identity M⁸=ωΓ identifies that fourth power with the NATIVE canonical action.

At the chosen tame fixed point of Γ, g has tangent derivative−ONE, because it is a nonidentity tame involution. The cotangent fiber of ωΓ therefore has character−ONE as well. If b is the fiber scalar of the chosen lift on M², the two equalities give
\[
b^2=c^{-1},\qquad b^4=-1,\qquad c^2=-1.
\]
This uses a fixed point on the ACTUAL target Γ. The action on the original étale source T is free, and no source fixed point is being inferred.

Write the eigenvalues of A_g as λ and−λ, with λ²=c and multiplicities n and4−n. The operator is semisimple since the characteristic is FIVE and its square is a scalar. Its determinant is
\[
1=\det A_g=\lambda^4(-1)^{4-n}=c^2(-1)^n=-(-1)^n.
\]
Hence n is odd. The only possibilities are ONE andTHREE. In particular n=ZERO orFOUR is impossible, so the projective image is nontrivial, and n=TWO is impossible.

For the sufficient finite-field condition, suppose a nontrivial projective involution admits a lift A∈SL₄(F₅). Then A²=cI with c∈F₅*. If c is a square, its eigenvalues ±λ lie in F₅ and λ⁴=ONE, so detA=ONE forces both eigenspace dimensions to be even. Nontriviality gives TWO-plus-TWO. If c is a nonsquare, Frobenius exchanges the two eigenvalues, forcing dimensions TWO-plus-TWO again; but then detA=c²=−ONE, a contradiction. Thus every such nontrivial involution has the balanced pattern. The already proved actual tame gate excludes an entire group satisfying this condition.

No equality of the ORIGINAL spin multiplier with the coefficient multiplier was presumed. The argument uses the correct second-power line L² and its fourth-power determinant transport. It therefore avoids the noncentral sign-character origin obstruction and does not need a common sixteen-spin packet on any coefficient quotient.
