# Proof of the sparse-map and lower-component restrictions

## The zero-component argument in every height r>=2

The accepted exact sequence0->O(8O)->F^2 K->O(17O)->0 pulls back to
a bundle with line subbundle O(8*5^(r-2)O) and quotient O(17*5^(r-2)O).
Both degrees exceed6,
so Hom(F^r K,O(6O))=0. If f=0, the composite F^r R_xi->O(6O)
factors through F^r K and is therefore zero. Thus rho factors through
the actual subline O(-5O) of K. Composing with the two sections1,x of
O(4O) gives two independent maps to L: a constant relation would be
(a+bx)rho=0 generically, forcing a=b=0.

At r=2 this replaces the returned123x123 minor with a short consequence
of [the positive presentation](../../Theorems/cartier_and_spin/explicit_degree_one_etale_sections.md).
The minor still passed as an independent consistency check. The argument
also extends the returned r=2 conclusion to every r>=2.

## Four-coordinate map spaces

Let T(z) be the complete80x35 pencil computing Hom(F^2 R_xi,K),
z_i=xi_i^25. On a set S of s lower-map coordinates, write its bilinear
ideal as I_S=(sum T[i,r,S[h]] z_i w_h)_r. Multiplying these equations
by all degree(d-1) monomials in w gives the exact bidegree(1,d) ideal
component. A coordinate unit row in its reduced row space is a genuine
polynomial identity z_i w_h^d in I_S, valid over every field extension.

It suffices to prove those identities for i<13 and the f-coordinates h.
If f!=0, one such coordinate forces z0=...=z12=0, the pure-v P5.
That locus is already excluded from Hom(F^2 R,L)=0 with nonzero Hom to K.
If f=0, the preceding argument applies. No normalization, minor open
set or field equation is imposed.

The complete list of52360 supports of size4 was checked in stages:
2952 pass the whole bidegree(1,1) block test;47711 of the49408 remaining
pass the whole(1,2) test;1640 more pass the individual f-square test;
the last57 pass the f-cube test. Every direction of smaller support is
contained in one of these spaces. The complete verifier regenerated
all lists and matrices and passed. The three-coordinate stage is also
retained, though not needed for coverage.

## Monomial f with unrestricted alpha

A local continuation replaces S by {j,23,...,34}, j=0,...,22. Thus one
f monomial is allowed with every alpha coefficient, not merely a small
support for the full map. For j=3,...,18 the bidegree(1,2) component
contains all13 elements z_i w_0^2, i<13. For j=0,1,2,19,20,21,22,
the degree2 test is inconclusive, and the degree3 component contains all
z_i w_0^3. Since w0!=0, every such source lies in the pure-v P5.

The local [source](../../scripts/arithmetic/second_return_free_alpha_probe.py)
uses the checked exact homogeneous-matrix implementation. The full
[degree2 record](../../../litt3-computation-data/geometric_bottleneck_replies_20260925/local_checks/free_alpha_degree2.json)
and [degree3 record](../../../litt3-computation-data/geometric_bottleneck_replies_20260925/local_checks/free_alpha_degree3.json)
include every support, matrix rank and membership outcome, with
[degree2 log](../../../litt3-computation-data/geometric_bottleneck_replies_20260925/local_checks/free_alpha_degree2.log)
and [degree3 log](../../../litt3-computation-data/geometric_bottleneck_replies_20260925/local_checks/free_alpha_degree3.log).
This is exact ideal membership on23 projective direction spaces;
it is not a finite-field point search. Failed degree2 tests were not
used as geometric existence assertions. No separate independent
reimplementation of these new degree3 checks is claimed.

The returned [report](../../../litt3-computation-data/geometric_bottleneck_replies_20260925/extracted/return_window/second_frobenius_window/REPORT.md),
[retained source](../../scripts/arithmetic/pro_geometric_bottlenecks_20260925/return/src/verify.py)
and [successful replay](../../../litt3-computation-data/geometric_bottleneck_replies_20260925/local_checks/return.log)
retain the full four-support evidence, failed full-space degree2 test
and bounded search as separately scoped results. The earlier independent
pencil proof follows; its scope is subsumed for the window but its stronger
source containment and independent check remain useful.

## Earlier independent proof for two-coordinate pencils

Let T_l denote the coefficient tensor in z_l. For a lower-map vector
w=e_i+s e_j, define the80x19 matrix
\[
M_{ij}(s)_{a,l}=(T_l)_{a,i}+s(T_l)_{a,j}.
\]
Its kernel is exactly the entire vector space of source parameters z
for this map direction. Let M_tail consist of columns13..18. Elementary
linear algebra gives
\[
\ker M\subseteq\{z_0=\cdots=z_{12}=0\}
\quad\Longleftrightarrow\quad
\operatorname{rank}M-\operatorname{rank}M_{tail}=13.
\]
Indeed the difference is the rank of the map from the first13 columns
to the quotient of the row-target space by the tail image; it is13
exactly when that map is injective.

The source script
[second_return_geometric_pencils.py](../../scripts/arithmetic/second_return_geometric_pencils.py)
checks this over F25(s), selects a nonzero maximal minor m(s), and
checks every root of m in its exact residue field. The constant endpoint
w=e_j is also checked. The [certificate](../../../litt3-computation-data/actual_frontier_trial_replies_20260925/local_checks/geometric_pencils.json)
records the selected rows and columns, the polynomial minor, all its
irreducible factors, and the ranks at those factors, for every one of
the595 pairs. All35 endpoints pass as well.

An [independent verifier](../../scripts/arithmetic/verify_second_return_geometric_pencils.py)
uses a different completeness argument, without rational-function row
reduction. If the recorded generic ranks are r and r-13, then:

- Every(r-12)-minor of M_tail has degree at most7. Its vanishing at
  all25 elements of F25, verified by the specialized tail ranks, proves
  it vanishes as a polynomial. Thus the tail rank is globally at most r-13.
- The selected r-minor has degree at most r<=19. Its equality to the
  recorded polynomial is verified at all25 field elements, which proves
  the polynomial identity. Where it is nonzero the rank difference is
  at least13 and hence exactly13, since only13 columns were added.
- The listed monic irreducible factors, with their multiplicities,
  multiply to the monic minor. At a root of each, exact ranks satisfy
  the same difference13. All conjugate roots have the same rank because
  the matrix is defined over F25.

This covers every geometric parameter of each pencil. The independent
run passed595 pencils,35 endpoints and1629 exceptional residue-field
checks. The use of25 evaluation points is a polynomial identity check
with a proved degree bound, not extrapolation from finite-field samples.
Finally z=xi^25 is bijective over k and preserves the coordinate P5.

The [generator log](../../../litt3-computation-data/actual_frontier_trial_replies_20260925/local_checks/geometric_pencils.log)
and [independent log](../../../litt3-computation-data/actual_frontier_trial_replies_20260925/local_checks/geometric_pencils_independent.log)
are retained. An earlier F25-only probe of14,315 sparse directions
motivated this calculation; that probe alone was not used as proof.
The accepted T tensor has its full actual-lattice reconstruction and
verification in the quotient atlas. The earlier pencil calculation
alone says nothing about larger supports; the extensions proved above
now cover four-coordinate spaces and monomial f with arbitrary alpha.
General dense map directions remain open.
