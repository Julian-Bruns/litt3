# Proof: the good cubic orbit and its actual double germs

[Statement](../../../Theorems/deformations/abelian_covers/backup_active_double_germs.md).
The complete backup twist table is the seed. Later affine/Frobenius
hindsight transports it to all sixty parameters; the existing generic
branch theorem removes ten separate four-jet calculations.

## 1. Exhaustion and explicit transport of the arithmetic orbit

Write G(I)=I^3+2I^2+4I+4. The first-height proof factors
I^6+I+1=(I^3+3I^2+4)G(I). Each root of the irreducible G lies in F125
and has norm one. Norm-one elements are exactly fourth powers in F125*.
Thus each I has four roots w with w^4=I, all in F125. Their traces are
\[
\operatorname{Tr}(w)=w(1+I+I^6)=0.
\]
For each w, z^5-z=w has five solutions in F125. This gives sixty
parameters and exhausts the entire geometric G(I)=0 locus. Its three
I-values are Frobenius conjugate; each twenty-point I-fiber is one affine
orbit by [prime-field branch symmetry](../../curve_arithmetic/prime_field_branch_family.md).
At the backup I=alpha+1, a root of G. Hence every parameter is an actual
affine curve isomorphism or a coefficient Frobenius twist of that seed.

Under z->a z+d, a in F5*,d in F5, w scales by a and its norm by a^3.
Since a^-3=a, the stated b transforms to ab+d. The norm of z-b scales
by a^3, so c transforms to ac. Therefore h_x and both bad pairs transform
by the SAME affine map. Trace and norm also commute with coefficient
Frobenius. At the backup, reduction modulo alpha^3+alpha+1 gives
\[
z=alpha^2+4alpha+2,\quad
\operatorname{Tr}(z)=4,\quad \operatorname{Nm}(w)=2,\quad
\operatorname{Nm}(z)=1,\quad b=0,\quad c=1,
\]
and h_x=2z/(z+1)=1/(3alpha+1). The denominator z-b+c is nonzero;
h_x is neither fixed-branch nor z because z is outside F5. This proves
the stated formula for the unique extra fiber datum on all sixty curves.
It uses isomorphisms between parameters, not an unproved internal
transitivity on the fixed backup.

The original [complete backup table](../../../../litt3-computation-data/legacy_workspace_computations/backup_active_twist_table.json)
and its [75-point/1125-twist nonsplit verification](../../../../litt3-computation-data/legacy_workspace_computations/backup_nonsplit_twists.json)
give six exceptional seed data, each with two defect-one twists. The ten
split data have no bad twists by the dormant direct sum in the
[critical-quartic theorem](../../../Theorems/projective_connections/genus_two_active_critical_quartics.md).
Actual pullback of connection/two-torsion pairs and coefficient Frobenius
transport the complete list and all kernel dimensions. They also transport
the actual doubles, JacOrd and formal cover presentations; no extra
source map or simultaneous Galois closure is introduced.

## 2. All ten branch germs follow from the generic family theorem

The ten branch pairs form the single affine ordered-pair orbit
({z,b},{b+d,b-d}). Transport any of them to the canonical pair
R0=u-t,R=u(u-3). The transformed parameter still has degree three.
The [parameterized A3 theorem](bad_double_abelian_a3_family.md) applies,
since every root of its exceptional polynomial
(t^5-t)(t^2+2t+3) has degree at most two. It gives the ACTUAL abelian
formal relation UV+W^4, including the two-sided Schur corrections and
the Picard-to-deck transition. Ten backup four-jet calculations are
therefore no longer needed as proof inputs.

Its constant operator has a zero one-dimensional character block and
invertible three- and two-dimensional character blocks. The displayed
block determinants (t+1)(t^5-t) and (t-1)(t-2) are nonzero here.
Coefficient Frobenius preserves these characters, so both the operator
and its second semilinear iterate have rank five. This proves the retained
simple-zero assertion without the ten former matrix replays.

## 3. Only the two mixed quadratic seeds remain

At the backup put F=u(u-1)(u-2)(u-3)(u-alpha). For the extra datum set
R0=u-alpha,S0=F/R0,D0=R0S0²,
J=R0'S0+2R0S0',K=D0^[6], and
A=K(3alpha)R0(u-3alpha)². The complete table proves this is the
normalized active quartic and identifies its two bad classes R=u(u-2)
and R=(u-1)(u-3). Form the actual etale doubles
\[
kappa^2=R,\quad ell^2=F/R,\quad v=kappa ell.
\]
All underlying backup doubles are Jacobian-ordinary by the
[small-cover theorem](../../jacobians/ordinary_covers/backup_small_abelian_ordinarity.md).
The actual injection sends b' to A b^5; no unrelated scalar replaces A.

For these degree-two R, the four components1,kappa,ell,v have regular
infinity cutoffs j<=-1,-2,-3,-4. The two involutions separate components,
so the six tangent cochains are exactly
\[
v/u,\ v/u^2,\ v/u^3,\ ell/u,\ kappa/u,\ ell/u^2.
\]
The O-cohomology basis is v/u,v/u²,ell/u. The generic theorem's
actual-cover/Picard dictionary applies to these ordinary curves.
Use exp(Xv'/u'+Yv'/u'^2+Zell'/u') through degree TWO, retaining
coefficient Frobenius. Source negative cohomology preserves these bases;
the target infinity lattice has the same exponential repair recursion.
A full two-sided Schur elimination of a constant unit five-by-five
block gives the scalar quadratic relation.

The two settled seed receipts have Hessian determinants3alpha² and
3+4alpha+2alpha², both nonzero, constant operator rank five, and second
semilinear rank five. The characteristic-not-two formal Morse lemma
therefore gives UV+W². No cubic, radical-quartic or higher jet is needed
for either mixed seed. This is the full ACTUAL formal module because
the ordinary Picard/deck change has invertible tangent map.

The narrowed [producer](../../../scripts/genus_two/backup_bad_double_jets.py)
and [independent determinant-quotient audit](../../../scripts/genus_two/audit_backup_bad_double_jets.py)
now handle ONLY cases2/3 through degree two. Their former branch selectors,
radical-quartic calculations and higher-order recurrences are removed.
The [two original exact receipts](../../../../litt3-computation-data/legacy_workspace_computations/backup_bad_double_jet_2.json)
(case3 is the adjacent _3.json) and the
[original independent audit](../../../../litt3-computation-data/legacy_workspace_computations/backup_all_bad_double_jet_audit.json)
remain provenance. That audit originally checked106 full-matrix
four-jets, all twelve constants and Hessians, and quotient lengths;
these unchanged inputs are reused rather than replayed.

Combining Sections2/3 gives all twelve germs at the backup. Section1
transports them to every good cubic parameter. The
[all-abelian defect classification](abelian_defect_flags.md) supplies
balanced and unbalanced cover lengths; no further Gröbner length replay
or arbitrary-source domination is needed.
