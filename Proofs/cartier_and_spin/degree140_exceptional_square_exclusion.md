# Proof of the exceptional degree-140 exclusion

Use the [statement](../../Theorems/cartier_and_spin/degree140_exceptional_square_exclusion.md)
and the coefficient conventions of the degree-ten boundary. The
[returned report](../../../litt3-computation-data/remaining_structural_replies_20260925/extracted/degree140/degree140_residual_square_partial/REPORT.md)
contains the complete seven-dimensional coefficient reconstruction,
the all-chart formulas and a proof for one of the ten linear v choices.
Its full verifier passed locally. The following extends that proof to
every exceptional component; it does not extend to the generic chart.

## Exhaustive exceptional parametrization

Set K=F25(alpha), where alpha^4+[7]alpha^3+[6]alpha^2+[2]alpha+[5]=0.
A K-code is c0+25c1+625c2+15625c3, with ci interpreted in F25.
The ten roots of P have codes9,14,2514,7367,20130,104315,139659,
154113,281660,364472, in that order. The returned affine-basis and
matrix checks prove that no original coefficient condition is lost.

On each linear-v exceptional chart, the determinant is
w^2(d0+d1*w^3), with d0*d1 nonzero. Put q=-d0/d1. After h=wH,
the second compatibility condition is a quadratic in H, with two
distinct nonzero geometric roots. The first condition solves s with
a unit pivot. Moreover
\[
F6=C(H)+wD(H)u,
\]
where D(H) is a unit in the quadratic coefficient algebra. Thus
R=F6 is a coordinate, and every component is parametrized exactly by
(kappa,R) in G_m^2. The three roots of w^3=q and two H-roots account
for six components per root of P, sixty in total. This is an exhaustive
chart assertion, verified before any square testing.

## Removing the cube-root coefficient

Write N_i=kappa*H_i for i=2,3,4 and N5=vQ+kappa*H5. Then
R0=kappa^36*mathscrR(x,lambda,R), where lambda=kappa^-1 and mathscrR
has lambda-degree at most6. The fixed-degree resultant formula in the
returned report is a polynomial identity, valid also at every leading
coefficient drop.

For any root w of w^3=q, substitute
\[
y=wY,\quad P_{new}=P/q,\quad t_{new}=q t,\quad
\mu=\lambda/w,\quad H_{i,new}=H_i(x,wY)/w.
\]
The explicit Laurent chart formulas prove that all H_{i,new} belong to
K(H)[x,Y,R], with Y^3=P/q, and are affine linear in R. The dependence
on w disappears. This is checked as a Laurent-polynomial identity
modulo w^3=q, together with F4=F5=0 and F6=R.

The normalized degree-ten polynomial and its critical quadratic are
both the old ones, after y=wY and lambda=w*mu, divided by w. Therefore
their degree-(10,2) resultant is multiplied by w^-12, and its cubic
norm by w^-36=q^-12. The denominator P^40*t^15*v^3 is multiplied
by q^-25. Hence the exact identity is
\[
\mathscr R_{new}(x,\mu,R)=q^{13}\mathscr R_{old}(x,w\mu,R).
\]
Every nonzero lambda corresponds to a nonzero mu, and multiplication
by a nonzero scalar preserves geometric squareness. This proves that
one normalized calculation covers all three w-values; no fifth-root
or separability assertion is involved. Both full-polynomial case3
identities were also cross-checked against the original normalization.

## Exact coefficient fields

The H-quadratic splits in K for cases3,5,8,9,10. Both H-roots were
treated separately. For cases1,2,4,6,7 it is irreducible over K.
Use K[b]/(b^2-alpha); alpha is a verified nonsquare in K. The backend
uses pair arithmetic and norm inversion, with no logarithm table for
the larger field. Its Python and C++ implementations passed160 exact
arithmetic and Frobenius comparisons. All original coefficients lie
in K, so the5^8-Frobenius exchanges the two H-roots. A complete
geometric exclusion for one root therefore proves it for the other.

