# Proof: exclusion of the one-root and five-root common square classes

Version1,3 October2026. Independently accepted in the [whole genus-two audit](../../Research/audits/Q0_FOUR_GENUS_TWO_WHOLE_AUDIT_2026_10_03.md). All coefficient manipulations below are by hand.

## The common actual derivative class

Use the [genus-two form](actual_q0_tensor_degree_four_genus_two_hyperelliptic_form.md), scaling D to ONE for this necessary local argument. Put Φ=az[A²+(1−z³)(z−a)] and y²=Φ. Smoothness gives deg Φ=FIVE, its five finite roots distinct, a≠0 and Φ(a)=a²A(a)²≠0. Define U,C,V,W as in the statement. Direct differentiation gives
\[
\delta X_1=(V+yU)/[z^2(z-a)^2],\qquad
\delta X_2=\kappa(W+ayC)/(z-a)^2,
\quad\kappa^2=1/a.
\]
Actual ramification indices ONE or THREE give even divisors of dx_i. Since div(dz/y)=2R2 is even, each δXi has even divisor. Its rational norm is therefore a square. The cancellation at the conjugate of Q makes each cleared norm divisible by (z−a)², so the polynomial square roots H1,H2 vanish at a. They have degree FIVE. Choose their signs so the leading terms agree with V,W. Then
\[
F1=V-H1,\ G1=V+H1,\quad
F2=W-H2,\ G2=W+H2
\]
satisfy F1G1=ΦU²,F2G2=a²ΦC², deg Gi=FIVE, deg Fi≤FOUR. Their leading coefficients are4 times the leading coefficient of Φ for G1, and3 times it for G2. At a, all four factors have value−Φ(a).

The identity (V+yU+H1)²=2(V+H1)(V+yU), and its second analogue, show that δXi has the square class of Gi. The ACTUAL tensor equality gives dx2/dx1=c⁻¹(t/z⁴)², so these classes coincide. Constants are squares over k.

Since Gi has even divisor on B, every odd finite multiplicity of its rational polynomial lies at a branch root of Φ. The rational ratio G1/G2 is a square in k(B). A rational function becoming a square in the quadratic extension k(z,y) is either a square in k(z) or Φ times one. The latter is impossible here: both Gi have degree FIVE, while Φ has odd degree FIVE, giving odd valuation at infinity. Thus G1/G2 is a rational square and their squarefree odd-root factors are IDENTICAL. Call their monic common factor R. Its degree is ONE, THREE or FIVE.

## The five-root class and A2=ZERO are impossible

If deg R=FIVE, then G2 is a constant times Φ. Its leading coefficient forces G2=3Φ, but evaluation at a gives G2(a)=−Φ(a). This contradicts Φ(a)≠0 in characteristic FIVE.

If A2=ZERO, C is constant and nonzero because C(a)=−A(a)≠0. The product F2G2=a²ΦC² and deg G2=FIVE force G2 to be a constant times Φ, the same contradiction. Hence A2≠0.

## The one-root class has a linked factor identity

Suppose R=z−r. The degree-FIVE square factors must be
\[
G1=k1(z-r)U^2,\qquad G2=k2(z-r)C^2.
\]
In particular both U,C have degree TWO. Evaluation at a gives k1=−1/(a−r),k2=−a²/(a−r), and consequently
\[
F1=F2=-(a-r)\Phi/(z-r).
\]
Since V−W=−2(z−a)Φ/z, subtracting the two factor sums and cancelling z−a gives
\[
(z-r)D(z)E(z)=-(a-r)\Phi(z)/z,
\]
where
\[
D=A'(z-a)-2A=-(A1+2aA2)z-aA1-2A0,
\]
\[
E=U+aC=-A1z^2-2(a^2A2+A0)z-a^2A1.
\]
In particular r≠ZERO, since Φ/z has nonzero constant coefficient and its finite roots are nonzero. The product identity will contradict the necessary coefficients below.

## Four coefficient comparisons suffice

Write t=A2², h=(a−r)/a, ρ=r/a, m=A1/(aA2), v=A0/(a²A2). Let sj be the coefficients of A²+(1−z³)(z−a), so
\[
s4=t-1,\ s3=2A2A1+a,\ s2=A1^2+2A2A0,\
s1=2A1A0+1,\ s0=A0^2-a.
\]
Here t≠0,1. The leading coefficients of G2 and G1 give respectively
\[
h=3t/(t-1),\qquad (m+1)^2=3.
\]
The z4 coefficient of F2+G2=2W gives m=4+2/t. Hence t²=THREE, and
\[
h=2-t,\quad \rho=t-1,\quad m=-1-t.
\]
The next two necessary comparisons can be displayed without any eliminated equations:

|coefficient in F2+G2=2W|necessary relation after these substitutions|
|---|---|
|z3|(−1−2t)v=2−2t, hence v=m|
|z1|a³(1+t)=1−t, hence a³=t+3|

For verification of the table, C=A2z²−2aA2z−aA1−A0 and
\[
F2=-(a-r)\Phi/(z-r),\quad G2=-a^2(z-r)C^2/(a-r).
\]
The z3 coefficient of2W is a s2+a²s3. Substitution gives the first displayed linear equation in v. The z1 coefficient of2W is4a s0−2a²s1; after v=m its value is4a², giving the second equation. Every divided factor is nonzero: t²=3 excludes t=0,1,−1, and −1−2t=ZERO would give t=TWO, incompatible with t²=3. No z2 or constant comparison has been presumed sufficient or used to manufacture a candidate.

Thus every alleged one-root case must satisfy
\[
A1=aA2m,\quad A0=a^2A2m,\quad
t^2=3,\quad m=-1-t,\quad a^3=t+3.
\]
The root of the nonzero linear D is then e=a(4+2t), which is nonzero. Put ζ=e/a=4+2t. For f(ζ)=ζ²+mζ+m, these identities give
\[
\zeta^2=3+t,\quad f(\zeta)=2+4t,\quad
t f(\zeta)^2-\zeta^3(\zeta-1)=4+t.
\]
Consequently
\[
\Phi(e)/e
=a^2\bigl[(\zeta-1)+a^3\{t f(\zeta)^2-\zeta^3(\zeta-1)\}\bigr]
=a^2(3+4t)\ne0.
\]
The last nonvanishing follows because3+4t=ZERO would give t=THREE, whose square is FOUR rather than THREE. But the linked product identity forces Φ(e)/e=ZERO at the root of D. This contradiction excludes the one-root class.

Only the common degree-THREE subset remains. There are TEN choices among the five finite branch roots, and each Gi is that cubic times a linear square. This is a precise linked-class reduction, not a whole exclusion of the non-Weierstrass stratum or the original common-cover problem.
