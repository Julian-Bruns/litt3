# Proof: original d-zero scalar-zero Cartier alternatives

Use the exact actual-source and relative-twist hypotheses of the [statement](../../Theorems/cartier_and_spin/canonical_ten_constant_dzero_scalar_zero_cartier_alternatives.md). The ordinary source and the original inherited connection are both retained throughout.

## The exact divisor frame and original differential equations

The canonical d-zero divisor theorem gives div_{F_Y*Q}(ξ′)=D−11P, Nm(D)=U=ξ′₀, and D=ιR for the affine adjunction divisor R. The full constant-source theorem gives D∈|6P|. Since L(6P)=⟨1,x,x²,x³,w⟩ and the pole order of h is exactly six, its x³ coefficient is nonzero. Scaling it to one gives h=F+rw as stated, including r=0. Thus
\[
\operatorname{div}_{F_Y^*Q}(s_Q)=-5P,
\qquad s_Q=\xi'/h,
\qquad U=F^2-r^2H.
\tag{1}
\]
The actual first primitive coefficient is j₀=ξ′₀/h=ιh=F−rw. No choice of the other norm sheet is permitted.

The inherited connection is regular. The polar multiplicity of s_Q is five, so its logarithmic derivative has no pole at P in characteristic five; at every affine point s_Q is a unit in its line. Consequently ∇s_Q/s_Q=(σ₀+σ₁x)η. Cartier extraction of (σ₀+σ₁x)H² gives
\[
\sigma_0^5=3B\sigma_0,\qquad
\sigma_1^5=2AB\sigma_0+B^2\sigma_1.
\tag{2}
\]
Both additive equations have nonzero linear term; there are five choices for σ₀ and five for σ₁ over each. In the SAME frame put
\[
P_\sigma=\delta-\sigma_0-\sigma_1x,
\qquad h_C=2B(Ax^5-1).
\]
The full infinitesimal algebra has canonical primitive ψ with ∇_δψ=−1+h_Cψ⁴. Its original primitive-coordinate equations are
\[
P_\sigma j_0=2j_1,\quad P_\sigma j_1=3j_2,
\quad P_\sigma j_2=4j_3,\quad P_\sigma j_3=-h_Cj_0.
\]
Eliminating j₁,j₂,j₃, including operator differentiation of σ, gives
\[
\boxed{(P_\sigma^4-h_C)(F-rw)=0,}
\tag{3}
\]
because−24=1. This equation requires no ordinary lift.

The original first-coordinate equation, in this same normalization, is
\[
\xi'_{1,e}=3\big[r(HF'-2Bx^3F)-\sigma U\big],
\qquad\sigma=\sigma_0+\sigma_1x.
\tag{4}
\]
Its odd coordinate is four times the derivative of the norm identity. The audited norm/Cartier model supplies, with z=r+t,
\[
\sigma_1=3Az,
\qquad
z\big[(A^3/B)z^4+Az^2+2Azt-vt\big]=0.
\tag{5}
\]
On z≠0 this fixes v=t⁻¹[(A³/B)z⁴+Az²]+2Az. The zero stratum is retained.

For later coefficient comparisons the saved normalized signed-minor formula gives
\[
U_5=3vt-At^2,\quad U_4=3v^2t^2+3a_0t+2Bt^2,
\quad U_3=vt^3(v^2+a_0u-B),
\]
\[
U_2=3a_0v^2t^3+(3a_0^2-b_0)t^2,
\quad U_1=v(3a_0^2-b_0)t^3,
\quad U_0=a_0(a_0^2-b_0)t^3+t^2.
\tag{6}
\]
The coefficients U_i mean [x^i]U, with U monic of degree six.

## Effective and ineffective ordinary lifts

The degree-one inverse line is effective exactly for σ=(0,0) or σ₀=0,σ₁²=−B. Here is the short exact calculation, preserving descended effectivity. A descended section corresponds to f∈L(5P)=⟨1,x,x²,w⟩ with P_σf=0. Write f=v₀+v₁x+v₂x²+v₃w. Its odd and even coefficients give
\[
v_1=\sigma_0v_3,\quad v_2=3\sigma_1v_3,
\quad\sigma_0v_0=0,\quad
\sigma_1v_0+\sigma_0^2v_3=0,
\]
\[
\sigma_0\sigma_1v_3=0,
\qquad(2B-3\sigma_1^2)v_3=0.
\]
If v₃=0, a nonzero solution is constant and forces σ=0. Otherwise σ₀=0,σ₁²=−B and f=w+3σ₁x² after scaling. These are precisely the two nontrivial effective classes. The exact sparse-effectivity review also identifies their points, so the relative-twist interpretation is fixed. In every other class h⁰(Q⁻¹)=h¹(Q⁻¹)=0 by degree-one genus-two Riemann–Roch.

