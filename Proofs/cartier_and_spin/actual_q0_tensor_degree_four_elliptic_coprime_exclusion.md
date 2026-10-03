# Proof: a quadratic common-class packet has no solutions

Version1,3 October2026. Independently accepted in the [whole degree-four audit](../../Research/audits/Q0_TENSOR_DEGREE_FOUR_WHOLE_RECOGNITION_AUDIT_2026_10_03.md). The new implication is the complete two-root-class parameterization and its bounded necessary-equation contradiction. No fixed-X arithmetic is repeated.

The [Weierstrass-Q exclusion](actual_q0_tensor_degree_four_elliptic_weierstrass_pole_exclusion.md) leaves non-Weierstrass Q. The [trivial class](actual_q0_tensor_degree_four_elliptic_trivial_class_exclusion.md) and [marked class Φ/z](actual_q0_tensor_degree_four_elliptic_marked_class_exclusion.md) are excluded separately. Use their common notation in the accepted coprime normal form, scaling D to ONE:
\[
b=vz+w,\ c=z+u,\ L=L1(z+l),\ T=L1^2\ne0,
\quad \Phi=z[T(z+l)^2+(z-\omega^2)(z-a)],
\]
\[
a=\omega^2w^2,\quad b_a=va+w\ne0,\quad c_a=a+u\ne0,
\quad p=T+1\ne0,\quad v,w\ne0.
\]
All three roots of Φ are distinct. Name them0,r,s so the remaining class is z(z−r). Either nonzero root may be r, so both classes are covered. Also a is not a branch root.

Let Ubar,Cbar be the derivatives U,C divided by L1, and retain V,W unchanged. The large factors must be
\[
G1=4v[\Phi/(z-s)](z-h)^2,\qquad
G2=3[\Phi/(z-s)](z-j)^2.
\]
Their allocated linear factors divide Ubar,Cbar. The small factors are the complementary linear branch factor times polynomial squares. These statements include a possible degree drop of Ubar. No condition Ubar has degree TWO is imposed.

## Two coefficients determine the whole packet

At a, the large-factor values are −b_aΦ(a),−c_aΦ(a). Thus
\[
4v(a-h)^2=-b_a(a-s),\qquad
3(a-j)^2=-c_a(a-s).
\]
In particular J=j−a is nonzero. Put β=(h−a)/J. Then
\[
\beta^2=2b_a/(vc_a)\ne0,\qquad h=a+\beta J.
\]
This β retains BOTH square-root signs. Write ζ=J²/c_a≠0. The second a-value identity gives
\[
s=a+3\zeta.
\]
The allocated-root equation Cbar(j)=0 gives
\[
l=vJ^2/b_a-a=2\zeta/\beta^2-a.
\]
Substituting this into Ubar(h)=0 and canceling J² gives
\[
\beta^2\zeta+2\beta J+a(1+2u/v^2)=0.
\]
Every canceled factor is nonzero: a,β,J,v,b_a,c_a,L1. No division by u is used. Consequently
\[
J=-[\beta^2\zeta+a(1+2u/v^2)]/(2\beta),\qquad
E(\zeta)=J^2-c_a\zeta=0.
\]
The polynomial E has degree TWO with leading coefficient β²/FOUR, so its monic normalization never loses an actual degree edge.

## The apparent β²=ONE boundary is impossible

Suppose β²=ONE. From b_a²=ac_a² and β²=2b_a/(vc_a), obtain v²=4a and v(u−a)=2w. The coprime cubic coefficient relation2u−v²=−a−ONE−ω then gives2u=3a+ω². Squaring v(u−a)=2w and using a=ω²w² gives (u−a)²=ω. Hence u−a=±ω² and a=(2ε−ONE)ω², where ε=±ONE.

Since l=2ζ−a and s=a+3ζ, s+l=ZERO. The actual root Φ(s)=0, with s,ζ≠0, forces s=ω². If ε=ONE, a=ω²=s contradicts non-Weierstrass Q. If ε=−ONE, a=2ω²,u=ω²,c_a=3ω². Then ζ=3ω² and J²=c_aζ=4ω. But a(ONE+2u/v²)=ZERO, so the displayed linear relation gives J=ω²/β and J²=ω. This is again impossible. Therefore β²≠ONE.

