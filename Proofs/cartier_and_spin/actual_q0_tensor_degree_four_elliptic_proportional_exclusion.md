# Proof: the remaining proportional shapes have too few possible branch values

Version2,3 October2026. Independently accepted in the [whole degree-four audit](../../Research/audits/Q0_TENSOR_DEGREE_FOUR_WHOLE_RECOGNITION_AUDIT_2026_10_03.md). The nonsquarefree auxiliary polynomial below is used only for explicit identities; it is not treated as a smooth genus-two model. The first three sections retain Version1. The new univariate reduction and field-degree obstruction close the remaining two classes.

Scale D to ONE in the accepted [proportional elliptic normal form](actual_q0_tensor_degree_four_elliptic_hyperelliptic_form.md). Absorb b1 into the cubic model, and write b=z−e, e≠0,a. Set Y=b y and
\[
\Psi=b^2\Phi=az[A^2+(1-z^3)(z-a)].
\]
Thus Ψ has degree FIVE, a simple root at ZERO, Ψ(a)≠0, and the actual X-coordinates become
\[
X_1=A/[z(z-a)]+Y/[z^2(z-a)],\qquad
X_2=A/[\kappa(z-a)]+\kappa Y/(z-a),\quad \kappa^2=1/a.
\]
Although Ψ has a double root, its field is exactly the original elliptic field. No smooth genus-two result is imported.

## The extra root e is ordinary

Suppose Φ(e)=0. Use a local parameter t with z−e a unit times t². The odd part of each Xi has order THREE there, because b vanishes once and y once. Its even part contributes an order-TWO term unless its z-derivative vanishes. Every actual ramification index is ONE or THREE. Hence both even derivatives vanish at e. In the usual notation
\[
U=A'z(z-a)-A(2z-a),\quad C=A'(z-a)-A,
\]
this gives U(e)=C(e)=0. Since U=zC−(z−a)A and e≠a, A(e)=0 and then A′(e)=0. Thus A has a double root at e. But Ψ has order THREE at e, while A² has order at least FOUR. The other summand (1−z³)(z−a) either is nonzero at e or has order ONE, since e≠0,a. This contradicts Ψ=az[A²+(1−z³)(z−a)]. Therefore Φ(e)≠0.

## Polynomial factors and the trivial class

Put δ0=y d/dz and δY=Y d/dz=bδ0. The cleared derivative norm squares for δY are b² times those for δ0, so their polynomial square roots have degree FIVE and vanish at a. Define V,W from Ψ as in the explicit [genus-two factor identities](actual_q0_tensor_degree_four_nonweierstrass_square_class_reduction.md), and Fi=Vi−Hi,Gi=Vi+Hi. These exact identities remain valid:
\[
F_1G_1=\Psi U^2,\quad F_2G_2=a^2\Psi C^2,
\quad F_1+G_1=2V,\quad F_2+G_2=2W.
\]
The large factors have degree FIVE, leading coefficients4p0 and3p0 for p0=lead Ψ, and value−Ψ(a) at a. If A2=0, the nonzero constant C makes G2=3Ψ, contradicting its value at a. Hence A2≠0.

The rational square class of each Gi is b times the original δ0 derivative class. As Φ has three simple finite roots and e is ordinary, a trivial original class makes the odd-root factor of each Gi exactly z−e. The degree-FIVE square factor must then be U² or C²: the double factor at e cannot supply an extra square unless the relevant derivative polynomial already vanishes there, and every other available even multiplicity comes from that derivative polynomial. Consequently
\[
G_1=-(z-e)U^2/(a-e),\quad
G_2=-a^2(z-e)C^2/(a-e),\quad
F_1=F_2=-(a-e)\Psi/(z-e).
\]
The one-root coefficient argument in the cited proof applies as a POLYNOMIAL argument: its hypotheses are degree FIVE, a simple zero at ZERO, Ψ(a)≠0, these factor identities and A2≠0; no distinctness of the other roots occurs in its comparisons. It forces t=A2² with t²=3, A1=−aA2(1+t), A0=−a²A2(1+t), a³=t+3. The linked factor identity forces Ψ(d)/d=0 at d=a(4+2t), whereas direct substitution gives Ψ(d)/d=a²(3+4t)≠0. Thus the trivial original class is excluded.

## The class Φ/z is impossible

