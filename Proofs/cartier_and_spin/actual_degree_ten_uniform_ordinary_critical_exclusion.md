# A nine-row jet identity replaces the ordinary common-critical incidence

30 September2026.
[Statement](../../Theorems/cartier_and_spin/actual_degree_ten_uniform_ordinary_critical_exclusion.md).
This is new use of the accepted coefficient module, not a replay of its
reconstruction or of the older square-tail exclusions.

## The coefficient module and its regular primitive frame

Use ascending F25 codes with beta^2=beta+3, and the fixed degree-four
alpha extension. Let D2,G3,G4,G5,kappa run through the homogeneous
source space before the constant/linear-v additional condition. Put
G2=y^2 D2. Its pole bounds are
\[
D_2\in H^0(14O),\quad G_3\in H^0(46O),\quad
G_4\in H^0(57O),\quad G_5\in H^0(70O).
\]
The finite regularity conditions are
\[
G_3-3B_0G_2\in(y^3),\quad
G_4-2B_0G_3+3B_0^2G_2\in(y^4),
\]
\[
G_5-B_0G_4+B_0^2G_3-B_0^3G_2\in(y^5).
\]
Write L0=(18,20,20,15) and H0=(Q-L0^5)/t^3. The other homogeneous
conditions used in the accepted reconstruction are
\[
3L_0^2G_2-2L_0G_3+G_4\in(t),
\]
\[
(G_5-L_0G_4+L_0^2G_3-L_0^3G_2)H_0+\kappa y^{10}\in(t^2),
\]
and pole(G5 Q+kappa y^10 t^3)<=125. This module has dimension eight.
Every constant or linear-v coefficient space is a subspace of it;
the particular term vQ occurs outside G5 and does not alter these
homogeneous critical coefficients.

In the actual regular W coordinate these three coefficients are
\[
g_2=G_2/y^2,\quad g_3=(G_3-3B_0G_2)/y^3,
\quad g_4=(G_4-2B_0G_3+3B_0^2G_2)/y^4.
\]
All three belong to the affine coordinate ring, by the displayed
divisibilities. The vector field delta0 is regular and nonzero at
every finite point: it is dual to dx/(3y^2), whose only zero is at O.
Thus vanishing of the first three delta0-jets is equivalent to order
at least three, including at the cubic branch points.

## A polynomial identity over the entire affine curve

For an accepted basis of the dimension-eight module, form the9-by8
matrix J whose three consecutive rows for each g_i are g_i,delta0(g_i)
and delta0^2(g_i). Let k be the constant row recording kappa. Exact
linear algebra gives a rational left solution aJ=k. Two choices of
pivot rows have polynomial denominators of degrees59 and66, with gcd1.
A univariate Bezout combination therefore gives a POLYNOMIAL left
solution. This covers every geometric affine point without requiring
enumeration of the exceptional denominator fibres.

For a smaller certificate, weight its nine coefficients by
\[
(y,y^2,1,\ y^2,1,y,\ 1,y,y^2).
\]
Expanding in 1,y,y^2 turns the identity into a polynomial-row problem
over K[x]. Hermite reduction followed by weighted weak-Popov reduction
of the two kernel rows gives coefficient-polynomial degree bounds
\[
(47,44,45,44,45,36,45,36,27).
\]
The exact identity aJ=k was checked on all eight basis columns, with
no remaining denominator. It consequently holds on every geometric
coefficient specialization, in every characteristic-five extension.
The computations concern a fixed linear module, not a parameter search.

The compact portable record `global_vertical_jet_identity.json` gives
the field conventions, eight original basis vectors, regular coefficient
polynomials, nine scalar polynomial multipliers and their y-powers.
To check it, use y^3=P, delta0(x)=3y^2 and delta0(y)=P', and multiply
the nine rows. The result is the stored kappa row exactly. No incoming
square-norm certificate is needed for this identity.

## Actual splitting forces the forbidden jets

Let P be a finite base point with t(P)v(P) nonzero, and suppose its
three critical coefficients vanish. Divide the actual source polynomial
by its unit leading coefficient. It has the form
\[
F=(W^5+q)^2+(W^5+q)\widetilde S+\widetilde\tau,
\quad\deg\widetilde S\le3,\quad\widetilde\tau\in R^\times,
\]
over the completed local ring R at P. All roots are integral because
this polynomial is monic with integral coefficients, and the actual
etale cover splits them in R. The
[vertical-flatness lemma](split_source_vertical_flatness.md) forces all
three nonconstant coefficients of S to vanish to order at least three.
Multiplication by the unit leading coefficient preserves this condition.
The global jet identity now gives kappa=0, contradicting the required
nonzero source scale. This proves the exclusion.

This argument is independent of the residual degree. It therefore
transfers immediately from the degree140 setting to the degree142/144
coefficient spaces and to the other nine linear choices of v. The
fixed t-support is retained throughout; coefficient25-Frobenius
transports it to its conjugate support choices. At t=0 or v=0 the
unit hypotheses have changed, so no exclusion there is inferred.

## New evidence and cost

Evidence is at
`../../../litt3-computation-data/seventeen_hour_continuation_20260929/vertical_jets/`.
Sources under scripts/arithmetic are `actual_vertical_jet_module_20260930.sage`,
`actual_vertical_jet_global_certificate_20260930.sage`,
`actual_vertical_jet_reduce_20260930.sage` and
`actual_vertical_jet_export_20260930.sage`.
Generic module construction took0.66 seconds, gluing the two polynomial
denominators2.92 seconds, and the shortened polynomial certificate4.70
seconds, all on one core. A separate finite-fibre exploration also
completed, but is unnecessary once the global polynomial identity is
available. No bounded search is used as a global conclusion.
