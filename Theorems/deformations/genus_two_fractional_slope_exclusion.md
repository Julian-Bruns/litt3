# Twisted dormant rigidity excludes fractional rank-two slopes

Let $C/\overline{\mathbf F}_5$ be a smooth projective genus-two curve.
For every normalized dormant rank-two oper on $C$, let $\mathcal V$
be its canonical-determinant Cartier-descent bundle, so that
$\det\mathcal V=\omega$ on the Frobenius-twisted curve. Assume
\[
H^0(\mathcal V\otimes\kappa)=0
\quad\text{for every such }\mathcal V
\text{ and every two-torsion line }\kappa.
\tag{1}
\]
Keep the actual Frobenius twists in this formulation.

There is NO rank-two coefficient $F$-isocrystal on $C$ with
coefficient residue degree one, nonconstant Newton polygon, and
normalized generic slopes
\[
(0,a/e),\qquad 0<a<e,
\tag{2}
\]
where $e$ is the coefficient ramification index. No determinant
triviality, chosen theta characteristic, or common-cover hypothesis
is required. The exclusion is a statement on this endpoint alone.

Hypothesis(1) holds on BOTH selected genus-two endpoints, by
[the twisted dormant vanishing theorem](../projective_connections/genus_two_active_critical_quartics.md).
It holds on every member of the five-fixed-branch family whose
parameter degree exceeds six, and at the cubic backup.
Consequently a nonconstant residue-degree1 rank-two companion on
either endpoint cannot have a generic gap strictly between zero
and one. The ordinary gap-one case is not excluded on an endpoint
alone; if it is compatible with the other actual map, it forces
the simultaneous lift already proved.

The proof gives a precise obstruction. A fractional-slope lattice
would have a dormant oper reduction $H$, determinant $D$ with
$D^4=\mathcal O$, and an actual nonzero section
\[
H^0(\mathcal V\otimes D^2)\ne0.
\tag{3}
\]
Thus the determinant contributes a two-torsion twist, not an
uncontrolled degree-zero line. This is why the existing uniform
two-torsion test suffices.

There is also a cyclic version with explicit extra input. Suppose
a finite Dieudonné cycle of rank-two coefficient crystals has an
oper reduction of degree zero in EVERY component. Here BOTH $F$
and $pF^{-1}$ are integral at every step. Normalize each
Frobenius matrix by a constant uniformizer power so that it is
integral and nonzero modulo the uniformizer. Every such step then
has elementary divisors $(1,p)$ everywhere, and every target oper
is active. The normalized cycle is generically ordinary. This
does not assert that arbitrary coefficient cycles admit oper
lattices in all their components; nonoper components remain a
possible essential feature of smaller gaps.

There is a sharper two-component normal form under the same
vanishing hypothesis. For an actual coefficient-rank-two Dieudonné
cycle of residue degree two, ramification $e$, nonconstant Newton
polygon and generic gap $b/(2e)$, $1\le b\le2e$, an isogenous
lattice has an oper in component $i$ with
\[
d_i=\max(b-e,0),\qquad d_{i-1}=\min(b,e),\qquad n=\min(b,e).
\]
The $d$'s are the ordered incoming determinant heights, and the
oper exists over the whole ring $A_i/\pi^n$. In particular the
half-slope case has $(d_i,d_{i-1},n)=(0,e,e)$. This sharpens the
general arbitrary-cycle lifting construction; it is not an
endpoint exclusion for residue degree two.

Version2,20 September2026. Author proof using the constructed
partial Hodge lattice and the previously checked dormant test.
[Proof](../../Proofs/deformations/genus_two_fractional_slope_exclusion.md).
