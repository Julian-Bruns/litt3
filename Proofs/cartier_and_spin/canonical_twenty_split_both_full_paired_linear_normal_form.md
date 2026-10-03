# Proof: the exact both-full paired linear normal form

Version1, 3 October2026. [Fresh independent whole mathematical audit PASS](../../Research/notes/oct03_ten_hour/split_twenty_both_full_paired_linear_normal_form_audit.md), no corrections; canonical extraction review pending. No computation is used. The [statement](../../Theorems/cartier_and_spin/canonical_twenty_split_both_full_paired_linear_normal_form.md) retains BOTH actual finite étale X maps on their SAME original source, both cubics, canonical comparison and faithful joint field.

## 1. The actual whole cubics give the linear equation

Use the SAME exact conductor and original sections of the [paired cubic theorem](canonical_split_paired_cubic_adjoint_counterterms.md). ENTIRE ρ divisibility of either original extension invokes the accepted [full-factor boundary](canonical_split_full_cubic_extension_degree_twenty_boundary.md). Under both full factors it gives r=20,C∼10L,R∼4L, genuine h=a/ρ,g=b/ρ∈H⁰(3D+10F∞), each OWN error zero and nonzero scalars G₂,G₁ with
\[
\mathcal Dh=G₂ρ,\qquad Eg=G₁ρ,
\]
\[
h³-P₂=γ₂G₂Q,\qquad g³-P₁=γ₁G₁Q,
\quad γ₁=-κ^{-1}γ₂.
\tag{2}
\]
At either boundary, h³ and g³ have pole order at most9; P₂ and P₁ have the SAME monic pole order10. Indeed P₁ has leading term v¹⁰ and v/u→±1, whose tenth powers are equal. The same defining Q in (2) therefore gives γ₁G₁=γ₂G₂. It follows that Eg=−κ𝒟h and g³−h³=P₁−P₂. Setting H=κh yields
\[
Eg+\mathcal DH=0.
\tag{3}
\]
This deduction uses the original whole cubics and their calibrated constants, not an arbitrary polynomial model. We now classify only the ambient LINEAR equation (3).

## 2. Complete bounded spaces and the potential map

The finite affine coordinate ring is k[t,u,v]/(v²−u²+d(t⁶−1)). A function with poles allowed only on D and F∞ is a polynomial in this ring. Its unique form is A(t,u)+vB(t,u). In the alternative coordinates u+v,u−v, their product is d(t⁶−1); the positive powers on either side have opposite generic boundary poles, so powers above the allowed boundary order cannot cancel. At infinity U=t⁻³u,V=t⁻³v, the functions1,U,U²,U³,V,VU,VU² on U²−V²=d are independent. Thus simultaneous leading cancellation cannot conceal excess infinity weight.

Consequently every H,g∈H⁰(3D+10F∞) has UNIQUE form
\[
H=A_0+vB_0,\qquad g=C_0+vZ_0,
\]
\[
A_0,C_0=\sum_{i=0}³a_i(t)u^i,\quad \deg a_i\le10-3i,
\]
\[
B_0,Z_0=\sum_{i=0}²b_i(t)u^i,\quad \deg b_i\le7-3i.
\tag{4}
\]
There are41 coefficients per section. The COMPLETE potential space is
\[
w=M+vN,\qquad
M=\sum_{i=0}²m_i(t)u^i,\quad\deg m_i\le8-3i,
\]
\[
N=a(t)+ub(t),\qquad\deg a\le5,\quad\deg b\le2.
\tag{5}
\]
Its dimension is18+9=27. No hidden finite rational denominator is allowed.

The surface identities [𝒟,E]=2u𝒟 and 𝒟u=0 give E𝒟=𝒟(E−2u)=𝒟T. Therefore H=−Tw,g=𝒟w solves (3). Both outputs have the required poles. The field 𝒟 raises finite weighted degree by at most2 and boundary order by at most1. For T, the apparent excess infinity weight cancels at top weight8: on tᵖuⁱ its coefficient is2i−p−2, zero when p+3i=8, and on vtᵖuⁱ it is2i−p, zero when p+3i=5. Both congruences are in characteristic5. Lower weights give at most10.

The five displayed residual modes also solve (3). The first two are 𝒟-invariant since 𝒟q=𝒟(t¹⁰)=0; C and Jqt⁴ are E-invariant since Eq=4uq and E(t⁴)=−4ut⁴. Direct substitution checks the final pair tv(v²−d),−u(v²−d); its weights are10 and9 and its boundary poles are at most3.

## 3. The first coefficient equation removes the antiderivative obstruction

Put E₀=−tu∂t+2q∂u on k[t,u]. The v and non-v parts of (3) are exactly
\[
\partial_tA_0+(E₀-3u)Z_0=0,
\]
\[
E₀C_0+(q-dt⁶)\partial_tB_0-3dt⁵B_0=0.
\tag{6}
\]
Within the Z₀ bounds, the ONLY polynomial t-antiderivative obstruction is t⁴(d₀+d₁u). The t⁴ coefficient of (E₀−3u)Z₀ is−2d₀u+2dd₁. A polynomial t-derivative has no t⁴ term in characteristic5, so both coefficients are zero. Thus Z₀=∂tM for an allowed M in (5). Subtract its potential pair. The remaining g has no v part, and the remaining non-v H coefficient is t-constant, in
\[
\operatorname{span}\{1,t⁵,t^{10},u,ut⁵,u²,u³\}.
\tag{7}
\]
Apart from this free term, the task is H=vB₀,g=C₀ subject to the second equation of (6).

