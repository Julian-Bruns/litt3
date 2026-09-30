# Proof: trace regular vector fields on the actual normalization

[Statement](../../Theorems/cartier_and_spin/degree140_normalized_critical_trace.md).
The accepted detailed proof and construction are sections12--20 of the
[incoming report](../../../litt3-computation-data/september29_evening_replies/actual_ramification/REPORT.md).
Its exact family is retained in
[family.json](../../../litt3-computation-data/september29_evening_replies/actual_ramification/data/family.json).
The source algorithms and reported computations are accepted inputs;
none were replayed for integration.

If ord_p(d)=2a, eta has order a on each unramified normalized branch.
If ord_p(d)=2a+1, a parameter u downstairs is s^2 upstairs; the lifted
delta0 has vector-field order-1 and eta has order2a+1. Hence eta*delta0
is regular in every case, and its affine zero divisor is pi*Gamma.
The actual critical-value formula places every affine zero of phi above
Lambda=infinity. Dividing by phi therefore causes no pole over a finite
nonzero scale. The report's boundary analysis also proves regularity
over zero and the asserted infinity bounds.

Trace of a regular function at a fibre is the sum of its point values
weighted by local lengths. A regular vector field applied to Lambda
vanishes at every ramified point, including a wild point. This proves
necessity. A pole of order m above a target point of ramification index e
contributes a trace pole of order at most floor(m/e), which proves the
polynomial degree bounds. The leading coefficients come from residues
at O4 alone; its first two expansion coefficients give the displayed
units, with no division by a variable leading coefficient.

To prove sufficiency, put M=18-r and N=103-r. The degree18 bundle
O_X(MO+Gamma) is globally generated. Its sections, multiplied by
eta*delta0/phi, give vector fields with no common zero at any finite
nonzero Lambda-fibre. For its reduced fibre Z, |Z|<=140 and
deg(N(O4+O7)-Z)>=2g(C). Riemann--Roch therefore supplies a function
isolating any chosen unramified point of Z. Multiplying such a function
by a nonvanishing vector field produces a nonzero trace there, with
weight one; all other point contributions vanish. The products lie in
the two asserted spaces U and eta*W by the explicit normalization
decomposition. Consequently vanishing of their basis traces excludes
every unramified point. Riemann--Roch gives dimensions113-r and97.

For the rank32 normalization algebra, d has exact pole32 at O.
Triangular reduction by d leaves the32 monomials in
<3,10> minus(32+<3,10>). A linear coordinate x+c*y separates all
support points and all tangent directions except for at most496 choices
of c; hence497 fixed distinct c's cover the geometric base. In a cyclic
chart write the multiplicity factorization F=product F_m^m. The ideals
given by product F_m^ceil(m/2) and product F_m^(m mod2) describe the two
normalization corrections in the incoming section-space construction.
Characteristic-five power factors must be retained; ordinary derivative
gcd alone is not sufficient.

The proof provides a uniform finite test, not a computed global unit
ideal. Nor does polynomial norm squareness substitute for this test:
the two normalized points at an even discriminant zero may have different
ramification indices despite an even total multiplicity downstairs.
