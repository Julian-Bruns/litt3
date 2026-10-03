# Proof: a finite node gate for the genus-two degree-four branch

Version1,3 October2026. Pending independent review. The argument is algebraic and uses no new or repeated arithmetic calculation.

Use the exact [coarse cube-map reduction](actual_q0_tensor_cubic_coarse_curve_reduction.md). At degree FOUR and genus TWO, its common unramified infinity count is ONE. Each x-map on B has one triple infinity pole R_i and one simple pole Q. The point Q is common, because q2/q1 is a cube and the common q-zero divisor cannot meet infinity: a valuation−2 must match another valuation−2 modulo THREE. If R1=R2, the q-ratio has zero divisor and is constant; then the joint x-curve has projection degree at most TWO, a contradiction. Hence R1,R2 are distinct.

The cubic root D_E→B branches at EIGHT common q-points and at Q. Hurwitz gives genus THIRTEEN. Its two elliptic projections have degree FOUR. The marked-boundary genus bound is exactly THIRTEEN, so every bound is equality. As in the degree-six equality case of the [joint-field alternative](actual_q0_tensor_elliptic_joint_field_cubic_alternative.md), its numerical class is4(F1+F2); the four marked pairs each have TWO transverse smooth branches; and there is no other singularity. The point above Q maps to (I,I), with I the elliptic infinity, and both elliptic projections are unramified there. The four mixed marked/infinity pairs are avoided entirely by equality of the marked inverse-image divisors.

The diagonal w-deck acts on E×E by (u1,u2)↦(ζu1,ζu2), fixing vi. It preserves the image divisor. Numerical class4(F1+F2) implies that its line is external L1⊠L2, with each Li of degree FOUR: the difference from an external numerical representative lies in Pic0(E×E)=Pic0(E)×Pic0(E). Diagonal invariance makes each Li invariant under ζ. The three invariant degree-four classes are O(T+3I), T∈{I,A_+,A_-}, with A_±=(0,±s); this follows from ker(ζ−1)={I,A_+,A_-} on Pic0(E).

An invariant linearization gives a weight at each of these three fixed points. For O(T+3I), its two q-point weights coincide exactly when T=I: if T=A_+ or A_-, the divisor has multiplicity ONE at just that q-point and ZERO at the other, so their weights differ modulo THREE. At the four mixed pairs, the defining section is nonzero. Comparing its character at (A_+,I) and (A_-,I) therefore forces the two q-weights of L1 to coincide; similarly those of L2 coincide. Thus both lines are O(4I).

Now H0(E,O(4I))=⟨1,u,v,u²⟩, with w-deck characters0,1,0,2. At a q-pair the image has multiplicity TWO, and the action on its two ambient tangent coordinates is scalar ζ. Its section therefore has character TWO. The character-two part of the external tensor product is exactly
\[
u_2^2(a+bv_1)+\gamma u_1u_2+u_1^2(d+ev_2).
\]
At infinity use the same local parameter ti=ui/vi on both factors. The leading term of the normalized section is bt1+et2. Both projections are unramified at the actual smooth (I,I) branch, so b,e≠0, and its slope is dt2/dt1=−b/e. Avoidance of the mixed pairs also gives a±bs≠0,d±es≠0.

Recall the actual cyclic-surface function a0=(y2/y1)(w1/w2)⁵, with a0³=R0(x1)/R0(x2), R0=q0⁵/P. The monic R0 has value ONE at infinity. Hence a0³=1 at the common infinity branch. The relation λ2=c⁻¹a0²λ1 and the preceding slope give
\[
c^3=(-b/e)^{-3}=-r^{-3}.
\]
This uses the actual infinity branch; leaving c free would lose the finiteness below.

At a marked pair (α,β), where α,β∈{s,−s}, put A_α=a+bα and D_β=d+eβ. The tangent slopes m of the TWO branches are the distinct nonzero roots of A_αm²+γm+D_β. The leading η equality from the joint-field proof gives
\[
m^{33}=c^{-3}(\beta/\alpha)^3(P(\beta)/P(\alpha))^2.
\]
Taking the product of the two slope identities yields
\[
(D_\beta/A_\alpha)^{33}
=r^6(P(\beta)/P(\alpha))^4,
\]
since (β/α)⁶=1. Divide these identities at the four pairs. They give the two displayed33rd-power equations for A=a/b and B=d/e. The diagonal (+,+) equation gives r³⁹=((B+s)/(A+s))³³.

The ratio ζ of the two distinct slopes has ζ³³=1,ζ≠1. Their sum and product give γ²/(A_αD_β)=2+ζ+ζ⁻¹. Since33 is odd, −1 is not a33rd root; hence γ cannot vanish. The set of possible values has at most SIXTEEN members, pairing ζ with ζ⁻¹. Use the (+,+) node and e=1 to obtain the stated final constraint.

Each Möbius ratio equation admits at most THIRTY-THREE finite values of A or B. With these fixed, the39th-power equation admits at most THIRTY-NINE nonzero values of r. The final squared equation admits at most THIRTY-TWO values of γ. Their product is the bound. All exponents are prime to FIVE. No full polynomial identity has been inferred from the tangent conditions: every candidate must still satisfy the global cube/differential identities and the actual local ramification profiles. Thus this is a finite gate for the whole genus-two degree-four branch, not its exclusion or a Y-cover construction.