For an ineffective class, applying Hom(Q,−) to 0→O_{Y₁}→F_{Y*}O_Y→B_Y→0 gives a unique ordinary lift of the ORIGINAL inclusion. Its adjunction coefficient g∈L(5P) satisfies
\[
\boxed{P_\sigma g=F-rw.}
\tag{7}
\]
The sign is fixed by the constant−1 in ∇ψ. With D_σ=2B−3σ₁², comparison gives g₃=1/D_σ,g₂=3σ₁/D_σ,g₁=σ₀/D_σ−r. In particular at σ₀=0,σ₁²=B it forces c₂=σ₁r,c₀=0. The denominator is−B, a unit. Equation(7) is not used for the two effective nonlifting classes.

## Exclusion of the two effective nonzero classes

At σ₀=0, equation(2) gives σ₁⁵=B²σ₁. Its four nonzero roots split into two roots each of e²=−B and e²=B. First take e²=−B and put f=w+3ex², P_e=δ−ex, C=Ax⁵−1 and R_e=P_e⁴−h_C. Hand differentiation gives
\[
R_e1=R_ex=0,\quad R_ex^2=-2eCf,
\quad R_ex^3=eBx^5f,
\quad R_ew=eR_ex^2.
\tag{8}
\]
For explicit intermediate checks, P_e²1=−ew−Bx², P_e³1=−eBx³+2Bxw, P_e⁴1=h_C, P_e³x=2eC, and P_e²x²=2C. Also
\[
P_e^4x^3=2ABx^8+2B^2x^7-2Bx^3+eBx^5w.
\]
The last formula in(8) follows from P_ex=w−ex² and P_e⁵=h_CP_e, the zero-p-curvature identity of this SAME line, with δh_C=0. Thus
\[
R_e(F-rw)=ef\big[Bx^5-2(c_2-er)(Ax^5-1)\big].
\]
Equation(3), cancellation of the nonzero e,f, and the constant coefficient force c₂=er. The remaining x⁵ coefficient would force B=0. This excludes both sign choices without assuming a lift.

## Exclusion of the two ineffective scalar-zero classes

Now e²=B. Effectivity fails, so(7) gives c₂=er,c₀=0. Equation(5) has z=2e/A and z²=−B/A²; hence v=−e and r=z−t. In(6), the x⁴ norm equation gives c₁=−a₀t. The x³, x and x² equations respectively give
\[
a_0(2r-t)=0,\qquad b_0=3a_0^2,
\qquad a_0(a_0-3Bt)=0.
\tag{9}
\]
All cancellations use the established units e,t,v.

If a₀≠0, then t=−z,r=2z,a₀=3Bt. The constant norm equation becomes 4z²=z²+B³z⁶, so B³z⁴=3 and B⁵=3A⁴. The fixed endpoint satisfies
\[
A^4=-\alpha,\quad B^5=\alpha^2-\alpha+1,
\quad B^5-3A^4=(\alpha+1)^2\ne0.
\]
Thus this stratum is impossible. If a₀=0, then b₀=0 and r²=t². The alternative r=−t would give z=0, so r=t,z=2t,t=e/A and F=x³+etx². This last possible norm/lift candidate fails(4): the SAME saved normalized ξ′₁ has x² coefficient4t, whereas its required right side has x² coefficient3(−3r)=t. The residual is3t≠0. Both ineffective sign choices are therefore excluded as well. The actual sheet of h is essential to this final comparison.

## The remaining trivial scalar-zero branch

