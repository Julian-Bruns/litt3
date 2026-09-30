# Endpoint residues after identifying their content denominator

30 September2026. [Statement](../../Theorems/cartier_and_spin/degree140_endpoint_top_trace_formulas.md).
Use the accepted normalized critical curve and the new
[exact local content factor](degree140_endpoint_content_jet_factor.md).
This calculation uses no incoming verification replay.

At a type-A endpoint the integral critical primitive V vanishes and
the raw and barred quantities satisfy
\[
\phi_{\rm bar}=u\,t^3/y^5+O(t^4),\qquad
\eta=4b/y^3+O(t),\qquad
\Lambda=c/t+O(1),\quad c=-R/(b^5u^2).
\]
Since omega0=dx/(3y^2), the residue differential for T_f or Q_f,
in the parameter t rather than x, is
\[
f\eta\phi_{\rm bar}^{m}(3y^2t')
 (\partial_t\Lambda)^2\Lambda^{-n-1}dt,
\quad m=0\text{ or }-1.
\]
Its negative residue contributes to the scale coefficient. At the three
indices in the statement the local order is exactly minus one before
a possible numerator vanishing, so only the displayed leading terms
are needed. Substitution gives respectively
\[
-2ft'b/(yc)=2ft'b^6u^2/(yR),
\]
\[
-2fy^4t'b/(uc^4)=3fy^4t'b^{21}u^7/R^4,
\]
\[
-2gy^4t'b/(uc^3)=2gy^4t'b^{16}u^5/R^3.
\]
The last formula includes the additional factor t in the multiplier.
At all three indices the proper polar-replacement polynomial is empty,
so there is no omitted residue from the other critical branch or from
ordinary phi-zeros. The trace in the fixed cubic algebra at each r_i
is three times the constant coefficient in the basis1,y,y^2.

The type-B boundary can be treated directly. Here a and chi are units,
and the critical equation makes V a uniformizer on the normalized
critical curve with ord_V(t)=2. Its other local orders are
\[
\operatorname{ord}_V(\eta)=1,\quad
\operatorname{ord}_V(\phi_{\rm bar})=5,\quad
\operatorname{ord}_V(\Lambda)=-5,\quad
\operatorname{ord}_V(\omega_0)=1.
\]
The derivative of the leading V^-5 term vanishes in characteristic five,
so ord_V(delta Lambda)>=-6. The three residue differentials above have
orders at least5,15,12 respectively. All their residues are therefore
zero, agreeing with their displayed right sides because b=0 and R!=0.
This proves the formulas at type B without specializing a type-A
uniformizer or inverting b. The proper polar-replacement terms are empty
at these coefficient indices in both cases. The same local argument
at type A allows a=0; its second critical point is then in the
critical-coordinate infinity chart, which maps to scale zero and supplies
no residue over scale infinity. Thus every accepted endpoint type is
covered directly.

## A uniform pole bound before expanding individual coefficients

Stay on a type-A neighborhood and write Lambda=t^-1*L(t), with L(0)=c.
The other local factors are regular power series over the coefficient
ring with b inverted; they introduce no R-denominator. For multiplier
t^k*f and exponent m, the residue differential takes the form
\[
t^{k+3m+n-3} A(t)
 \frac{(tL'(t)-L(t))^2}{L(t)^{n+1}}dt,
\]
where A(t) is regular in t and in R. Its residue extracts coefficient
j=2-k-3m-n from the remaining series. It vanishes if j<0. Expanding
the inverse of L introduces at most one additional c^-1 per power of t.
The constant term of (tL'-L)^2 is c^2. Its terms linear in c start in
degree at least two, and its terms independent of c start in degree
at least four. Consequently the worst c-pole comes from c^2 and has
order at most n+j-1=1-k-3m. This proves the bound, with negative
orders replaced by zero. The proper polar-replacement terms contain
no Lambda denominator and hence introduce no R-pole.

At n=2-k-3m, j=0 and the contribution is a nonzero unit times
c^(1-n) whenever the multiplier's endpoint value is nonzero. This gives
sharpness at a genuine type-A content divisor. The argument explains
both earlier endpoint-vanishing multipliers without calculating any
lower trace coefficients. It does not assert that b-denominators have
cancelled in every intermediate lower-coefficient expression.

For Q_1 the two infinity residue differentials at n=5 have orders2
and1, so neither has a residue. For f=x or x^2, the needed coefficients
are respectively at exponents2 and5 in the same differentials. Both
are given by short Laurent expansions retaining the actual source
coefficient Frobenius. Let I_j be their sums, normalized by w^5.
Each finite contribution for x^j is the corresponding endpoint trace
A_i multiplied by r_i^j. Inverting the constant Vandermonde matrix
therefore proves the three separate equations in the statement. Its
determinant is a unit because t is squarefree.

## Exact construction and focused new checks

The [closed-form source](../../scripts/arithmetic/degree140_endpoint_small_top_20260930.sage)
uses the first content jets and endpoint b-values only. It compares the
complete Q_1 leading coefficient with nine retained full-residue fixtures.
A [separate local-series fixture](../../scripts/arithmetic/degree140_endpoint_small_top_fixture_20260930.cpp)
checks all three formulas, with multipliers1,x,x^2, at the same nine
new-formula fixtures. All81 coefficient comparisons agree. These are
implementation checks of the new formulas; the residue derivation proves
the identities.

The [symbolic fixed-algebra construction](../../scripts/arithmetic/degree140_endpoint_small_top_symbolic_20260930.sage)
uses cubic multiplication, adjugates and norms. It never expands a
degree140 trace algebra. For each of the three x-endpoints it produces
the normalized T2,Q5,tQ4 fractions with numerator/denominator bidegrees
respectively
\[
(17,87)/(18,90),\quad (68,347)/(72,360),\quad
(52,264)/(54,270).
\]
Their numerator supports are918,13881,7957. The computation takes
approximately180 seconds on one core. Its three cubic denominators
are retained separately. They are powers of the corresponding content
norm, up to units.

The [short-infinity source](../../scripts/arithmetic/degree140_quintic_leading_equations_20260930.sage)
constructs the I_j, applies the Vandermonde inverse and saves three
equations with22839 or22840 terms each. All27 complete leading-coefficient
comparisons with the retained full-residue fixtures agree. The equations
have bidegree(86,425) before chart-unit removal. This computation took
about12 seconds for the infinity expressions. A final JSON serialization
error occurred after saving the exact equations and passing all checks;
the source integer conversion is corrected and the receipt was recovered
from the saved output, without repeating the coefficient calculation.

Exact data and receipts are in
`../../../litt3-computation-data/seventeen_hour_continuation_20260929/traces/`:
`endpoint_small_top.json`, `endpoint_small_top_fixture.json`,
`endpoint_small_top_symbolic.sobj`, its adjacent JSON, and
`quintic_leading_equations.sobj` with its recovered JSON receipt.
No claim that the three leading-degeneration equations have an empty
zero set is made at this stage.
