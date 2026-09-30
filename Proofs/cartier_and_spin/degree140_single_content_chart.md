# Proof: fractional-linear reduction and its finite exceptional incidence

[Statement](../../Theorems/cartier_and_spin/degree140_single_content_chart.md).
The local content numerator is j=B^5E-DC^5+2M B^4C^2.
All coefficients here are the exact affine-in-H Laurent functions
reconstructed in the [two-sheet proof](degree140_two_sheet_content_exclusion.md).

On B Delta nonzero, z=C/B gives
H=(C0-B0 z)/(B1 z-C1), B=Delta/(B1 z-C1). Divide j by B^5 and
substitute these identities. Clearing the one nonzero denominator
gives exactly G in the statement. Equivalently the polynomial identity
\[
B^6G(v,C/B)=\Delta j(H,v)
\]
holds before imposing the open conditions. It was verified coefficientwise
at all three endpoints by
[endpoint_content_mobius.cpp](../../scripts/arithmetic/endpoint_content_mobius.cpp).
The exact local files, including all34 coefficients, are in the
[external evidence directory](../../../litt3-computation-data/two_sheet_quintic_replies_20260927/).
The componentwise geometric genus is consequently at most70 after
normalization, by its bidegree in P1 times P1; no irreducibility or
rationality is asserted.

## Delta=0 is not silently localized away

At each endpoint v^8Delta is a squarefree polynomial of degree15 with
nonzero constant coefficient. Work in its full quotient algebra over
F_(5^8). B1 is a unit, so z0=C1/B1 is defined there. On Delta=0,
C=z0 B for every H and
\[
j=B^5(T_0+T_1H),\quad
T_0=E_0-Dz_0^5+2Mz_0^2B_0,\quad
T_1=E_1+2Mz_0^2B_1.
\]
T1 is also a unit. The sole positive-content candidate is therefore
H=-T0/T1; all15 points survive the previous open conditions, including
B,H,a0(q),Psi and the excluded q-values. Every assertion of invertibility
is checked by polynomial gcd, and j evaluates to zero in this algebra.
This accounts for every geometric point of the exceptional incidence.

For each of the three degree15 algebras the actual compact residual
was specialized, reversed and normalized. The formal square-root
coefficients C71,C72 were recomputed, each of scale degree47. Their
extended Euclidean certificate is
\[
U(\mu)C_{71}(\mu)+V(\mu)C_{72}(\mu)=1.
\]
All three identities were checked exactly. Hence no exceptional
candidate admits any geometric scale, even zero, satisfying the two
necessary square equations.

The [boundary source](../../scripts/arithmetic/endpoint_content_mobius_boundary.cpp)
reuses the already verified norm and square circuit, without changing
the returned source. It constructs the new degree15 algebras and checks
all additional divisions and identities. The complete computation ran
locally; its chart data, square equations and Bezout witnesses are in
[mobius_boundary](../../../litt3-computation-data/two_sheet_quintic_replies_20260927/mobius_boundary/).
No finite-field point search replaces this quotient-algebra proof.

The remaining positive-content question is now entirely on the stated
sparse open curve, with the actual scale still free. At most one content
sheet is allowed over each endpoint by the two-sheet theorem, but
different endpoints may still each contribute one.
