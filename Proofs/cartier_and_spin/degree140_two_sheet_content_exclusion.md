# Proof: the complete two-sheet incidence and its square equations

[Statement](../../Theorems/cartier_and_spin/degree140_two_sheet_content_exclusion.md).
The [complete returned report](../../../litt3-computation-data/two_sheet_quintic_replies_20260927/extracted/two_sheet_content_exclusion/REPORT.md)
and the [exact family definition](../../Research/requests/quintic_and_endpoint_content_2026_09_27/02_two_sheet_endpoint_content.md)
specify every input. The submitted prompt remains unchanged. This proof
records the coverage, decisive identities and locally executed checks.

## Complete algebraic coverage

The actual normalized source is reconstructed from149 linear equations
in155 variables. Their rank is149. Specifying h,w,e,f raises the rank
to153, leaving exactly the two kernel coordinates. The two infinity
equations solve those coordinates with determinant a unit times w^2.
This reconstructs448 Laurent monomials, and all source congruences and
the infinity graph are checked after substitution. No necessary linear
condition is substituted for the actual source.

At an endpoint r write its sheet value y=w v, so q=P(r)/v^3 and H=hw.
The [small-root criterion](degree140_simple_content_reduction.md) becomes
q^2 j_r(H,v), where
\[
j_r=B^5E-DC^5+2M B^4C^2.
\]
The coefficients B,C,E are affine in H, D=-P(r)^3v/M(r), and B is
nonzero at any positive-content square. They are reconstructed by
actual curve-ring divisions, not guessed local expansions. After an
invertible Laurent monomial is removed, j_r has311 terms, H-degree6
and v-degree90. Two distinct sheets are represented by j_r(H,v)=0
and j_r(H,[11]v)=0; cycling the marked sheet covers every unordered pair.

The fixed-degree H-resultant has degree948 and v-valuation478. Its
nonzero-v projection has degree470. The degree-one subresultant gives
s0+s1 H in the ideal. The projection decomposes as coprime polynomials
of degrees452 and18, with all multiplicities retained. On the former,
s1 is a unit and H=-s0/s1; both equations vanish identically in this
algebra. This degree452 modulus is squarefree and all open conditions
are units. On the latter, two direct identities Uj+Vj_other=1 exclude
the algebras of dimensions6 and12; the latter retains fourth powers
of a cubic squarefree modulus. Thus no nilpotent degree-drop component
has been discarded.

## Exact square obstructions

The ordinary452-dimensional algebra at each endpoint splits into
coprime blocks with dimensions
\[
\begin{array}{c|l}
145049&1,8,6,44,180,213\\
211895&1,2,68,381\\
211959&1,4,3,6,47,54,337.
\end{array}
\]
Specialize the compact norm to each algebra and normalize its reversed
degree140 polynomial to constant coefficient1. If U(s) is this series,
its formal square root through order72 is U^63 modulo s^73, because
2*63=1+125 in characteristic five. The circuit U^3(U^2)^5(U^2)^25
computes its coefficients C71,C72. Both must vanish for a degree70
polynomial square. Each has scale degree47.

In all17 blocks the certificate gives
\[
U_1(\mu)C_{71}(\mu)+U_2(\mu)C_{72}(\mu)=1.
\]
These identities hold in the full coefficient algebras, so exclude
every geometric scale, not only rational values or reduced sample
points. Together with the six unreduced degree-drop identities they
cover the entire two-sheet incidence at all three roots. Three-sheet
incidence contains a pair and is excluded as well.

The earlier common-critical and individual-content results say that
all content lies at these endpoints, with at most one unit at each
individual sheet. The new theorem allows at most one sheet per
endpoint. Therefore c_W is a squarefree divisor of t. The established
primitive norm is separable and coprime to its fixed content; hence
the full discriminant is not the zero polynomial in the scale.

## Executed verification

All85 manifest entries, the entire reconstruction,56 regenerated-file
comparisons, all17 square unit identities and all six unreduced
degree-drop identities passed locally. The verifier also used its
independent direct polynomial multiplication audit. The original
sources are preserved byte-for-byte in
[the source directory](../../scripts/arithmetic/pro_two_sheet_quintic_20260927/two_sheet/).
A standard C++17 include aggregate was supplied for Mac portability;
no arithmetic or assertions were changed. Commands, versions and scope
are in the [integration record](../../Research/audits/TWO_SHEET_QUINTIC_REPLIES_2026_09_27.md).
