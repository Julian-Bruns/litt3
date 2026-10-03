# Proof: retain the Frobenius correction at a q-zero

Version1, 3 October2026. [Fresh independent five-check whole review PASS](../../Research/audits/OCT03_ALL_PHASE_QZERO_FROZEN_CONTACT_FIVE_WHOLE_AUDIT_2026_10_03.md), with no required mathematical correction. See the [statement](../../Theorems/shared_tensors/finite_all_phase_noncritical_qzero_contact_five_exclusion.md).

Use d=d0=[23]=3−β, d²2,d5=−d, and the fixed centered p coefficients[8,3,21,23,22,12,22,21,1,22,1]. The settled fixed-root unit certificate gives p(a),p(b) nonzero at every q-root. Also a,b are nonzero and q′(a),q′(b) are units. Write W=a5,Z=b5; then W²=Z²=d and Z=±W.

## Exact rational identity and its q-zero Laurent expansion

Put f(U)=U³p(U)²/q(U)11 and g(U)=U4p(U)/q(U)3. The exact relation
\[
g(U)^2=f(U)(U/q(U))^5
\]
shows that the ratio f(V)/f(A) is constant modulo a fifth power of a local parameter if and only if g(V)/g(A) is so: the fifth-power ratio of U/q is a unit along the frozen conic because q(V)=s q(A), and is constant modulo parameter fifth powers; squaring detects all coefficients of orders one through four.

The following exact rational identity is verified by substituting U5=W and reducing powers using q(U)=U²+d:
\[
g(U)=\frac{P_{U^5}(q(U))}{Q(U^5)},\quad Q(W)=W^2-d,
\]
\[
P_W(T)=c_1(W)T+c_2(W)T^2+c_3(W)T^3+c_4(W)T^4,
\]
\[
c_1=(d-1)(1+W)(W^2-d),
\]
\[
c_2=W^2+(4+4d)W+4+d,
\]
\[
c_3=(1+3d)W^2+4dW+1+2d,
\qquad c_4=W^2+dW+3+2d.
\]
For an explicit independent check, write p(U)=Σ_{j=0}^4 U^j a_j(U5), with
\[
a_0=W^2+(3-2d)W+1-d,
\quad a_1=3+(d-1)W,
\]
\[
a_2=(d+3)(1+W),\quad a_3=d+W,
\quad a_4=(d-1)(1+W).
\]
Multiplying g by Q gives U4p(U)q(U)². Replacing U5 by W and U² by T−d gives the displayed c_i; its constant coefficient is Q(a2+d a4)=0. This is polynomial hand algebra; no geometric q-zero is removed.

At a q-zero, T=q(A) is a local parameter. Do NOT freeze A5 to W before dividing by T5: its order-five change affects a relevant order-four coefficient. The exact square-root branch expansion gives
\[
A^5=W+\frac{T^5}{2W}+O(T^{10}),
\qquad Q(A^5)=T^5.
\]
Since c1(W)=0 and c1′(W)/(2W)=(d−1)(1+W), the identity yields
\[
g(A)=T^{-3}\left[c_2(W)+c_3(W)T+c_4(W)T^2
+(d-1)(1+W)T^4+O(T^5)\right].
\]
In the other frozen branch, q(V)=sT gives the SAME expansion with W replaced by Z and T replaced by sT. The leading coefficients c2(W),c2(Z) are nonzero: they are the nonzero leading coefficients a4p(a),b4p(b) of g at its pole of order three.

If the frozen numerator has contact at least five, the quotient f(V)/f(A) is constant modulo T5. Thus g(V)/g(A) is also constant modulo T5. There must be a nonzero L satisfying
\[
c_2(Z)=L c_2(W),\quad
s c_3(Z)=L c_3(W),\quad
s^2c_4(Z)=L c_4(W),
\]
\[
s^4(d-1)(1+Z)=L(d-1)(1+W).
\]
The Laurent poles cancel in this ratio. Only the first three equations will be needed.

## Diagonal and anti-diagonal q-roots

If Z=W, the first equation gives L1. The coefficient c3(W)=2+3d+4dW is nonzero. Indeed its vanishing would give W=d+3, whose square is d+1, contrary to W²=d. The second equation therefore gives s1, a contradiction.

If Z=−W, the first three equations imply equality at W and−W of c2 c4/c3² (where c3 is nonzero by the preceding argument for either root). Their cross-multiplied difference is nonzero. Modulo W²=d, direct multiplication gives
\[
c_2(W)c_4(W)=(2+d)+3dW,
\]
\[
c_3(W)^2=(2+4d)+(d+3)W.
\]
Therefore
\[
c_2(W)c_4(W)c_3(-W)^2
-c_2(-W)c_4(-W)c_3(W)^2
=2W(d+1)\ne0.
\]
Here W≠0 and d+1≠0 follow from d²2. This contradicts the necessary equality. Both signs are excluded in EVERY η. No numerical phase or root sampling is involved.

## Actual separating-source application

Let k=e_P(z)≥5 at a unit noncritical source point and put ℓ=orddz. The actual separating local expansion makes ℓ≥5: for5∤k it is k−1≥5, and for5|k it is at least k. Since the endpoint maps are étale and p(a)p(b) are units, A−a is an actual source parameter; q(A) has order one.

The ORIGINAL q and theta equations give, keeping η=κ³,
\[
K=B^3p(B)^2-\eta z^{33}A^3p(A)^2,
\qquad\operatorname{ord}K\ge\ell+1\ge6.
\]
Freezing V gives ord(B−V)≥k+1≥6 and ord(z33−s11)=k≥5. Thus its actual frozen numerator has contact at least five, impossible above. The phase was never normalized. No π, Galois completion or additional different premise enters this source argument.

Both actual endpoint legs remain on their SAME original source. The proof does not treat the remaining ordinary q-unit arbitrary-phase locus, critical z-values, source indices below five or unmarked-source extraction.
