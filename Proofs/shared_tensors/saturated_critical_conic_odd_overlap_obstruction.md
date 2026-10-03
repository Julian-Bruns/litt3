# Proof: a conic parameter has an odd pole degree and two even fibers

Version1, 3 October 2026. [Independent whole-scope audit PASS](../../Research/audits/OCT03_NONSPLIT_RESIDUAL_TWENTY_ALL_DEGREE_PARITY_WHOLE_AUDIT_2026_10_03.md), with no required corrections. The argument was independently discovered in [the degree25 research note](../../Research/notes/oct03_ten_hour/residual_twenty_degree25_three_full_fibers.md), with its explicit leading-ratio-one hypothesis. See the [statement](../../Theorems/shared_tensors/saturated_critical_conic_odd_overlap_obstruction.md).

The conic equation gives
\[
(B-A)(A+B)=(z^3-1)(A^2+d_0).
\]
Nonconstancy of z makes z³−1 nonzero. It also makes D1 nonempty, so A has poles and A²+d0 is nonzero. If A+B were identically zero, the conic would force z³=1, a contradiction. Thus both displayed denominators below are nonzero rational functions.

Define
\[
F=\frac{B-A}{z^3-1}=\frac{A^2+d_0}{A+B},\qquad
H=F-A=\frac{d_0-AB}{A+B}.
\]
All equalities hold in k(C), so different expressions may be used in different local rings. The direct identity
\[
(d_0-AB)^2+d_0(A+B)^2=(A^2+d_0)(B^2+d_0)
\]
proves H²+d0=z³F².

We audit all possible poles of H. Outside J+D1+D2, A and B are regular and z³−1 is a unit; hence H=F−A is regular. At D1, use H=(B−z³A)/(z³−1). Here z³A has order three and B is regular, while z³−1 is a unit, so H is regular. At D2, B−A has pole order three and z³−1 pole order six, so F has zero order three and H=F−A is regular. Finally at P∈J, the leading equality gives A=l u⁻³+lower-pole terms and B=l u⁻³+lower-pole terms. The denominator A+B has exact pole order three with leading coefficient2l, and d0−AB has exact pole order six with leading coefficient−l². Thus H has exact pole order three. There are no other points to consider, and
\[
\operatorname{div}_\infty(H)=3J.
\]

If J is empty the conclusion is already true. Otherwise H is nonconstant. Since div(z) is even,
\[
\operatorname{div}(H^2+d_0)=3\operatorname{div}(z)+2\operatorname{div}(F)
\]
is even. Choose a²=−d0. Characteristic different from two and d0≠0 make a and−a distinct. At a zero of H−a, H+a is the nonzero value2a, so each zero of H−a has even order; similarly for H+a. But H−a has the same pole divisor3J as H, and its zero divisor has degree3deg(J). Hence deg(J) is even. This divisor proof includes inseparable H and uses no derivative or Jacobian argument.

The hypotheses that z is nonconstant, that z³−1 has no finite zeros away from J, and that the common leading ratio is ONE are substantive. Extra finite zeros can produce additional poles of H, and leading ratio minus one changes the common pole calculation. In an application a global sign may be calibrated on rational functions without changing either actual endpoint map; that calibration must be proved separately.
