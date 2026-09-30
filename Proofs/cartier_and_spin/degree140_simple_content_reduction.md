# Proof: primitive critical coefficients and the small critical root

[Statement](../../Theorems/cartier_and_spin/degree140_simple_content_reduction.md).

## Fixed content now has small support

At an affine point off t=0, put s=min(ord(g2),ord(g3),ord(g4)).
Homogeneity of the fixed-degree(10,2) resultant gives content
valuation10s. To see equality, divide the critical quadratic by
a uniformizer^s. Over the residue field with transcendental scale
it is nonzero, allowing degree zero or one. A common finite root
with f_lambda would force W^5+Qbar=0 and then t^3=0, impossible.
At an infinite root of the homogenized critical polynomial the
degree-ten f has value lambda, also nonzero. Thus the remaining
resultant is a unit in that Gauss valuation.

The [common-critical exclusion](degree140_common_critical_exclusion.md)
makes s=0 for every such point at a square specialization. Taking
the cubic norm preserves the sum of these content valuations,
including above ramified x-values. Hence no fixed x-content remains
away from the three roots of t. At each endpoint, the individual
bound gamma_p<=1 and three distinct sheets give n_i<=3. The
retained pole-rank theorem says at most one endpoint can have two
vanishing sheet values of the scale-linear coefficient. Two
positive-content sheets imply that condition. Consequently at most
one n_i exceeds one and deg c_W<=3+1+1=5.

The primitive norm curve is irreducible and separable over k(mu),
as established in the compact norm's spectral proof. It is coprime
to its removed fixed content. Therefore its full x-discriminant is
identically zero exactly when c_W has a repeated factor, now exactly
when some n_i>=2. This is a statement at square-specialization RATIOS,
not a claim that the discriminant is nonzero at their square scales.

The exact content and pole-rank proofs are retained in the
[earlier report](../../../litt3-computation-data/quartic_complete_partial_replies_20260927/extracted/constant/constant140_endpoint_content/REPORT.md),
sections headed "Exact local content away from t=0" and "Global
pole-rank theorem". Their established certificates are reused.

## Why a possible simple-content point has b0 nonzero

The critical polynomial of the translated cubic is aW^2+bW+c.
At an endpoint c is in(tau), and Md+N is in(tau^2). If b0=0,
the universal resultant gives
\[
[\lambda^0]\operatorname{Res}(f_\lambda,aW^2+bW+c)
 =\tau^5a_0^5d_0^2c_1^5\pmod{\tau^6}.
\]
The already verified endpoint incidences exclude both
(a0,b0)=(0,0) and (b0,c1)=(0,0) against the square ideal.
Since d0 is a unit, the displayed coefficient is then nonzero.
The divided resultant has content zero at that point. Thus a
positive-content point at a hypothetical square must have b0!=0.

## A single numerator detects simple content

When b0!=0, the critical polynomial has a unique small root
W(tau)=w1 tau+O(tau^2), with w1=-c1/b0. Using c=-aW^2-bW on
that root replaces its cubic value by aW^3+2bW^2+d. The exact
relation Md+N=tau^2 ell(tau) therefore gives
\[
f_\lambda(W(\tau))=
 \tau^5\bigl(\ell_0+d_0w_1^5+2m_0b_0w_1^2\bigr)
 +O(\tau^6).
\tag{1}
\]
The scale term begins in order six, so the leading expression is
independent of lambda. The other critical root, viewed projectively,
is distinct. If finite, W^5 is nonzero there, giving a nonzero
scale coefficient; if infinite, the degree-ten homogenization has
value lambda. Thus this other factor is a unit over the residue
field k(lambda), including when a0=0.

Dividing the resultant by tau^5 shows that its coefficient content
is positive exactly when the parentheses in(1) vanish. Multiplication
by b0^5 gives J_p in the statement. The source and parameter changes
from this resultant to the barred one multiply by units at the
endpoint, since P(r_i)!=0, so they preserve the content condition.

The universal low-order formula is
\[
[\tau^5]\operatorname{Res}(f_\lambda,aW^2+bW+c)
=J_p\bigl(b_0^5\lambda-a_0^3b_0^3-a_0^5d_0\bigr).
\tag{2}
\]
It is polynomial even at a0=0. The
[symbolic verifier](../../scripts/arithmetic/endpoint_simple_content_identity.py)
reconstructs all three scale coefficients of the universal resultant
and verifies(2) modulo tau^6 over F5, with independent indeterminates.
The DVR proof(1), rather than a constant-series fixture, justifies
arbitrary higher coefficients of the actual source.

The resulting two-sheet incidence has since been
[completely excluded](degree140_two_sheet_content_exclusion.md).
The remaining one-sheet incidence has the
[sparse chart and exceptional-locus exclusion](degree140_single_content_chart.md).