If σ=0, then z=0 and r=−t. Direct differentiation gives
\[
(\delta^4-h_C)1=-2ABx^5+2B,
\quad(\delta^4-h_C)x=4B^2x^5,
\]
\[
(\delta^4-h_C)x^2=(\delta^4-h_C)x^3
=(\delta^4-h_C)w=0.
\]
The first two residuals are independent, so(3) forces c₀=c₁=0. The top norm equations give c₂=−vt and v²=a₀u+B. The x³ and constant equations give a₀v=0 and a₀(a₀²−b₀)=0. If v=0, then a₀=−Bt≠0,b₀=a₀², but U₂=2a₀²t²≠0 contradicts its required zero value. Therefore v≠0,a₀=0,v²=B and U₁=0 gives b₀=0. This proves the stated necessary families and their h,U.

On these families
\[
\xi'_{1,e}=Atx^7+(2Bt+Avt^2)x^6+4tx^2+4vt^2x.
\]
Indeed HF′−2Bx³F=3Ax⁷+(B−2Avt)x⁶+2x²+2vtx. Multiplying by3r=−3t gives exactly the displayed ξ′₁. Thus no further restriction comes from the first-coordinate equation; higher regularity and original-source requirements remain separate. In particular δL(5P)=⟨w,xw,x³⟩ does not contain the nonzero c₂x² term. This trivial-Q inclusion is nonlifting, and may not be discarded by the ineffective-class argument.

## Exact nonzero-q₁ determinant consequence

The original nonzero-q₁ net/support theorem requires Q⁻¹ effective. The only effective alternatives were the trivial class and the two just-excluded e²=−B classes. Thus σ=0 and Cartier descent of the SAME s_Q gives Q=O_{Y₁}(−P₁) exactly.

The inherited ω_{Y₁}-valued alternating pairing identifies B_{1,Y}/K=Q*⊗ω_{Y₁}; its ambient determinant is detB_{1,Y}=ω_{Y₁}². Taking determinants gives detK=ω_{Y₁}⊗Q, hence detK=O(P₁), since ω_{Y₁}=O(2P₁). This conclusion concerns the original K, not a newly chosen Frobenius root. It applies only with the retained nonzero-q₁, d-zero and saturation hypotheses.

## Evidence and review provenance

The [norm/Cartier model review](../../Research/audits/OCT03_GRAM_FOUR_DZERO_NORM_CARTIER_TORSION_MODEL_AUDIT_2026_10_03.md), [sparse-effectivity review](../../Research/audits/GENUS_TWO_SPARSE_FIVE_TORSION_EFFECTIVITY_AUDIT_2026_10_03.md), [exact-lift/trivial-branch review](../../Research/audits/OCT03_GRAM_FOUR_DZERO_CARTIER_LIFT_TRIVIAL_BRANCH_AUDIT_2026_10_03.md), and [four-class review](../../Research/audits/OCT03_GRAM_FOUR_DZERO_FOUR_SCALAR_ZERO_CLASSES_AUDIT_2026_10_03.md) are all PASS in their recorded scopes. The latter two reviewed notes have hashes `776ded095cdf72c42f80328fbee9a11ba61e9ace07899a9a2ff1345b6e979dc0` and `e87889015fbfdc3e9834e69a2fea518f5634584abdb38c5bd1f62c8371d4606b`.

The exact saved coefficient text is [annihilator.txt](../../../litt3-computation-data/oct03_gram_four_dzero_annihilator_2026_10_03/annihilator.txt), SHA-256 `e3e7ee1b5c9e9c2b4aff1f4b4f13c2d083c63c9ac5ba929a614ad2dd2f9f01ec`. The single norm-model execution has [external evidence](../../../litt3-computation-data/oct03_gram_four_dzero_norm_cartier_model_2026_10_03_164837/summary.json), executed source hash `8c4800a1f3a473cb9e6a22eb6c563add75c1d62a9bdf4b685bb2a9e484bab899` and saved annihilator input hash `34112c5aba9757d388f0af4422b0a8b1f530be60c141357a8d94d227ba77250e`. It completed with exit0 in2.802seconds externally, one process/thread, internal10-second alarm and external15-second timeout. It constructed eleven necessary equations, without a new basis, search, sample, resultant or source decision. The static derivative/elimination proofs above required no numerical replay.

The two surviving necessary trivial families are not asserted to realize regular saturated K, the prescribed quotient splitting, seven-simple-zero adjunction, finite coefficient action or original native j, or BOTH original finite étale endpoint maps. The twenty σ₀≠0 classes, d_fam≠0, other jets and saturation loss remain outside these exclusions. The unmarked same-source common-cover problem remains unsolved.
