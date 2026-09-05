# Independent audit of the degree-45 families endpoint

## Verdict

**PASS.**  No breaking objection was found in either theorem or in the
finite certificate.

- **Auditor:** `/root/x_elliptic_quotient_maps`
- **Date:** 2026-09-04
- **Descent theorem checked:**
  `57_DEGREE45_FAMILIES_SHADOW_DESCENDS_TO_F125.md`
- **SHA-256:**
  `ad4e64ec621071d07b04b96b218227c1c9003bac4b899151cfa5ce080d3cca8f`
- **Exclusion theorem checked:**
  `58_DEGREE45_FAMILIES_SHADOW_EXCLUDED.md`
- **SHA-256:**
  `bd80d2932efddce3d2f3ff6bc1bf8ae15eb31095df6a131d6b7601bb8e6993c6`
- **Certificate checked and rerun:**
  `57_DEGREE45_F125_GRID_SEARCH.sage`
- **SHA-256:**
  `cffdd68caa4900adab4bc92662ff6cd9eebbd11e1a479c1138044e012e53152a`

## Scope of the audit

The audit checked the following points independently.

1. The divisor identities for the two degree-two functions, the common
   translation (Q_i=P_i+T), and the deduction (28T=0).
2. The calculation that the common cyclotomic zero divisor has degree 48
   and at least 44 distinct points.
3. Descent of the smooth `(2,2)` image, both coordinate functions, the
   reconstructed functions (x,r), and all marked high points to
   (mathbf F_{125}).
4. Completeness of the 252 elliptic-curve representatives, including all
   twists at (j=0) and (j=1728).
5. Enumeration of every nonzero rational point killed by 28, every allowed
   pair of marked high points, and all sixteen independent scalar-coset
   choices for the two functions.
6. The Miller-function evaluation at ordinary points, tangencies,
   (P=T), (T=-P), the point at infinity, and the removable zero at
   (-(P+T)).
7. The argument that every geometric cyclotomic-grid point is already
   rational over (mathbf F_{125}), so enumerating `E.points()` loses
   nothing.
8. The asserted totals and maximum by a fresh complete execution under
   Sage 10.9.

## Findings

### Descent and divisor calculations

Both nonconstant functions have degree two.  Their distinct deck
involutions imply that they generate the function field.  The divisor of
(dr/dx) gives (28T=0) with the signs and coefficients stated in the
note.  Comparing

\[
 \frac{A^{31}-1}{B^{31}-1}=\frac{x-1}{x}
\]

gives the two residual degree-14 divisors and hence a common divisor of
degree (62-14=48).  The support estimate loses at most the four total
ramification units of a degree-two map.

The at least 44 common points map injectively to
(mu_{31}^2\subset(mathbf F_{125})^2).  Since two distinct `(2,2)`
curves intersect in degree eight, Frobenius fixes the image curve.  The
coordinate projections and formula reconstructing (x,r) are then
defined over the same field.  Uniqueness of the multiplicity-31 point in
each marked fiber proves rationality of all six high points.  No descent
gap was found.

### Completeness of elliptic curves and scalars

For (j\ne0,1728), the displayed short Weierstrass model and its
quadratic twist give the two classes.  At (j=0), the quotient
(K^\times/(K^\times)^6) has order two; at (j=1728),
(K^\times/(K^\times)^4) has order four.  Thus the count
(2(125-2)+2+4=252) is complete.

Since (K^\times) has order (124=4\cdot31), raising to the 31st power
maps onto (mu_4).  Therefore the four level sets for each base function
are exactly the four possibilities obtained by arbitrary rescaling, and
the sixteen intersections cover the two independent constants.  Using
unordered pairs of high points is harmless because the tested maximum is
symmetric in the two functions.

### Miller evaluation and rationality

The reciprocal Miller line has precisely the required divisor.  The
branch `S == O` handles (T=-P), including the order-two case (P=T).
The tangent branch handles (P=T) otherwise.  At (-S), the alternate
formula follows from

\[
 (y-L)(y+L)=(x-x(P))(x-x(T))(x-x(S))
\]

and evaluates the removable zero without division by zero.  The excluded
set is exactly the support of the zero and pole divisors, including all
coincidence cases.  The partition assertion gives a useful independent
check that no regular rational point is silently discarded.

The two degree-two deck involutions are (R\mapsto P_0+T-R) and
(R\mapsto P_1+T-R).  Since (P_0\ne P_1), the functions generate
(K(E)), and their `(2,2)` map is a closed immersion.  A geometric point
whose two coordinates lie in (mu_{31}\subset K) is therefore fixed by
Frobenius.  This validates the restriction of the search to `E(K)`.

### Independent rerun

The fresh run completed successfully and reproduced all assertions:

```text
curves 252
curves_with_nonzero_rational_28_torsion 186
torsion_points_tested 1256
unordered_high_point_pairs_tested 9580970
global_maximum_distinct_grid_intersection 32
number_of_maximizers 9
```

## Non-breaking suggestions and limitations

- The result remains explicitly conditional on the normalized mod-31
  families-preserving shadow.  The files state this limitation correctly.
- The certificate uses exhaustive exact arithmetic but finds the maximum
  only for the necessary cyclotomic-grid condition; this is sufficient
  because (32<44), and the file states the distinction correctly.
- The Miller evaluator is subtle enough that retaining its level-set
  partition assertion is important.  No additional edge-case branch is
  needed.

No edit to either theorem is recommended.
