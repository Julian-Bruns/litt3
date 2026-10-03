# Twisted dormant rigidity bounds every fractional rank-two slope

Version3,3 October2026. The later all-positive-edge normalization
replaces the separate residue-one construction and gives endpoint
bounds at EVERY coefficient residue degree.

Let \(C/\overline{\mathbf F}_5\) be a smooth projective genus-two
curve. For every normalized dormant rank-two oper let \(\mathcal V\)
be its canonical-determinant Cartier-descent bundle, with
\(\det\mathcal V=\omega\) on the Frobenius-twisted curve. Assume
\[
H^0(\mathcal V\otimes\kappa)=0
\quad\text{for every such }\mathcal V
\text{ and every }\kappa\in J[2].
\tag{1}
\]
All actual Frobenius twists remain part of this hypothesis.

## The endpoint bound in every residue degree

Let \(K/\mathbf Q_5\) have ramification index e and residue degree f.
Any rank-two K-coefficient F-isocrystal on C with nonconstant Newton
polygon and normalized generic slopes \((0,\delta)\),
\(0<\delta<1\), satisfies
\[
\delta\le1-1/f.
\tag{2}
\]
No determinant triviality, prior integral lattice or common-cover
hypothesis is required. Thus residue degree one excludes EVERY
fractional gap, and residue degree two excludes every gap in (1/2,1).
The ordinary gap-one case is allowed by this endpoint criterion.

Hypothesis(1) holds on BOTH selected endpoints, on every member of
the five-fixed-branch family whose parameter degree exceeds six,
and at the cubic backup, by
[the twisted dormant vanishing theorem](../projective_connections/genus_two_active_critical_quartics.md).

## The actual common coefficient has a stronger bound

Suppose such a coefficient has rationally compatible endpoint data
on an ACTUAL coreless finite étale span \(X\leftarrow Z\to C\),
with EVERY Frobenius arrow respected on the SAME source.
Every fractional generic gap then satisfies
\[
\delta\le1/2.
\tag{3}
\]
Only the genus-two endpoint needs(1). This is a restriction on a
supplied common coefficient, not an endpoint-only half-gap exclusion
or a construction from a bare span.

## Useful lattice and determinant data

The proof's two-oper criterion is general: under(1), a primitive
Dieudonné Frobenius step between oper reductions has elementary
divisors (1,p), and its target is active. Hence a full oper cycle
is generically ordinary. The supplied integral maps include BOTH
F and pF^-1.

At residue degree one the would-be fractional oper has determinant
D with D^4 trivial and the exact forbidden witness
\(H^0(\mathcal V\otimes D^2)\ne0\). Its twist is two-torsion;
the determinant need not be trivial.

For residue degree two and generic gap b/(2e), a fractional
coefficient, if it exists, has an isogenous terminal lattice with
ordered heights (0,b), up to cyclic labeling, where 1<=b<=e.
The active source is an oper over the WHOLE ring \(A_i/\pi^b\).
The ordinary case b=2e has heights (e,e) and whole precision pi^e.
The former intermediate rows e<b<2e are excluded.

The general lifting theorem still applies to supplied ordinary
common data. No coefficient or common cover is produced here.
Independent bounded review passes the new endpoint and common
bounds. [Proof](../../Proofs/deformations/genus_two_fractional_slope_exclusion.md).