Write Φ=pz(z−r)(z−s), where 0,r,s are distinct and e is different from all three. Suppose the original class is represented by (z−r)(z−s)=Φ/(pz). The common odd-root factor of the large factors is then
\[
R=(z-e)(z-r)(z-s),\qquad \Psi=R S,\quad S=p(z-e)z.
\]
Write G1=4pR(z−h)²,G2=3pR(z−j)². Evaluation at a makes 4(z−h)²−3(z−j)²=(z−a)(z−b0). The linear square factors divide U,C respectively, by the product identities: the only double root of Ψ is e, and its odd multiplicity in R prevents an additional square at e without the same zero in U or C. Hence F1,F2 are S times linear squares. Their difference has value ZERO at a and is S(z−a)(cz+d).

The identity2(V−W)=(z−a)Ψ/z now yields
\[
R[S-pz(z-b0)]=zS(cz+d).
\]
Cancel p(z−e)z to get
\[
(b0-e)(z-r)(z-s)=z(cz+d).
\]
At ZERO, rs≠0 forces b0=e and then c=d=0. Thus F1=F2 and S=pz(z−e).

The remaining part of the [common smaller-factor proof](actual_q0_tensor_degree_four_genus_two_quotient_exclusion.md) now uses only these identities, rather than squarefreeness of Ψ. It gives A=A2(z−u0)² and j0=(2u0−a)/a with j0²=3, h=a(j0+3), j=a(2j0+4), b0=a(j0+4). Since R(0)≠0, evaluating F2+G2=2W at ZERO gives ab0=3j². Substitution yields j0+4=3j0+4, contrary to j0²=3. This excludes Φ/z.

Only the two classes containing ZERO remain at this point. Their cancellation equation has a genuine degree-TWO right side, so they require the following new argument.

## The remaining class fixes A up to its leading scalar

Name the roots so Φ=pz(z−r)(z−s) and the original class is z(z−r). Both choices of r among the two nonzero roots are included. The auxiliary factors are R=(z−e)z(z−r), S=p(z−e)(z−s). The preceding cancellation equation now gives
\[
(z-r)[(b0-e-s)z+es]=(z-s)(cz+d).
\]
At r this forces d=−cr. Comparing coefficients then gives c=−e,d=er,b0=s. Consequently
\[
4(z-h)^2-3(z-j)^2=(z-a)(z-s),
\qquad F_1-F_2=-ep(z-e)(z-s)(z-a)(z-r).
\]
Choose α with α²=THREE; the two signs are retained. Factoring the first quadratic as 2(z−h)±α(z−j) gives
\[
h=(3+\alpha)a+(3-\alpha)s,\qquad
j=(3-2\alpha)a+(3+2\alpha)s.
\]
Because the allocated square factors divide U,C, one has U(h)=C(j)=0. Neither h nor j equals a. Solving these TWO linear equations in A1,A0 gives
\[
A1/A2=(4-\alpha)a+(2+\alpha)s,
\]
\[
A0/A2=(1+3\alpha)a^2+as+(1+2\alpha)s^2.
\]
Put u=(s−a)/a≠0, t=A2²≠0, and abbreviate
\[
C0=2+\alpha,\quad D0=3+\alpha,\quad E0=4+3\alpha,\quad k0=4-2\alpha,
\]
\[
m=1+C0u,\quad v=(1+2\alpha)u^2-2-C0u,
\quad n=4+C0u+D0u^2,\quad M=4+D0u,
\]
\[
N=M+un,\quad T=N+k0u^2n,\quad \sigma_0=1+u.
\]
Thus A(aZ)=A2 a² Abar(Z), where Abar=Z²+mZ+v. The leading and constant coefficients in the displayed smaller-factor difference determine
\[
\epsilon=e/a=-tn/(t-1),\qquad \rho=r/a=M/n.
\]
For clarity, division of U,C by their allocated roots, in normalized coordinates, gives a difference of quadratic squares with leading coefficient n, a root at Z=ONE and constant coefficient M. Thus that difference is n(Z−1)(Z−ρ). Its leading coefficient equals −ε(t−1)/t, which proves both formulas. In particular n≠0 follows from e,p,t≠0. Here t≠ONE because Ψ has degree FIVE. No vanishing denominator was discarded.