The new leading coefficient is
q^16*(3H^3*epsilon^8)^3*R^3, which is nonzero. Exact coefficient
decoding verifies the bounds needed below separately for each family.
The finite exceptions require inverse5-Frobenius in the actual
coefficient field: exponent5^7 over K and5^15 over its quadratic
extension. These conventions are explicit in the driver.

## Geometric square test and its exceptional values

Divide a degree140 residual by its leading coefficient. A monic
degree70 square root has uniquely forced coefficients j0=1 and
\[
j_n=\tfrac12\left(b_n-\sum_{i=1}^{n-1}j_i j_{n-i}\right),
\qquad 1\le n\le70.
\]
Its remaining70 coefficient errors E71,...,E140 vanish exactly at
square points. To eliminate negative powers of R, replace x by x/R^3
and multiply the residual by R^417/c, where its leading coefficient
is cR^3. This is a valid square test at each geometric R nonzero.

The decoded coefficient identities give
deg_R(E71,E72,E73)<= (426,432,438) and lambda-degrees(53,54,54).
The three fixed-degree pairwise resultants consequently have degrees
at most45900,46218,46980 in R. Computing all48828 values at distinct
roots of unity in K determines these polynomials uniquely, also when
their coefficients lie in the quadratic extension of K. This is
exact interpolation justified by degree bounds, not a finite-field
emptiness inference. Leading-degree drops are retained.

For every executed H-branch the resulting degrees are
(34065,34398,34933), with R-valuations(8997,8984,9144).
After removing these powers of R, an exact Bezout identity for the
three cofactors has monic right side R^15+c0=(R^3+c1)^5, c0 nonzero.
The identity and the divisibilities are checked independently; the
identity degree is below the65104-point verification set.

All three nonzero roots of R^3+c1 are explicitly retained. At each,
the scalar-parameter reconstruction agrees coefficient by coefficient
with the parametric residual, and a square-tail Bezout identity equals1.
This excludes EVERY geometric scaling at every leftover R-value.
Direct12-by-12 Sylvester comparisons supplement the universal
resultant identity. Neither a residual gcd nor these sampled comparisons
alone would be a complete exclusion; the full finite-exception closure
is essential.

## Executed coverage and reproducibility

The retained original and new certificates cover the roots as follows:

| Root codes | Method | Components |
| --- | --- | ---: |
| 2514 | Returned full proof, both H-roots | 6 |
| 364472 | Local original-normalization extension | 6 |
| 20130,154113,281660 | Local normalized calculation, both H-roots | 18 |
| 9,14,7367,104315,139659 | Quadratic backend and coefficient conjugation | 30 |

All runs and all finite-exception closures passed. The original full
replay and every new evaluation table, resultant, Bezout coefficient
list and execution log are retained in
[local_checks](../../../litt3-computation-data/remaining_structural_replies_20260925/local_checks/).
The aggregate coverage record is
[exceptional_coverage.json](../../../litt3-computation-data/remaining_structural_replies_20260925/local_checks/exceptional_coverage.json).
Tables are also exported to portable JSON; integer coefficient
encodings and coefficient-field definitions are recorded there.

Source entry points are
[extend_degree140_exceptional.py](../../scripts/arithmetic/extend_degree140_exceptional.py),
[degree140_normalized_exceptional.py](../../scripts/arithmetic/degree140_normalized_exceptional.py),
[degree140_quadratic_field.py](../../scripts/arithmetic/degree140_quadratic_field.py),
and [build_degree140_quadratic_backend.py](../../scripts/arithmetic/build_degree140_quadratic_backend.py).
The byte-exact returned sources are retained beside them under
scripts/arithmetic/pro_remaining_structural_20260925/degree140/.

The nonzero-determinant charts remain genuine open cases. The new
calculation justifies eliminating the exceptional pivot from the next
degree140 square question, not declaring the full locus empty.
