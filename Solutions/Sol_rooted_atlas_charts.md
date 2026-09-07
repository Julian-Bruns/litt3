# Reduced rooted atlas equations and exhaustive disjoint charts

2026-09-07. Bounded validation of a new solver presentation, not an atlas
exclusion. Scope: the compact untwisted system with its actual tensors.
No all-torsion coefficient construction or common-cover conclusion follows.

## Exact rooted normalized scheme

Let k be an algebraic closure of F5, and use the compact system
X: N(U,b^[5])=0, R(U,b^[5])=b, U.b=2. Its finite reducedness and
full Jacobian rank are proved in
[compact atlas proof](../Solutions/Sol_compact_etale_atlas_system.md).
Write n(v,b),s(v,b) for the bilinear tensors obtained by taking fifth
roots of all N,R coefficients. Over F25 this means raising coefficients
to the fifth power. Put c=v.s(v,b). Define

    Xr: n(v,b)=0, b=s(v,b)^[5], c=2.

The morphism Xr -> X sends (v,b) to (v^[5],b). It is well defined since
N(v^[5],b^[5])=n(v,b)^[5] and R(v^[5],b^[5])=s(v,b)^[5]. On its graph,
U.b=c^5, and 2^5=2. It gives a bijection on geometric points, since
fifth powers have unique roots in k. This statement alone would NOT
establish equality of nonreduced schemes.

Here Xr is reduced, as follows directly from the known Jacobian of X.
For a tangent vector (dv,db) to Xr, the graph equations imply db=0.
The remaining equations say n(dv,b)=0 and
dv.s+v.s(dv,b)=0. Raise their scalar values to fifth powers and put
dU=dv^[5], dB=R(dU,b^[5]). They become

    N(dU,b^[5])=0,
    b.dU+U.dB=0.

Together with the defining equation for dB these say (dU,dB) is a
tangent vector to X. Its full Jacobian rank gives dU=dB=0, hence dv=0.
Thus Xr has zero cotangent space at every geometric point; Nakayama and
finite type imply that it is finite reduced. The geometric bijection is
therefore an isomorphism of these finite reduced k-schemes. The same holds
over F25 by descent. Equivalently, finite reduced algebras over a perfect
field have invertible relative Frobenius. A concrete inverse over F25 can
use v_i=U_i^(5^(2L-1)), where F_(25^L) contains every solution coordinate.
Existence of such an L follows from finiteness; it is not needed by a solver.

By contrast, the raw substitution U=v^[5] pulls back the original ideal
to equations n^[5]=0, s^[5]-b=0, and (c-2)^5=0 (after graph reduction).
It can carry nilpotents. Xr is its reduction; the Jacobian argument is the
required justification for using the displayed root equations and calling
them an exact reduced-scheme presentation of X.

## Uniform projective charts and the factor three

Remove normalization but retain its nonvanishing:

    Y: n=0, b=s^[5], c!=0.

There is an algebraic Gm action with parameter z:

    v -> z^-4 v,   b -> z^5 b,   s -> z s,   c -> z^-3 c.

It maps to the original unnormalized action U->t^-4 U,b->t b via
t=z^5. The weight-one s coordinates, not b alone, give reduced slices.
At every Y point some s_j is nonzero since c!=0. For each j from 0 to m-1,
use the following disjoint first-nonzero-coordinate chart Cj, with an
inverse variable w:

    n=0;
    b_h=0 and s_h=0 for h<j;
    b_j=1 and s_j=1;
    b_h=s_h^5 for h>j;
    w*c=1.

Eliminate b_0,...,b_j by substitution if desired. The earlier b_h graph
equations are then replaced by s_h=0. The selected b_j graph equation is
replaced by s_j=1. Retaining only s_h^5=0 or s_j^5-1=0 would retain
unwanted nilpotents. There is NO equation c=2 in a chart.

The corresponding stratum of Y is isomorphic to Cj x Gm: scale by
z=s_j^-1 to obtain its unique representative with s_j=1. The normalization
c=2 on this product becomes z^3=c_Cj/2. Because c_Cj is invertible and
3 is nonzero, this defines a finite etale degree-three cover of Cj.
Every normalized solution occurs on exactly one such cover, and each
geometric chart point has exactly three normalized lifts, permuted freely
by mu3. In particular these charts are finite reduced: reducedness
descends from their faithfully flat degree-three cover, a locally closed
subscheme of the finite reduced Xr. They are the disjoint strata of the
quotient Xr/mu3. No projective infinity locus is omitted. This is a quotient
of presentations, not a proof that its points are distinct unmarked atlases.

A b_j=1 slice without s_j=1 has an infinitesimal mu5 stabilizer thickness:
its scaling equation is z^5*b_j=1. Set-theoretic uniqueness of fifth roots
does not justify treating that slice as reduced. The s-coordinate chart
above removes this exact defect.

## Actual positive test

[The check](../scripts/rooted_atlas_charts.sage) verifies that the saved
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
[rooted_atlas_charts.json](../Research/computations/rooted_atlas_charts.json).

## Cached genus-nine export

[export_rooted_atlas.sage](../scripts/export_rooted_atlas.sage) generates all
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
[rooted_atlas_chart29_certificate.sage](../scripts/rooted_atlas_chart29_certificate.sage)
instead constructs and checks an exact polynomial ideal certificate,
with multipliers of degree at most1, against all94 original bilinear rows.
Its external `chart-29/polynomial_certificate.json` records these multipliers.
The exporter deliberately retains chart29's original row-reduced equations
for a solver, rather than labeling this as a constant certificate.
These exclude three narrow projective strata, not a whole fixed oper.
