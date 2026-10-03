# Proof: two elliptic degree-four normal forms

Version1,3 October2026. Independently accepted in the [elliptic normal-form and Weierstrass audit](../../Research/audits/Q0_FOUR_ELLIPTIC_WEIERSTRASS_AUDIT_2026_10_03.md). All manipulations are by hand, with no arithmetic replay.

As in the [genus-two normal form](actual_q0_tensor_degree_four_genus_two_hyperelliptic_form.md), the actual common q-zero divisor excludes FOUR unramified infinity points: that would make z constant and reduce the joint x-degree to at most TWO. Hence the poles are3Ri+Q and div(z)=2R1−2R2, with Ri distinct and Q common. On the elliptic B this degree-two map has Ri as branch points. Choose y²=Φ(z), deg Φ=3, Φ(0)=0, and put a=z(Q)≠0.

The invariant and anti-invariant pole bounds now allow LINEAR odd numerators, because y has pole THREE at R2. Therefore
\[
X_1=\frac{A(z)}{z(z-a)}+\frac{b(z)y}{z^2(z-a)},\qquad
X_2=\frac{B(z)}{z-a}+\frac{c(z)y}{z-a},
\]
where A,B have degree at most TWO and b,c degree at most ONE. The actual triple poles imply b(0)≠0 and c1≠0. Odd parts in X2²+D=z³(X1²+D) give Bc=Ab.

Suppose first that b,c are coprime. Then Bc=Ab gives A=cL,B=bL with deg L≤1. The even equation becomes
\[
\Phi(z)=zL(z)^2+\frac{D z(z^3-1)(z-a)^2}{M(z)},\qquad
M(z)=z c(z)^2-b(z)^2.
\]
The cubic M has nonzero constant and leading coefficients. Consequently it divides (z³−1)(z−a)².

If Q is not Weierstrass, cancellation at its conjugate forces b(a),c(a),L(a) all nonzero and
\[
a c(a)L(a)+b(a)y(\iota Q)=0,\qquad
b(a)L(a)+c(a)y(\iota Q)=0.
\]
Thus M(a)=0 and Φ(a)=aL(a)². If Q is Weierstrass, the invariant parts must be regular, giving L(a)=0, and the two actual odd simple poles require b(a)c(a)≠0. If M(a) were nonzero, both terms in the displayed formula for Φ would have a double zero at a, contradicting smoothness. Hence M(a)=0 here too.

Let ε be ONE if a³=1 and ZERO otherwise, and let j be the multiplicity of a in M. In the non-Weierstrass case the correction term must vanish at a, so j≤1+ε. In the Weierstrass case its order must be ONE, since zL² has order at least TWO there; hence j=1+ε. All other roots of M belong to the three simple roots of z³−1. It follows that
\[
M=c1^2(z-a)(z-r)(z-s)
\]
for TWO DISTINCT cube roots r,s of unity. This includes a=r or a=s. Multiplying z by a cube root of unity, which preserves z³=q2/q1, puts the unordered pair at {1,ω}. There is only ONE normalized partition type.

Write c=c1(z+u),b=c1(vz+w). Comparing M/c1² with (z−a)(z−1)(z−ω) gives the three coefficient equations in the statement. Cancelling this factorization in the formula for Φ gives
\[
\Phi=zL^2+(D/c1^2)z(z-\omega^2)(z-a).
\]
Replace y and L by c1y and c1L. This produces the stated formulas with fixed D, rather than an extra free scaling parameter.

The simple roots at ZERO and infinity give L0²+Dω²a≠0 and L1²+D≠0. In the non-Weierstrass case Φ(a)=aL(a)² is nonzero. In the Weierstrass case L(a)=0 and the derivative of Φ at a is Da(a−ω²), so smoothness is a≠ω². The nonzero pole coefficients give a,w,a+u,va+w≠0.

Now retain the proportional case c=κb. Since c1≠0, write b=b1(z−e). The triple pole at R1 gives e≠0. Also e≠a: if b(a)=c(a)=0, both odd parts would be regular at Q; at a non-Weierstrass Q the even parts then have poles at both Q and its conjugate or neither, whereas at a Weierstrass Q they have only even pole orders. Neither permits the actual unique order-ONE pole. The even equation is
\[
b(z)^2\Phi(z)=\frac{zA(z)^2}{\kappa^2}
 +\frac{Dz(1-z^3)(z-a)^2}{\kappa^2z-1}.
\]
The same cancellation at the conjugate of a non-Weierstrass Q as in the genus-two proof forces aκ²=1. For a Weierstrass Q, A(a)=0 and b(a)≠0. If a≠κ⁻², polynomiality forces κ⁶=1, making the entire right side divisible by (z−a)². Since b(a)≠0, Φ would not be squarefree. Hence aκ²=1 in this case too. Cancel the denominator to obtain the proportional formula in the statement. Its factor (z−e)² is a genuine additional condition, not an impossible factor: the numerator A² term can supply it. Therefore this case has not been discarded.

Only the q-cube relation and exact pole data have been used. The other actual-source identities and pure-three ramification remain necessary. The reduction retains BOTH coprime and proportional odd-numerator cases; it is not a proof that any member realizes a tensor self-span, nor a replacement for the original Y-leg.
