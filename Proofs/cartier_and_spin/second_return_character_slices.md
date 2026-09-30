# Proof and evidence for the character-slice exclusions

Use the exact eighty-by-thirty-five pencil T(z) in the
[actual quotient atlas](../../Theorems/cartier_and_spin/second_return_actual_quotient_atlas.md),
with z_i=xi_i^25. The complete column span of the twelve alpha columns
over all nineteen source coordinates has rank51. Its annihilator
gives a29-row necessary pencil involving f only. The construction
eliminates arbitrary alpha; it does not assume matching characters.

Under the cubic grading the source blocks are
ZA=(z0,z6,z7), ZB=(z1..5,z8..12), ZC=(z13..18), of dimensions3,10,6.
The pure-v locus is ZA=ZB=0. The f-only pencils have the following
(row count, source count, coefficient count) sizes:

| f | ZA | ZB | ZC |
| --- | --- | --- | --- |
| p(x) |(6,3,11)|(13,10,11)|(10,6,11)|
| y p(x) |(13,3,8)|(10,10,8)|(6,6,8)|
| y^2 p(x) |(9,3,4)|(6,10,4)|(13,6,4)|

All exclusions below are homogeneous ideal/module membership over
F25, extended to k. A certificate that every source coordinate times
every relevant nonzero section-coordinate power belongs to the
equation module forces those source coordinates to vanish on the
entire projective geometric locus. Full matrix rank is sufficient
in some steps; other steps check the particular target monomials
even though the whole matrix has a cokernel.

For f=y^2p, the ZA and ZC pencils have full membership certificates
in degrees2 and4. Thus ZA=ZC=0. The remaining full-map block on ZB
and the eight coordinates of this f and its matching correction has
a degree6 Macaulay matrix of size18216-by-17160 and full column rank.
It excludes every remaining nonzero source. This is an actual Hom
vanishing statement for this f-space, stronger than the window claim.

For f=p of degree<=2, f-only identities place ZA and ZB in specified
one-dimensional kernels. Together with arbitrary ZC this is an
eight-dimensional source space. The full T equations, with all twelve
alpha coefficients retained, give a61-by-8-by-15 tensor. Its degree3
matrix has size7320-by-5440 and rank5343; all24 required source-times-
p-coordinate-cubed targets are in its row span. Hence there is no
nonzero source. For degree exactly3, separate degree2 and degree10
identities force ZA=ZB=0 whenever the cubic coefficient is nonzero.
The established pure-v theorem then excludes the window.

For f=yp of arbitrary allowed degree, the ZA pencil has a degree3
full-column-rank certificate (rank360). Thus ZA=0 throughout this
character space. For p linear, the ZB determinant has degree10 with
squarefree factors of degrees1,1,1,3,4; the point at infinity of the
p-pencil is invertible. At every determinant root the two remaining
source kernels are one-dimensional. Exact full-map product matrices
force the ZB coordinate to vanish. This is a geometric finite-algebra
test over all factor fields, not a rational-point sample.

For p quadratic with nonzero leading coefficient, the ZC pencil has
common kernel (16,22,12,7,21,1). A literal Nullstellensatz identity1
in the ZB determinant and the five-by-five ZC minors proves that
this is its entire kernel whenever ZB can survive. The unmatched
correction equations then use maps of ranks10 and4 to force those
corrections to zero; the zero-ZC case uses the already closed third
character block. The remaining matched block has a degree5 matrix
of size21450-by-20020, rank19600, with all30 requested targets in
its row span. Thus ZB=0, and the source is pure-v.

The [complete returned report](../../../litt3-computation-data/structural_slices_replies_20260925/extracted/character/cubic_character_slices/REPORT.md)
retains all tensor constructions, exact identities and the proof that
unmatched corrections were not discarded. All proved-claim checks
passed in the [complete local replay](../../../litt3-computation-data/structural_slices_replies_20260925/local_checks/character.log),
including the large homogeneous matrices and the exceptional-rank
unit identity. The original source is preserved under
[pro_structural_slices_20260925/character](../../scripts/arithmetic/pro_structural_slices_20260925/character/).

The higher j=0 and j=1 matrix attempts and finite samples are explicitly
inconclusive. A generated degree5 higher-j=1 module was not executed
in the returned work. These records are useful failed approaches,
not nonemptiness or emptiness proofs. No further stable-window or
strict-return conclusion follows from the present computations.
