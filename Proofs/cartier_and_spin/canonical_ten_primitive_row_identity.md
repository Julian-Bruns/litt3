# Proof: the two primitive maps have too many common critical branches

Version1. [Statement](../../Theorems/cartier_and_spin/canonical_ten_primitive_row_identity.md). PASS by [whole root review](../../Research/audits/CANONICAL_TEN_ROW_IDENTITY_AND_KERNEL_AUDIT_2026_10_03.md). Every quotient below is an actual quotient inside the original source; no original X descent is inferred.

## The actual coefficient quotient retains degree ten and its different

Write r=|R| and J=ker(G→R). The accepted [general quotient theorem](canonical_degree_ten_no_a5_quotient.md) says that J acts freely on the actual target Γ, because r>FIVE and this quotient retains both inertia types. Put Γ_R=Γ/J and C=T/J. The equivariant torsor square is cartesian and étale horizontally, so the descended actual map
\[
\phi_C:C\longrightarrow\Gamma_R
\]
has degree TEN, full S₁₀ monodromy, and different exactly q_C*P, with local index TWO at all its r points. The lower monodromy contains the already established S₁₀ monodromy of its base change, hence is itself S₁₀. The genera are
\[
g(C)=r+1,\qquad g(\Gamma_R)=r/20+1.
\]
These conclusions need no additional quarter-line descent on Γ_R.

Suppose the cyclic row bound leaves an étale double deck σ. It commutes with R, is free on C, and induces the hyperelliptic involution ι on Y. Since the distinguished P is Weierstrass, σ preserves q_C*P. Therefore both φ_C and φ_C∘σ have the SAME r distinct ramification points, all of index TWO.

## The two target fields cannot coincide

Let F=k(Γ_R) inside k(C). If σF=F, the restriction of σ commutes with R and normalizes its invariant field B=F^R=k(β). Its action on Y is ι, so ι normalizes the actual β-field. Note carefully that B is the degree-TEN field, not the hyperelliptic field k(Y)^ι.

Use the accepted [actual canonical-ten normal form](canonical_degree_ten_wild_spin_carrier_exclusion.md):
\[
y^2=z^5+c_4z^4+c_0,\qquad\beta=\frac{(y+b)^2}{z^5},\qquad
b^2=2c_0,\quad b,c_4,c_0\ne0.
\]
The β pole divisor is FIVE times the pair over z=ZERO; this pair is preserved by ι. Thus any induced Möbius map β↦u(β) fixes infinity and is affine. Comparing the nonzero y term in u(β)=ιβ forces slope −ONE. But
\[
\beta+\iota\beta=2+\frac{2c_4}{z}+\frac{c_0}{z^5}
\]
is not constant. Hence no affine map exists and σF≠F.

The full S₁₀ monodromy makes C/F primitive: its point stabilizer S₉ is maximal. The intermediate compositum FσF is therefore either F or all k(C). The first possibility would force σF=F because both have the same degree in k(C), already excluded. Thus the two actual target fields jointly generate k(C).

## A singularity correction to Castelnuovo–Severi

For completeness, let f_i:Z→Z_i be any two separating maps of degrees d_i jointly generating k(Z). Their joint image W in the smooth surface Z₁×Z₂ is an integral curve whose normalization is Z. The intersections with the two fiber classes are d₁,d₂. Write its numerical class as the corresponding fiber part plus a class orthogonal to both fibers. The Hodge index theorem, applied to the ample sum of the fibers, gives
\[
W^2\leq2d_1d_2.
\]
Adjunction on the smooth surface consequently bounds its arithmetic genus by
\[
p_a(W)\leq d_1g(Z_1)+d_2g(Z_2)+(d_1-1)(d_2-1).
\]
This is valid in characteristic FIVE and does not presume that the image is smooth.

If both maps ramify at a normalization point, both ambient local coordinate derivatives vanish there. That normalized branch cannot be a smooth embedded branch of W. Its branch delta invariant is therefore at least ONE. For a reduced curve in a smooth surface, the local delta is the sum of its branch deltas plus the nonnegative pairwise intersection contributions. Thus m distinct common ramification points contribute at least m to the TOTAL delta, even if several image points coincide. Since
\[
p_a(W)-g(Z)=\sum\delta_W,
\]
the reusable common-ramification inequality in the statement follows.

Apply it to the two degree-TEN maps from C. Their joint image has arithmetic genus at most
\[
20(r/20+1)+81=r+101.
\]
Its normalization has genus r+ONE, so its total delta is at most ONE HUNDRED. But the r distinct common ramification points contribute at least r. Hence r≤ONE HUNDRED.

The accepted [defining-linear classification](canonical_ten_defining_linear_coefficient_reduction.md) gives R=PSL₄(F_(25^a)), whose order is greater than ONE HUNDRED for every a≥ONE. This contradiction deletes the étale double deck. The normalized row is C itself. No argument here asserts that its projective image is smooth or separates distinct points; those are different questions.
