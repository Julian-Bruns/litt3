# Reducing the trace system over its actual coefficient ring

30 September2026. [Statement](../../Theorems/cartier_and_spin/degree140_monic_eleven_trace_combination.md).
The nine input trace polynomials are the actual global polynomials from
the multiplied, positive and corrected companion constructions. Their
rational coefficients are retained in the
[external trace directory](../../../litt3-computation-data/seventeen_hour_continuation_20260929/traces/).
They lie in R=K[H^+-1,q^+-1,Psi^-1].

## Unit division in scale degree twelve

The exact leading coefficient of the normalized x*t trace is
<29601> q^15/H^33. It is read directly from the global coefficient
construction, not inferred from a finite sample of ratios.
Consequently ordinary monic polynomial division in R[mu] reduces all
other rows to degree at most eleven. For the certificate below only
rows0,2,6 are needed. Their original degrees are11,13,13, so the pivot
is multiplied by scale powers at most one. Their degree-eleven
coefficients therefore use only pivot coefficients in degrees10..12,
which the retained calculation includes exactly.

The first fixed-cutoff implementation was subsequently found unsafe
for the other, higher-degree rows: a discarded low coefficient can
contribute after a positive scale shift. Its broader truncated arrays
and the claimed degree-ten continuation must NOT be used. This does
not affect the three coefficients or the Bezout identity used here.
The replacement uses coefficient queries on the full operation graph.

The replacement
[exact operation-graph source](../../scripts/arithmetic/degree140_trace_exact_dag_20260930.sage)
has reconstructed every degree-ten leading coefficient from the full
inputs. It also checks equality of the three selected degree-eleven
coefficients above and the monic leading identity. A small independent
polynomial-division fixture specifically tests positive scale shifts
bringing lower coefficients into range, including nested shifts and
Laurent denominators. Its `selftest` mode passes. The replacement
checkpoint is `trace_exact_monic11_dag.sobj`; its queried leading
coefficients are in `trace_exact_monic11_leading.sobj`.

## A small leading-coefficient ideal

Let N_i denote the numerator of the degree-eleven coefficient in reduced
row i. Use indices0,1,2 for the multiplied family;3,4,5 for the positive
family;6,7,8 for the companion family. Row1 was the degree-twelve pivot.
The first leading numerator has the form
\[
N_0=q^{12}(a(q)H+b(q)),\quad \deg a=4,\quad b=cq^2,\ c\ne0.
\]
The fixed scalar is included in a,b. For i=2,6 let d_i=deg_H(N_i)=7.
The two univariate polynomials
\[
R_i(q)=a(q)^{d_i}N_i(-b(q)/a(q),q)
\]
have a known monomial factor q^{v_i}. After that factor is removed their
degrees are38 and39, and their exact gcd over K is1. This computation
does not assume a(q) nonzero at a sought parameter: the expressions
displayed here are polynomials, calculated by expansion without division.

Write a univariate Bezout identity u*R2/q^v2+v*R6/q^v6=1. For each i,
the exact polynomial identity
\[
a^{d_i}N_i-R_i=(aH+b)S_i
\]
defines S_i in K[H,q]. Substitution into the Bezout identity and clearing
only powers of q yields
\[
W_0N_0+W_2N_2+W_6N_6=q^{16}.
\]
The source checks this exact multivariate identity, including its scalar.
There are527,67,66 monomials in W0,W2,W6. Their H-degrees are6,0,0;
their q-degrees are80,78,77. Thus the certificate is much smaller than
expanding the full trace equations or computing their global resultants.

If the degree-eleven coefficient in row i is N_i/D_i, multiply that
entire row by W_i*D_i and sum. The leading coefficient is q^16.
All D_i are units of R, and q is invertible. Division by q^16 gives a
monic degree-eleven polynomial in the ideal of the actual traces.
No localization by a, by an endpoint coefficient, or by an undisplayed
exceptional polynomial enters this argument.

## Reproducible new calculation and scope

The exact source is
[degree140_trace_leading_bezout_20260930.sage](../../scripts/arithmetic/degree140_trace_leading_bezout_20260930.sage).
It reads the retained leading-row reduction, constructs the two
polynomial substitutions and a Bezout identity, and checks the displayed
identity in K[H,q]. Its compact mathematical output is
`trace_leading_bezout.sobj`, with a human-readable size/scope receipt
`trace_leading_bezout.json`, in the external trace directory.
The check and construction take about3.5 seconds on one calculation core.
Only a new consequence of the input polynomials was checked; no incoming
verification program was replayed.

The initial further fixed-cutoff row arrays are withdrawn because of
the shift issue above. The full polynomial combination certified here
is still monic, so formal polynomial division reduces every original
row to degree at most ten; the later coefficient values require the
replacement calculation. No degree-ten monic combination is established
by the withdrawn arrays.

All traces vanish at an admitted fully ramified nonzero scale by the
established trace criterion, so the constructed polynomial vanishes
there. A monic relation gives a useful finite scale constraint but does
not show that the joint equations have no solution. In particular no
actual two-map common-cover conclusion follows yet.
