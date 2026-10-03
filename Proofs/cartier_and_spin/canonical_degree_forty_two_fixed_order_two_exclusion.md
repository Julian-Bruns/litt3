# Proof: the degree-ten scalar gate misses every actual fixed coordinate

Version1,3 October2026. [Statement](../../Theorems/cartier_and_spin/canonical_degree_forty_two_fixed_order_two_exclusion.md). [Independent whole-case review PASS](../../Research/audits/BACKUP42_WHOLE_REPAIRED_EXCLUSION_AUDIT_2026_10_03.md). Both original étale maps and all source sections are retained.

Use the exact actual [differential shape](canonical_degree_forty_two_differential_shape_reduction.md). At a fixed origin put x=b/q,Q=q⁻⁴,A=1+3Q. With L the leading even w⁷ coefficient of g and t the leading odd y w⁸ coefficient of h, that proof and the fixed-coordinate substitutions give
\[
L/q^2=x^2+Ax+4=(x-2)^2+3Qx,
\qquad t/q^3=-(x-2)^3+Q(3x^2-1).
\]
The exact H pole NINETEEN forces t=0. The norm and primitive leading coefficients give τ=−L³=4q³/b, so
\[
Q=\frac{(x-2)^3}{3x^2-1},\qquad
x[(x-2)^2+3Qx]^3=Q.
\]
Here Q≠0. The denominator cannot vanish: otherwise the first equation before division would force x=2, where3x²−1≠0. Likewise x−2≠0. Since
\[
(3x^2-1)+3x(x-2)=x^2-x-1,
\]
eliminating Q yields
\[
P(x):=x(x-2)^3(x^2-x-1)^3-(3x^2-1)^2=0,
\]
or explicitly P=x¹⁰+x⁹+x⁷+4x⁶+2x⁵+3x⁴+3x²+3x+4.

All actual fixed-origin Q values are in F₁₂₅, so Q¹²⁵−Q=0. The [native exact source](../../scripts/genus_two/oct03_backup42_fixed_cone_two_finite_field_gate.py) computes in F₅[x], with no external CAS or Gröbner basis. It verifies the denominator inverse modulo P, the modular Frobenius value and the exact Euclidean witness. Its [receipt](../../../litt3-computation-data/oct03_backup42_differential_shape/fixed_cone_two_finite_field_gate.json) records ascending coefficient lists. Concretely, writing Q as a polynomial modulo P, the Frobenius difference is
\[
C_9=x^9+3x^8+3x^7+4x^6+4x^5+2x^4+3x^3+2x^2+3x.
\]
The checked identity is
\[
(x^5+x^4+3x^3+4x^2+3x+1)P
 +(4x^6+x^5+x^4+x+2)C_9=x^3+x+4.
\]
Thus every admissible x satisfies x³+x+4=0. Reducing the rational Q expression in that cubic gives Q=1+3x+x². The cubic has no F₅ root and is irreducible.

Write BACKUP α³+α+1=0 and r=α+1. The three possible x are−α and its Frobenius conjugates, so their Q values are exactly the Frobenius conjugates of r². From r³=3r²+r+1 and r⁴=4r+3 these are
\[
r^2,\qquad r^{10}=r^2+3r+2,\qquad
r^{50}=r^{19}=3r^2+2r+4.
\]
Here r³'s constant gives norm(r)=1 and hence r³¹=1, permitting the exponent reduction50→19.

We now compare the ACTUAL five fixed-origin coordinates. The selected branch set is P¹(F₅) minus4, together with α. For P=a∈{0,1,2,3}, a fractional linear map fixing4 and sending a to infinity can be chosen as
\[
m_a(z)=4+D\frac{z-4}{z-a},\qquad D\in F_5^\times.
\]
It preserves the fixed branch set and sends the moving parameter to α′=mₐ(α). In the ensuing normalized fixed model q=−(1+α′)=−D r/(α−a). Its fourth inverse is therefore
\[
Q_a=((\alpha-a)/r)^4,
\]
independent of D. At the original infinity origin Q∞=r⁻⁴. Direct reductions with r's cubic give

|origin|actual Q|
|---|---|
|∞|r²+4|
|0|4r²+r+3|
|1|3r²+3|
|2|r²+2r+1|
|3|r²+2r+3|

For example r⁻¹=r²+2r+4,r⁻²=4r²+4r+3,r⁻³=3r²+1 and r⁻⁴=r²+4; expanding (1−(a+1)/r)⁴ gives the table. Since1,r,r² are linearly independent, none of its FIVE entries equals any of the three candidate Q values. This contradiction excludes every fixed order-two BACKUP carrier.

The sole computation was one fresh exact polynomial Euclidean/Frobenius gate, completed in0.0008 CPU seconds on one core. Its source verifies its identities directly and preserves the witness outside the research workspace. Every geometric and coordinate implication is explicit above; no source or second endpoint map was replaced.
