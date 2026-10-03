# Proof: the remaining common cubic-root factor is impossible

Version1,3 October2026. Independently accepted in the [whole genus-two audit](../../Research/audits/Q0_FOUR_GENUS_TWO_WHOLE_AUDIT_2026_10_03.md). The new implication is a polynomial degree argument and evaluation at ZERO, with no computation.

The [Weierstrass-Q theorem](actual_q0_tensor_degree_four_weierstrass_simple_pole_exclusion.md) excludes that entire stratum. Suppose henceforth that Q is NOT Weierstrass. Use the full [non-Weierstrass reduction](actual_q0_tensor_degree_four_nonweierstrass_square_class_reduction.md), including its explicit one-root and five-root contradictions. Its notation is retained: Φ=az[A²+(1−z³)(z−a)], A2≠0, U,C,V,W, square roots H1,H2 vanishing at a, and Fi,Gi. In particular
\[
F1G1=\Phi U^2,\quad F2G2=a^2\Phi C^2,\quad
F1+G1=2V,\quad F2+G2=2W,
\]
and all four factors have value−Φ(a)≠0 at a. The only surviving common odd-root factor R is monic of degree THREE. Write Φ=R S, with S quadratic, and let p≠0 be the leading coefficient of Φ. Smoothness gives gcd(R,S)=ONE.

## The two smaller factors must coincide

Since Gi has degree FIVE and common squarefree factor R, there are finite points s,t with
\[
G1=4pR(z-s)^2,\qquad G2=3pR(z-t)^2.
\]
The constants are fixed by the leading coefficients in the preceding reduction. Evaluation at a gives
\[
\frac{(a-s)^2}{(a-t)^2}=3/4=2;
\]
neither denominator vanishes. The polynomial4(z−s)²−3(z−t)² is monic quadratic and vanishes at a. Define its other root b. Hence
\[
G1-G2=pR(z-a)(z-b),\qquad b=-a-2s-t.
\]
On the other hand, each Fi is S times a polynomial square of degree at most TWO, because its product with Gi is respectively ΦU² or a²ΦC². Their difference vanishes at a, so
\[
F1-F2=S(z-a)(cz+d)
\]
for constants c,d. The exact identity2(V−W)=(z−a)Φ/z now gives
\[
R\bigl[S-pz(z-b)\bigr]=zS(cz+d).
\]
Since R,S are coprime, R divides z(cz+d). Its degree THREE is larger than the degree at most TWO of the latter. Therefore c=d=ZERO,
\[
F1=F2,\qquad S=pz(z-b).
\]
In particular R(0)≠0 and b≠0, by squarefreeness of Φ.

## The common smaller factor forces A to be a square

The polynomial C has degree TWO, because A2≠0. Thus F2 is S times a nonzero linear square and has degree FOUR. Equality F1=F2 forces U also to have degree TWO; its remaining linear square factor has the SAME root u as that of C. Consequently U(u)=C(u)=ZERO.

The identity U=zC−(z−a)A and C(a)=−A(a)≠0 show u≠a and A(u)=ZERO. Then C(u)=(u−a)A'(u) gives A'(u)=ZERO. Since A is quadratic with nonzero leading coefficient in characteristic FIVE,
\[
A=A2(z-u)^2.
\]
Its two derivative polynomials are therefore
\[
C=A2(z-u)(z+u-2a),\qquad
U=A2(z-u)\bigl((2u-a)z-au\bigr).
\]
Their other roots, allocated to G1 and G2, are
\[
s=au/(2u-a),\qquad t=2a-u.
\]
Here2u−a≠0 because U has degree TWO. The preceding ratio of values at a becomes
\[
\left(\frac{a}{2u-a}\right)^2=2.
\]
Put j=(2u−a)/a. Then j²=THREE, and direct substitution gives
\[
s=a(j+3),\qquad t=a(2j+4),\qquad b=a(j+4).
\]
These identities retain both possible square-root signs for j.

## Evaluation at ZERO is incompatible with j²=THREE

Since S=pz(z−b), F2(0)=ZERO and Φ'(0)=−pbR(0). Also W=(Φ'/2)(z−a)−Φ. The identity F2+G2=2W at ZERO gives
\[
3pR(0)t^2=abpR(0),\qquad\text{hence}\qquad ab=3t^2.
\]
Canceling a² and using j²=THREE turns this into
\[
j+4=3(2j+4)^2=3(j+3)=3j+4.
\]
Thus2j=ZERO, impossible because j²=THREE. This contradiction excludes EVERY remaining common cubic-root subset, with no choice of individual branch roots or assumption of a simultaneous closure.

Both positions of Q are now excluded. Only the genus-ONE quotient remains in degree FOUR after the separate rational exclusion. Both original étale X-maps were retained throughout; no Y-map or arbitrary separable substitute was used.
