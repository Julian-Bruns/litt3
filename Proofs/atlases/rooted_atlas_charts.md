# Proof: feedback rooting and the weight-one quotient slices

[Statement](../../Theorems/atlases/rooted_atlas_charts.md), Version2.
The general lemma replaces the two former tangent arguments while
retaining the actual compact-atlas and full inverse-system applications.

## 1. Partial Frobenius rooting

The map phi:Y->X in the statement is well defined because
`P^[-q](v,b)^[q]=P(v^[q],b^[q])`. It is finite: the coordinate algebra
of Y is generated over that of X by v_i with v_i^q=x_i. Thus Y is finite,
and unique qth roots give a bijection on geometric points.

At a geometric point, a tangent vector (dv,db) of Y has db=0. Raising
the scalar values of the linearized A^[-q] equations to the qth power
gives A_x(x,y^[q]) dx=0 with dx=dv^[q]. Put

    dy=(d B^[-q](dv,0))^[q]=B_x(x,y^[q]) dx.

Then (dx,dy) is a tangent vector of X, since y enters all right-hand
sides there only through y^[q]. Its vanishing forces dv=0, and db was
already zero. This is a semilinear construction on tangent-vector
coordinates, not the differential of phi or a qth power of a dual-number
parameter. Coefficient rooting commutes with differentiation because
integer exponent coefficients lie in F_p.

The finite scheme Y therefore has zero cotangent space at every geometric
point; Nakayama makes each local Artin ring a field. It is finite étale.
The geometric bijection between finite étale schemes is an isomorphism,
and this descends to k. The raw substitution scheme has equations
A^[-q](v,b)^[q]=0 and the same feedback equations. Its geometric points
are the same, so the now reduced scheme Y is exactly its reduction.

For the bilinear incidence use x=U, y=b, B=R and
`A=(N,U.R-lambda)`. The feedback equation makes the last original
equation equivalent to U.b=lambda over every coefficient ring. Its
coefficient root is v.s-lambda^(1/q), proving the normalized assertion.

## 2. Exhaustive quotient charts and the factor q−2

On the unnormalized scheme `Y0={n=0,b=s^[q],c!=0}`, there is a Gm action

    v -> z^(1-q)v,  b -> z^q b,  s -> z s,  c -> z^(2-q)c.

It maps to the original action U->t^(1-q)U, b->t b by t=z^q. At every
point some s_j is nonzero. Impose s_h=0 for h<j and s_j invertible.
With z=s_j, the slice coordinates are

    v_C=z^(q-1)v,  b_C=z^-q b,  s_C=z^-1 s,  c_C=z^(q-2)c.

These formulas identify the whole stratum with Cj×Gm. In this product
normalization is `z^(q-2)=c_C/ell`, where ell=lambda^(1/q). Since p is
odd, q−2>0 is prime to p. Thus the normalized stratum Tj->Cj is a
finite étale mu_(q−2)-torsor. It has q−2 geometric lifts per point.

Tj is a locally closed subscheme of finite étale Xr. Its finite free
coordinate algebra contains that of Cj injectively; hence the latter
is finite-dimensional and reduced, and is étale over perfect k. The
empty chart causes no exception. The Tj are disjoint open-and-closed
subschemes exhausting Xr, so the Cj form exactly the disjoint quotient
strata of Xr/mu_(q−2). In particular q=p=3 gives degree one without
an exceptional argument.

The equations s_h=0 and s_j=1 are essential: replacing them by their
qth powers retains possible nilpotents. A b_j=1 slice alone has the
infinitesimal mu_q thickness of z^q b_j=1. The weight-one s_j slice
removes that defect. No equation c=ell is imposed on Cj itself.

For the fixed system q=p=5, ell=2. The next two sections retain its
original exact positive test, field convention and exporter evidence.
## 3. Actual positive test

[The check](../../scripts/atlases/rooted_atlas_charts.sage) verifies that the saved
actual genus-two tensor restricts to the three small equations after the
four previously certified linear restrictions. It takes coefficient roots,
checks the tensor identities exactly, computes the normalized rooted
coordinate-algebra length, and checks reducedness through all maximal
Jacobian minors. It also computes both disjoint charts in the projective
coordinates [b2:b3], including their inverse-c normalization condition.
These form exhaustive coordinates because the certified linear restrictions
express b0,b1 in b2,b3. The small intrinsic normalization is ell=1;
its rooted cubic uses coefficient roots of ell and equals 1.

This is an independent test of the new presentation against the already
proved 33 normalized solutions / 11 directions. It is not a run of the
full genus-nine solver. Results are saved in
[rooted_atlas_charts.json](../../Research/computations/rooted_atlas_charts.json).

## 4. Cached genus-nine export

[export_rooted_atlas.sage](../../scripts/atlases/export_rooted_atlas.sage) generates all
32 first-nonzero charts from the cached canonical tensors, taking coefficient
fifth roots with exact round-trip checks. It first row-reduces the bilinear
equations with nonlinear columns before linear v columns and the constant.
Any resulting affine equations with constant nonzero v coefficient are used
for substitution, repeating until stable. No variable is inverted in this
preprocessing. The only specified localization remains w*c=1.

The external directory
`/Users/julian/Documents/litt3-computation-data/atlas-rooted-first`
contains per-chart coefficient-basis certificates, reconstruction maps,
metadata and F5 msolve inputs. These add a variable a with a^2+4a+2 and
verify every encoded polynomial by coefficient specialization and complete
text readback. Over an algebraic closure of F5 the input includes the two
coefficient-field embeddings; it is valid for emptiness and doubles finite
coordinate-algebra length relative to F25. The manifest is a controller
interface, not a Groebner-basis or completion certificate.

Charts30 and31 have exact constant-combination certificates yielding1 from
their original bilinear chart rows. Chart29 produces1 only after affine
elimination; a constant row-combination claim would be too strong.
[rooted_atlas_chart29_certificate.sage](../../scripts/atlases/rooted_atlas_chart29_certificate.sage)
instead constructs and checks an exact polynomial ideal certificate,
with multipliers of degree at most1, against all94 original bilinear rows.
Its external `chart-29/polynomial_certificate.json` records these multipliers.
The exporter deliberately retains chart29's original row-reduced equations
for a solver, rather than labeling this as a constant certificate.
These were the first three excluded projective strata. The current
[certificate record](../../Research/notes/atlases/atlas_f4_run.md) includes independently
replayed original-equation units for every chart22–31 of the first tensor
and the first two invariant tensors. It still excludes no whole oper.
