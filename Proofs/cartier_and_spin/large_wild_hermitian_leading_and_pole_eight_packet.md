# Proof: leading compatibility, a common remainder ratio, and pole-eight Frobenius freedom

Version1,3 October2026. [Statement](../../Theorems/cartier_and_spin/large_wild_hermitian_leading_and_pole_eight_packet.md). Pending independent review. Retain the actual-source scope and functions in the [Version2 large-wild reduction](large_wild_spin_frobenius_and_cubic_reduction.md), and the new [remainder jet lemma](large_wild_hermitian_remainder_jet_constraints.md). These new implications require no numerical calculation or historical certificate replay. No source or endpoint map changes.

## A bounded primitive leaves only L(8P) Frobenius freedom

The existing packet gives dK1=\(\mathcal R_1\)F³σ, K1∈L(40P), and \(\mathcal R_1\)∈L(21P) ordinarily/tamely or L(27P) in the distinguished-wild case. Cartier exactness gives C(\(\mathcal R_1\)F³σ)=0.

Use the monic quintic y²=Φ(z), σ=dz/y, with P at infinity. Write F³σ=Udz+Vσ. If F has pole7, degU≤8,degV≤10 and \(\mathcal R_1\)=A10+yB8. Multiplication gives invariant coefficient A10U+B8V of degree≤18, and odd coefficient A10V+ΦB8U of degree≤21. The degree-ten bound includes the mixed term3AΦB² in F³; it leaves the ensuing degree21 bound unchanged. If F has pole5, degU≤5,degV≤7 and \(\mathcal R_1\)=A13+yB11; the same two bounds18 and21 follow.

The explicit polynomial-sector integration in the preceding reduction therefore yields a primitive H1 regular away from P. Its invariant polynomial degree is at most19, giving pole38. For the odd sector, VnewΦ² has degree≤31 and a primitive of degree≤32. Interpolation by a fifth power of a degree≤4 polynomial cancels the five branch-root constants; division by Φ³ then gives degree≤17, hence odd primitive pole≤39. Thus H1∈L(39P) in every distinguished position.

Now d(K1−H1)=0. Its fifth root K2 is regular off P and has pole≤8P, since K1−H1 has pole≤40P. Substituting K1=H1+K2⁵ into the earlier packet gives the exact displayed G decomposition. This construction does not claim that K2 vanishes.

## A leading coefficient relation omitted by the scalar alone

At an unramified wild point, set t=F and f=β⁻¹=t¹⁰⁰⁰G⁻⁷. Denote a=c1000,b=c1120,d=c1144. Full Hermitian normality supplies f=A F8(φ(t)), with φ(t)=μt+O(t²), and consequently
\[
a=A\mu^{1000},\quad b=3A\mu^{1120},\quad d=3A\mu^{1144}.
\]
The first possible leading-term correction has increment125, and the1120-term cannot contribute to1144 because its increments are divisible by FIVE. Thus these coefficient formulas are exact even for a general source change. Since6·1120=1000+5·1144, characteristic FIVE gives
\[
b^6+2ad^5=0.
\]
This relation is required in addition to constancy of the fixed-base scalar; it holds for every local target multiplier A, so no target normalization was silently imposed.

The preceding reduction computes a=G(R)⁻⁷, b=3G(R)⁻⁸J24⁵, d=2cfR G(R)⁻⁸. Substitution gives
\[
J_{24}^{30}+c^5 f_R^5G(R)=0,
\quad\text{hence}\quad J_{24}^6=4cf_RJ(R).
\]
Here G(R)=J(R)⁵ and fifth roots are unique in k. Since J24=4\(\mathcal R(R)\)fR, FOUR to the sixth power is ONE, and J(R)=K1(R)⁵, cancellation gives exactly
\[
\mathcal R(R)^6f_R^5=4cK_1(R)^5.
\]
All cancelled quantities are nonzero at these actual unramified wild points.

## The common ratio and its small residual divisor

The preceding Hermitian scalar is
\[
\mathcal J_R=\frac{\mathcal R(R)^{625}f_R^{500}}
{c^{125}K_1(R)^{525}}.
\]
Raise the new leading relation to the hundredth power to replace fR⁵⁰⁰. FOUR to the hundredth power is ONE, so this simplifies the expression to (\(\mathcal R(R)\)/(cK1(R)))²⁵. The actual Γ quotient identifies all these completions over the SAME β field, so their scalars agree. The twenty-fifth power is injective over k, and therefore \(\mathcal R/K_1\) has one common nonzero value λ on this fiber. The leading relation also gives \(\mathcal R(R)\)fR⁵=4c/λ⁵.

The remainder jet lemma kills the first THREE Taylor coefficients of \(\mathcal R\). The existing K1 packet kills the first THREE Taylor coefficients of K1. Their values agree after multiplying by λ, so \(\mathcal R-\lambda K_1\) has zero order at leastFOUR at every finite F-zero. It has no other finite pole. Consequently W=(\(\mathcal R-\lambda K_1\))/F⁴ is regular away from P. Ordinarily/tamely its numerator has pole≤41P and F⁴ has pole28P, giving W∈L(13P). In the distinguished-wild case the bounds are87P and20P, giving W∈L(67P). The double F-zero at P is accounted for only in these permitted pole bounds.

This is a small Frobenius remainder and a common-value constraint extracted from FULL completed-field normality. It does not replace that normality by one scalar, infer an endpoint atlas, or exclude the degree7000 carrier.