## Both sign families and all parameter denominators

The coprime sign formulas give b_a=δωw c_a, with δ=±ONE. Thus β²=2δωw/v. In these two sign families, all possible parameters are
\[
u=3\omega^2/(\beta^2-2)\qquad(\delta=+1),
\]
\[
u=-(4\omega+3)(\beta^2+1)/[(3\omega+2)\beta^2+4\omega+1]\qquad(\delta=-1).
\]
The positive denominator cannot vanish because its defining relation is (β²−TWO)u=3ω². In the negative case simultaneous numerator and denominator zero would require β²=FOUR, where the denominator equals ω+FOUR≠0. Thus no actual denominator-zero branch was removed. The valid u=ZERO negative-sign case is retained.

In either family put
\[
v=[\delta\omega^2(\omega+u)-(1+u)](3\omega+1),\qquad w=1+u-v.
\]
Now Φ(s)=0, l=2ζ/β²−a and s=a+3ζ determine
\[
T=-3(s-\omega^2)/[\zeta(3+2/\beta^2)^2].
\]
The denominator is nonzero: ζ≠0 and3+2/β²=ZERO is exactly the β²=ONE boundary already excluded. The actual T and p remain nonzero. The test below omits their numerator opens, enlarging the necessary locus rather than discarding an edge.

## Exact coefficient reduction and the unit resultants

All functions now belong to F25(β,ζ), where ω²+ω+ONE=ZERO, and E is a monic quadratic over F25(β). Define
\[
\operatorname{Abar}=c(z+l),\quad \operatorname{Bbar}=b(z+l),
\]
\[
\operatorname{Ubar}=\operatorname{Abar}'z(z-a)-\operatorname{Abar}(2z-a),\qquad
\operatorname{Cbar}=\operatorname{Bbar}'(z-a)-\operatorname{Bbar},
\]
\[
V=(v\Phi+b\Phi'/2)(z-a)-b(3\Phi-2a\Phi/z),\quad
W=(\Phi+c\Phi'/2)(z-a)-c\Phi.
\]
The TWO complete necessary norm-product equations are
\[
G1(2V-G1)-\Phi T\operatorname{Ubar}^2=0,
\qquad G2(2W-G2)-\Phi T\operatorname{Cbar}^2=0.
\]
Every z-coefficient must vanish. Clear its ζ-denominator and reduce the numerator modulo E. This gives14 nonzero equations A_i(β)ζ+B_i(β)=0 in each δ family. Coefficient degree drops, including A_i=ZERO at a candidate, are retained. For each equation form the resultant with the fixed monic quadratic E. An actual common ζ-root would make all14 resultants vanish. The degree of an equation may drop without invalidating that necessary condition.

The fresh [source](../../scripts/genus_two/oct03_q0_degree_four_coprime_quadratic_gate.py) constructs these exact equations. Before elimination it checks the sign identity, β² ratio, Φ(s)=0, Ubar(h)=Cbar(j)=0 modulo E and BOTH large-factor values at a. It then expands both full norm products, derives the14 linear remainders and takes the14 univariate resultants. In BOTH δ families their RAW gcd in F25[β] is ONE. No factor was removed from either gcd.

The source also checks the coefficient poles of E and the reduced equations against the known actual nonzero factors β,β²−ONE, the displayed u-parameter denominator, and a,w,v,b_a,c_a. There is no uncontrolled coefficient-pole factor. All original rational formulas have only these β-poles and the justified ζ-denominator. Thus specialization at an actual candidate is valid. The [receipt](../../../litt3-computation-data/oct03_q0_degree_four_coprime_quadratic_gate/gate.json) records the original rational coefficients, all14 remainders and resultants in each family, raw gcds and pole checks. The bounded phase took1.059751 CPU seconds with a ten-second cap and one worker. No candidate or fixed-P root sweep was performed.

The unit gcds exclude both remaining classes in both sign families. Together with the trivial, marked and Weierstrass-Q exclusions this closes the whole coprime elliptic form. No arbitrary separable map or replaced Y-leg is used.
