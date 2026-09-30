# Proof of the degree-ten square-boundary statements

The returned reconstruction imposes the original congruences and pole
bounds in the affine ring k[x,y]/(y^3-P). Its1299x157 matrix has rank150
for each of the eleven fixed v. The particular vector and seven kernel
vectors are checked directly against every equation. Besides the
accepted third-coefficient identity, this gives on the entire spaces
\[
[x^{20}y]N_5=[8]\kappa,\quad [x^{23}]N_5=0,\quad
[x^{38}y](QN_5+\kappa t^3y^{10})=\eta\kappa.
\]
These are affine-linear identities verified on a basis; they are not
inferences from randomly sampled parameters.

The discriminant of D(Z)=3N2 Z^2+2N3 Z+N4 is4N3^2-12N2N4.
The two summands have poles92 and at most89 (constant v) or90 (linear
v). Since kappa!=0, the first leading coefficient is nonzero. Thus D
is a genuine separable quadratic throughout the open locus.

Use the parameter u=x^3/y at O. Then x=u^-3(1+O(u^3)) and
 y=u^-10(1+O(u^3)). The critical roots have leading forms
Zbig~N3/N2 and Zsmall=z u^-11+w u^-10+O(u^-9), with z=2d/b.
The first is of pole14 or13. Since the leading coefficient of D is
3N2, the factor (3N2)^10 F(Zbig) has leading coefficient M and pole
464 or467. At the small root the pole125 coefficient of F is
\[
[8]\kappa z^5+[24](bz^2+dz+f)=U.
\]
The pole124 coefficient is V: the unknown w cancels because2bz+d=0,
and the N5 Z^5 term has no such coefficient since [x^23]N5=0 and a
fifth power has no intermediate exponents. All remaining terms have
smaller poles. If U=0 this calculation remains valid, including z=0.

The cubic norm of a function with unique pole of order m on X has
polynomial degree m and leading coefficient the cube of that local
leading coefficient. The residual denominator is monic of degree445
or448. This proves both asserted coefficient identities. If d=0 and
U=0, then V=eta kappa!=0, proving the extra necessary condition.
The proof is a formal valuation argument; the22 initial and22 boundary
numerical evaluations in the archive only audit its constants.

The direction K5=y^2 P t^2 preserves every linear equation and open
condition when added to N5: y^2P=y^5 gives the branch congruence,
(Q-L0^5)K5 is divisible by t^5, and the infinity bounds are satisfied.
Along any such line, D is constant and F is affine in its parameter s.
The resultant is quadratic in s and its cubic norm has degree<=6.
Thus seven distinct field-element evaluations reconstruct R0(s,x)
exactly; extra evaluations independently check the interpolation.

For each of the eleven specific lines in the certificate, write
R0=L(s)x^144+r1(s)x^143+... . The formal square-root numerators obey
\[
H_0=1,\qquad
H_n=\frac{r_n L^{n-1}-\sum_{i=1}^{n-1}H_iH_{n-i}}2.
\]
A degree72 polynomial square root with L!=0 requires H73=H74=0.
The stored exact Bezout identity for each line is
B73 H73+B74 H74=monic(L)^10. Its right side does not vanish off L=0.
Each L is a scalar times the cube of one linear factor; at its only
geometric root the full residual has degree143. This proves entire
line exclusions including their leading boundary. No identity for the
remaining six free parameters is claimed.

The degree142 examples solve V=0 by a separate affine direction and
then U=0 by the K5 direction. The evaluator checks the full equations,
nonzero kappa, exact D2 pole, actual degree142, and nonsquareness.
They prove that U=V=0 occurs, without furnishing a square or a cover.

The [original report](../../../litt3-computation-data/geometric_bottleneck_replies_20260925/extracted/degree10_square/REPORT.md)
contains every line, point and coefficient convention. The
[retained verifier](../../scripts/arithmetic/pro_geometric_bottlenecks_20260925/degree10/src/verify.py)
rebuilds the full data, both resultant algorithms, every Bezout identity
and all lower-degree examples. The [local replay](../../../litt3-computation-data/geometric_bottleneck_replies_20260925/local_checks/degree10.log)
passed, regenerating all46 data files. Boundary and zero-polynomial
conditions were preserved. The full geometric square locus is open.
