# Global endpoint norm constraints for the remaining three ten-block sources

Version1, 3 October2026. [Fresh independent whole audit PASS, all eight checks](../../Research/audits/OCT03_GLOBAL_THREE_BLOCK_ENDPOINT_NORM_HERMITE_WHOLE_AUDIT_2026_10_03.md), with no required mathematical correction. This is a canonical record of the reviewed [research note](../../Research/notes/oct03_ten_hour/three_ten_blocks_global_source_next.md). [Complete proof](../../Proofs/cartier_and_spin/canonical_ten_three_block_global_endpoint_norm_constraints.md).

## Actual-source hypotheses

Retain the actual canonical BACKUP packet and its three-ten-block field reduction, with BOTH original finite étale endpoint maps on the SAME source. Work over k=algebraic closure of F5, with beta²=beta+3 and [a+5b]=a+b beta. The fixed endpoint is X:y³=P(x), where P has ascending coefficients [11,22,18,5,19,20,15,16,9,22,1]. It has genus nine, unique infinity O, pole semigroup ⟨3,10⟩, and theta=dx/y² with divisor 16O. Put q(U)=U²+c0, c0=[23].

On the actual jointly generated smooth source C=C0, let h1,h2:C→X be finite étale of degree d, so g(C)=8d+1. Write xj,yj,thetaj for their pulled endpoint data. Require the accepted remaining ratio-one, residual-fifteen sector:
\[
d\in\{25,30\},\quad h_j^*O=J+D_j,\quad \deg J=d-15,\quad\deg D_j=15,
\]
with J,D1,D2 reduced and pairwise disjoint, and
\[
\operatorname{div}(z)=2D_1-2D_2,\quad
q(x_2+1)=z^3q(x_1+1),\quad
\theta_1=\kappa z^8\theta_2,\quad\kappa^3=1,\quad
k(C)=k(x_1,x_2,z).
\]
The actual π:C→Q has degree ten and S10 monodromy; Q→P1_z has degree three. The accepted tame reduction leaves only unramified fibers, single folds and uniform quadratic π-fibers, with exactly 8d single-fold branch values. Every common point has x-leading ratio one and source z-index exactly four, at a value a³=1. Write Ja for the common points over a and ka=deg Ja. The profiles are (5,5,5) for d30 and (5,5,0) or (5,3,2) for d25, up to permutation. At a full value ka=5 the actual Q-fiber is 2Aa+Ba, with π*Aa=2Ja and π*Ba finite on both endpoints, unramified or with one fold. These are accepted inputs, not conclusions newly asserted here.

## Necessary global constraints

Write L(mO)=H0(X,O_X(mO)). Set v2=z, v1=1/z, t2(a)=a and t1(a)=a^{-1}, and form the TWO ACTUAL monic endpoint norms
\[
N_j(T)=\operatorname{Norm}_{k(C)/h_j^*k(X)}(T-v_j)
=T^d+\sum_{s=1}^d n_{j,s}T^{d-s}.
\]
Then k(C)=k(xj,z); each Nj is irreducible and separable of degree d, and
\[
n_{j,s}\in L(2\min(s,15)O),\qquad
\operatorname{ord}_O N_j(t_j(a))=-30+4k_a.
\]
At a full value, for the Hasse derivative N_j^{[r]} defined by the coefficient of H^r in Nj(t+H),
\[
N_j^{[r]}(t_j(a))\in L((10+4r)O)\quad(0\le r\le5),\qquad
N_j^{[1]}(t_j(a))\in L(13O).
\]
Moreover
\[
N_j(t_j(a))=A_{j,a}y+g_{j,a}(x),\quad A_{j,a}\ne0,\quad\deg g_{j,a}\le3,
\]
with exact divisor (hj)_*(π*Ba)−10O, including fold weights. These values are not independently rescaled.

At each FULL value ka=5, use the same endpoint parameter u at O and put uj=hj*u. If on P∈Ja
\[
z-a=b_Pu_2^4+O(u_2^5),\quad u_2=h_2^*u,\quad b_P\ne0,
\]
then
\[
\sum_{P\in J_a}b_P^{-1}=0.
\]
The common parameter phase is u1=λa u2+…, with λa=κ²a. The first-leg leading coefficients of v1−a^{-1} are b'_P=−a^{-2}bP λa^{-4}; their reciprocal balance is exactly −a²λa times the displayed balance and is redundant.

There is ONE nonzero constant K, independent of the full value a, such that
\[
\frac{A_{1,a}}{A_{2,a}}=K a^{1-\deg J}.
\]
Thus for d30 the three A1,a/(a A2,a) coincide; for d25 with two full values, their two A1,a/A2,a coincide. The one-full-value case imposes no comparison between different values.

For d30 put H(T)=T³−1. For each leg,
\[
N_j=H^2S_j+HU_j+V_j,\quad\deg_T U_j,\deg_T V_j\le2,
\]
where coefficients(Vj)⊂L(10O) and coefficients(Uj)⊂L(13O). The unique full H-adic expansion Nj=Σr H^r Vj,r, degT Vj,r≤2, has coefficient bounds
\[
r=0:L(10O),\quad r=1:L(13O),\quad r=2:L(18O),\quad
r=3:L(22O),\quad r=4:L(26O),\quad r\ge5:L(30O).
\]
Monicity and the individual coefficient bounds remain additional restrictions. For d25 profile(5,5,0), use Hj=(T−tj(a))(T−tj(b)) at its two full values; the twice-division form has degree-at-most-one L10/L13 remainders. For profile(5,3,2), only one value has the full L10/L13 pair of jets; the other values have exact poles eighteen and twenty-two. No three-full interpolation is asserted for d25.

Let Wj⊂X×P1 be the integral image of (hj,vj), and let δfin,j be its normalization defect over finite endpoint points. Its normalization is the ACTUAL C, and
\[
p_a(W_j)=38d-29,\quad \sum_w\delta_w=30d-30,\quad
\delta_{\mathrm{fin},j}\le30d-30-210-4\sum_{a^3=1}\binom{k_a}{2}.
\]
The upper bounds are 540 for d30, 430 for d25 profile(5,5,0), and 454 for d25 profile(5,3,2). For Δj=discT Nj≠0,
\[
\operatorname{div}_{\mathrm{fin}}(\Delta_j)\text{ is effective and even},\qquad
\deg\operatorname{div}_{\mathrm{fin}}(\Delta_j)=2\delta_{\mathrm{fin},j}.
\]
These inequalities need not be equalities. Even discriminant divisor does not imply a square in k(X); an unramified quadratic endpoint character may survive.

## Exact remaining scope

This is a package of necessary conditions, not an exclusion of d25 or d30 and not a construction of a common cover. Separate companion norm identities or local germs do not replace the entire norm algebra and its second actual étale endpoint map. Ordinary nontrivial-phase diagonal branches and centered folds remain permitted. No finite source-index-four absence, weighted-trace obstruction, original X-map on Q, Hom vanishing, or simultaneous endpoint Galois closure is asserted. The accepted π sign double has not been identified with either endpoint discriminant character. The unrestricted same-source common-cover problem remains unresolved.
