# Complete exact list of28,990 dormant-opers on the fixed X

`complete_oper_solutions.json` has one row per distinct geometric oper and
its multiplicity. It is an EXACT ALGEBRAIC list, not floating-point data.
Shared coordinate polynomials and finite-field equations avoid expanding
the same enormous field elements thousands of times. The total with
multiplicity is29,375. None of these rows is yet a common cover.

## Reading a row

An `invariant_row` points directly to the zero-based row of
`invariant_oper_solutions.json`, whose24 coordinates are already written
there. Its full multiplicity is8.

For a non-invariant row, its `orbit` selects one irreducible F5 polynomial
f in `normalized_oper_closed_points.json`. Its F25 residue degree is d,
half its F5 degree. In an algebraic closure containing the fixed
F25=F5[a]/(a^2+4a+2), choose alpha satisfying

    f(alpha)=0,        h_zeta(alpha)=a.

The second condition is essential: omitting it would double-count the
conjugate coefficient-field component. Choose beta with

    beta^3=lambda(alpha),         rho=2a+1.

Here h_zeta and lambda are coefficient lists in
`normalized_oper_algebra_certificate.json`, in ascending powers of z.
The scale lambda is nonzero and rho has order3. For the row's
`frobenius_exponent` j and `cubic_branch` b, set

    q=alpha^(25^j),           t=rho^b*beta^(25^j).

The24 coordinates, in the same order as the invariant list, are exactly

    b_i = B_i(q)                          (0<=i<=7),
    c_i = t*h_ci(q)                       (0<=i<=3),
    c_4 = t,
    a_i = t^2*h_ai(q)                     (0<=i<=9),
    a_10 = t^2.

All B_i and h_i are in the shared algebra certificate. These coordinates
give the potential in `fixed_x_dormant_equations`. Every such row has
multiplicity1. This definition applies whether beta already belongs to
the residue field or requires a cubic extension.

Choosing different initial alpha or beta only permutes the rows within
that orbit. Every j=0,...,d-1 and b=0,1,2 is included. Distinct j give
distinct normalized a9=q, distinct b give distinct c4=t, different
factors are coprime, and invariant rows have c4=0. Thus there are no duplicates.

## Compact census

|Normalized orbit|F25 degree|Original distinct points|Multiplicity each|
|---|---:|---:|---:|
|orbit_0000|1|3|1|
|orbit_0001|2|6|1|
|orbit_0002|13|39|1|
|orbit_0003|17|51|1|
|orbit_0004|40|120|1|
|orbit_0005|124|372|1|
|orbit_0006|205|615|1|
|orbit_0007|220|660|1|
|orbit_0008|403|1209|1|
|orbit_0009|578|1734|1|
|orbit_0010|718|2154|1|
|orbit_0011|7324|21972|1|
|Previously exported invariant points|55|55|8|

For the untwisted actual-atlas existence property, Frobenius and the
actual deck automorphism identify all3d tests in each normalized orbit.
Together with the6 invariant Frobenius orbits,18 representatives suffice,
but each still has its entire continuous quotient-map search.

## Reproduction and proof boundary

- `sage scripts/certify_oper_parametrization.sage ...` verifies the original
  normalized identities in the proposed full-length algebra.
- `sage tests/check_oper_original_input.sage` independently verifies the
  retained43 input polynomials, separator, degree and squarefreeness.
- `sage scripts/factor_oper_parametrization.sage` verifies the exact factorization.
- `python3 scripts/export_complete_oper_list.py` writes all28,990 row indices.

See `fixed_x_oper_enumeration` for the exact theorem and linked audit.
This completes the rank-two enumeration, not the56-equation atlas test,
the nontrivial twists, smaller cored cases, or the coreless branch.
