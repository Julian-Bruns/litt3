# Endpoint jets determine complete characters in the top V4 profiles

Version4,26September2026. Retain the actual same-source hypotheses,
polynomial frames and endpoint labels of
[quotient-jet rigidity](klein_four_quotient_jet_rigidity.md). Fix the entire
Klein-four parameter curve over k(t), including its three character
square-root polynomials and frames, the pole partition and the full
endpoint values and first jets. The denominators T_i are not fixed in
advance. Fixing only the common-pole subset of mu29 does NOT fix this
parameter curve.

Suppose the three quotients F_i/T_i are uniquely determined, and for
every index i either d_i<=3 or
\[
d_i\le10,\qquad c_i-j_2>2d_i+8.
\]
Then every polynomial pair (T_i,f_i), hence every nontrivial character
component u_i,v_i of the two comparison functions, is uniquely determined.
All109 remaining degree87 allocations and715 of729 degree86 allocations
satisfy these hypotheses directly. The remaining fourteen degree86
allocations are covered by a coupled quadratic bootstrap. Thus complete
character uniqueness holds for all109 and729 allocations respectively.

There are two further refinements. In comparing two systems, use
delta_i=d_i if T_i is already fixed and delta_i=2d_i otherwise.
The quotient-jet criteria then hold with2d_i replaced by delta_i,
and their quadratic degree criterion is
\[
2j+2j2>22+\sum_i\delta_i-2(29-e).
\]
One may iterate these quotient criteria and common-factor lifting.
For the latter, if a different lift exists its reduced sparse pair
has degree r<=d_i-4. Its number of single-triple zeros is at most
16+2r. If the other two degree bounds sum to at most three, one
endpoint denominator is nonzero and this improves to15 for r=0,
or14+2r for1<=r<=6. If both other degree bounds are at most one,
both endpoint denominators are nonzero and the r=0 bound is13.

The exact iteration determines all quotients in4588 of4616 degree85
allocations, and the complete character data in4536 of4616. These
stronger counts fix the ENTIRE parameter curve and endpoint frames;
they do not strengthen the curve-independent quotient count4559.
The other80 complete-character cases remain open, as does actual
existence in every case covered by uniqueness.

Let M0 contain the defining coefficients of the fixed parameter curve,
its chosen local square-root frames, pole data and labeled endpoint
jets. The nontrivial character components are defined over M0.
For fixed such data, there are at most nine possible rational trace pairs
(u_0,v_0), counted as solutions of a finite algebra of dimension at most
nine over M0(t). Every actual pair of comparison functions is defined over
a constant extension of M0 of degree at most nine. If the three monic
character square-root polynomials are defined over F_(25^b), one can
take M0=F_(25^lcm(2b,28)) in the normalized setup. No new uniform bound
on b is supplied here.

These are finite reconstruction and coefficient-field bounds for the
specified fixed-parameter-curve V4 branch. They neither decide the remaining trace
equations nor construct or exclude an actual common cover. Lower degrees
are not covered by the stated numerical application.

[Proof and exact scope check](../../Proofs/cartier_and_spin/klein_four_finite_character_reconstruction.md).
