# Dormant residue fields control every Frobenius height

Version4,3 October2026. The later good-cubic classification transports
the arithmetic seed to its full sixty-parameter locus.

Let C be a smooth projective geometrically connected genus-two curve
over a perfect field K of odd characteristic. If C has no regular
dormant projective connection over K, EVERY geometrically semistable
rank-two bundle of even degree on C over K is strongly semistable.
No determinant, ordinariness or theta-coordinate hypothesis is needed.
If C has a theta characteristic over K, the converse also holds:
a K-rational dormant connection produces a geometrically stable
trivial-determinant bundle over K whose first Frobenius pullback
is unstable. Thus the stated absence criterion is exact under this
additional hypothesis.

In particular, suppose C is over Fq and every closed point of its
finite dormant scheme has residue degree divisible by a prime ell.
Every such bundle defined over F_(q^r), with ell not dividing r,
is strongly semistable at every height.

For every member of the good cubic locus
\[
C_t:v^2=u(u-1)(u-2)(u-3)(u-t),\quad t\notin\mathbf F_5,\qquad
I=\bigl((t+1)^{-5}-(t+1)^{-1}\bigr)^4,\quad
I^3+2I^2+4I+4=0,
\]
all sixty parameters lie in F125, and the WHOLE regular dormant
scheme is one reduced degree-five point over F125. The cubic backup
alpha³+alpha+1=0 supplies the single required arithmetic certificate.
Thus every geometrically semistable rank-two bundle of even degree
on any such C_t over F_(125^r), with 5 not dividing r, is strongly semistable.
This includes every nonsplit extension of omega by O over that field.
The field restriction is SHARP for the whole rank-two moduli problem:
when 5 divides r there are exactly eighty geometric stable classes
with trivial determinant whose first Frobenius pullback is unstable,
and all eighty are defined over F_(125^r). All lie outside the
theta-normalized pointed loci, by the separate all-geometric
first-height test.

Now let X <- Z -> C_t be an ACTUAL finite étale span with any of
these sixty curves and the fixed genus-nine X, defined in its entirety over
K=F_(5^(6r)), with 5 not dividing r. Then its joint tangent is zero
and exactly one of the following alternatives occurs:

1. There is no clump. The common regular-connection space is EMPTY,
   and the full marked deformation ring is k=bar(F5).
2. There is a positive clump. Its reduced genus-two image has four
   points, and the primitive common tensor has weight four and zero
   multiplicity two. There is exactly one common regular connection;
   it is active nilpotent, and its genus-two Hasse-root class is
   geometrically NONTRIVIAL two-torsion. The span has a unique
   simultaneous W2 lift and marked deformation ring W(k)/(5^e),
   with 2<=e<=infinity.

There is no assumption on covering degree, Galois closure or source
a-number. Both actual maps and their field of definition are retained.
An arbitrary geometric span may require a field degree divisible by
five; no reduction excluding that possibility is proved. Even the
two displayed alternatives do not exclude special-fiber spans, and
the second does not exclude a full mixed-characteristic lift.

The finite-quotient version of the residue argument remains available
in the proof. Its corrected theta computation is an independent check
of the same degree-five obstruction, rather than a required input.

[Proof and arithmetic certificate](../../Proofs/deformations/frobenius_residue_escape.md).
