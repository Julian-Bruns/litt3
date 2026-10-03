# Proof: the order-two translation retains a genuine norm sign

Version1,3 October2026. Independently reviewed in the [signed-packet audit](../../Research/audits/Q0_DEGREE_SIX_SIGNED_ELLIPTIC_PACKETS_AUDIT_2026_10_03.md); see the [statement](../../Theorems/cartier_and_spin/actual_q0_tensor_degree_six_one_uniform_elliptic_reduction.md).

The individual uniform elliptic factorization in the [uniform-both proof](actual_q0_tensor_degree_six_uniform_elliptic_exclusion.md) supplies an actual translation P of order TWO on B fixing, say, the first old x-map. Its order-THREE elliptic quotient is j=ZERO. In characteristic FIVE its invariant differential has Cartier ZERO; the étale isogeny pulls it to a nonzero Cartier-zero invariant differential on B. Thus B is supersingular and also has j=ZERO. Explicitly for a Weierstrass cubic $Y^2=X^3+AX+B$ the characteristic-FIVE Hasse coefficient is $[X^4](X^3+AX+B)^2=2A$, so Cartier ZERO forces A=ZERO. The actual original joint source is C0=B(y1), with y1³=Pfixed(x1). Because P fixes x1, it lifts to C0 by fixing y1, with order TWO, and commutes with the simultaneous y-deck. It fixes the first original tensor and hence the common tensor from the second original X-map. It is free and does NOT need to lift to any original source above C0; those original maps and their Y-leg stay on that source.

Form the self-pair consisting of the second X-map and its P-translate. Their joint projection degree divides SIX. If it were ONE,TWO orTHREE, accepted [degree-at-most-two](actual_q0_tensor_low_degree_recognition.md) and [degree-THREE](actual_q0_tensor_degree_three_recognition.md) tensor recognition would make their X-fields equal. Then the order-TWO P acts on that X-field through Aut(X)=C3, so fixes it pointwise. Together with the first old X-field, which P already fixes, this contradicts their joint generation of C0. Thus the new pair still jointly generates C0 with degree SIX. Its simultaneous y-deck is the original one; the same cubic root alternative consequently has index THREE. Its joint coarse x-field is B: a proper index THREE would leave an impossible unramified degree-TWO map to P1.

Let D,PD be the new degree-TWO reduced triple infinity divisors. A common point forces both points common because P is free of order TWO. If D=PD, the common q-zero divisor makes the q-ratio constant and forces joint x-degree at most TWO. Hence D and PD are disjoint. On the elliptic B the divisor D−PD is principal: translation by an order-TWO point changes a degree-TWO divisor class by twice that point, namely ZERO. The common reduced q-zero divisor therefore makes q(x2)/q(x1) a constant times a SIXTH power. Choose t with
\[
q(x_2)/q(x_1)=t^6,\qquad \operatorname{div}(t)=D-PD.
\]
Then deg t=TWO and P(t)t is a constant η with η6=ONE. Multiplication of t by a SIXTH root of unity changes η by its square, so the TWO remaining classes are η=±ONE. The negative sign cannot be discarded by a normalization preserving t6.

Write the actual elliptic equation Y²=Φ4(t), with ordinary ZERO and infinity. P normalizes this degree-TWO map and commutes with its hyperelliptic involution. It sends Y to a constant times Y/t²; P²=ONE and freeness at the TWO fixed t-values force exactly
\[
P(t)=\eta/t,\qquad P(Y)=-\eta Y/t^2.
\]
In particular the fixed t-values t²=η are NOT quartic branch values. All normal forms below retain that condition.

## Positive norm sign

