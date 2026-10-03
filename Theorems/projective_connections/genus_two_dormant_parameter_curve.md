# The dormant parameter curve is elliptic, with alternating monodromy

Version4,3 October2026. The complete first-height incidence now follows
from the two affine torsion orbits and six symbolic seeds. The optional
irreducible-specialization count remains local evidence.

Consider the smooth genus-two family
\[
C_t:\ v^2=u(u-1)(u-2)(u-3)(u-t),\qquad
t\notin\{0,1,2,3\},
\]
over F5. Let D be its degree-five scheme of regular dormant
projective connections, as parametrized by the universal quintic.

The smooth projective normalization of D over the parameter line is
the genus-one curve
\[
E:\quad w^2=1+3s^4.
\]
The degree-five map and the dormant coordinate are
\[
t=\frac{s^4-2s^3+1-w}{2s^3},\qquad T=3t-1+s.
\]
The displayed formula extends to a finite morphism E -> P1_t.
It is tamely ramified exactly at t=0,1,2,3,infinity, with geometric
fiber type (3,1,1) at each. Its arithmetic AND geometric monodromy
are A5. The smooth Galois closure has genus41 and constant field F5.

## A rational quintic after an elliptic isogeny

With origin (s,w)=(0,1), E is isomorphic to
\[
E_0:\ y^2=x^3+3x,\qquad
x=2(w+1)/s^2,\quad y=4(w+1)/s^3.
\]
Write pi for its F5 Frobenius and V for Verschiebung. Then
\[
V_x=\frac{x^5+2x^3+x}{x^4+3x^2+1},\qquad
V_y=V_x'(x)y.
\]
The ordinary smooth parameter locus is t outside F5. Put
\[
z=(t+1)^{-1},\qquad A=(z^5-z)^4,\qquad U=V_x^2.
\]
The complete dormant scheme of C_t, over its field of definition,
is isomorphic to the reduced degree-five scheme
\[
\boxed{U^3(U+3)^2=A.}
\]
Indeed, on E_0 one has z=xy/(2x^2+3) and
z^5-z=3V_xV_y. The new quintic has discriminant -A^3.
This is an isomorphism of the actual connection parameter schemes,
not only an equality of splitting fields or a count of points.

## The first pointed incidence is an elliptic subgroup

A point P of E_0 above a smooth parameter gives a dormant bundle
whose degree-two normalization has a section after some two-torsion
twist if and only if
\[
P\in E_0(\mathbf F_{125})[65].
\]
This is the subgroup of odd order65 in the group of order130.
Equivalently P lies in ker((1+pi+pi^2)V), a reduced subgroup of order65.
For ordinary smooth parameters the same condition is
\[
\boxed{U^3+4U^2+3U+4=0.}
\]
There are sixty such ordinary dormant points, one over each ordinary
first-height bad parameter. Each has exactly one two-torsion twist
with a section, and its section space is one-dimensional. The other
five subgroup points lie over t=4; each has three such twists, each
with a one-dimensional section space. This concerns FIRST-height
pointed incidence. It does not identify any later-height failure
with torsion of a proposed order.

[Proof and exact certificate](../../Proofs/projective_connections/genus_two_dormant_parameter_curve.md).