The z3 coefficient of Ψ=az[A²+(1−z³)(z−a)] gives tT=N. Since T−N=k0u²n≠0, T cannot vanish in an actual solution; hence
\[
t=N/T,\qquad \epsilon=N/(k0u^2),\qquad \rho=M/n.
\]
Also N≠0. The root at s gives
\[
a^{-3}=\ell=\sigma_0^3-t u(3+E0u)^2\ne0.
\]
The complete normalized quartic identity still required is
\[
t\operatorname{Abar}(Z)^2+(\ell-Z^3)(Z-1)
=(t-1)(Z-\epsilon)^2(Z-\rho)(Z-\sigma_0).
\]
Its leading and z3 coefficients already agree. Clear the THREE remaining coefficients by k0u²T. Set Ms=3+E0u. They are
\[
P2=k0u^2N(2+E0u^2)+nN^2+2k0u^2N(M+n\sigma_0)+k0^2u^4M\sigma_0,
\]
\[
P1=k0u^2[T\sigma_0^3+N(2mv-uMs^2)-2NM\sigma_0]-N^2(M+n\sigma_0),
\]
\[
P0=k0u^2[N(v^2+uMs^2)-T\sigma_0^3]+N^2M\sigma_0.
\]
All THREE must vanish. They have degrees8,9,9. The root at σ0 gives σ0²P2+σ0P1+P0=0.

## One tiny exact identity leaves two shapes

The fresh [univariate source](../../scripts/genus_two/oct03_q0_degree_four_proportional_univariate_gate.py) directly multiplies the normalized quartic, derives the three coefficients, checks U(h)=C(j)=0 and the large-factor quadratic identity, then checks a Bézout identity. It gives
\[
B2\,P2+B1\,P1
=u^3+(4\alpha+4)u^2+\alpha
=(u+\alpha+2)(u-1)(u-2\alpha-2),
\]
where
\[
B2=(\alpha+3)u^5+(4\alpha+2)u^4+(2\alpha+2)u^3+(3\alpha+1)u^2+(4\alpha+2)u+\alpha+3,
\]
\[
B1=(\alpha+3)u^4+(4\alpha+3)u^3+4\alpha u^2+3u+\alpha+4.
\]
At u=−α−2, M=4+(3+α)u=0 and n=M(1+u)=0, excluded by the actual leading coefficient above. Therefore every actual candidate has u=ONE or u=2α+2. Both values lie in F25. The same formulas retain both α signs and both class choices. All denominator, branch-distinctness, degree and non-Weierstrass opens are recorded in the [receipt](../../../litt3-computation-data/oct03_q0_degree_four_proportional_univariate_gate/gate.json); none was used to drop a valid edge. The successful exact phase took0.048139 CPU seconds with a ten-second cap and one core. A prior receipt-serialization failure was repaired; no input calculation or settled arithmetic was replayed.

## The fixed P has only two possible values in their branch field

For either residual shape, t,a³,m,v lie in F25. Scale z=aZ and set ξ=X1/A2. Eliminating Y from the ACTUAL map gives the irreducible quartic equation
\[
t[Z^3(Z-1)\xi^2-2Z^2\operatorname{Abar}(Z)\xi+\operatorname{Abar}(Z)^2]-\ell+Z^3=0.
\]
All its coefficients lie in F25. Its smooth normalization is the actual elliptic B, with separating degree-FOUR map ξ and infinity profile(3,1). Hence this cover descends to F25. Hurwitz and the actual local indices ONE/THREE give exactly THREE distinct finite branch values. Their reduced degree-THREE divisor is F25-rational, so each value belongs to F25⁶=F5¹². Also A2²=t and the original centering scale √D belong to F25²⊂F25⁶. Therefore the THREE original finite branch values of X1, transformed back to x, all lie in F5¹².

Use the settled fixed-P arithmetic, recorded by the original [arithmetic source](../../scripts/arithmetic/pro_k_etale_symmetry.py), without running it again. In the F25 code convention ν²=ν+3,
\[
P=(x-[9])(x-[14])f4g4,
\]
with ascending coefficients f4=[18,15,10,4,1],g4=[8,2,21,11,1], both irreducible quartics over F25. Thus all roots lie in F25⁴=F5⁸, and precisely TWO lie in F25²=F5⁴. But F5⁸∩F5¹²=F5⁴. The THREE distinct finite branch values just obtained are required by the actual cover to be roots of P. This is impossible.

The proportional non-Weierstrass case is therefore wholly excluded. The accepted [Weierstrass-Q theorem](actual_q0_tensor_degree_four_elliptic_weierstrass_pole_exclusion.md) supplies the other position, and the accepted [coprime theorem](actual_q0_tensor_degree_four_elliptic_coprime_exclusion.md) supplies the other numerator case. No elliptic-genus assertion or replacement of the original Y-leg is made.