## 4. All five remaining coefficient equations

For N=a(t)+ub(t) the potential coefficient in H is
\[
-E₀N=-2db+(ta')u+(tb'-2b)u².
\tag{8}
\]
The b parameters uniquely remove the u⁰ coefficients of degrees0,1,2 in B₀. The a parameters uniquely remove its u¹ coefficients of degrees1,2,3,4, leaving unused only a₀,a₅t⁵. The remaining coefficient is
\[
B_0=\sum_{i=3}⁷b_it^i+ku+(l_0+l_1t)u².
\tag{9}
\]
Write C₀=c₀+c₁u+c₂u²+c₃u³, with degrees bounded respectively10,7,4,1, and write B₀=β₀+β₁u+β₂u². Expansion of (6), from u⁰ through u⁴, gives ALL five equations
\[
2c₁+(1-t⁶)β₀'-3t⁵β₀=0,
\]
\[
-tc₀'+4dc₂+d(1-t⁶)β₁'-3dt⁵β₁=0,
\]
\[
2c₁-tc₁'+dc₃+β₀'+d(1-t⁶)β₂'-3dt⁵β₂=0,
\]
\[
4c₂-tc₂'+β₁'=0,\qquad c₃-tc₃'+β₂'=0.
\tag{10}
\]
The first equation is divided by nonzero d. The forbidden high degrees8,9,10,11, whose factors i+3 are nonzero for i=3,4,5,6, force b₃=b₄=b₅=b₆=0 and leave c₁=4b₇t⁶. The last two equations give c₂=Jt⁴,c₃=−l₁+c₃₁t. The middle equation then gives c₃₁=l₀=0,b₇=−dl₁: its relevant coefficients are dc₃₁ at t,−3dl₀ at t⁵ and b₇+dl₁ at t⁶. In the second equation the t⁵ coefficient−3dkt⁵ cannot occur in tc₀', so k=0. The remainder yields
\[
c₀=C+c_{05}t⁵+c_{0,10}t^{10}+dJt⁴.
\]
Hence the residual pair is
\[
H=l₁tv(v²-d),
\]
\[
g=C+c_{05}t⁵+c_{0,10}t^{10}+Jqt⁴-l₁u(v²-d).
\tag{11}
\]
The unused N constants absorb the two nonconstant Frobenius g terms, because 𝒟v=−3dt⁵ and 𝒟(vt⁵)=−3dt¹⁰, while T(v)=T(vt⁵)=0. The unused t-constant M monomials1,t⁵,u,ut⁵,u² have five independent H outputs spanning u,ut⁵,1,t⁵,u³+2du. These absorb five dimensions of (7), leaving Aq and Bt¹⁰. This proves existence of the asserted normal form.

## 5. Uniqueness and dimension32

Suppose a combination of the27 potentials and five residual modes is zero. The v part of g gives M_t=0. In the v part of H the K mode has a nonzero t⁷ term in its u⁰ coefficient, while E₀N has u⁰ degree at most2. Thus K=0. Now E₀N=0 forces b=0,a=a₀+a₅t⁵. The non-v part of g becomes−3d(a₀t⁵+a₅t¹⁰)+C+Jqt⁴. Its u²t⁴ coefficient gives J=0, and its distinct powers1,t⁵,t¹⁰ give C=a₀=a₅=0. Finally the five M outputs above, q and t¹⁰ are independent, so M=A=B=0. In particular the joint potential kernel 𝒟w=Tw=0 is zero. All27+5 parameters are UNIQUE, and the linear kernel has dimension32.

## 6. The invariant fourth-derivative density

The identities 𝒟⁵=0,[𝒟,E]=2u𝒟 and 𝒟u=0, applied to (3), give
\[
(E+3u)\mathcal D⁴g=0,\qquad \mathcal D(\mathcal D⁴g)=0.
\]
Since Eq³=2uq³, the ratio 𝒟⁴g/q³ is killed by BOTH fields. Their determinant on t,u is2vq≠0, so they form a generic basis of the k-derivations of k(S). Their common kernel is k(S)⁵, since k is perfect. Thus the ratio is W⁵ for W∈k(S).

The numerator has poles at most7D+18F∞ and q³ has poles exactly6D+18F∞ and reduced q-prime zeros multiplied by3. Thus W⁵ can have negative orders no worse than−1 on D or−3 on a q prime, and none elsewhere or at infinity. A negative fifth-power order is at most−5, so none is possible. The rational W has no divisorial pole on smooth projective S and is constant. Therefore 𝒟⁴g=cq³. Hand differentiation gives 𝒟⁴(t⁴)=4q², whence 𝒟⁴(qt⁴)=4q³; every potential and the other modes have zero fourth derivative in g. Thus c=4J.

## 7. The original nonlinear source conditions remain

For the ACTUAL pair H=κh, the normal form is necessary. It leaves g³−h³=P₁−P₂, h³−P₂=γ₂G₂Q and 𝒟h=G₂ρ to be solved together with integral C, exact conductor, faithful joint field, original canonical comparison and TWO finite étale endpoint maps from the SAME C₀/T. The normal form provides none of those conditions for an arbitrary polynomial pair. No degree20 source exclusion or unmarked common-cover solution follows, and no auxiliary map replaces either original endpoint leg.