For η=ONE, $P(F_+)=t^{-3}F_+$ and $P(F_-)=-t^{-3}F_-$. Write F±=A±+b±Y. The elliptic pole budget gives deg A±≤THREE,deg b±≤ONE, and both odd parts are nonzero. Reciprocal comparison forces b+=a0(t−ONE),b−=c0(t+ONE), with both constants nonzero. Their coprimeness and the odd product identity give A+=b+L,A−=−b−L. The even comparison forces $L(t)=-t^2L(1/t)$, so L=λ(t²−ONE). Rescaling Y,L by a common constant normalizes a0c0 to ONE and gives the positive-sign statement with arbitrary a≠ZERO. The actual equation is
\[
\Phi_4=(\lambda^2+1)(t^4+1)+(1-2\lambda^2)t^2.
\]
Its characteristic-FIVE Hasse coefficient is directly $I=[t^4]\Phi_4^2=(1-2\lambda^2)^2+2(\lambda^2+1)^2=\lambda^4+3$. Indeed the holomorphic invariant form dt/Y has Cartier $I^{1/5}dt/Y$. Its Cartier ZERO therefore forces λ4=TWO, without needing a separate j formula. No λ-sign is identified; both give the same necessary λ² values. Ordinary ZERO/infinity and smoothness remain required, as does the actual own-triple leading product
\[
4\lambda^2+(a+a^{-1})^2\ne0.
\]
The fixed t-values ±ONE have Φ4=THREE and are automatically ordinary.

## Negative norm sign, including its proportional boundary

For η=−ONE, $P(F_+)=-t^{-3}F_-$ and $P(F_-)=t^{-3}F_+$. Coefficient comparison gives
\[
b_-(t)=-t b_+(-1/t),\qquad A_-(t)=-t^3A_+(-1/t).
\]
Exactly-one-constant odd coefficient is impossible: the odd product identity would give deg L≤TWO, leaving the constant-odd factor with pole at most TWO at infinity. Both coefficients must be linear. If they were proportional, their common root r would satisfy r²=−ONE. At this FIXED t-value the odd terms vanish. The odd product identity gives A−=−rA+, while the displayed P comparison, and P swapping the TWO sheets there, give A+=−A+. Thus BOTH factors vanish, contradicting r6−ONE=−TWO≠ZERO. This deletes the entire common-linear-factor boundary using actual freeness, without an auxiliary discriminant open.

The odd coefficients are therefore coprime. The even product identity makes their TWO roots roots of t6−ONE. Write them as r and−ONE/r, retaining ALL SIX r. Normalizing their leading product to ONE gives $b_+=a(t-r),b_-=a^{-1}(t+1/r)$. The comparison imposes a²r=ONE, so BOTH roots a are retained. The even parts give
\[
L(t)=-t^2L(-1/t),\qquad L=\lambda(t^2-1)+\mu t.
\]
Thus Φ4=L²+W with $W=(t^6-1)/[(t-r)(t+1/r)]$. Put $u=r^{-1}-r$. Then u∈{ZERO,±√TWO}, and direct division gives
\[
W=t^4-u t^3+(u^2+1)t^2+u t+1.
\]
The quartic coefficients are A=λ²+ONE at t4 and t0, B=TWO λμ−u at t3, −B at t, and C=μ²−TWO λ²+u²+ONE at t2. Its characteristic-FIVE Hasse coefficient $[t^4]\Phi_4^2=2A^2-2B^2+C^2$ must vanish. Its supersingular equation is therefore
\[
I=2(\lambda^2+1)^2-2(2\lambda\mu-u)^2
+(\mu^2-2\lambda^2+u^2+1)^2=0.
\]
Retain A≠ZERO, the actual quartic discriminant, the free-involution opens Φ4(i)Φ4(−i)≠ZERO for i²=−ONE, and the same own-triple leading product $4\lambda^2+(a+a^{-1})^2\ne0$. In particular λ=ZERO and μ=ZERO are not removed unless they fail one of these genuine conditions. The actual full fixed-P cube and tensor identities remain additional requirements in BOTH signs.

The two signed packets exhaust the involution normalization. Their inconsistencies are proved in the separate accepted [whole ONE-uniform exclusion](actual_q0_tensor_degree_six_one_uniform_elliptic_exclusion.md). This normal-form proof does not identify the new X-pair's fields or descend any original Y-leg to an auxiliary quotient.
